"""  Parse Cobalt Strike Logs 
Description:    Generate CSV representations of Cobalt Strike .bin logs 
Authors:        Alyssa R. (@ramen0x3f), Nick M. (@kulinacs)
Created:        2020-02-28
Last Updated:   2020-12-09

Dependencies: pip3 install javaobj-py3

Usage: python3 parse_cs_bin.py <directory containing CobaltStrike .bin files>

The parse_cs_bin.py script will recursively search the provided directories for CobaltStrike.bin files and parse them into CSV files.

The CSV files generated will be written to an output directory and grouped by the directory path they were located.
"""
from argparse import ArgumentParser,RawTextHelpFormatter
from glob import glob
from os import makedirs, path
from sys import argv
import csv, javaobj 

if __name__=="__main__":
    parser = ArgumentParser(description="Generate CSV representations of Cobalt Strike .bin logs ") 

    ## For arguments sake
    parser.add_argument('directory',type=str,
                        help='path to the directory containing CobaltStrike .bin files')
    parser.add_argument('--prefix',type=str, default="export",
                        help='Output directory. Default is "exports".')
    parser.add_argument("-s", "--show-passwords", action="store_true", help="Show password from database.")
    args = parser.parse_args()

    ## BINgo was his name-o
    print("[+] Exporting all .bin files and grouping by directory")
    files = glob(f"{args.directory}/**/*.bin", recursive=True)

    created_folders = set()

    for filename in files:
        try:
            # Create folders
            output_folder = path.join(args.prefix, f"{path.dirname(filename).replace('./', '').replace('/', '_')}")
            makedirs(output_folder, exist_ok=True)
            created_folders.add(output_folder)

            # Handle different data types 
            datatype = path.basename(filename).split('.')[0]
            if datatype in ["archives", "beacons", "services", "credentials", "listeners", "sessions", "targets", "c2info"]:
                with open(path.join(output_folder, f"{datatype}.csv"), 'w', newline='') as csvfile:
                    # Assume it's a dict, if not, try a list.
                    try:
                        bindata = [d for k,d in javaobj.loads(open(filename,"rb").read()).items()]
                    except:
                        bindata = [javaobj.loads(open(filename,"rb").read())]
                    
                    if datatype in ["archives"]:
                        tempdata = bindata
                        bindata = []
                        for entry in tempdata:
                            bindata.append({entry.annotations[1]: entry.annotations[2], entry.annotations[3]: entry.annotations[4], entry.annotations[5]: entry.annotations[6]})
                    # Output data
                    if len(bindata) > 0:
                        max_keys = 0
                        for entry in bindata:
                            if len(entry.keys()) > max_keys:
                                max_keys = len(entry.keys())
                                csvfieldnames=entry.keys()
                        writer = csv.DictWriter(csvfile, fieldnames=csvfieldnames, extrasaction='raise', restval='')

                        writer.writeheader()
                        for entry in bindata:
                            # Redact the passwords
                            if entry.get('password'):
                                if not args.show_passwords:
                                    entry['password'] = "***REDACTED***"
                            writer.writerow(entry)
        except Exception as e:
            print(f"Error processing file: {filename} - {e}")

    print("[*] Created the following folders:")
    for folder in created_folders:
        print(f"\t[*] {folder}")

    print("[*] Post-processing folders to pull out listener usage information")
    for folder in created_folders:
        with open(path.join(folder, 'c2info.csv'), newline='') as c2file:
            c2info = csv.DictReader(c2file)
            with open(path.join(folder, 'sessions.csv'), newline='') as session_file:
                sessions = csv.DictReader(session_file)
                c2_usage = {}

                for c2 in c2info:
                    c2_usage[c2['bid']] = {'bid': c2['bid'], 'domains': c2['domains']}

                for session in sessions:
                    try:
                        c2_usage[session['id']]['opened'] = session['opened']
                    except:
                        pass

                with open(path.join(folder, f"c2usage.csv"), 'w', newline='') as csvfile:
                    usage_list = [v for k, v in c2_usage.items()]
                    if len(usage_list) > 0:
                        writer = csv.DictWriter(csvfile, fieldnames=usage_list[0].keys())

                        writer.writeheader()
                        for entry in usage_list:
                            writer.writerow(entry)
                        
                    print(f'[*] Created file {path.join(folder, f"c2usage.csv")}')

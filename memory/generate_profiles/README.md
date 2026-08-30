# generate_profiles

Docker environment for generating Volatility/dwarf2json memory-forensics profiles from Linux kernel packages.

## Usage

```bash
docker build -t generate_profiles .
docker run -v /path/to/kernel-rpms:/build -it generate_profiles
```

Inside the container, with the kernel `.rpm` packages mounted at `/build`:

- `./build.sh` extracts each kernel package with `rpm2cpio`/`cpio` and lists the kernel versions found.
- `./extract-vmlinux.sh <kernel-image>` extracts an uncompressed `vmlinux` from a (possibly compressed) kernel image.

The image also has `dwarf2json` and the Volatility source checked out, ready to build ISF/profile files from the extracted `vmlinux`.

# Windows Sandbox

A collection of script to install tools for DFIR in Windows Sandbox. Started with the code in this repo [Windows Sandbox Configuration][wsc]. Updated versions and also added more tools and removed some. 

Included tools:

- Amazon Corretto
- capa
- dnSpy (by dnSpyEx which is a unofficial continuation of the dnSpy project)
- HxD
- Ghidra
- Notepad++
- PE-bear
- PEstudio
- Python
- SysinternalsSuite
- Sysmon started with SwiftOnSecurity sysmon-config
- x64dbg
- upx
- Visual Studio Code
- Zimmerman Tools
- Selected scripts from Didier Stevens

Downloaded but not installed by default:

- Wireshark
- npcap

## Installation and configuration

First enable Windows Sandbox by running **Add and remove Windows features**.

Then start a PowerShell terminal and download the code.

	git clone https:/github.com/reuteras/irtools.git
	cd irtools/wsb

Create configuration with local path by running.

	./createSandboxConfig.ps1

You need to have Python 3.10 installed (or change to another version in the Sandbox by modifying the scripts).

	./downloadFiles.ps1

## Usage

Start the Sandbox by clicking on **sandbox_tools_no_network.wsb** or running **./sandbox_tools_no_network.wsb** in a PowerShell terminal.

## TODO

- [ ] Would be nice to get Windows Terminal in the sandbox.


  [wsc]: https://github.com/firefart/sandbox


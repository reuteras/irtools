# Windows Sandbox

A collection of script to install some tools in a Windows Sandbox. Started with the code in the repo [Windows Sandbox Configuration][wsc]. Updated versions and also added more tools and removed some. 

Included tools:

- Visual Studio Code
- Amazon Corretto
- Notepad++
- Ghidra
- SysinternalsSuite
- x64dbg
- Python
- HxD
- upx
- PE-bear
- PEstudio
- Sysmon started with SwiftOnSecurity sysmon-config
- capa
- Zimmerman Tools
- Selected scripts from Didier Stevens

Downloaded but not installed:

- Wireshark
- npcap

## Installation and configuration

First enable Windows Sandbox by running Add and remove Windows features.

Start a PowerShell terminal.

	git clone https:/github.com/reuteras/irtools.git
	cd irtools/wsb
	./createSandboxConfig.ps1
	./downloadFiles.ps1

## Usage

Start the Sandbox by clicking on **sandbox_tools_no_network.wsb** or running **./sandbox_tools_no_network.wsb** in a PowerShell terminal.

## TODO

- [ ] Would be nice to get Windows Terminal in the sandbox.


  [wsc]: https://github.com/firefart/sandbox


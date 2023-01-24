# Windows Sandbox

A collection of script to install tools for DFIR in Windows Sandbox. Started with the code in this repo [Windows Sandbox Configuration][wsc]. Updated versions and also added more tools and removed some. 

Included tools:

- [Amazon Corretto][amc]
- [capa][cap]
- [dnSpy][dns] (by dnSpyEx which is a unofficial continuation of the dnSpy project)
- [exiftool][ext]
- [HxD][hxd]
- [Ghidra][ghi]
- [LOKI][lok]
- [Notepad++][not]
- [PE-bear][peb]
- [PEstudio][pes]
- [Python[pyt]
- [ripgrep][rip]
- [sqlite][sql] cli
- [SysinternalsSuite][syi]
- [Sysmon][sym] started with [SwiftOnSecurity sysmon-config][sws]
- [x64dbg][xdb]
- [upx][upx]
- [visidata][vis]
- [Visual Studio Code][vsc]
- [Zimmerman Tools][zim]
- Selected scripts from [Didier Stevens][dis]
- Selected pip packages for Python

Downloaded but not installed by default:

- [Wireshark][wis]
- [npcap][npc]

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

  [amc]: https://docs.aws.amazon.com/corretto/
  [cap]: https://github.com/mandiant/capa
  [dis]: https://github.com/DidierStevens/DidierStevensSuite
  [dns]: https://github.com/dnSpyEx/dnSpy
  [ext]: https://exiftool.org/
  [hxd]: https://mh-nexus.de/
  [ghi]: https://github.com/NationalSecurityAgency/ghidra
  [lok]: https://github.com/Neo23x0/Loki
  [not]: https://notepad-plus-plus.org/
  [npc]: https://npcap.com/
  [peb]: https://github.com/hasherezade/pe-bear
  [pes]: https://www.winitor.com/
  [pyt]: https://python.org/
  [rip]: https://github.com/BurntSushi/ripgrep
  [sql]: https://sqlite.org/
  [sws]: https://github.com/SwiftOnSecurity/sysmon-config
  [syi]: https://learn.microsoft.com/en-us/sysinternals/
  [sym]: https://learn.microsoft.com/en-us/sysinternals/downloads/sysmon
  [upx]: https://github.com/upx/upx
  [vis]: https://www.visidata.org/
  [vsc]: https://code.visualstudio.com/
  [wis]: https://wireshark.org/
  [wsc]: https://github.com/firefart/sandbox
  [xdb]: https://x64dbg.com/
  [zim]: https://github.com/EricZimmerman


# Sandbox-Automation TOOL
Windows Sandbox provides a lightweight desktop environment to safely run applications in isolation. Software installed inside the Windows Sandbox environment remains "sandboxed" and runs separately from the host machine. Sandbox automation. 
## Requirements
1. Windows 10 or 11 Pro Version
2. Turn ON Windows Sandbox Feature
## Usage
1. Find the folder with the power shell script.ps1 file.
2. Type "PowerShell" in the address bar of the folder window. This will open up
PowerShell in that folder.
3. Run the script with the power shell commands providing it following with
some information:
hostfolder: Where your file is located.
file: The name of the file you want to run in the sandbox.
sandboxfolder: A special folder in the sandbox where your file will be.
readonly: Decide if you want your files to be read-only in the sandbox
(True/False).
Syntax for sandbox command in powershell: 
.\script.ps1 -hostfolder "C:\Sandbox" -file "example.exe" -
sandboxfolder "C:\sandbox" -readonly True
User-Manual for Sandbox Automation Tool 3
When the command is entered, scripts.ps1 will launch the sandbox and run the
provided file in the sandbox. The script.ps1 will first set the sandbox
configuration file, in which necessary information will be written, then that
sandbox file will launched, which will start the sandbox. This process
automatically runs the provided file in sandbox.

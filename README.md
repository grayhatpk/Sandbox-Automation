# Sandbox Automation Tool User Manual

## Introduction
The Sandbox Automation Tool provides a lightweight desktop environment, Windows Sandbox, to safely run applications in isolation. Software installed inside the Windows Sandbox environment remains segregated from the host machine. The sandbox is temporary, and upon closure, all associated software, files, and states are deleted.

## Files Descriptions
__script.ps1__ <br>This is a PowerShell script file. It contains code to interact with the user, receive parameters, generate the sandbox configuration file, and execute the provided executable within the sandbox. 

__sandbox_configuration.wsb__ <br> This is a Windows Sandbox configuration file. Windows Sandbox provides a lightweight desktop environment to safely run applications in isolation. The sandbox_configuration.wsb file likely contains settings such as virtualized hardware configurations, networking settings, and other parameters necessary for setting up the sandbox environment.

__script.exe__ <br> This is an example executable file. Executable files contain instructions that a computer can execute directly. In this context, script.exe is the file that will be run within the sandbox environment created by script.ps1.

## Requirements
- Computer with PowerShell installed.
- System.Windows.Forms library for GUI.
- Windows Pro version with Sandbox feature enabled.

## Getting Started
1. Search for "Turn Windows features ON OFF" in the search bar.
2. Choose the option to open the menu.
3. Look for "Windows Sandbox":
   - If checked, leave it.
   - If not, check it, then click OK.

## User Manual for Sandbox Automation Tool

### Interactive Mode
1. Find the folder with the PowerShell script file (script.ps1).
2. Type "PowerShell" in the folder window address bar to open PowerShell in that folder.
3. Run the script with the following commands:

.\script.ps1 -hostfolder "C:\Sandbox" -file "example.exe" -sandboxfolder "C:\sandbox" -readonly True

Replace parameters accordingly.

### GUI Mode
- If parameters are not provided, a GUI will prompt for necessary information.
- Run the script: `./script.ps1`

#### GUI Components
- **Host Folder Path:** Browse to locate the folder containing your file.
- **Arguments:** Enter the file name and sandbox folder name.
- **Permissions:** Choose desired permissions.
- Click "RUN" to initiate the process.

### Running
Once configured, the tool prepares the sandbox for your file. Your file will run safely within the sandbox environment, enabling observation of its behavior.


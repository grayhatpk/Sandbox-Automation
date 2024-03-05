param(    
    [Parameter(HelpMessage="Host Folder Path i.e. C:\\Sandbox")]
    [string]$hostfolder,

    [Parameter(HelpMessage="File name to execute in Sandbox i.e. file.exe")]
    [string]$file,

    [Parameter(HelpMessage="THe mapped Sandbox folder i.e C:\sandbox")]
    [string]$sandboxfolder,

    [Parameter(HelpMessage="Permission for the files i.e. -readonly True/False")]
    [string]$readonly
)

[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null

if ($hostfolder.Length -gt 0 -and $file.Length -gt 0 -and $sandboxfolder.Length -gt 0 -and $readonly.Length -gt 0) {
        $wsbContent = 
@"
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
<MappedFolders>
    <MappedFolder>
        <HostFolder>$hostfolder</HostFolder>
        <SandboxFolder>$sandboxfolder</SandboxFolder>
        <ReadOnly>$readonly</ReadOnly>
    </MappedFolder>
</MappedFolders>
<LogonCommand>
    <Command>explorer.exe "$sandboxfolder\$file"</Command>
</LogonCommand>
</Configuration>
"@
        Set-Content -Path "F:\Freelancing\Sandbox-automation\Sandbox_configuration.wsb" -Value $wsbContent
        .\Sandbox_configuration.wsb
}

else{

    $form = New-Object System.Windows.Forms.Form
    $form.Size = New-Object System.Drawing.Size(1400, 900)

    
    $pathLabel = New-Object System.Windows.Forms.Label
    $pathLabel.Location = New-Object System.Drawing.Point(180, 202)
    $pathLabel.Size = New-Object System.Drawing.Size(150, 50)
    $pathLabel.Text = "Folder Path: "
    $pathLabel.Font = New-Object System.Drawing.Font("Arial", 12)

   `
    $pathTextBox = New-Object System.Windows.Forms.TextBox
    $pathTextBox.Location = New-Object System.Drawing.Point(300, 200)
    $pathTextBox.Size = New-Object System.Drawing.Size(500, 100)
    $pathTextBox.ReadOnly = $true 
    $pathTextBox.Text = "Select path to File" 
    $pathTextBox.Font =  New-Object System.Drawing.Font("Arial", 12)

`
    $browseButton = New-Object System.Windows.Forms.Button
    $browseButton.Location = New-Object System.Drawing.Point(810, 200)
    $browseButton.Size = New-Object System.Drawing.Size(100, 23)
    $browseButton.Text = "Browse"
    $browseButton.FlatStyle = 'Flat' 
    $browseButton.FlatAppearance.BorderSize = 2
    $browseButton.Add_Click({
        $folderDialog = New-Object System.Windows.Forms.FolderBrowserDialog
        
        $result = $folderDialog.ShowDialog()
        if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
            $pathTextBox.Text = $folderDialog.SelectedPath
        }
    })
    
    $argLabel = New-Object System.Windows.Forms.Label
    $argLabel.Location = New-Object System.Drawing.Point(200, 250)
    $argLabel.Size = New-Object System.Drawing.Size(100, 100) 
    $argLabel.Text = "Arguments"
    $argLabel.Font = New-Object System.Drawing.Font("Arial", 12)
    
    
    $argTextBox = New-Object System.Windows.Forms.TextBox
    $argTextBox.Location = New-Object System.Drawing.Point(300, 250)

    $argTextBox.Width = 500 
    $argTextBox.Height = 1000 

    $argTextBox.Text = "-file executablename.exe -sandboxfolder C:\Sandbox\mapped\folder "
    $argTextBox.Font =  New-Object System.Drawing.Font("Arial", 12)

    $clearButton = New-Object System.Windows.Forms.Button
    $clearButton.Location = New-Object System.Drawing.Point(810, 250)
    $clearButton.Size = New-Object System.Drawing.Size(100, 50)
    $clearButton.Text = "Clear"
    $clearButton.Add_Click({
        $argTextBox.Clear()
    })
    $clearButton.FlatStyle = 'Flat' 
    $clearButton.FlatAppearance.BorderSize = 2

    $permLabel = New-Object System.Windows.Forms.Label
    $permLabel.Location = New-Object System.Drawing.Point(150, 350)
    $permLabel.Size = New-Object System.Drawing.Size(150, 30)
    $permLabel.Text = "Permissions "
    $permLabel.Font = New-Object System.Drawing.Font("Arial", 14)

    $checkbox3 = New-Object System.Windows.Forms.CheckBox
    $checkbox3.Location = New-Object System.Drawing.Point(300, 470)
    $checkbox3.Text = " ReadOnly Value True/False"
    $checkbox3.size = New-Object System.Drawing.size(200, 50)

    $checkbox2 = New-Object System.Windows.Forms.CheckBox
    $checkbox2.Location = New-Object System.Drawing.Point(300, 420)
    $checkbox2.Text = "Networkign Enable/Disable"
    $checkbox2.size = New-Object System.Drawing.size(200, 50)

    $checkbox1 = New-Object System.Windows.Forms.CheckBox
    $checkbox1.Text = "vGPU Enable/Disable"
    $checkbox1.Location = New-Object System.Drawing.Point(300, 370)
    $checkbox1.size = New-Object System.Drawing.size(200, 50)

    
    
    $runButton = New-Object System.Windows.Forms.Button
    $runButton.Location = New-Object System.Drawing.Point(280, 550)
    $runButton.Size = New-Object System.Drawing.Size(600, 40)
    $runButton.Text = "RUN"
    $runButton.FlatStyle = 'Flat' 
    $runButton.FlatAppearance.BorderSize = 2

    $runButton.Add_Click({
        if ($pathTextBox.Text -ne "Select File Path" -and $argTextBox.Text -ne "-file filename.exe -sandboxfolder Sandbox\Mapped\Folder\Path " ) {
            $arguments = $argTextBox.Text -split ' '
            $fileIndex = [array]::IndexOf($arguments, '-file') + 1
            $sandboxIndex = [array]::IndexOf($arguments, '-sandboxfolder') + 1
            $file = $arguments[$fileIndex]
            $sandboxFolder = $arguments[$sandboxIndex]
            $folder = $pathTextBox.Text

            $filePath = Join-Path -Path $folder -ChildPath $file
            Write-Host $filePath

            if (Test-Path $filePath) {
               Write-Host "File exists: $filePath"
               if ($checkbox3.Checked)                
                {
                    $read = "True"
                }
                else{
                    $read = "False"
                }

                $wsbContent =
@"
<?xml version="1.0" encoding="UTF-8"?>
<Configuration>
<MappedFolders>
    <MappedFolder>
        <HostFolder>$folder</HostFolder>
        <SandboxFolder>$sandboxFolder</SandboxFolder>
        <ReadOnly>$read</ReadOnly>
    </MappedFolder>
</MappedFolders>
<LogonCommand>
    <Command>explorer.exe "$sandboxfolder\$file"</Command>
</LogonCommand>
</Configuration>
"@
                Set-Content -Path "F:\Freelancing\Sandbox-automation\sandbox.wsb" -Value $wsbContent
                .\sandbox.wsb
            } else {
                Write-Host "File does not exist: $filePath"
            }}})

    # Add Controls to the form
    $form.Controls.Add($pathTextBox)
    $form.Controls.Add($pathLabel)
    $form.Controls.Add($argLabel)
    $form.Controls.Add($argTextBox)
    $form.Controls.Add($browseButton)
    $form.Controls.Add($clearButton)
    $form.Controls.Add($runButton)
    $form.Controls.Add($permLabel)
    $form.Controls.Add($checkbox5)
    $form.Controls.Add($checkbox4)
    $form.Controls.Add($checkbox1)
    $form.Controls.Add($checkbox2)
    $form.Controls.Add($checkbox3)


    $result = $form.ShowDialog()
}



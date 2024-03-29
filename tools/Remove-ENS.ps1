function Show-Remove-ENS_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formTrellixEndpointSecur = New-Object 'System.Windows.Forms.Form'
	$groupbox3 = New-Object 'System.Windows.Forms.GroupBox'
	$buttonRemoveEndpointSecuri = New-Object 'System.Windows.Forms.Button'
	$buttonRemoveAgent = New-Object 'System.Windows.Forms.Button'
	$statusbar = New-Object 'System.Windows.Forms.StatusBar'
	$groupbox2 = New-Object 'System.Windows.Forms.GroupBox'
	$button4RemoveTrellixFolder = New-Object 'System.Windows.Forms.Button'
	$button5RebootIntoWindows = New-Object 'System.Windows.Forms.Button'
	$groupbox1 = New-Object 'System.Windows.Forms.GroupBox'
	$button1BackupRegistry = New-Object 'System.Windows.Forms.Button'
	$button2RemoveSafeBootKeys = New-Object 'System.Windows.Forms.Button'
	$button3RebootInSafeMode = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	######### LOAD FORM #########
	
	# Checking if computer is running in normal or safe mode
	$BootStatus = (Get-WmiObject win32_computersystem -Property BootupState).BootupState
	if ($BootStatus -eq "Normal boot")
	{
		$statusbar.Text = "System running in Normal mode"
		$button2RemoveSafeBootKeys.Enabled = $false
		$button3RebootInSafeMode.Enabled = $false
		$button4RemoveTrellixFolder.Enabled = $false
		$button5RebootIntoWindows.Enabled = $false
	}
	else
	{
		$statusbar.Text = "System running in Safe mode"
		$button1BackupRegistry.Enabled = $false
		$button2RemoveSafeBootKeys.Enabled = $false
		$button3RebootInSafeMode.Enabled = $false
		$button4RemoveTrellixFolder.Enabled = $true
		$button5RebootIntoWindows.Enabled = $true
	}
	
	######### NORMAL BOOT ACTIONS #########
	
	$buttonRemoveEndpointSecuri_Click = {
		# Uninstall Trellix ENS
		$statusbar.Text = "Uninstalling ENS. Please wait..."
		Start-Process -Wait MsiExec.exe -Arg "/X{377DA1C7-79DE-4102-8DB7-5C2296A3E960} /passive /norestart"
		Start-Process -Wait MsiExec.exe -Arg "/X{6F88C6E9-CAD0-4D03-99E1-161383F9AD6F} /passive /norestart"
		Start-Process -Wait MsiExec.exe -Arg "/X{820D7600-089E-486B-860F-279B8119A893} /passive /norestart"
		Start-Process -Wait MsiExec.exe -Arg "/X{B16DE18D-4D5D-45F8-92BD-8DC17225AFD8} /passive /norestart"
		Start-Process -Wait MsiExec.exe -Arg "/X{D3925418-7CC4-4E0C-8074-8FC7196634C1} /passive /norestart"
		$statusbar.Text = "ENS was uninstalled"
	}
	
	$buttonRemoveAgent_Click = {
		# Force uninstall of the Trellix Agent
		$statusbar.Text = "Uninstalling Agent. Please wait..."
		Start-Process -Wait "C:\Program Files\McAfee\Agent\x86\FrmInst.exe" -Arg "/forceuninstall"
		$statusbar.Text = "Agent was uninstalled"
	}
	
	$button1BackupRegistry_Click = {
		# Backup Registry
		$statusbar.Text = "Backing up registry. Please wait..."
		mkdir C:\temp\ -Force
		& "reg" export HKLM "C:\temp\Reg_HKLM_Backup.reg"
		& "reg" export HKCR "C:\temp\Reg_HKCR_Backup.reg"
		if ((Test-Path -Path C:\temp\Reg_HKCR_Backup.reg) -and (Test-Path -Path C:\temp\Reg_HKLM_Backup.reg))
		{
			$statusbar.Text = "Done! Registry backed up to C:\temp\"
			$button2RemoveSafeBootKeys.Enabled = $true
		}
		else
		{
			$statusbar.Text = "Backup failed. Please close all applications and try again"
		}
	}
	
	$button2RemoveSafeBootKeys_Click = {
		# Delete SafeBoot keys
		$statusbar.Text = "Deleting SafeBoot Keys..."
		$SafeBootKeys = "HKLM:\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\mfe*"
		Remove-Item $SafeBootKeys -Recurse
		$statusbar.Text = "Done! Please reboot into Safe Mode"
		$button3RebootInSafeMode.Enabled = $true
	}
	
	$button3RebootInSafeMode_Click = {
		$statusbar.Text = "Rebooting into Safe Mode in 1 minute..."
		# Set next boot in Safe Mode with networking
		& "bcdedit" /set safeboot network
		& "shutdown" /r
	}
	
	######### SAFE MODE ACTIONS #########
	
	$button4RemoveTrellixFolder_Click = {
		$statusbar.Text = "Removing Trellix folders. Please wait..."
		# Remove multistring
		$MultiStringKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}\"
		Get-Item $MultiStringKey | Remove-ItemProperty -Name "UpperFilters"
		New-ItemProperty -Path $MultiStringKey -Name "UpperFilters" -PropertyType MultiString -Value partmgr
		
		#Remove Multiple Trellix Services
		$ServiceKeys = "HKLM:\SYSTEM\CurrentControlSet\Services\mfe*"
		Remove-Item $ServiceKeys -Recurse
		Remove-ItemProperty -Path "HKCR:\AllFilesystemObjects\shellex\ContextMenuHandlers\" -Name "{EA485C0C-93BB-48C3-AE57-6399F85F0F7E}" -Force
		Remove-ItemProperty -Path "HKLM:\Software\" -Name "Network Associates" -Force
		Remove-ItemProperty -Path "HKLM:\Software\" -Name "McAfee" -Force
		Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\" -Name "McAfee" -Force
		Remove-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\" -Name "Network Associates" -Force
		Remove-ItemProperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products" -Name "7C1AD773ED972014D87BC522693A9E06" -Force
		Remove-ItemProperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products" -Name "9E6C88F60DAC30D4991E6131389FDAF6" -Force
		Remove-ItemProperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products" -Name "D81ED61BD5D48F5429DBD81C2752FA8D" -Force
		Remove-ItemProperty -Path "HKLM:\SOFTWARE\Classes\Installer\Products" -Name "0067D028E980B68468F072B918918A39" -Force
		
		# Delete Trellix Driver files
		Remove-Item "C:\Windows\System32\drivers\mfe*" -Recurse -Force
		Remove-Item "C:\Windows\System32\MFEVTPS.exe" -Force
		
		# Delete Trellix Folders
		Remove-Item "C:\Program Files\Common Files\McAfee\" -Recurse -Force
		Remove-Item "C:\Program Files (x86)\Common Files\McAfee\" -Recurse -Force
		Remove-Item "C:\Program Files\McAfee\" -Recurse -Force
		Remove-Item "C:\Program Files (x86)\McAfee\" -Recurse -Force
		$statusbar.Text = "Trellix folders removed. Please reboot back into Windows"
	}
	
	$button5RebootIntoWindows_Click = {
		# Reboot into Windows
		$statusbar.Text = "Rebooting into Windows in 1 minute..."
		& "bcdedit" /deletevalue safeboot
		& "shutdown" /r
	}
	
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formTrellixEndpointSecur.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonRemoveEndpointSecuri.remove_Click($buttonRemoveEndpointSecuri_Click)
			$buttonRemoveAgent.remove_Click($buttonRemoveAgent_Click)
			$button4RemoveTrellixFolder.remove_Click($button4RemoveTrellixFolder_Click)
			$button5RebootIntoWindows.remove_Click($button5RebootIntoWindows_Click)
			$button1BackupRegistry.remove_Click($button1BackupRegistry_Click)
			$button2RemoveSafeBootKeys.remove_Click($button2RemoveSafeBootKeys_Click)
			$button3RebootInSafeMode.remove_Click($button3RebootInSafeMode_Click)
			$formTrellixEndpointSecur.remove_Load($Form_StateCorrection_Load)
			$formTrellixEndpointSecur.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formTrellixEndpointSecur.SuspendLayout()
	$groupbox3.SuspendLayout()
	$groupbox2.SuspendLayout()
	$groupbox1.SuspendLayout()
	#
	# formTrellixEndpointSecur
	#
	$formTrellixEndpointSecur.Controls.Add($groupbox3)
	$formTrellixEndpointSecur.Controls.Add($statusbar)
	$formTrellixEndpointSecur.Controls.Add($groupbox2)
	$formTrellixEndpointSecur.Controls.Add($groupbox1)
	$formTrellixEndpointSecur.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 13)
	$formTrellixEndpointSecur.AutoScaleMode = 'Font'
	$formTrellixEndpointSecur.ClientSize = New-Object System.Drawing.Size(246, 372)
	$formTrellixEndpointSecur.FormBorderStyle = 'FixedDialog'
	$formTrellixEndpointSecur.MaximizeBox = $False
	$formTrellixEndpointSecur.MinimizeBox = $False
	$formTrellixEndpointSecur.Name = 'formTrellixEndpointSecur'
	$formTrellixEndpointSecur.StartPosition = 'CenterScreen'
	$formTrellixEndpointSecur.Text = 'Trellix Endpoint Security Removal Tool'
	#
	# groupbox3
	#
	$groupbox3.Controls.Add($buttonRemoveEndpointSecuri)
	$groupbox3.Controls.Add($buttonRemoveAgent)
	$groupbox3.Location = New-Object System.Drawing.Point(12, 13)
	$groupbox3.Name = 'groupbox3'
	$groupbox3.Size = New-Object System.Drawing.Size(222, 80)
	$groupbox3.TabIndex = 8
	$groupbox3.TabStop = $False
	$groupbox3.Text = 'Uninstall Trellix'
	#
	# buttonRemoveEndpointSecuri
	#
	$buttonRemoveEndpointSecuri.Location = New-Object System.Drawing.Point(8, 19)
	$buttonRemoveEndpointSecuri.Name = 'buttonRemoveEndpointSecuri'
	$buttonRemoveEndpointSecuri.Size = New-Object System.Drawing.Size(208, 23)
	$buttonRemoveEndpointSecuri.TabIndex = 1
	$buttonRemoveEndpointSecuri.Text = 'Remove Endpoint Security'
	$buttonRemoveEndpointSecuri.UseVisualStyleBackColor = $True
	$buttonRemoveEndpointSecuri.add_Click($buttonRemoveEndpointSecuri_Click)
	#
	# buttonRemoveAgent
	#
	$buttonRemoveAgent.Location = New-Object System.Drawing.Point(8, 48)
	$buttonRemoveAgent.Name = 'buttonRemoveAgent'
	$buttonRemoveAgent.Size = New-Object System.Drawing.Size(208, 23)
	$buttonRemoveAgent.TabIndex = 0
	$buttonRemoveAgent.Text = 'Remove Agent'
	$buttonRemoveAgent.UseVisualStyleBackColor = $True
	$buttonRemoveAgent.add_Click($buttonRemoveAgent_Click)
	#
	# statusbar
	#
	$statusbar.Location = New-Object System.Drawing.Point(0, 350)
	$statusbar.Name = 'statusbar'
	$statusbar.Size = New-Object System.Drawing.Size(246, 22)
	$statusbar.TabIndex = 7
	#
	# groupbox2
	#
	$groupbox2.Controls.Add($button4RemoveTrellixFolder)
	$groupbox2.Controls.Add($button5RebootIntoWindows)
	$groupbox2.Location = New-Object System.Drawing.Point(12, 250)
	$groupbox2.Name = 'groupbox2'
	$groupbox2.Size = New-Object System.Drawing.Size(222, 83)
	$groupbox2.TabIndex = 6
	$groupbox2.TabStop = $False
	$groupbox2.Text = 'Safe Mode Tasks'
	#
	# button4RemoveTrellixFolder
	#
	$button4RemoveTrellixFolder.Location = New-Object System.Drawing.Point(8, 20)
	$button4RemoveTrellixFolder.Name = 'button4RemoveTrellixFolder'
	$button4RemoveTrellixFolder.Size = New-Object System.Drawing.Size(208, 23)
	$button4RemoveTrellixFolder.TabIndex = 5
	$button4RemoveTrellixFolder.Text = '4- Remove Trellix folders'
	$button4RemoveTrellixFolder.UseVisualStyleBackColor = $True
	$button4RemoveTrellixFolder.add_Click($button4RemoveTrellixFolder_Click)
	#
	# button5RebootIntoWindows
	#
	$button5RebootIntoWindows.Location = New-Object System.Drawing.Point(7, 48)
	$button5RebootIntoWindows.Name = 'button5RebootIntoWindows'
	$button5RebootIntoWindows.Size = New-Object System.Drawing.Size(209, 23)
	$button5RebootIntoWindows.TabIndex = 4
	$button5RebootIntoWindows.Text = '5- Reboot into Windows'
	$button5RebootIntoWindows.UseVisualStyleBackColor = $True
	$button5RebootIntoWindows.add_Click($button5RebootIntoWindows_Click)
	#
	# groupbox1
	#
	$groupbox1.Controls.Add($button1BackupRegistry)
	$groupbox1.Controls.Add($button2RemoveSafeBootKeys)
	$groupbox1.Controls.Add($button3RebootInSafeMode)
	$groupbox1.Location = New-Object System.Drawing.Point(13, 112)
	$groupbox1.Name = 'groupbox1'
	$groupbox1.Size = New-Object System.Drawing.Size(221, 112)
	$groupbox1.TabIndex = 5
	$groupbox1.TabStop = $False
	$groupbox1.Text = 'System Preparation'
	#
	# button1BackupRegistry
	#
	$button1BackupRegistry.Location = New-Object System.Drawing.Point(7, 20)
	$button1BackupRegistry.Name = 'button1BackupRegistry'
	$button1BackupRegistry.Size = New-Object System.Drawing.Size(208, 23)
	$button1BackupRegistry.TabIndex = 4
	$button1BackupRegistry.Text = '1- Backup Registry'
	$button1BackupRegistry.UseVisualStyleBackColor = $True
	$button1BackupRegistry.add_Click($button1BackupRegistry_Click)
	#
	# button2RemoveSafeBootKeys
	#
	$button2RemoveSafeBootKeys.Location = New-Object System.Drawing.Point(6, 49)
	$button2RemoveSafeBootKeys.Name = 'button2RemoveSafeBootKeys'
	$button2RemoveSafeBootKeys.Size = New-Object System.Drawing.Size(209, 23)
	$button2RemoveSafeBootKeys.TabIndex = 2
	$button2RemoveSafeBootKeys.Text = '2- Remove SafeBoot keys'
	$button2RemoveSafeBootKeys.UseVisualStyleBackColor = $True
	$button2RemoveSafeBootKeys.add_Click($button2RemoveSafeBootKeys_Click)
	#
	# button3RebootInSafeMode
	#
	$button3RebootInSafeMode.Location = New-Object System.Drawing.Point(7, 78)
	$button3RebootInSafeMode.Name = 'button3RebootInSafeMode'
	$button3RebootInSafeMode.Size = New-Object System.Drawing.Size(208, 23)
	$button3RebootInSafeMode.TabIndex = 3
	$button3RebootInSafeMode.Text = '3- Reboot in Safe Mode'
	$button3RebootInSafeMode.UseVisualStyleBackColor = $True
	$button3RebootInSafeMode.add_Click($button3RebootInSafeMode_Click)
	$groupbox1.ResumeLayout()
	$groupbox2.ResumeLayout()
	$groupbox3.ResumeLayout()
	$formTrellixEndpointSecur.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formTrellixEndpointSecur.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formTrellixEndpointSecur.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formTrellixEndpointSecur.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formTrellixEndpointSecur.ShowDialog()

} #End Function

#Call the form
Show-Remove-ENS_psf | Out-Null

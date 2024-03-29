function Show-Update-Checker_psf {

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
	$formUpdateChecker = New-Object 'System.Windows.Forms.Form'
	$statusbar1 = New-Object 'System.Windows.Forms.StatusBar'
	$labelLatestVersion = New-Object 'System.Windows.Forms.Label'
	$labelInstalledVersion = New-Object 'System.Windows.Forms.Label'
	$textboxLatestDLP = New-Object 'System.Windows.Forms.TextBox'
	$textboxLatestAgent = New-Object 'System.Windows.Forms.TextBox'
	$labelDataLossPrevention = New-Object 'System.Windows.Forms.Label'
	$textboxDLPVersion = New-Object 'System.Windows.Forms.TextBox'
	$textboxLatestFRP = New-Object 'System.Windows.Forms.TextBox'
	$buttonOK = New-Object 'System.Windows.Forms.Button'
	$textboxFRPVersion = New-Object 'System.Windows.Forms.TextBox'
	$labelFileAndRemovableMedi = New-Object 'System.Windows.Forms.Label'
	$textboxLatestTP = New-Object 'System.Windows.Forms.TextBox'
	$labelAgent = New-Object 'System.Windows.Forms.Label'
	$textboxFWVersion = New-Object 'System.Windows.Forms.TextBox'
	$labelThreatPrevention = New-Object 'System.Windows.Forms.Label'
	$textboxLatestFW = New-Object 'System.Windows.Forms.TextBox'
	$labelFirewall = New-Object 'System.Windows.Forms.Label'
	$textboxATPVersion = New-Object 'System.Windows.Forms.TextBox'
	$labelAdaptiveThreatProtec = New-Object 'System.Windows.Forms.Label'
	$textboxLatestATP = New-Object 'System.Windows.Forms.TextBox'
	$textboxAgentVersion = New-Object 'System.Windows.Forms.TextBox'
	$textboxTPVersion = New-Object 'System.Windows.Forms.TextBox'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	########### AGENT VERSION
	
	function Get-AgentVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Agent\masvc.exe") -eq $true)
		{
			$textboxAgentVersion.Text = (Get-Item "C:\Program Files\McAfee\Agent\masvc.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxAgentVersion.Text = "Not installed"
		}
	}
	
	Get-AgentVersion
	
	########### TP VERSION
	
	function Get-TPVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Threat Prevention\mfetp.exe") -eq $true)
		{
			$textboxTPVersion.Text = (Get-Item "C:\Program Files\McAfee\Endpoint Security\Threat Prevention\mfetp.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxTPVersion.Text = "Not installed"
		}
	}
	
	Get-TPVersion
	
	########### ATP VERSION
	
	function Get-ATPVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Adaptive Threat Protection\mfeatp.exe") -eq $true)
		{
			$textboxATPVersion.Text = (Get-Item "C:\Program Files\McAfee\Endpoint Security\Adaptive Threat Protection\mfeatp.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxATPVersion.Text = "Not installed"
		}
	}
	
	Get-ATPVersion
	
	########### FIREWALL VERSION
	
	function Get-FWVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Firewall\mfefw.exe") -eq $true)
		{
			$textboxFWVersion.Text = (Get-Item "C:\Program Files\McAfee\Endpoint Security\Firewall\mfefw.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxFWVersion.Text = "Not installed"
		}
	}
	
	Get-FWVersion
	
	########### FRP VERSION
	
	function Get-FRPVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Encryption for Files and Folders\MfeFfCore.exe") -eq $true)
		{
			$FRPVersion = (Get-Item "C:\Program Files\McAfee\Endpoint Encryption for Files and Folders\MfeFfCore.exe").VersionInfo.FileVersion | Out-String
			$FRPVersion = $FRPVersion.Replace(", ", ".").Replace("`n", "").Replace("`r", "")
			$textboxFRPVersion.Text = $FRPVersion
		}
		else
		{
			$textboxFRPVersion.Text = "Not installed"
		}
	}
	
	Get-FRPVersion
	
	########### DLP VERSION
	
	function Get-DLPVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\DLP\Agent\fcag.exe") -eq $true)
		{
			$textboxDLPVersion.Text = (Get-Item "C:\Program Files\McAfee\DLP\Agent\fcag.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxDLPVersion.Text = "Not installed"
		}
	}
	
	Get-DLPVersion
	
	################### LATEST VERSIONS
	
	Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dekkerpt/SMT/main/Versions.txt" -OutFile $env:TEMP\Versions.txt
	$VersionsFile = Get-Content -Path "$env:TEMP\Versions.txt"
	
	$LatestAgent = ($VersionsFile | Select-Object -Index 0).SubString(6, 9)
	$LatestTP = ($VersionsFile | Select-Object -Index 1).SubString(3, 11)
	$LatestFW = ($VersionsFile | Select-Object -Index 2).SubString(3, 11)
	$LatestATP = ($VersionsFile | Select-Object -Index 3).SubString(4, 11)
	$LatestFRP = ($VersionsFile | Select-Object -Index 4).SubString(4, 9)
	$LatestDLP = ($VersionsFile | Select-Object -Index 5).SubString(4, 12)
	
	# Convert Strings to Integers for comparison
	# Getting file versions from all the modules installed on the local system
	$AgentVersionN = [int]((Get-Item "C:\Program Files\McAfee\Agent\masvc.exe").VersionInfo.FileVersion).Replace(".",",")
	$TPVersionN = [int]((Get-Item "C:\Program Files\McAfee\Endpoint Security\Threat Prevention\mfetp.exe").VersionInfo.FileVersion).Replace(".",",")
	$FWVersionN = [int]((Get-Item "C:\Program Files\McAfee\Endpoint Security\Firewall\mfefw.exe").VersionInfo.FileVersion).Replace(".",",")
	$ATPVersionN = [int]((Get-Item "C:\Program Files\McAfee\Endpoint Security\Adaptive Threat Protection\mfeatp.exe").VersionInfo.FileVersion).Replace(".",",")
	$FRPVersionN = [int]((Get-Item "C:\Program Files\McAfee\Endpoint Encryption for Files and Folders\MfeFfCore.exe").VersionInfo.FileVersion).Replace(" ","")
	$DLPVersionN = [int]((Get-Item "C:\Program Files\McAfee\DLP\Agent\fcag.exe").VersionInfo.FileVersion).Replace(".",",")
	
	# Converting the latest 
	$LatestAgentN = [int]$LatestAgent.Replace(".",",")
	$LatestTPN = [int]$LatestTP.Replace(".", ",")
	$LatestFWN = [int]$LatestFW.Replace(".", ",")
	$LatestATPN = [int]$LatestATP.Replace(".", ",")
	$LatestFRPN = [int]$LatestFRP.Replace(".", ",")
	$LatestDLPN = [int]$LatestDLP.Replace(".", ",")
	
	#### CHECK AGENT VERSION
	
	if ($textboxAgentVersion.Text -eq "Not installed")
	{
		$textboxLatestAgent.Text = ""
	}
	elseif ($textboxAgentVersion.Text -eq $LatestAgent)
	{
		$textboxLatestAgent.Text = $LatestAgent
		$textboxAgentVersion.ForeColor = 'White'
		$textboxAgentVersion.BackColor= 'Green'
	}
	elseif ($AgentVersionN -lt $LatestAgentN)
	{
		$textboxLatestAgent.Text = $LatestAgent
		$textboxAgentVersion.ForeColor = 'Black'
		$textboxAgentVersion.BackColor = 'Yellow'
	}
	
	#### CHECK TP VERSION
	
	if ($textboxTPVersion.Text -eq "Not installed")
	{
		$textboxLatestTP.Text = ""
	}
	elseif ($textboxTPVersion.Text -eq $LatestTP)
	{
		$textboxLatestTP.Text = $LatestTP
		$textboxTPVersion.ForeColor = 'White'
		$textboxTPVersion.BackColor = 'Green'
	}
	elseif ($TPVersionN -lt $LatestTPN)
	{
		$textboxLatestTP.Text = $LatestTP
		$textboxTPVersion.ForeColor = 'Black'
		$textboxTPVersion.BackColor = 'Yellow'
	}
	
	#### CHECK FW VERSION
	
	if ($textboxFWVersion.Text -eq "Not installed")
	{
		$textboxLatestFW.Text = ""
	}
	elseif ($textboxFWVersion.Text -eq $LatestFW)
	{
		$textboxLatestFW.Text = $LatestFW
		$textboxFWVersion.ForeColor = 'White'
		$textboxFWVersion.BackColor = 'Green'
	}
	elseif ($FWVersionN -lt $LatestFWN)
	{
		$textboxLatestFW.Text = $LatestFW
		$textboxFWVersion.ForeColor = 'Black'
		$textboxFWVersion.BackColor = 'Yellow'
	}
	
	#### CHECK ATP VERSION
	
	if ($textboxATPVersion.Text -eq "Not installed")
	{
		$textboxLatestATP.Text = ""
	}
	elseif ($textboxATPVersion.Text -eq $LatestATP)
	{
		$textboxLatestATP.Text = $LatestATP
		$textboxATPVersion.ForeColor = 'White'
		$textboxATPVersion.BackColor = 'Green'
	}
	elseif ($ATPVersionN -lt $LatestATPN)
	{
		$textboxLatestATP.Text = $LatestATP
		$textboxATPVersion.ForeColor = 'Black'
		$textboxATPVersion.BackColor = 'Yellow'
	}
	
	#### CHECK FRP VERSION
	
	if ($textboxFRPVersion.Text -eq "Not installed")
	{
		$textboxLatestFRP.Text = ""
	}
	elseif ($textboxFRPVersion.Text -eq $LatestFRP)
	{
		$textboxLatestFRP.Text = $LatestFRP
		$textboxFRPVersion.ForeColor = 'White'
		$textboxFRPVersion.BackColor = 'Green'
	}
	elseif ($FRPVersionN -lt $LatestFRPN)
	{
		$textboxLatestFRP.Text = $LatestFRP
		$textboxFRPVersion.ForeColor = 'Black'
		$textboxFRPVersion.BackColor = 'Yellow'
	}
	
	#### CHECK DLP VERSION
	
	if ($textboxDLPVersion.Text -eq "Not installed")
	{
		$textboxLatestDLP.Text = ""
	}
	elseif ($textboxDLPVersion.Text -eq $LatestDLP)
	{
		$textboxLatestDLP.Text = $LatestDLP
		$textboxDLPVersion.ForeColor = 'White'
		$textboxDLPVersion.BackColor = 'Green'
	}
	elseif ($DLPVersionN -lt $LatestDLPN)
	{
		$textboxLatestDLP.Text = $LatestDLP
		$textboxDLPVersion.ForeColor = 'Black'
		$textboxDLPVersion.BackColor = 'Yellow'
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formUpdateChecker.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$formUpdateChecker.remove_Load($Form_StateCorrection_Load)
			$formUpdateChecker.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formUpdateChecker.SuspendLayout()
	#
	# formUpdateChecker
	#
	$formUpdateChecker.Controls.Add($statusbar1)
	$formUpdateChecker.Controls.Add($labelLatestVersion)
	$formUpdateChecker.Controls.Add($labelInstalledVersion)
	$formUpdateChecker.Controls.Add($textboxLatestDLP)
	$formUpdateChecker.Controls.Add($textboxLatestAgent)
	$formUpdateChecker.Controls.Add($labelDataLossPrevention)
	$formUpdateChecker.Controls.Add($textboxDLPVersion)
	$formUpdateChecker.Controls.Add($textboxLatestFRP)
	$formUpdateChecker.Controls.Add($buttonOK)
	$formUpdateChecker.Controls.Add($textboxFRPVersion)
	$formUpdateChecker.Controls.Add($labelFileAndRemovableMedi)
	$formUpdateChecker.Controls.Add($textboxLatestTP)
	$formUpdateChecker.Controls.Add($labelAgent)
	$formUpdateChecker.Controls.Add($textboxFWVersion)
	$formUpdateChecker.Controls.Add($labelThreatPrevention)
	$formUpdateChecker.Controls.Add($textboxLatestFW)
	$formUpdateChecker.Controls.Add($labelFirewall)
	$formUpdateChecker.Controls.Add($textboxATPVersion)
	$formUpdateChecker.Controls.Add($labelAdaptiveThreatProtec)
	$formUpdateChecker.Controls.Add($textboxLatestATP)
	$formUpdateChecker.Controls.Add($textboxAgentVersion)
	$formUpdateChecker.Controls.Add($textboxTPVersion)
	$formUpdateChecker.AcceptButton = $buttonOK
	$formUpdateChecker.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 13)
	$formUpdateChecker.AutoScaleMode = 'Font'
	$formUpdateChecker.ClientSize = New-Object System.Drawing.Size(363, 284)
	$formUpdateChecker.FormBorderStyle = 'FixedDialog'
	$formUpdateChecker.MaximizeBox = $False
	$formUpdateChecker.MinimizeBox = $False
	$formUpdateChecker.Name = 'formUpdateChecker'
	$formUpdateChecker.StartPosition = 'CenterScreen'
	$formUpdateChecker.Text = 'Update Checker'
	#
	# statusbar1
	#
	$statusbar1.Location = New-Object System.Drawing.Point(0, 262)
	$statusbar1.Name = 'statusbar1'
	$statusbar1.Size = New-Object System.Drawing.Size(363, 22)
	$statusbar1.TabIndex = 27
	$statusbar1.Text = 'Use the Trellix Software menu to update to the latest version'
	#
	# labelLatestVersion
	#
	$labelLatestVersion.AutoSize = $True
	$labelLatestVersion.Location = New-Object System.Drawing.Point(260, 13)
	$labelLatestVersion.Name = 'labelLatestVersion'
	$labelLatestVersion.Size = New-Object System.Drawing.Size(74, 13)
	$labelLatestVersion.TabIndex = 25
	$labelLatestVersion.Text = 'Latest Version'
	#
	# labelInstalledVersion
	#
	$labelInstalledVersion.AutoSize = $True
	$labelInstalledVersion.Location = New-Object System.Drawing.Point(156, 13)
	$labelInstalledVersion.Name = 'labelInstalledVersion'
	$labelInstalledVersion.Size = New-Object System.Drawing.Size(84, 13)
	$labelInstalledVersion.TabIndex = 24
	$labelInstalledVersion.Text = 'Installed Version'
	#
	# textboxLatestDLP
	#
	$textboxLatestDLP.Location = New-Object System.Drawing.Point(260, 181)
	$textboxLatestDLP.Name = 'textboxLatestDLP'
	$textboxLatestDLP.ReadOnly = $True
	$textboxLatestDLP.Size = New-Object System.Drawing.Size(89, 20)
	$textboxLatestDLP.TabIndex = 23
	$textboxLatestDLP.TextAlign = 'Center'
	#
	# textboxLatestAgent
	#
	$textboxLatestAgent.Location = New-Object System.Drawing.Point(260, 34)
	$textboxLatestAgent.Name = 'textboxLatestAgent'
	$textboxLatestAgent.ReadOnly = $True
	$textboxLatestAgent.Size = New-Object System.Drawing.Size(90, 20)
	$textboxLatestAgent.TabIndex = 13
	$textboxLatestAgent.TextAlign = 'Center'
	#
	# labelDataLossPrevention
	#
	$labelDataLossPrevention.AutoSize = $True
	$labelDataLossPrevention.Location = New-Object System.Drawing.Point(11, 185)
	$labelDataLossPrevention.Name = 'labelDataLossPrevention'
	$labelDataLossPrevention.Size = New-Object System.Drawing.Size(109, 13)
	$labelDataLossPrevention.TabIndex = 10
	$labelDataLossPrevention.Text = 'Data Loss Prevention'
	#
	# textboxDLPVersion
	#
	$textboxDLPVersion.Location = New-Object System.Drawing.Point(156, 182)
	$textboxDLPVersion.Name = 'textboxDLPVersion'
	$textboxDLPVersion.ReadOnly = $True
	$textboxDLPVersion.Size = New-Object System.Drawing.Size(89, 20)
	$textboxDLPVersion.TabIndex = 11
	$textboxDLPVersion.TextAlign = 'Center'
	#
	# textboxLatestFRP
	#
	$textboxLatestFRP.Location = New-Object System.Drawing.Point(260, 149)
	$textboxLatestFRP.Name = 'textboxLatestFRP'
	$textboxLatestFRP.ReadOnly = $True
	$textboxLatestFRP.Size = New-Object System.Drawing.Size(89, 20)
	$textboxLatestFRP.TabIndex = 21
	$textboxLatestFRP.TextAlign = 'Center'
	#
	# buttonOK
	#
	$buttonOK.Anchor = 'Bottom, Right'
	$buttonOK.DialogResult = 'OK'
	$buttonOK.Location = New-Object System.Drawing.Point(259, 221)
	$buttonOK.Name = 'buttonOK'
	$buttonOK.Size = New-Object System.Drawing.Size(90, 23)
	$buttonOK.TabIndex = 0
	$buttonOK.Text = '&OK'
	$buttonOK.UseCompatibleTextRendering = $True
	$buttonOK.UseVisualStyleBackColor = $True
	#
	# textboxFRPVersion
	#
	$textboxFRPVersion.Location = New-Object System.Drawing.Point(156, 150)
	$textboxFRPVersion.Name = 'textboxFRPVersion'
	$textboxFRPVersion.ReadOnly = $True
	$textboxFRPVersion.Size = New-Object System.Drawing.Size(89, 20)
	$textboxFRPVersion.TabIndex = 9
	$textboxFRPVersion.TextAlign = 'Center'
	#
	# labelFileAndRemovableMedi
	#
	$labelFileAndRemovableMedi.AutoSize = $True
	$labelFileAndRemovableMedi.Location = New-Object System.Drawing.Point(11, 153)
	$labelFileAndRemovableMedi.Name = 'labelFileAndRemovableMedi'
	$labelFileAndRemovableMedi.Size = New-Object System.Drawing.Size(133, 13)
	$labelFileAndRemovableMedi.TabIndex = 8
	$labelFileAndRemovableMedi.Text = 'File and Removable Media'
	#
	# textboxLatestTP
	#
	$textboxLatestTP.Location = New-Object System.Drawing.Point(260, 61)
	$textboxLatestTP.Name = 'textboxLatestTP'
	$textboxLatestTP.ReadOnly = $True
	$textboxLatestTP.Size = New-Object System.Drawing.Size(90, 20)
	$textboxLatestTP.TabIndex = 15
	$textboxLatestTP.TextAlign = 'Center'
	#
	# labelAgent
	#
	$labelAgent.AutoSize = $True
	$labelAgent.Location = New-Object System.Drawing.Point(12, 38)
	$labelAgent.Name = 'labelAgent'
	$labelAgent.Size = New-Object System.Drawing.Size(35, 13)
	$labelAgent.TabIndex = 0
	$labelAgent.Text = 'Agent'
	#
	# textboxFWVersion
	#
	$textboxFWVersion.Location = New-Object System.Drawing.Point(156, 119)
	$textboxFWVersion.Name = 'textboxFWVersion'
	$textboxFWVersion.ReadOnly = $True
	$textboxFWVersion.Size = New-Object System.Drawing.Size(90, 20)
	$textboxFWVersion.TabIndex = 7
	$textboxFWVersion.TextAlign = 'Center'
	#
	# labelThreatPrevention
	#
	$labelThreatPrevention.AutoSize = $True
	$labelThreatPrevention.Location = New-Object System.Drawing.Point(12, 65)
	$labelThreatPrevention.Name = 'labelThreatPrevention'
	$labelThreatPrevention.Size = New-Object System.Drawing.Size(92, 13)
	$labelThreatPrevention.TabIndex = 2
	$labelThreatPrevention.Text = 'Threat Prevention'
	#
	# textboxLatestFW
	#
	$textboxLatestFW.Location = New-Object System.Drawing.Point(260, 118)
	$textboxLatestFW.Name = 'textboxLatestFW'
	$textboxLatestFW.ReadOnly = $True
	$textboxLatestFW.Size = New-Object System.Drawing.Size(90, 20)
	$textboxLatestFW.TabIndex = 19
	$textboxLatestFW.TextAlign = 'Center'
	#
	# labelFirewall
	#
	$labelFirewall.AutoSize = $True
	$labelFirewall.Location = New-Object System.Drawing.Point(12, 122)
	$labelFirewall.Name = 'labelFirewall'
	$labelFirewall.Size = New-Object System.Drawing.Size(42, 13)
	$labelFirewall.TabIndex = 6
	$labelFirewall.Text = 'Firewall'
	#
	# textboxATPVersion
	#
	$textboxATPVersion.Location = New-Object System.Drawing.Point(156, 90)
	$textboxATPVersion.Name = 'textboxATPVersion'
	$textboxATPVersion.ReadOnly = $True
	$textboxATPVersion.Size = New-Object System.Drawing.Size(90, 20)
	$textboxATPVersion.TabIndex = 5
	$textboxATPVersion.TextAlign = 'Center'
	#
	# labelAdaptiveThreatProtec
	#
	$labelAdaptiveThreatProtec.AutoSize = $True
	$labelAdaptiveThreatProtec.Location = New-Object System.Drawing.Point(12, 93)
	$labelAdaptiveThreatProtec.Name = 'labelAdaptiveThreatProtec'
	$labelAdaptiveThreatProtec.Size = New-Object System.Drawing.Size(134, 13)
	$labelAdaptiveThreatProtec.TabIndex = 4
	$labelAdaptiveThreatProtec.Text = 'Adaptive Threat Protection'
	#
	# textboxLatestATP
	#
	$textboxLatestATP.Location = New-Object System.Drawing.Point(260, 89)
	$textboxLatestATP.Name = 'textboxLatestATP'
	$textboxLatestATP.ReadOnly = $True
	$textboxLatestATP.Size = New-Object System.Drawing.Size(90, 20)
	$textboxLatestATP.TabIndex = 17
	$textboxLatestATP.TextAlign = 'Center'
	#
	# textboxAgentVersion
	#
	$textboxAgentVersion.Location = New-Object System.Drawing.Point(156, 35)
	$textboxAgentVersion.Name = 'textboxAgentVersion'
	$textboxAgentVersion.ReadOnly = $True
	$textboxAgentVersion.Size = New-Object System.Drawing.Size(90, 20)
	$textboxAgentVersion.TabIndex = 1
	$textboxAgentVersion.TextAlign = 'Center'
	#
	# textboxTPVersion
	#
	$textboxTPVersion.Location = New-Object System.Drawing.Point(156, 62)
	$textboxTPVersion.Name = 'textboxTPVersion'
	$textboxTPVersion.ReadOnly = $True
	$textboxTPVersion.Size = New-Object System.Drawing.Size(90, 20)
	$textboxTPVersion.TabIndex = 3
	$textboxTPVersion.TextAlign = 'Center'
	$formUpdateChecker.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formUpdateChecker.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formUpdateChecker.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formUpdateChecker.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $formUpdateChecker.ShowDialog()

} #End Function

#Call the form
Show-Update-Checker_psf | Out-Null

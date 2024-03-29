function Show-ESS_psf {

	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Design, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Define SAPIEN Types
	#----------------------------------------------
	try{
		[ProgressBarOverlay] | Out-Null
	}
	catch
	{
        if ($PSVersionTable.PSVersion.Major -ge 7)
		{
			$Assemblies = 'System.Windows.Forms', 'System.Drawing', 'System.Drawing.Primitives', 'System.ComponentModel.Primitives', 'System.Drawing.Common', 'System.Runtime'
            if ($PSVersionTable.PSVersion.Minor -ge 1)
			{
				$Assemblies += 'System.Windows.Forms.Primitives'
			}
		}
		else
		{
			$Assemblies = 'System.Windows.Forms', 'System.Drawing'  

        }
		Add-Type -ReferencedAssemblies $Assemblies -TypeDefinition @"
		using System;
		using System.Windows.Forms;
		using System.Drawing;
        namespace SAPIENTypes
        {
		    public class ProgressBarOverlay : System.Windows.Forms.ProgressBar
	        {
                public ProgressBarOverlay() : base() { SetStyle(ControlStyles.OptimizedDoubleBuffer | ControlStyles.AllPaintingInWmPaint, true); }
	            protected override void WndProc(ref Message m)
	            { 
	                 base.WndProc(ref m);
            if (m.Msg == 0x000F)// WM_PAINT
            {
                if (Style != System.Windows.Forms.ProgressBarStyle.Marquee || !string.IsNullOrEmpty(this.Text))
                {
                    using (Graphics g = this.CreateGraphics())
                    {
                        if (_SetProgressBarColors)
                        {
                            SolidBrush brush = null;
                            Rectangle rec = new Rectangle(0, 0, this.Width, this.Height);
                            double scaleFactor = (((double)Value - (double)Minimum) / ((double)Maximum - (double)Minimum));
                            if (ProgressBarRenderer.IsSupported)
                                ProgressBarRenderer.DrawHorizontalBar(g, rec);
                            rec.Width = (int)((rec.Width * scaleFactor) - 4);
                            rec.Height -= 4;
                            brush = new SolidBrush(this.BackColor);
                            g.FillRectangle(brush, 2, 2, rec.Width, rec.Height);
                        }
                        using (StringFormat stringFormat = new StringFormat(StringFormatFlags.NoWrap))
                        {
                            stringFormat.Alignment = StringAlignment.Center;
                            stringFormat.LineAlignment = StringAlignment.Center;
                            var fontbrush = new SolidBrush(_SetProgressBarColors? this.ForeColor : System.Drawing.Color.Black);
                            if (!string.IsNullOrEmpty(this.Text))
                                g.DrawString(this.Text, this.Font, fontbrush, this.ClientRectangle, stringFormat);
                            else
                            {
                                int percent = (int)(((double)Value / (double)Maximum) * 100);
                                g.DrawString(percent.ToString() + "%", this.Font, fontbrush, this.ClientRectangle, stringFormat);
                            }
                        }
                    }
                }
            }
	            }
              
                public string TextOverlay
                {
                    get
                    {
                        return base.Text;
                    }
                    set
                    {
                        base.Text = value;
                        Invalidate();
                    }
                }

                bool _SetProgressBarColors = false;

       
                public bool SetProgressBarColors
                {
                    get { return _SetProgressBarColors; }
                    set { _SetProgressBarColors = value; Invalidate(); }
                }
	        }
        }
"@ -IgnoreWarnings | Out-Null
	}
	#endregion Define SAPIEN Types

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$ESS = New-Object 'System.Windows.Forms.Form'
	$progressbaroverlay1 = New-Object 'SAPIENTypes.ProgressBarOverlay'
	$statusbar1 = New-Object 'System.Windows.Forms.StatusBar'
	$picturebox2 = New-Object 'System.Windows.Forms.PictureBox'
	$picturebox1 = New-Object 'System.Windows.Forms.PictureBox'
	$groupbox2 = New-Object 'System.Windows.Forms.GroupBox'
	$groupbox10 = New-Object 'System.Windows.Forms.GroupBox'
	$labelVersion = New-Object 'System.Windows.Forms.Label'
	$labelStatus = New-Object 'System.Windows.Forms.Label'
	$textboxDLPStatus = New-Object 'System.Windows.Forms.TextBox'
	$textboxDLPVersion = New-Object 'System.Windows.Forms.TextBox'
	$groupbox9 = New-Object 'System.Windows.Forms.GroupBox'
	$label7 = New-Object 'System.Windows.Forms.Label'
	$label8 = New-Object 'System.Windows.Forms.Label'
	$textboxFRPStatus = New-Object 'System.Windows.Forms.TextBox'
	$textboxFRPVersion = New-Object 'System.Windows.Forms.TextBox'
	$groupbox8 = New-Object 'System.Windows.Forms.GroupBox'
	$label9 = New-Object 'System.Windows.Forms.Label'
	$label10 = New-Object 'System.Windows.Forms.Label'
	$textboxATPStatus = New-Object 'System.Windows.Forms.TextBox'
	$textboxATPVersion = New-Object 'System.Windows.Forms.TextBox'
	$groupbox7 = New-Object 'System.Windows.Forms.GroupBox'
	$label3 = New-Object 'System.Windows.Forms.Label'
	$label4 = New-Object 'System.Windows.Forms.Label'
	$textboxFWStatus = New-Object 'System.Windows.Forms.TextBox'
	$textboxFWVersion = New-Object 'System.Windows.Forms.TextBox'
	$groupbox4 = New-Object 'System.Windows.Forms.GroupBox'
	$label5 = New-Object 'System.Windows.Forms.Label'
	$label6 = New-Object 'System.Windows.Forms.Label'
	$textboxAgentStatus = New-Object 'System.Windows.Forms.TextBox'
	$textboxAgentVersion = New-Object 'System.Windows.Forms.TextBox'
	$groupbox5 = New-Object 'System.Windows.Forms.GroupBox'
	$label1 = New-Object 'System.Windows.Forms.Label'
	$label2 = New-Object 'System.Windows.Forms.Label'
	$textboxENSStatus = New-Object 'System.Windows.Forms.TextBox'
	$textboxENSVersion = New-Object 'System.Windows.Forms.TextBox'
	$groupbox1 = New-Object 'System.Windows.Forms.GroupBox'
	$groupbox14 = New-Object 'System.Windows.Forms.GroupBox'
	$labelEPOEnvironment = New-Object 'System.Windows.Forms.Label'
	$textboxLastCommunication = New-Object 'System.Windows.Forms.TextBox'
	$textboxEPOEnvironment = New-Object 'System.Windows.Forms.TextBox'
	$labelLastCommunication = New-Object 'System.Windows.Forms.Label'
	$textboxRebootTime = New-Object 'System.Windows.Forms.TextBox'
	$labelLastRebootTime = New-Object 'System.Windows.Forms.Label'
	$textboxRebootPending = New-Object 'System.Windows.Forms.TextBox'
	$labelRebootPending = New-Object 'System.Windows.Forms.Label'
	$labelHostname = New-Object 'System.Windows.Forms.Label'
	$textboxHostname = New-Object 'System.Windows.Forms.TextBox'
	$labelUserID = New-Object 'System.Windows.Forms.Label'
	$textboxUserID = New-Object 'System.Windows.Forms.TextBox'
	$menustrip1 = New-Object 'System.Windows.Forms.MenuStrip'
	$helpToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$aboutToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$troubleshootingToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$installToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$checkForUpdatesToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator1 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$toolsToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$runMERToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$runRemovalToolToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$runManualRemovalToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$agentToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$endpointSecurityToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$fileAndRemovableProtectionToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$dataLossPreventionjToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$reinstallAgentToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator2 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$changeEPOToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$testConnectionToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$forceAgentSyncToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$checkLogsToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$fRPToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$fRPToolToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$uninstallFRPToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator3 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$removeFRPCacheToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$removeFRPUserCacheToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$removeFRPAllUsersCacheToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$reinstallENSToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$reinstallFRPToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$reinstallDLPToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$checkForUpdatesToolStripMenuItem1 = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$toolstripseparator4 = New-Object 'System.Windows.Forms.ToolStripSeparator'
	$installFWToolStripMenuItem = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	function New-PopUp
	{
		<#
		.SYNOPSIS
		    New-Popup will display a popup message
		.DESCRIPTION
		    The New-Popup command uses the Wscript.Shell PopUp method to display a graphical message
		    box. You can customize its appearance of icons and buttons. By default the user
		    must click a button to dismiss but you can set a timeout value in seconds to
		    automatically dismiss the popup.
		 
		    The command will write the return value of the clicked button to the pipeline:
		    OK = 1
		    Cancel = 2
		    Abort = 3
		    Retry = 4
		    Ignore = 5
		    Yes = 6
		    No = 7
		 
		    If no button is clicked, the return value is -1.
		.PARAMETER Message
		    The message you want displayed
		.PARAMETER Title
		    The text to appear in title bar of dialog box
		.PARAMETER Time
		    The time to display the message. Defaults to 0 (zero) which will keep dialog open until a button is clicked
		.PARAMETER Buttons
		    Valid values for -Buttons include:
		    "OK"
		    "OKCancel"
		    "AbortRetryIgnore"
		    "YesNo"
		    "YesNoCancel"
		    "RetryCancel"
		.PARAMETER Icon
		    Valid values for -Icon include:
		    "Stop"
		    "Question"
		    "Exclamation"
		    "Information"
		    "None"
		.PARAMETER ShowOnTop
		    Switch which will force the popup window to appear on top of all other windows.
		.PARAMETER AsString
		    Will return a human readable representation of which button was pressed as opposed to an integer value.
		.EXAMPLE
		    new-popup -message "The update script has completed" -title "Finished" -time 5
		 
		    This will display a popup message using the default OK button and default
		    Information icon. The popup will automatically dismiss after 5 seconds.
		.EXAMPLE
		    $answer = new-popup -Message "Please pick" -Title "form" -buttons "OKCancel" -icon "information"
		 
		    If the user clicks "OK" the $answer variable will be equal to 1. If the user clicks "Cancel" the
		    $answer variable will be equal to 2.
		.EXAMPLE
		    $answer = new-popup -Message "Please pick" -Title "form" -buttons "OKCancel" -icon "information" -AsString
		 
		    If the user clicks "OK" the $answer variable will be equal to 'OK'. If the user clicks "Cancel" the
		    $answer variable will be 'Cancel'
		.OUTPUTS
		    An integer with the following value depending upon the button pushed.
		 
		    Timeout = -1 # Value when timer finishes countdown.
		    OK = 1
		    Cancel = 2
		    Abort = 3
		    Retry = 4
		    Ignore = 5
		    Yes = 6
		    No = 7
		.LINK
		    Wscript.Shell
		#>
		
		#region Parameters
		[CmdletBinding()]
		[OutputType('int')]
		[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseShouldProcessForStateChangingFunctions', '')]
		Param (
			[Parameter(Position = 0, Mandatory, HelpMessage = 'Enter a message for the popup')]
			[ValidateNotNullorEmpty()]
			[string]$Message,
			[Parameter(Position = 1, Mandatory, HelpMessage = 'Enter a title for the popup')]
			[ValidateNotNullorEmpty()]
			[string]$Title,
			[Parameter(Position = 2)]
			[ValidateScript({ $_ -ge 0 })]
			[int]$Time = 0,
			[Parameter(Position = 3)]
			[ValidateNotNullorEmpty()]
			[ValidateSet('OK', 'OKCancel', 'AbortRetryIgnore', 'YesNo', 'YesNoCancel', 'RetryCancel')]
			[string]$Buttons = 'OK',
			[Parameter(Position = 4)]
			[ValidateNotNullorEmpty()]
			[ValidateSet('Stop', 'Question', 'Exclamation', 'Information', 'None')]
			[string]$Icon = 'None',
			[Parameter(Position = 5)]
			[switch]$ShowOnTop,
			[Parameter(Position = 6)]
			[switch]$AsString
			
		)
		#endregion Parameters
		
		begin
		{
			Write-Verbose -Message "Starting [$($MyInvocation.Mycommand)]"
		}
		
		process
		{
			# set $ShowOnTopValue based on switch
			if ($ShowOnTop)
			{
				$ShowOnTopValue = 4096
			}
			else
			{
				$ShowOnTopValue = 0
			}
			
			#lookup key to convert buttons to their integer equivalents
			$ButtonsKey = @{
				'OK'			   = 0
				'OKCancel'		   = 1
				'AbortRetryIgnore' = 2
				'YesNo'		       = 4
				'YesNoCancel'	   = 3
				'RetryCancel'	   = 5
			}
			
			#lookup key to convert icon to their integer equivalents
			$IconKey = @{
				'Stop'	      = 16
				'Question'    = 32
				'Exclamation' = 48
				'Information' = 64
				'None'	      = 0
			}
			
			#lookup key to convert return value to human readable button press
			$ReturnKey = @{
				-1 = 'Timeout'
				1 = 'OK'
				2 = 'Cancel'
				3 = 'Abort'
				4 = 'Retry'
				5 = 'Ignore'
				6 = 'Yes'
				7 = 'No'
			}
			
			#create the COM Object
			try
			{
				$wshell = New-Object -ComObject Wscript.Shell -ErrorAction Stop
				#Button and icon type values are added together to create an integer value
				$return = $wshell.Popup($Message, $Time, $Title, $ButtonsKey[$Buttons] + $Iconkey[$Icon] + $ShowOnTopValue)
				if ($return -eq -1)
				{
					Write-Verbose -Message "User timedout [$($returnkey[$return])] after [$time] seconds"
				}
				else
				{
					Write-Verbose -Message "User pressed [$($returnkey[$return])]"
				}
				if ($AsString)
				{
					$ReturnKey[$return]
				}
				else
				{
					$return
				}
			}
			catch
			{
				#You should never really run into an exception in normal usage
				Write-Warning -Message 'Failed to create Wscript.Shell COM object'
				Write-Warning -Message ($_.exception.message)
			}
		}
		
		end
		{
			Write-Verbose -Message "Ending [$($MyInvocation.Mycommand)]"
		}
		
	}
	
	function RunMER
	{
		WriteLog "[MER] Starting MER Task"
		if ($textboxAgentStatus.Text -eq "Not installed")
		{
			New-PopUp -Message "No Agent installed" -Title "MER" -Buttons OK -Icon Exclamation
			WriteLog "[MER] No agent installed"
		}
		else
		{
			$statusbar1.Text = "Running MER. Please wait.."
			if ((Test-Path "c:\temp\") -eq $false)
			{
				New-Item "c:\temp" -Type Directory
			}
			$arg = "/update"
			WriteLog "[MER] Updating MER"
			Start-Process -Wait .\Software\Tools\WebMER\MER.exe -Args $arg
			$Hostname = $env:COMPUTERNAME
			$SavePath = "C:\temp\" + "MER-" + $Hostname + ".tgz"
			$arguments = "/detected /save " + $SavePath
			WriteLog "[MER] Running MER"
			Start-Process -Wait .\Software\Tools\WebMER\MER.exe -Args $arguments -WindowStyle Minimized
			if (Test-Path "C:\temp\*")
			{
				New-PopUp -Title "MER" -Message "MER file created on C:\Temp\" -Buttons OK -Icon Information
				Invoke-Item "C:\temp\"
				$statusbar1.Text = "MER created. Check C:\temp\ directory."
				WriteLog "[MER] File created"
			}
			else
			{
				$statusbar1.Text = "Could not create MER file"
				WriteLog "[MER] Could not create MER file"
			}
		}
		
	}
	
	##### CHECK TO SEE IF WHAT VERSION IS RUNNING
	# Disable Software and Tools menus while running Standalone version
	
	if (!(Test-Path "C:\Program Files\Endpoint Security Solution\"))
	{
		$installToolStripMenuItem.Enabled = $false
		$toolsToolStripMenuItem.Enabled = $false
	}
	
	
	##### CHECK FOR UPDATES ON START
	
	function CheckUpdateOnStart
	{
		Invoke-WebRequest -Uri "https://raw.githubusercontent.com/dekkerpt/SMT/main/Versions.txt" -OutFile $env:TEMP\Versions.txt
		$VersionsFile = Get-Content -Path "$env:TEMP\Versions.txt"
		$LatestVersion = ($VersionsFile | Select-Object -Index 6).SubString(4, 7)
		$CurrentVersion = (Get-Item "C:\Program Files\Endpoint Security Solution\ESS.exe").VersionInfo.FileVersion
		$LatestVersionN = [int]$LatestVersion.Replace(".", ",")
		$CurrentVersionN = [int]$CurrentVersion.Replace(".", ",")
		
		if ((Test-Path ("C:\Program Files\Endpoint Security Solution\")) -and ($CurrentVersionN -lt $LatestVersionN))
		{
			New-PopUp -Message "Please update Endpoint Security Solution" -Title "ESS" -Icon Exclamation -Buttons OK -ShowOnTop
			$ESS.Close()
		}
	}
	
	CheckUpdateOnStart
	
	###### LOG FUNCTION
	
	$statusbar1.Text = ""
	$logdir = "C:\Users\$env:USERNAME\AppData\LocalLow\ESSLogs"
	$Date = (Get-Date).toString("yyyyMMdd-HHmmss")
	if (!(Test-Path $logdir))
	{
		New-Item -Path $logdir -ItemType Directory
	}
	
	$Logfile = "$logdir\$Date" + "_" + "$env:COMPUTERNAME.log"
	
	function WriteLog
	{
		Param ([string]$LogString)
		$Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
		$LogMessage = "$Stamp $LogString"
		Add-content $LogFile -value $LogMessage
	}
	
	WriteLog "############### ESS LOG ###############"
	
	###### SET PROGRESSBAR VALUES
	
	$progressbaroverlay1.Maximum = 3;
	$progressbaroverlay1.Step = 1;
	$progressbaroverlay1.Value = 0
	$progressbaroverlay1.Visible = $false
	
	###### SET FORM ICON
	
	$ESS.Text = "Endpoint Security Solution " + [System.Windows.Forms.Application]::ProductVersion
	
	$base64IconString = "iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAPsSURBVDhPjVRbbJRFFD7nzL+7XcQWbCttd2ublKpEqTb6YKxdtBezXgAlGh8IkLQPSAOCjQSxDWpINCb4gInAgxUvkDT4oLYNbYAGwUYJpkF8gFCMpexutanl0gXDtt0Zv/n7s0ldY/ySf2fm3M83c5bpf2BbuK5QET8vxDsd5qSfVLuPqH9rrO+aZ5JBVsCmoseDPlEvw7FcDOU7LPcr5mpluNCBOeTkkJCPJYHzWegvBkhNYD2nSL7JCthcXNMEnw5URD44egEm/CwDkHX4SYLC3IxqH4Mu19ohGfnZ7qjR8eJkoMlUuiqir7HfTySjWIffi/dfcQ1mceiD0mdCDqlKY3QREryqSS9DkrB4BhkYMj8Lye4Aq/a7JbjwLvEvX6SCAU+dwbZYb+L1yz3ftcYOd6LVCzxbxF/u74aS2jshKMJhHlorAx/VqHIVOKyyLYOvcbTdBd0JNmYowM61oMiVpkvfjlv/j0qf64VNFBXWMTgrBendONwLkoO2XZc3Bn9GjvmY/4D+RfB0hyuDHs5T+K7Cdt2p62PHqnMLzsO/DDw+KGnS1WljHgJPKbR7As4HUO1mGNfeNKln34kfXYPqqoSlGbq9eBh9aaN/nzF6Eb76pbn55ZqoAoUO35qZijkI4vIIYrs/Tny/1u7Xl9S2BEg+cVhtxbF7e6zvN6z2+9Tq95StWE/G7MN2ShsTEbbufHJj4vAtQeZJS6QxZoE1noVRqPo+VLnFE8xBWut8u6LNCfiGvAs55MogHMMZVXN5S9FTfiucofTnkF8wRHU7wo0brGwOmBbbBRTEFUslbH8YvTrab2UyrXUMbyWBHBWkZkqssGP0x0nF9Ibdo9rd75dGX5jdE7UX1yssVUhGU0ZbvwLQ1rpzctCKSJ29EU89klv2BBRVyDb4U3LkF6s4lRwZWpZXkUL2p3HTL61csCS5buHSQQyFre5dVDc8bfRnxDy0Ce/R+ljYbPTo/Hv8eCmrYJR3OjnyhasBBiaHBxryFt9E0CieTBS9jqUo/TA4a1TCXyHQ/t7rQxc9cxfuDWuju2D0qzFUvyX05CuuxsOO2JFdPlJRPJ0vb5jp87BpxY3akXJv/J9wr8eiJRRZzYYO+IjHHZGGXfHjbuu38XZJY3C+4+vD9EQwMXtRXYunmoPMLO9JnDyIlveB2UJk73kr3FDjqQiXUpwjqgudRGBzGg/7TU+VhUyFFq8VRxxHFFoxa9zxIvkQY3gJw78dlZUj6Bk89hWbR7rjnksW5gS02Biq4XkcaEP7bXjYOd6fA/4bVSdmdVPr5Z4/PdN/RVbA22gLNzwAPtbihgtyWHVi/I56qv8A0d8ZZT5IlL+PxwAAAABJRU5ErkJggg=="
	$iconimageBytes = [Convert]::FromBase64String($base64IconString)
	$ims = New-Object IO.MemoryStream($iconimageBytes, 0, $iconimageBytes.Length)
	$ims.Write($iconimageBytes, 0, $iconimageBytes.Length);
	$ESS.Icon = [System.Drawing.Icon]::FromHandle((new-object System.Drawing.Bitmap -argument $ims).GetHIcon())
	
	
	######################################################## SYSTEM INFORMATION GROUPBOX ##############################################################
	
	######## USERID
	
	$textboxUserID.Text = $env:USERNAME
	
	######## HOSTNAME
	
	$textboxHostname.Text = $env:COMPUTERNAME
	
	######## LAST REBOOT TIME
	
	$BootTime = (Get-CimInstance -ClassName win32_operatingsystem).LastBootUpTime
	$BootTime = Get-Date $BootTime -Format "dd/MM/yyyy HH:mm"
	$textboxRebootTime.Text = $BootTime
	
	######## REBOOT PENDING
	
	Function Get-PendingRebootStatus
	{
		[CmdletBinding()]
		Param (
			[Parameter(
					   Mandatory = $false,
					   ValueFromPipeline = $true,
					   ValueFromPipelineByPropertyName = $true,
					   Position = 0
					   )]
			[string[]]$ComputerName = $env:COMPUTERNAME
		)
		
		BEGIN { }
		
		PROCESS
		{
			Foreach ($Computer in $ComputerName)
			{
				Try
				{
					$PendingReboot = $false
					
					$HKLM = [UInt32] "0x80000002"
					$WMI_Reg = [WMIClass] "\\$Computer\root\default:StdRegProv"
					
					if ($WMI_Reg)
					{
						if (($WMI_Reg.EnumKey($HKLM, "SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\")).sNames -contains 'RebootPending') { $PendingReboot = $true }
						if (($WMI_Reg.EnumKey($HKLM, "SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\")).sNames -contains 'RebootRequired') { $PendingReboot = $true }
						
						#Checking for SCCM namespace
						$SCCM_Namespace = Get-WmiObject -Namespace ROOT\CCM\ClientSDK -List -ComputerName $Computer -ErrorAction Ignore
						if ($SCCM_Namespace)
						{
							if (([WmiClass]"\\$Computer\ROOT\CCM\ClientSDK:CCM_ClientUtilities").DetermineIfRebootPending().RebootPending -eq $true) { $PendingReboot = $true }
						}
						
						[PSCustomObject]@{
							ComputerName  = $Computer.ToUpper()
							PendingReboot = $PendingReboot
						}
					}
				}
				catch
				{
					Write-Error $_.Exception.Message
					
				}
				finally
				{
					#Clearing Variables
					$null = $WMI_Reg
					$null = $SCCM_Namespace
				}
			}
		}
		
		END { }
	}
	
	$textboxRebootPending.Text = (Get-PendingRebootStatus -ComputerName $env:COMPUTERNAME).PendingReboot
	
	######## EPO ENVIRONMENT
	
	function Get-Environment
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Agent\masvc.exe") -eq $true)
		{
			Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\WOW6432Node\Network Associates\ePolicy Orchestrator\Agent" -Name ePOServerList
		}
		else { }
	}
	
	$EPOServerList = Get-Environment
	
	$EnvironmentOffice = "10.253.90.175"
	$EnvironmentOfficeAUDI = "10.241.128.198"
	$EnvironmentOfficeFRP = "10.253.90.240"
	$EnvironmentProduction = "10.253.90.196"
	$EnvironmentProductionAudi = "10.241.128.140"
	$EnvironmentServer = "10.253.90.194"
	$EnvironmentServerAudi = "10.241.128.139"
	
	switch ($EPOServerList)
	{
		{ $_.Contains($EnvironmentOffice) } { $textboxEPOEnvironment.Text = "Connected to VWAG Office EPO Service" }
		{ $_.Contains($EnvironmentOfficeFRP) } { $textboxEPOEnvironment.Text = "Connected to VWAG Office FRP EPO Service" }
		{ $_.Contains($EnvironmentOfficeAUDI) } { $textboxEPOEnvironment.Text = "Connected to AUDI Office EPO Service" }
		{ $_.Contains($EnvironmentProduction) } { $textboxEPOEnvironment.Text = "Connected to VWAG Production EPO Service" }
		{ $_.Contains($EnvironmentProductionAUDI) } { $textboxEPOEnvironment.Text = "Connected to AUDI Production EPO Service" }
		{ $_.Contains($EnvironmentServer) } { $textboxEPOEnvironment.Text = "Connected to VWAG Server EPO Service" }
		{ $_.Contains($EnvironmentServerAUDI) } { $textboxEPOEnvironment.Text = "Connected to AUDI Server EPO Service" }
		default { $textboxEPOEnvironment.Text = "Not managed by VWAG" }
	}
	
	######## LAST COMMUNICATION
	
	if (Test-Path -Path "C:\Program Files\McAfee\Agent\masvc.exe")
	{
		$GetLastCommunication = & "C:\Program Files\McAfee\Agent\cmdagent" -i | Select-String -Pattern LastASCTIME | Out-String
		$GetLastCommunication = $GetLastCommunication.Replace("`n", "").Replace("`r", "").Replace(" ", "")
		$ASCTime_Year = $GetLastCommunication.SubString(12, 4)
		$ASCTime_Month = $GetLastCommunication.SubString(16, 2)
		$ASCTime_Day = $GetLastCommunication.SubString(18, 2)
		$ASCTime_Hour = $GetLastCommunication.SubString(20, 2)
		$ASCTime_Minute = $GetLastCommunication.SubString(22, 2)
		$AgentASC = $ASCTime_Day + "/" + $ASCTime_Month + "/" + $ASCTime_Year + " " + $ASCTime_Hour + ":" + $ASCTime_Minute
		if ($AgentASC -eq "// :")
		{
			$textboxLastCommunication.text = "Waiting for communication. Please restart app"
		}
		else
		{
			$textboxLastCommunication.Text = $AgentASC
		}
		
	}
	
	else
	{
		$textboxEPOEnvironment.Text = "No agent installed"
		$textboxLastCommunication.Text = "No agent installed"
	}
	
	######################################################## SOFTWARE INFORMATION GROUPBOX ##############################################################
	
	########### AGENT STATUS
	
	function Get-AgentStatus
	{
		if (($null -eq (Get-Process "masvc" -ea SilentlyContinue)) -and ((Test-Path -Path "C:\Program Files\McAfee\Agent\masvc.exe") -eq $false))
		{
			$textboxAgentStatus.Text = "Not installed"
		}
		elseif ($null -eq (Get-Process "masvc" -ea SilentlyContinue))
		{
			$textboxAgentStatus.BackColor = 'Yellow'
			$textboxAgentStatus.ForeColor = 'Black'
			$textboxAgentStatus.Text = "Not running"
		}
		else
		{
			$textboxAgentStatus.BackColor = 'Green'
			$textboxAgentStatus.ForeColor = 'White'
			$textboxAgentStatus.Text = "Running"
		}
	}
	
	Get-AgentStatus
	
	########### AGENT VERSION
	
	function Get-AgentVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Agent\masvc.exe") -eq $true)
		{
			$textboxAgentVersion.Text = (Get-Item "C:\Program Files\McAfee\Agent\masvc.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxAgentVersion.Text = ""
		}
	}
	
	Get-AgentVersion
	
	########### TP STATUS
	
	function Get-TPStatus
	{
		if (($null -eq (Get-Process "mfetp" -ea SilentlyContinue)) -and ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Threat Prevention\mfetp.exe") -eq $false))
		{
			$textboxENSStatus.Text = "Not installed"
		}
		elseif ($null -eq (Get-Process "mfetp" -ea SilentlyContinue))
		{
			$textboxENSStatus.BackColor = 'Yellow'
			$textboxENSStatus.ForeColor = 'Black'
			$textboxENSStatus.Text = "Not running"
		}
		else
		{
			$textboxENSStatus.BackColor = 'Green'
			$textboxENSStatus.ForeColor = 'White'
			$textboxENSStatus.Text = "Running"
		}
	}
	
	Get-TPStatus
	
	########### TP VERSION
	
	function Get-TPVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Threat Prevention\mfetp.exe") -eq $true)
		{
			$textboxENSVersion.Text = (Get-Item "C:\Program Files\McAfee\Endpoint Security\Threat Prevention\mfetp.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxENSVersion.Text = ""
		}
	}
	
	Get-TPVersion
	
	########### ATP STATUS
	
	function Get-ATPStatus
	{
		if (($null -eq (Get-Process "mfeatp" -ea SilentlyContinue)) -and ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Adaptive Threat Protection\mfeatp.exe") -eq $false))
		{
			$textboxATPStatus.Text = "Not installed"
		}
		elseif ($null -eq (Get-Process "mfeatp" -ea SilentlyContinue))
		{
			$textboxATPStatus.BackColor = 'Yellow'
			$textboxATPStatus.ForeColor = 'Black'
			$textboxATPStatus.Text = "Not running"
		}
		else
		{
			$textboxATPStatus.BackColor = 'Green'
			$textboxATPStatus.ForeColor = 'White'
			$textboxATPStatus.Text = "Running"
		}
	}
	
	Get-ATPStatus
	
	########### ATP VERSION
	
	function Get-ATPVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Adaptive Threat Protection\mfeatp.exe") -eq $true)
		{
			$textboxATPVersion.Text = (Get-Item "C:\Program Files\McAfee\Endpoint Security\Adaptive Threat Protection\mfeatp.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxATPVersion.Text = ""
		}
	}
	
	Get-ATPVersion
	
	########### FIREWALL STATUS
	
	function Get-FWStatus
	{
		if (($null -eq (Get-Process "mfefw" -ea SilentlyContinue)) -and ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Firewall\mfefw.exe") -eq $false))
		{
			$textboxFWStatus.Text = "Not installed"
		}
		elseif ($null -eq (Get-Process "mfefw" -ea SilentlyContinue))
		{
			$textboxFWStatus.BackColor = 'Yellow'
			$textboxFWStatus.ForeColor = 'Black'
			$textboxFWStatus.Text = "Not running"
		}
		else
		{
			$textboxFWStatus.BackColor = 'Green'
			$textboxFWStatus.ForeColor = 'White'
			$textboxFWStatus.Text = "Running"
		}
	}
	
	Get-FWStatus
	
	########### FIREWALL VERSION
	
	function Get-FWVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Security\Firewall\mfefw.exe") -eq $true)
		{
			$textboxFWVersion.Text = (Get-Item "C:\Program Files\McAfee\Endpoint Security\Firewall\mfefw.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxFWVersion.Text = ""
		}
	}
	
	Get-FWVersion
	
	########### FRP STATUS
	
	function Get-FRPStatus
	{
		if (($null -eq (Get-Process "MfeFfCore" -ea SilentlyContinue)) -and ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Encryption for Files and Folders\MfeFfCore.exe") -eq $false))
		{
			$textboxFRPStatus.Text = "Not installed"
		}
		elseif ($null -eq (Get-Process "MfeFfCore" -ea SilentlyContinue))
		{
			$textboxFRPStatus.ReadOnly = $true
			$textboxFRPStatus.BackColor = 'Yellow'
			$textboxFRPStatus.ForeColor = 'Black'
			$textboxFRPStatus.Text = "Not running"
		}
		else
		{
			$textboxFRPStatus.ReadOnly = $true
			$textboxFRPStatus.BackColor = 'Green'
			$textboxFRPStatus.ForeColor = 'White'
			$textboxFRPStatus.Text = "Running"
		}
	}
	
	Get-FRPStatus
	
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
			$textboxFRPVersion.Text = " "
		}
	}
	
	Get-FRPVersion
	
	########### DLP STATUS
	
	function Get-DLPStatus
	{
		if (($null -eq (Get-Process "fcag" -ea SilentlyContinue)) -and ((Test-Path -Path "C:\Program Files\McAfee\DLP\Agent\fcag.exe") -eq $false))
		{
			$textboxDLPStatus.Text = "Not installed"
		}
		elseif ($null -eq (Get-Process "fcag" -ea SilentlyContinue))
		{
			$textboxDLPStatus.BackColor = 'Yellow'
			$textboxDLPStatus.ForeColor = 'Black'
			$textboxDLPStatus.Text = "Not running"
		}
		else
		{
			$textboxDLPStatus.BackColor = 'Green'
			$textboxDLPStatus.ForeColor = 'White'
			$textboxDLPStatus.Text = "Running"
		}
	}
	
	Get-DLPStatus
	
	########### DLP VERSION
	
	function Get-DLPVersion
	{
		if ((Test-Path -Path "C:\Program Files\McAfee\DLP\Agent\fcag.exe") -eq $true)
		{
			$textboxDLPVersion.Text = (Get-Item "C:\Program Files\McAfee\DLP\Agent\fcag.exe").VersionInfo.FileVersion
		}
		else
		{
			$textboxDLPVersion.Text = ""
		}
	}
	
	Get-DLPVersion
	
	################################ MENU ACTIONS ################################
	
	################################ MENU TRELLIX SOFTWARE
	
	########### AGENT MENU
	
	### REINSTALL AGENT
	
	$reinstallAgentToolStripMenuItem_Click = {
		
		if (!(Test-Path "${env:ProgramFiles(x86)}\SMT"))
		{
			New-PopUp -Message "Software not available. `n`nPlease run the installer." -Title "Information" -Buttons OK -Icon Information -ShowOnTop
		}
		else
		{
			$Agent = ".\Software\Agent\01-EPO\FramePkg.exe"
			$Arg = "/install=agent /forceinstall"
			
			WriteLog "[AGENT] Reinstall agent."
			Start-Process -Wait $Agent $Arg
			Get-AgentStatus
			Get-AgentVersion
		}
		
	}
	
	### CHANGE EPO
	
	$changeEPOToolStripMenuItem_Click = {
		New-PopUp -Message "Feature not available" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
	}
	
	########### ENDPOINT SECURITY MENU
	
	### INSTALL ATP / TP
	
	$reinstallENSToolStripMenuItem_Click = {
		
		if (!(Test-Path "${env:ProgramFiles(x86)}\SMT"))
		{
			New-PopUp -Message "Software not available. `n`nPlease run the installer." -Title "Information" -Buttons OK -Icon Information -ShowOnTop
		}
		else
		{
			$statusbar1.Text = "Installing ATP / TP. Please wait..."
			WriteLog "[ENS] Uninstalling ATP / TP"
			$ATP = "MsiExec.exe /X{377DA1C7-79DE-4102-8DB7-5C2296A3E960} /S"
			$TP = "MsiExec.exe /X{820D7600-089E-486B-860F-279B8119A893} /S"
			Start-Process -Wait $TP
			Start-Process -Wait $ATP
			
			WriteLog "[ENS] Installing ATP / TP"
			$ENSPackage = ".\Software\ENS"
			$arguments = "ADDLOCAL=""atp,tp"" /passive"
			Start-Process -Wait "$ENSPackage\setupEP.exe" -ArgumentList $arguments
			
			Get-ATPStatus
			Get-ATPVersion
			Get-TPStatus
			Get-TPVersion
			$statusbar1.Text = "ATP / TP was installed"
			WriteLog "[ENS] ATP / TP was installed"
		}
	}
	
	### INSTALL FW
	
	$installFWToolStripMenuItem_Click = {
		
		if (!(Test-Path "${env:ProgramFiles(x86)}\SMT"))
		{
			New-PopUp -Message "Software not available. `n`nPlease run the installer." -Title "Information" -Buttons OK -Icon Information -ShowOnTop
		}
		else
		{
			$statusbar1.Text = "Installing Firewall. Please wait..."
			WriteLog "[FW] Uninstalling firewall.."
			$FW = "MsiExec.exe /X{6F88C6E9-CAD0-4D03-99E1-161383F9AD6F} /S"
			Start-Process -Wait $FW
			
			WriteLog "[FW] Installing FW"
			$ENSPackage = ".\Software\ENS"
			$arguments = "ADDLOCAL=""fw"" /passive"
			Start-Process -Wait "$ENSPackage\setupEP.exe" -ArgumentList $arguments
			
			Get-FWStatus
			Get-FWVersion
			
			$statusbar1.Text = "Firewall was installed"
			WriteLog "[FW] Reinstallation completed"
		}
	}
	
	########### DATA LOSS PREVENTION MENU
	
	### INSTALL DLP
	
	$reinstallDLPToolStripMenuItem_Click = {
		New-PopUp -Message "Feature not available" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
	}
	
	########### FILE AND REMOVABLE MEDIA PROTECTION MENU
	
	### INSTALL FRP
	
	$reinstallFRPToolStripMenuItem_Click = {
		
		if (!(Test-Path "${env:ProgramFiles(x86)}\SMT"))
		{
			New-PopUp -Message "Software not available. `n`nPlease run the installer." -Title "Information" -Buttons OK -Icon Information -ShowOnTop
		}
		else
		{
			if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Encryption for Files and Folders\MfeFfCore.exe") -eq $true)
			{
				$statusbar1.Text = "Uninstalling FRP. Please wait..."
				WriteLog "[FRP] Uninstalling FRP"
				$arguments = "/norestart /x {CD46E054-452A-47DD-9ECB-E26CD15D29CD} REMOVE=ALL REBOOT=NO /l*v ""$env:TEMP\MfeFRP_Uninstallh.log"" /q"
				Start-Process msiexec $arguments
				Remove-Item "$env:ProgramData\McAfee\FRP\FrpClientDb.db" -Force -ErrorAction SilentlyContinue
				Remove-Item "$env:APPDATA\McAfee\Endpoint Encryption for Files and Folders\KeyCache\KeyCache.enc" -Force -ErrorAction SilentlyContinue
				Remove-Item "$env:APPDATA\McAfee\Endpoint Encryption for Files and Folders\PolicyCache\PolicyCache.enc" -Force -ErrorAction SilentlyContinue
			}
			
			$statusbar1.Text = "Installing FRP. Please wait..."
			WriteLog "[FRP] Installing FRP"
			
			$FRPInstallerDir = ".\Software\FRP"
			$arguments = "/norestart /l*vx ""$env:TEMP\MfeFRP_Installh.log"" /passive"
			Start-Process -Wait "$FRPInstallerDir\eeff64.msi" -Args $arguments
			
			$regPath = "HKLM:\SYSTEM\CurrentControlSet\services\MfeEEFF"
			
			# Set "Disentangle" registry value to REG_DWORD 0
			Set-ItemProperty -Path $regPath -Name "Disentangle" -Value 0 -Type DWord -Force
			
			# Set "Version2Exists" registry value to REG_DWORD 0
			Set-ItemProperty -Path $regPath -Name "Version2Exists" -Value 0 -Type DWord -Force
			
			Get-FRPStatus
			Get-FRPVersion
			
			$statusbar1.Text = "FRP installed"
		}
	}
	
	########### CHECK FOR UPDATES MENU
	
	$checkForUpdatesToolStripMenuItem1_Click = {
		& .\Software\Tools\Update-Checker\Update-Checker.exe
	}
	
	################################ MENU TROUBLESHOOTING
	
	########### FRP MENU
	
	### FRP TOOLS
	
	$fRPToolToolStripMenuItem_Click = {
		try
		{
			Invoke-Item "\\VWAGWOSENC04.wob.vw.vwg\Trellix_Tools\" -ErrorAction Stop
			WriteLog "[FRP TOOLS] Opened FRP Tools folder"
		}
		catch
		{
			$ErrorMessage = $_.Exception.Message
			WriteLog "[FRP TOOLS] Couldn't open Tools folder. Error: $ErrorMessage"
		}
	}
	
	### REMOVE FRP CACHE
	
	$removeFRPCacheToolStripMenuItem_Click = {
		WriteLog "[FRP] Removing FRP Cache"
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Encryption for Files and Folders\MfeFfCore.exe") -eq $true)
		{
			$progressbaroverlay1.Visible = $true
			$progressbaroverlay1.Maximum = 3
			$progressbaroverlay1.Value = 0
			$progressbaroverlay1.Step = 1
			$progressbaroverlay1.Text = "Deleting Cache..."
			try
			{
				Remove-Item "$env:ProgramData\McAfee\FRP\FrpClientDb.db" -Force -ErrorAction SilentlyContinue
				WriteLog "[FRP] Deleted FrpClient.db"
				$progressbaroverlay1.PerformStep()
				Remove-Item "$env:APPDATA\McAfee\Endpoint Encryption for Files and Folders\KeyCache\KeyCache.enc" -Force -ErrorAction SilentlyContinue
				WriteLog "[FRP] Deleted KeyCache.db"
				$progressbaroverlay1.PerformStep()
				Remove-Item "$env:APPDATA\McAfee\Endpoint Encryption for Files and Folders\PolicyCache\PolicyCache.enc" -Force -ErrorAction SilentlyContinue
				WriteLog "[FRP] Deleted Policycache.db"
				$progressbaroverlay1.PerformStep()
				$progressbaroverlay1.Text = "Done!"
				WriteLog "[FRP] FRP Cache removed"
			}
			catch
			{
				WriteLog ($_.exception.message)
			}
		}
		
		else
		{
			$statusbar1.Text = "FRP is not installed"
			WriteLog "[FRP] FRP not installed"
		}
	}
	
	### REMOVE FRP USER CACHE
	
	$removeFRPUserCacheToolStripMenuItem_Click = {
		WriteLog "[FRP] Removing FRP User Cache"
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Encryption for Files and Folders\MfeFfCore.exe") -eq $true)
		{
			$progressbaroverlay1.Visible = $true
			$progressbaroverlay1.Maximum = 5
			$progressbaroverlay1.Value = 0
			$progressbaroverlay1.Step = 1
			$progressbaroverlay1.Text = "Deleting Cache..."
			Remove-Item "$env:ProgramData\McAfee\FRP\FrpClientDb.db" -Force -ErrorAction SilentlyContinue
			$progressbaroverlay1.PerformStep()
			Remove-Item "C:\Windows\SysWOW64\config\systemprofile\AppData\Roaming\McAfee\Endpoint Encryption for Files and Folders\KeyCache\KeyCache.enc" -Force -ErrorAction SilentlyContinue
			$progressbaroverlay1.PerformStep()
			Remove-Item "C:\Windows\SysWOW64\config\systemprofile\AppData\Roaming\McAfee\Endpoint Encryption for Files and Folders\PolicyCache\PolicyCache.enc" -Force -ErrorAction SilentlyContinue
			$progressbaroverlay1.PerformStep()
			Remove-Item "$env:APPDATA\McAfee\Endpoint Encryption for Files and Folders\KeyCache\KeyCache.enc" -Force -ErrorAction SilentlyContinue
			$progressbaroverlay1.PerformStep()
			Remove-Item "$env:APPDATA\McAfee\Endpoint Encryption for Files and Folders\PolicyCache\PolicyCache.enc" -Force -ErrorAction SilentlyContinue
			$progressbaroverlay1.PerformStep()
			$progressbaroverlay1.Text = "Done!"
			WriteLog "[FRP] FRP User Cache removed"
		}
		else
		{
			$statusbar1.Text = "FRP is not installed"
			WriteLog "[FRP] FRP not installed"
		}
	}
	
	### REMOVE FRP ALL USERS CACHE
	
	$removeFRPAllUsersCacheToolStripMenuItem_Click = {
		WriteLog "[FRP] Removing FRP All User Cache"
		if ((Test-Path -Path "C:\Program Files\McAfee\Endpoint Encryption for Files and Folders\MfeFfCore.exe") -eq $true)
		{
			$progressbaroverlay1.Visible = $true
			$progressbaroverlay1.Maximum = 5
			$progressbaroverlay1.Value = 0
			$progressbaroverlay1.Step = 1
			$progressbaroverlay1.Text = "Deleting Cache..."
			Remove-Item "$env:ProgramData\McAfee\FRP\FrpClientDb.db" -Force -ErrorAction SilentlyContinue
			$progressbaroverlay1.PerformStep()
			Remove-Item "C:\Windows\SysWOW64\config\systemprofile\AppData\Roaming\McAfee\Endpoint Encryption for Files and Folders\KeyCache\KeyCache.enc" -Force -ErrorAction SilentlyContinue
			$progressbaroverlay1.PerformStep()
			Remove-Item "C:\Windows\SysWOW64\config\systemprofile\AppData\Roaming\McAfee\Endpoint Encryption for Files and Folders\PolicyCache\PolicyCache.enc" -Force -ErrorAction SilentlyContinue
			$progressbaroverlay1.PerformStep()
			$users = Get-ChildItem "C:\Users"
			foreach ($user in $users)
			{
				$userName = $user.Name
				Remove-Item "C:\Users\$userName\AppData\Roaming\McAfee\Endpoint Encryption for Files and Folders\KeyCache\KeyCache.enc" -Force -ErrorAction SilentlyContinue
				$progressbaroverlay1.PerformStep()
				Remove-Item "C:\Users\$userName\AppData\Roaming\McAfee\Endpoint Encryption for Files and Folders\PolicyCache\PolicyCache.enc" -Force -ErrorAction SilentlyContinue
				$progressbaroverlay1.PerformStep()
			}
			$progressbaroverlay1.Text = "Done!"
		}
		else
		{
			$statusbar1.Text = "FRP is not installed"
			WriteLog "[FRP] FRP not installed"
		}
	}
	
	### UNINSTALL FRP
	
	$uninstallFRPToolStripMenuItem_Click = {
		New-PopUp -Message "Feature not available" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
	}
	
	########### CHECK LOGS
	
	$checkLogsToolStripMenuItem_Click = {
		if ((!(Test-Path -Path "C:\ProgramData\McAfee\Agent\logs")) -and (!(Test-Path -Path "C:\ProgramData\McAfee\Endpoint Security\Logs")))
		{
			New-PopUp -Message "Agent and ENS are not installed. Cannot open logs folder" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
			WriteLog "[LOG] Couldn't open Agent and ENS Log Folder. Agent and ENS are not installed"
		}
		elseif ((!(Test-Path -Path "C:\ProgramData\McAfee\Agent\logs")) -and (Test-Path -Path "C:\ProgramData\McAfee\Endpoint Security\Logs"))
		{
			New-PopUp -Message "Agent is not installed. Cannot open logs folder" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
			WriteLog "[LOG] Couldn't open Agent Log Folder. Agent is not installed"
			Invoke-Item -Path "C:\ProgramData\McAfee\Endpoint Security\Logs"
			WriteLog "[LOG] Opened ENS logs folder"
		}
		elseif ((Test-Path -Path "C:\ProgramData\McAfee\Agent\logs") -and (!(Test-Path -Path "C:\ProgramData\McAfee\Endpoint Security\Logs")))
		{
			Invoke-Item -Path "C:\ProgramData\McAfee\Agent\Logs"
			WriteLog "[LOG] Opened Agent logs folder"
			New-PopUp -Message "ENS is not installed. Cannot open logs folder" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
			WriteLog "[LOG] Couldn't open ENS Log folder. ENS is not installed"
		}
		else
		{
			Invoke-Item -Path "C:\ProgramData\McAfee\Agent\Logs"
			WriteLog "[LOG] Opened Agent logs folder"
			Invoke-Item -Path "C:\ProgramData\McAfee\Endpoint Security\Logs"
			WriteLog "[LOG] Opened ENS logs folder"
		}
	}
	
	########### FORCE AGENT SYNC
	
	$forceAgentSyncToolStripMenuItem_Click = {
		if ((Test-Path -Path "C:\Program Files\McAfee\Agent\masvc.exe") -eq $true)
		{
			if ($textboxEPOEnvironment.Text -ne "Not managed by VWAG")
			{
				WriteLog "[SYNC] Starting agent sync"
				$statusbar1.Text = "Enforcing Agent synchronization. Please Wait..."
				Start-Job -ScriptBlock {
					$cmdagent = "C:\Program Files\McAfee\Agent\cmdagent.exe"
					$arguments = "-c", "-e", "-p", "-f"
					Start-Process $cmdagent -ArgumentList "-s"
					Start-Sleep -Seconds 3
					foreach ($arg in $arguments)
					{
						Start-Process $cmdagent -ArgumentList $arg -WindowStyle Hidden
						Start-Sleep -Seconds 3
					}
				}
				Get-Job | Wait-Job
				$statusbar1.Text = "Agent synced"
				WriteLog "[SYNC] Agent synced"
			}
			else
			{
				New-PopUp "Can't perform sync. Client not connected to VWAG network" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
				WriteLog "[SYNC] Can't perform sync. Client not connected to VWAG network"
			}
			
		}
		else
		{
			New-PopUp "No agent installed" - Title "Information" -Buttons OK -Icon Information -ShowOnTop
			WriteLog "[SYNC] No agent installed. Can't sync with EPO"
		}
	}
	
	########### TEST CONNECTION
	
	$testConnectionToolStripMenuItem_Click = {
		WriteLog "[TCP] Checking connection.."
		
		if (!(Test-Path -Path "C:\Program Files\McAfee\Agent\masvc.exe"))
		{
			New-PopUp -Message "Agent not installed. Cannot test connection" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
			WriteLog "[TCP] Agent not installed. Cannot test connection"
		}
		else
		{
			switch ($EPOServerList)
			{
				{ $_.Contains($OfficeEnvironment) } {
					
					WriteLog "[TCP] VWAG Office Connection Test"
					$progressbaroverlay1.Text = "Running connection test. Please wait..."
					$progressbaroverlay1.Visible = $true
					Start-Sleep -Seconds 1
					$progressbaroverlay1.PerformStep()
					Start-Sleep -Seconds 1
					$progressbaroverlay1.PerformStep()
					WriteLog "[TCP] Starting TCP test..."
					$tcp = Start-Job -ScriptBlock { Test-NetConnection -ComputerName "10.253.90.175" -Port "51443" -WarningAction SilentlyContinue }
					Get-Job | Wait-Job
					$result = (Receive-Job -Job $tcp).TcpTestSucceeded
					Get-Job | Remove-Job
					if ($Result -eq $true)
					{
						$progressbaroverlay1.PerformStep()
						$progressbaroverlay1.TextOverlay = "Test Connection: SUCCESS"
						WriteLog "[TCP] VWAG Office Connection Test SUCCESS"
					}
					else
					{
						$progressbaroverlay1.PerformStep()
						$progressbaroverlay1.TextOverlay = "Test Connection: FAIL"
						WriteLog = "[TCP] VWAG Office Connection Test FAIL"
					}
				}
				{ $_.Contains($AUDIOfficeEnvironment) } {
					
					WriteLog "[TCP] AUDI Office Connection Test"
					$progressbaroverlay1.Text = "Running connection test. Please wait..."
					$progressbaroverlay1.Visible = $true
					Start-Sleep -Seconds 1
					$progressbaroverlay1.PerformStep()
					Start-Sleep -Seconds 1
					$progressbaroverlay1.PerformStep()
					$tcp = Start-Job -ScriptBlock { Test-NetConnection -ComputerName "10.241.128.198" -Port "51443" -WarningAction SilentlyContinue }
					Get-Job | Wait-Job
					$result = (Receive-Job -Job $tcp).TcpTestSucceeded
					Get-Job | Remove-Job
					if ($Result -eq $true)
					{
						$progressbaroverlay1.PerformStep()
						$progressbaroverlay1.TextOverlay = "Test Connection: SUCCESS"
						WriteLog "[TCP] AUDI Office Connection Test SUCCESS"
					}
					else
					{
						$progressbaroverlay1.PerformStep()
						$progressbaroverlay1.TextOverlay = "Test Connection: FAIL"
						WriteLog "[TCP] AUDI Office Connection Test FAIL"
					}
				}
				
				{ $_.Contains($OfficeFRPEnvironment) } {
					
					WriteLog "[TCP] VWAG FRP Connection Test"
					$progressbaroverlay1.Text = "Running connection test. Please wait..."
					$progressbaroverlay1.Visible = $true
					Start-Sleep -Seconds 1
					$progressbaroverlay1.PerformStep()
					Start-Sleep -Seconds 1
					$progressbaroverlay1.PerformStep()
					$tcp = Start-Job -ScriptBlock { Test-NetConnection -ComputerName "10.253.90.240" -Port "51443" -WarningAction SilentlyContinue }
					Get-Job | Wait-Job
					$result = (Receive-Job -Job $tcp).TcpTestSucceeded
					Get-Job | Remove-Job
					if ($Result -eq $true)
					{
						$progressbaroverlay1.PerformStep()
						$progressbaroverlay1.TextOverlay = "Test Connection: SUCCESS"
						WriteLog "[TCP] VWAG FRP Connection Test SUCCESS"
					}
					else
					{
						$progressbaroverlay1.PerformStep()
						$progressbaroverlay1.TextOverlay = "Test Connection: FAIL"
						WriteLog "[TCP] VWAG FRP Connection Test FAIL"
					}
				}
				default {
					New-PopUp -Message "Client not connected to VWAG network" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
					WriteLog "[TCP] Client not connected to VWAG network"
				}
			}
		}
	}
	
	################################ MENU TOOLS
	
	########### RUN MER
	
	$runMERToolStripMenuItem_Click = {
		RunMER
	}
	
	########### RUN REMOVAL TOOL
	
	$runRemovalToolToolStripMenuItem_Click = {
		& .\Software\Tools\Removal-Tool\EndpointProductRemoval.exe
	}
	
	########### RUN MANUAL REMOVAL TOOL
	
	$runManualRemovalToolStripMenuItem_Click = {
		& .\Software\Tools\Remove-ENS\Remove-ENS.exe
	}
	
	################################ MENU HELP
	
	########### CHECK FOR UPDATES
	
	$checkForUpdatesToolStripMenuItem_Click = {
		New-PopUp -Message "Feature not available" -Title "Information" -Buttons OK -Icon Information -ShowOnTop
	}
	
	########### ABOUT
	
	$aboutToolStripMenuItem_Click = {
		$AppVersion = [System.Windows.Forms.Application]::ProductVersion
		[System.Windows.Forms.MessageBox]::Show("Endpoint Security Solution v$AppVersion `n`nIn case of any questions or reports,`nplease contact the ESS team `n`nEmail: antivirus@volkswagen.de", "Endpoint Security Solution");
	}
	
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$ESS.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$aboutToolStripMenuItem.remove_Click($aboutToolStripMenuItem_Click)
			$checkForUpdatesToolStripMenuItem.remove_Click($checkForUpdatesToolStripMenuItem_Click)
			$runMERToolStripMenuItem.remove_Click($runMERToolStripMenuItem_Click)
			$runRemovalToolToolStripMenuItem.remove_Click($runRemovalToolToolStripMenuItem_Click)
			$runManualRemovalToolStripMenuItem.remove_Click($runManualRemovalToolStripMenuItem_Click)
			$reinstallAgentToolStripMenuItem.remove_Click($reinstallAgentToolStripMenuItem_Click)
			$changeEPOToolStripMenuItem.remove_Click($changeEPOToolStripMenuItem_Click)
			$testConnectionToolStripMenuItem.remove_Click($testConnectionToolStripMenuItem_Click)
			$forceAgentSyncToolStripMenuItem.remove_Click($forceAgentSyncToolStripMenuItem_Click)
			$checkLogsToolStripMenuItem.remove_Click($checkLogsToolStripMenuItem_Click)
			$fRPToolToolStripMenuItem.remove_Click($fRPToolToolStripMenuItem_Click)
			$uninstallFRPToolStripMenuItem.remove_Click($uninstallFRPToolStripMenuItem_Click)
			$removeFRPCacheToolStripMenuItem.remove_Click($removeFRPCacheToolStripMenuItem_Click)
			$removeFRPUserCacheToolStripMenuItem.remove_Click($removeFRPUserCacheToolStripMenuItem_Click)
			$removeFRPAllUsersCacheToolStripMenuItem.remove_Click($removeFRPAllUsersCacheToolStripMenuItem_Click)
			$reinstallENSToolStripMenuItem.remove_Click($reinstallENSToolStripMenuItem_Click)
			$reinstallFRPToolStripMenuItem.remove_Click($reinstallFRPToolStripMenuItem_Click)
			$reinstallDLPToolStripMenuItem.remove_Click($reinstallDLPToolStripMenuItem_Click)
			$checkForUpdatesToolStripMenuItem1.remove_Click($checkForUpdatesToolStripMenuItem1_Click)
			$installFWToolStripMenuItem.remove_Click($installFWToolStripMenuItem_Click)
			$ESS.remove_Load($Form_StateCorrection_Load)
			$ESS.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$ESS.SuspendLayout()
	$picturebox2.BeginInit()
	$picturebox1.BeginInit()
	$groupbox2.SuspendLayout()
	$groupbox10.SuspendLayout()
	$groupbox9.SuspendLayout()
	$groupbox8.SuspendLayout()
	$groupbox7.SuspendLayout()
	$groupbox4.SuspendLayout()
	$groupbox5.SuspendLayout()
	$groupbox1.SuspendLayout()
	$groupbox14.SuspendLayout()
	$menustrip1.SuspendLayout()
	#
	# ESS
	#
	$ESS.Controls.Add($progressbaroverlay1)
	$ESS.Controls.Add($statusbar1)
	$ESS.Controls.Add($picturebox2)
	$ESS.Controls.Add($picturebox1)
	$ESS.Controls.Add($groupbox2)
	$ESS.Controls.Add($groupbox1)
	$ESS.Controls.Add($menustrip1)
	$ESS.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 13)
	$ESS.AutoScaleMode = 'Font'
	$ESS.AutoSizeMode = 'GrowAndShrink'
	$ESS.BackColor = [System.Drawing.Color]::FromArgb(255, 95, 25, 56)
	$ESS.ClientSize = New-Object System.Drawing.Size(810, 375)
	$ESS.MainMenuStrip = $menustrip1
	$ESS.MaximumSize = New-Object System.Drawing.Size(826, 414)
	$ESS.MinimumSize = New-Object System.Drawing.Size(826, 414)
	$ESS.Name = 'ESS'
	$ESS.StartPosition = 'CenterScreen'
	#
	# progressbaroverlay1
	#
	$progressbaroverlay1.Location = New-Object System.Drawing.Point(0, 351)
	$progressbaroverlay1.Name = 'progressbaroverlay1'
	$progressbaroverlay1.Size = New-Object System.Drawing.Size(810, 23)
	$progressbaroverlay1.TabIndex = 29
	#
	# statusbar1
	#
	$statusbar1.Location = New-Object System.Drawing.Point(0, 353)
	$statusbar1.Name = 'statusbar1'
	$statusbar1.Size = New-Object System.Drawing.Size(810, 22)
	$statusbar1.TabIndex = 28
	#
	# picturebox2
	#
	$picturebox2.BackColor = [System.Drawing.Color]::Transparent 
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
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'))
	#endregion
	$picturebox2.BackgroundImage = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$picturebox2.BackgroundImageLayout = 'None'
	$picturebox2.Location = New-Object System.Drawing.Point(616, 313)
	$picturebox2.Name = 'picturebox2'
	$picturebox2.Size = New-Object System.Drawing.Size(182, 31)
	$picturebox2.TabIndex = 26
	$picturebox2.TabStop = $False
	#
	# picturebox1
	#
	$picturebox1.BackColor = [System.Drawing.Color]::Transparent 
	$picturebox1.BackgroundImageLayout = 'Center'
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
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
RK5CYIIL'))
	#endregion
	$picturebox1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$picturebox1.Location = New-Object System.Drawing.Point(12, 313)
	$picturebox1.Name = 'picturebox1'
	$picturebox1.Size = New-Object System.Drawing.Size(191, 31)
	$picturebox1.TabIndex = 25
	$picturebox1.TabStop = $False
	#
	# groupbox2
	#
	$groupbox2.Controls.Add($groupbox10)
	$groupbox2.Controls.Add($groupbox9)
	$groupbox2.Controls.Add($groupbox8)
	$groupbox2.Controls.Add($groupbox7)
	$groupbox2.Controls.Add($groupbox4)
	$groupbox2.Controls.Add($groupbox5)
	$groupbox2.BackColor = [System.Drawing.Color]::Transparent 
	$groupbox2.ForeColor = [System.Drawing.Color]::White 
	$groupbox2.Location = New-Object System.Drawing.Point(321, 43)
	$groupbox2.Name = 'groupbox2'
	$groupbox2.Size = New-Object System.Drawing.Size(476, 237)
	$groupbox2.TabIndex = 2
	$groupbox2.TabStop = $False
	$groupbox2.Text = 'SOFTWARE INFORMATION'
	#
	# groupbox10
	#
	$groupbox10.Controls.Add($labelVersion)
	$groupbox10.Controls.Add($labelStatus)
	$groupbox10.Controls.Add($textboxDLPStatus)
	$groupbox10.Controls.Add($textboxDLPVersion)
	$groupbox10.ForeColor = [System.Drawing.SystemColors]::ButtonFace 
	$groupbox10.Location = New-Object System.Drawing.Point(240, 163)
	$groupbox10.Name = 'groupbox10'
	$groupbox10.Size = New-Object System.Drawing.Size(228, 65)
	$groupbox10.TabIndex = 14
	$groupbox10.TabStop = $False
	$groupbox10.Text = 'Data Loss Prevention'
	#
	# labelVersion
	#
	$labelVersion.AutoSize = $True
	$labelVersion.Location = New-Object System.Drawing.Point(110, 23)
	$labelVersion.Name = 'labelVersion'
	$labelVersion.Size = New-Object System.Drawing.Size(42, 13)
	$labelVersion.TabIndex = 5
	$labelVersion.Text = 'Version'
	#
	# labelStatus
	#
	$labelStatus.AutoSize = $True
	$labelStatus.Location = New-Object System.Drawing.Point(6, 23)
	$labelStatus.Name = 'labelStatus'
	$labelStatus.Size = New-Object System.Drawing.Size(37, 13)
	$labelStatus.TabIndex = 4
	$labelStatus.Text = 'Status'
	#
	# textboxDLPStatus
	#
	$textboxDLPStatus.BorderStyle = 'FixedSingle'
	$textboxDLPStatus.Location = New-Object System.Drawing.Point(6, 39)
	$textboxDLPStatus.Name = 'textboxDLPStatus'
	$textboxDLPStatus.ReadOnly = $True
	$textboxDLPStatus.Size = New-Object System.Drawing.Size(98, 20)
	$textboxDLPStatus.TabIndex = 6
	$textboxDLPStatus.TabStop = $False
	$textboxDLPStatus.TextAlign = 'Center'
	#
	# textboxDLPVersion
	#
	$textboxDLPVersion.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxDLPVersion.BorderStyle = 'FixedSingle'
	$textboxDLPVersion.Location = New-Object System.Drawing.Point(110, 39)
	$textboxDLPVersion.Name = 'textboxDLPVersion'
	$textboxDLPVersion.ReadOnly = $True
	$textboxDLPVersion.Size = New-Object System.Drawing.Size(112, 20)
	$textboxDLPVersion.TabIndex = 7
	$textboxDLPVersion.TabStop = $False
	$textboxDLPVersion.TextAlign = 'Center'
	#
	# groupbox9
	#
	$groupbox9.Controls.Add($label7)
	$groupbox9.Controls.Add($label8)
	$groupbox9.Controls.Add($textboxFRPStatus)
	$groupbox9.Controls.Add($textboxFRPVersion)
	$groupbox9.ForeColor = [System.Drawing.SystemColors]::ButtonFace 
	$groupbox9.Location = New-Object System.Drawing.Point(6, 163)
	$groupbox9.Name = 'groupbox9'
	$groupbox9.Size = New-Object System.Drawing.Size(228, 65)
	$groupbox9.TabIndex = 13
	$groupbox9.TabStop = $False
	$groupbox9.Text = 'File and Removable Protection'
	#
	# label7
	#
	$label7.AutoSize = $True
	$label7.Location = New-Object System.Drawing.Point(110, 23)
	$label7.Name = 'label7'
	$label7.Size = New-Object System.Drawing.Size(42, 13)
	$label7.TabIndex = 5
	$label7.Text = 'Version'
	#
	# label8
	#
	$label8.AutoSize = $True
	$label8.Location = New-Object System.Drawing.Point(6, 23)
	$label8.Name = 'label8'
	$label8.Size = New-Object System.Drawing.Size(37, 13)
	$label8.TabIndex = 4
	$label8.Text = 'Status'
	#
	# textboxFRPStatus
	#
	$textboxFRPStatus.BorderStyle = 'FixedSingle'
	$textboxFRPStatus.Location = New-Object System.Drawing.Point(6, 39)
	$textboxFRPStatus.Name = 'textboxFRPStatus'
	$textboxFRPStatus.ReadOnly = $True
	$textboxFRPStatus.Size = New-Object System.Drawing.Size(98, 20)
	$textboxFRPStatus.TabIndex = 6
	$textboxFRPStatus.TabStop = $False
	$textboxFRPStatus.TextAlign = 'Center'
	#
	# textboxFRPVersion
	#
	$textboxFRPVersion.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxFRPVersion.BorderStyle = 'FixedSingle'
	$textboxFRPVersion.Location = New-Object System.Drawing.Point(110, 39)
	$textboxFRPVersion.Name = 'textboxFRPVersion'
	$textboxFRPVersion.ReadOnly = $True
	$textboxFRPVersion.Size = New-Object System.Drawing.Size(112, 20)
	$textboxFRPVersion.TabIndex = 7
	$textboxFRPVersion.TabStop = $False
	$textboxFRPVersion.TextAlign = 'Center'
	#
	# groupbox8
	#
	$groupbox8.Controls.Add($label9)
	$groupbox8.Controls.Add($label10)
	$groupbox8.Controls.Add($textboxATPStatus)
	$groupbox8.Controls.Add($textboxATPVersion)
	$groupbox8.ForeColor = [System.Drawing.SystemColors]::ButtonHighlight 
	$groupbox8.Location = New-Object System.Drawing.Point(6, 92)
	$groupbox8.Name = 'groupbox8'
	$groupbox8.Size = New-Object System.Drawing.Size(228, 65)
	$groupbox8.TabIndex = 13
	$groupbox8.TabStop = $False
	$groupbox8.Text = 'Adaptive Threat Protection'
	#
	# label9
	#
	$label9.AutoSize = $True
	$label9.Location = New-Object System.Drawing.Point(110, 23)
	$label9.Name = 'label9'
	$label9.Size = New-Object System.Drawing.Size(42, 13)
	$label9.TabIndex = 5
	$label9.Text = 'Version'
	#
	# label10
	#
	$label10.AutoSize = $True
	$label10.Location = New-Object System.Drawing.Point(6, 23)
	$label10.Name = 'label10'
	$label10.Size = New-Object System.Drawing.Size(37, 13)
	$label10.TabIndex = 4
	$label10.Text = 'Status'
	#
	# textboxATPStatus
	#
	$textboxATPStatus.BorderStyle = 'FixedSingle'
	$textboxATPStatus.Location = New-Object System.Drawing.Point(6, 39)
	$textboxATPStatus.Name = 'textboxATPStatus'
	$textboxATPStatus.ReadOnly = $True
	$textboxATPStatus.Size = New-Object System.Drawing.Size(98, 20)
	$textboxATPStatus.TabIndex = 8
	$textboxATPStatus.TabStop = $False
	$textboxATPStatus.TextAlign = 'Center'
	#
	# textboxATPVersion
	#
	$textboxATPVersion.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxATPVersion.BorderStyle = 'FixedSingle'
	$textboxATPVersion.Location = New-Object System.Drawing.Point(110, 39)
	$textboxATPVersion.Name = 'textboxATPVersion'
	$textboxATPVersion.ReadOnly = $True
	$textboxATPVersion.Size = New-Object System.Drawing.Size(112, 20)
	$textboxATPVersion.TabIndex = 9
	$textboxATPVersion.TabStop = $False
	$textboxATPVersion.TextAlign = 'Center'
	#
	# groupbox7
	#
	$groupbox7.Controls.Add($label3)
	$groupbox7.Controls.Add($label4)
	$groupbox7.Controls.Add($textboxFWStatus)
	$groupbox7.Controls.Add($textboxFWVersion)
	$groupbox7.ForeColor = [System.Drawing.SystemColors]::ButtonHighlight 
	$groupbox7.Location = New-Object System.Drawing.Point(240, 92)
	$groupbox7.Name = 'groupbox7'
	$groupbox7.Size = New-Object System.Drawing.Size(228, 65)
	$groupbox7.TabIndex = 12
	$groupbox7.TabStop = $False
	$groupbox7.Text = 'Firewall'
	#
	# label3
	#
	$label3.AutoSize = $True
	$label3.Location = New-Object System.Drawing.Point(110, 23)
	$label3.Name = 'label3'
	$label3.Size = New-Object System.Drawing.Size(42, 13)
	$label3.TabIndex = 5
	$label3.Text = 'Version'
	#
	# label4
	#
	$label4.AutoSize = $True
	$label4.Location = New-Object System.Drawing.Point(6, 23)
	$label4.Name = 'label4'
	$label4.Size = New-Object System.Drawing.Size(37, 13)
	$label4.TabIndex = 4
	$label4.Text = 'Status'
	#
	# textboxFWStatus
	#
	$textboxFWStatus.BorderStyle = 'FixedSingle'
	$textboxFWStatus.Location = New-Object System.Drawing.Point(6, 39)
	$textboxFWStatus.Name = 'textboxFWStatus'
	$textboxFWStatus.ReadOnly = $True
	$textboxFWStatus.Size = New-Object System.Drawing.Size(98, 20)
	$textboxFWStatus.TabIndex = 6
	$textboxFWStatus.TabStop = $False
	$textboxFWStatus.TextAlign = 'Center'
	#
	# textboxFWVersion
	#
	$textboxFWVersion.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxFWVersion.BorderStyle = 'FixedSingle'
	$textboxFWVersion.Location = New-Object System.Drawing.Point(110, 39)
	$textboxFWVersion.Name = 'textboxFWVersion'
	$textboxFWVersion.ReadOnly = $True
	$textboxFWVersion.Size = New-Object System.Drawing.Size(112, 20)
	$textboxFWVersion.TabIndex = 7
	$textboxFWVersion.TabStop = $False
	$textboxFWVersion.TextAlign = 'Center'
	#
	# groupbox4
	#
	$groupbox4.Controls.Add($label5)
	$groupbox4.Controls.Add($label6)
	$groupbox4.Controls.Add($textboxAgentStatus)
	$groupbox4.Controls.Add($textboxAgentVersion)
	$groupbox4.ForeColor = [System.Drawing.SystemColors]::ButtonHighlight 
	$groupbox4.Location = New-Object System.Drawing.Point(6, 21)
	$groupbox4.Name = 'groupbox4'
	$groupbox4.Size = New-Object System.Drawing.Size(228, 65)
	$groupbox4.TabIndex = 10
	$groupbox4.TabStop = $False
	$groupbox4.Text = 'Agent'
	#
	# label5
	#
	$label5.AutoSize = $True
	$label5.Location = New-Object System.Drawing.Point(106, 23)
	$label5.Name = 'label5'
	$label5.Size = New-Object System.Drawing.Size(42, 13)
	$label5.TabIndex = 5
	$label5.Text = 'Version'
	#
	# label6
	#
	$label6.AutoSize = $True
	$label6.Location = New-Object System.Drawing.Point(6, 21)
	$label6.Name = 'label6'
	$label6.Size = New-Object System.Drawing.Size(37, 13)
	$label6.TabIndex = 4
	$label6.Text = 'Status'
	#
	# textboxAgentStatus
	#
	$textboxAgentStatus.BorderStyle = 'FixedSingle'
	$textboxAgentStatus.Location = New-Object System.Drawing.Point(6, 39)
	$textboxAgentStatus.Name = 'textboxAgentStatus'
	$textboxAgentStatus.ReadOnly = $True
	$textboxAgentStatus.Size = New-Object System.Drawing.Size(98, 20)
	$textboxAgentStatus.TabIndex = 2
	$textboxAgentStatus.TabStop = $False
	$textboxAgentStatus.TextAlign = 'Center'
	#
	# textboxAgentVersion
	#
	$textboxAgentVersion.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxAgentVersion.BorderStyle = 'FixedSingle'
	$textboxAgentVersion.Location = New-Object System.Drawing.Point(110, 39)
	$textboxAgentVersion.Name = 'textboxAgentVersion'
	$textboxAgentVersion.ReadOnly = $True
	$textboxAgentVersion.Size = New-Object System.Drawing.Size(112, 20)
	$textboxAgentVersion.TabIndex = 3
	$textboxAgentVersion.TabStop = $False
	$textboxAgentVersion.TextAlign = 'Center'
	#
	# groupbox5
	#
	$groupbox5.Controls.Add($label1)
	$groupbox5.Controls.Add($label2)
	$groupbox5.Controls.Add($textboxENSStatus)
	$groupbox5.Controls.Add($textboxENSVersion)
	$groupbox5.ForeColor = [System.Drawing.SystemColors]::ButtonHighlight 
	$groupbox5.Location = New-Object System.Drawing.Point(240, 21)
	$groupbox5.Name = 'groupbox5'
	$groupbox5.Size = New-Object System.Drawing.Size(228, 65)
	$groupbox5.TabIndex = 11
	$groupbox5.TabStop = $False
	$groupbox5.Text = 'Threat Prevention'
	#
	# label1
	#
	$label1.AutoSize = $True
	$label1.Location = New-Object System.Drawing.Point(110, 23)
	$label1.Name = 'label1'
	$label1.Size = New-Object System.Drawing.Size(42, 13)
	$label1.TabIndex = 5
	$label1.Text = 'Version'
	#
	# label2
	#
	$label2.AutoSize = $True
	$label2.Location = New-Object System.Drawing.Point(6, 23)
	$label2.Name = 'label2'
	$label2.Size = New-Object System.Drawing.Size(37, 13)
	$label2.TabIndex = 4
	$label2.Text = 'Status'
	#
	# textboxENSStatus
	#
	$textboxENSStatus.BorderStyle = 'FixedSingle'
	$textboxENSStatus.Location = New-Object System.Drawing.Point(6, 39)
	$textboxENSStatus.Name = 'textboxENSStatus'
	$textboxENSStatus.ReadOnly = $True
	$textboxENSStatus.Size = New-Object System.Drawing.Size(98, 20)
	$textboxENSStatus.TabIndex = 4
	$textboxENSStatus.TabStop = $False
	$textboxENSStatus.TextAlign = 'Center'
	#
	# textboxENSVersion
	#
	$textboxENSVersion.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxENSVersion.BorderStyle = 'FixedSingle'
	$textboxENSVersion.Location = New-Object System.Drawing.Point(110, 39)
	$textboxENSVersion.Name = 'textboxENSVersion'
	$textboxENSVersion.ReadOnly = $True
	$textboxENSVersion.Size = New-Object System.Drawing.Size(112, 20)
	$textboxENSVersion.TabIndex = 5
	$textboxENSVersion.TabStop = $False
	$textboxENSVersion.TextAlign = 'Center'
	#
	# groupbox1
	#
	$groupbox1.Controls.Add($groupbox14)
	$groupbox1.Controls.Add($textboxRebootTime)
	$groupbox1.Controls.Add($labelLastRebootTime)
	$groupbox1.Controls.Add($textboxRebootPending)
	$groupbox1.Controls.Add($labelRebootPending)
	$groupbox1.Controls.Add($labelHostname)
	$groupbox1.Controls.Add($textboxHostname)
	$groupbox1.Controls.Add($labelUserID)
	$groupbox1.Controls.Add($textboxUserID)
	$groupbox1.BackColor = [System.Drawing.Color]::Transparent 
	$groupbox1.Font = [System.Drawing.Font]::new('Microsoft Sans Serif', '8.25')
	$groupbox1.ForeColor = [System.Drawing.SystemColors]::ButtonFace 
	$groupbox1.Location = New-Object System.Drawing.Point(12, 43)
	$groupbox1.Name = 'groupbox1'
	$groupbox1.Size = New-Object System.Drawing.Size(293, 237)
	$groupbox1.TabIndex = 1
	$groupbox1.TabStop = $False
	$groupbox1.Text = 'SYSTEM INFORMATION'
	#
	# groupbox14
	#
	$groupbox14.Controls.Add($labelEPOEnvironment)
	$groupbox14.Controls.Add($textboxLastCommunication)
	$groupbox14.Controls.Add($textboxEPOEnvironment)
	$groupbox14.Controls.Add($labelLastCommunication)
	$groupbox14.ForeColor = [System.Drawing.SystemColors]::ButtonFace 
	$groupbox14.Location = New-Object System.Drawing.Point(8, 122)
	$groupbox14.Name = 'groupbox14'
	$groupbox14.Size = New-Object System.Drawing.Size(276, 106)
	$groupbox14.TabIndex = 100
	$groupbox14.TabStop = $False
	$groupbox14.Text = 'Connection'
	#
	# labelEPOEnvironment
	#
	$labelEPOEnvironment.AutoSize = $True
	$labelEPOEnvironment.ForeColor = [System.Drawing.SystemColors]::Window 
	$labelEPOEnvironment.Location = New-Object System.Drawing.Point(6, 17)
	$labelEPOEnvironment.Name = 'labelEPOEnvironment'
	$labelEPOEnvironment.Size = New-Object System.Drawing.Size(91, 13)
	$labelEPOEnvironment.TabIndex = 96
	$labelEPOEnvironment.Text = 'EPO Environment'
	#
	# textboxLastCommunication
	#
	$textboxLastCommunication.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxLastCommunication.BorderStyle = 'FixedSingle'
	$textboxLastCommunication.Location = New-Object System.Drawing.Point(6, 80)
	$textboxLastCommunication.Name = 'textboxLastCommunication'
	$textboxLastCommunication.ReadOnly = $True
	$textboxLastCommunication.Size = New-Object System.Drawing.Size(264, 20)
	$textboxLastCommunication.TabIndex = 99
	$textboxLastCommunication.TabStop = $False
	$textboxLastCommunication.TextAlign = 'Center'
	#
	# textboxEPOEnvironment
	#
	$textboxEPOEnvironment.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxEPOEnvironment.BorderStyle = 'FixedSingle'
	$textboxEPOEnvironment.Location = New-Object System.Drawing.Point(6, 33)
	$textboxEPOEnvironment.Name = 'textboxEPOEnvironment'
	$textboxEPOEnvironment.ReadOnly = $True
	$textboxEPOEnvironment.Size = New-Object System.Drawing.Size(264, 20)
	$textboxEPOEnvironment.TabIndex = 97
	$textboxEPOEnvironment.TabStop = $False
	$textboxEPOEnvironment.TextAlign = 'Center'
	#
	# labelLastCommunication
	#
	$labelLastCommunication.AutoSize = $True
	$labelLastCommunication.ForeColor = [System.Drawing.SystemColors]::Window 
	$labelLastCommunication.Location = New-Object System.Drawing.Point(6, 64)
	$labelLastCommunication.Name = 'labelLastCommunication'
	$labelLastCommunication.Size = New-Object System.Drawing.Size(102, 13)
	$labelLastCommunication.TabIndex = 98
	$labelLastCommunication.Text = 'Last Communication'
	#
	# textboxRebootTime
	#
	$textboxRebootTime.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxRebootTime.BorderStyle = 'FixedSingle'
	$textboxRebootTime.Location = New-Object System.Drawing.Point(6, 90)
	$textboxRebootTime.Name = 'textboxRebootTime'
	$textboxRebootTime.ReadOnly = $True
	$textboxRebootTime.Size = New-Object System.Drawing.Size(133, 20)
	$textboxRebootTime.TabIndex = 93
	$textboxRebootTime.TabStop = $False
	$textboxRebootTime.TextAlign = 'Center'
	#
	# labelLastRebootTime
	#
	$labelLastRebootTime.AutoSize = $True
	$labelLastRebootTime.Location = New-Object System.Drawing.Point(6, 74)
	$labelLastRebootTime.Name = 'labelLastRebootTime'
	$labelLastRebootTime.Size = New-Object System.Drawing.Size(91, 13)
	$labelLastRebootTime.TabIndex = 91
	$labelLastRebootTime.Text = 'Last Reboot Time'
	#
	# textboxRebootPending
	#
	$textboxRebootPending.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxRebootPending.BorderStyle = 'FixedSingle'
	$textboxRebootPending.Location = New-Object System.Drawing.Point(153, 90)
	$textboxRebootPending.Name = 'textboxRebootPending'
	$textboxRebootPending.ReadOnly = $True
	$textboxRebootPending.Size = New-Object System.Drawing.Size(131, 20)
	$textboxRebootPending.TabIndex = 94
	$textboxRebootPending.TabStop = $False
	$textboxRebootPending.TextAlign = 'Center'
	#
	# labelRebootPending
	#
	$labelRebootPending.AutoSize = $True
	$labelRebootPending.Location = New-Object System.Drawing.Point(153, 74)
	$labelRebootPending.Name = 'labelRebootPending'
	$labelRebootPending.Size = New-Object System.Drawing.Size(84, 13)
	$labelRebootPending.TabIndex = 92
	$labelRebootPending.Text = 'Reboot Pending'
	#
	# labelHostname
	#
	$labelHostname.AutoSize = $True
	$labelHostname.Location = New-Object System.Drawing.Point(153, 26)
	$labelHostname.Name = 'labelHostname'
	$labelHostname.Size = New-Object System.Drawing.Size(55, 13)
	$labelHostname.TabIndex = 33
	$labelHostname.Text = 'Hostname'
	#
	# textboxHostname
	#
	$textboxHostname.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxHostname.BorderStyle = 'FixedSingle'
	$textboxHostname.Location = New-Object System.Drawing.Point(153, 42)
	$textboxHostname.Name = 'textboxHostname'
	$textboxHostname.ReadOnly = $True
	$textboxHostname.Size = New-Object System.Drawing.Size(131, 20)
	$textboxHostname.TabIndex = 34
	$textboxHostname.TabStop = $False
	$textboxHostname.TextAlign = 'Center'
	#
	# labelUserID
	#
	$labelUserID.AutoSize = $True
	$labelUserID.Location = New-Object System.Drawing.Point(6, 26)
	$labelUserID.Name = 'labelUserID'
	$labelUserID.Size = New-Object System.Drawing.Size(40, 13)
	$labelUserID.TabIndex = 31
	$labelUserID.Text = 'UserID'
	#
	# textboxUserID
	#
	$textboxUserID.BackColor = [System.Drawing.SystemColors]::Window 
	$textboxUserID.BorderStyle = 'FixedSingle'
	$textboxUserID.Location = New-Object System.Drawing.Point(6, 42)
	$textboxUserID.Name = 'textboxUserID'
	$textboxUserID.ReadOnly = $True
	$textboxUserID.Size = New-Object System.Drawing.Size(131, 20)
	$textboxUserID.TabIndex = 0
	$textboxUserID.TabStop = $False
	$textboxUserID.TextAlign = 'Center'
	#
	# menustrip1
	#
	$menustrip1.BackColor = [System.Drawing.Color]::WhiteSmoke 
	[void]$menustrip1.Items.Add($installToolStripMenuItem)
	[void]$menustrip1.Items.Add($troubleshootingToolStripMenuItem)
	[void]$menustrip1.Items.Add($toolsToolStripMenuItem)
	[void]$menustrip1.Items.Add($helpToolStripMenuItem)
	$menustrip1.Location = New-Object System.Drawing.Point(0, 0)
	$menustrip1.Name = 'menustrip1'
	$menustrip1.Size = New-Object System.Drawing.Size(810, 24)
	$menustrip1.TabIndex = 0
	$menustrip1.Text = 'menustrip1'
	#
	# helpToolStripMenuItem
	#
	[void]$helpToolStripMenuItem.DropDownItems.Add($checkForUpdatesToolStripMenuItem)
	[void]$helpToolStripMenuItem.DropDownItems.Add($toolstripseparator1)
	[void]$helpToolStripMenuItem.DropDownItems.Add($aboutToolStripMenuItem)
	$helpToolStripMenuItem.ForeColor = [System.Drawing.Color]::Black 
	$helpToolStripMenuItem.Name = 'helpToolStripMenuItem'
	$helpToolStripMenuItem.Size = New-Object System.Drawing.Size(44, 20)
	$helpToolStripMenuItem.Text = 'Help'
	#
	# aboutToolStripMenuItem
	#
	$aboutToolStripMenuItem.Name = 'aboutToolStripMenuItem'
	$aboutToolStripMenuItem.Size = New-Object System.Drawing.Size(171, 22)
	$aboutToolStripMenuItem.Text = 'About'
	$aboutToolStripMenuItem.add_Click($aboutToolStripMenuItem_Click)
	#
	# troubleshootingToolStripMenuItem
	#
	[void]$troubleshootingToolStripMenuItem.DropDownItems.Add($fRPToolStripMenuItem)
	[void]$troubleshootingToolStripMenuItem.DropDownItems.Add($checkLogsToolStripMenuItem)
	[void]$troubleshootingToolStripMenuItem.DropDownItems.Add($forceAgentSyncToolStripMenuItem)
	[void]$troubleshootingToolStripMenuItem.DropDownItems.Add($testConnectionToolStripMenuItem)
	$troubleshootingToolStripMenuItem.ForeColor = [System.Drawing.Color]::Black 
	$troubleshootingToolStripMenuItem.Name = 'troubleshootingToolStripMenuItem'
	$troubleshootingToolStripMenuItem.Size = New-Object System.Drawing.Size(105, 20)
	$troubleshootingToolStripMenuItem.Text = 'Troubleshooting'
	#
	# installToolStripMenuItem
	#
	[void]$installToolStripMenuItem.DropDownItems.Add($agentToolStripMenuItem)
	[void]$installToolStripMenuItem.DropDownItems.Add($endpointSecurityToolStripMenuItem)
	[void]$installToolStripMenuItem.DropDownItems.Add($dataLossPreventionjToolStripMenuItem)
	[void]$installToolStripMenuItem.DropDownItems.Add($fileAndRemovableProtectionToolStripMenuItem)
	[void]$installToolStripMenuItem.DropDownItems.Add($toolstripseparator4)
	[void]$installToolStripMenuItem.DropDownItems.Add($checkForUpdatesToolStripMenuItem1)
	$installToolStripMenuItem.ForeColor = [System.Drawing.Color]::Black 
	$installToolStripMenuItem.Name = 'installToolStripMenuItem'
	$installToolStripMenuItem.Size = New-Object System.Drawing.Size(98, 20)
	$installToolStripMenuItem.Text = 'Trellix Software'
	#
	# checkForUpdatesToolStripMenuItem
	#
	$checkForUpdatesToolStripMenuItem.Enabled = $False
	$checkForUpdatesToolStripMenuItem.Name = 'checkForUpdatesToolStripMenuItem'
	$checkForUpdatesToolStripMenuItem.Size = New-Object System.Drawing.Size(171, 22)
	$checkForUpdatesToolStripMenuItem.Text = 'Check for Updates'
	$checkForUpdatesToolStripMenuItem.add_Click($checkForUpdatesToolStripMenuItem_Click)
	#
	# toolstripseparator1
	#
	$toolstripseparator1.Name = 'toolstripseparator1'
	$toolstripseparator1.Size = New-Object System.Drawing.Size(168, 6)
	#
	# toolsToolStripMenuItem
	#
	[void]$toolsToolStripMenuItem.DropDownItems.Add($runMERToolStripMenuItem)
	[void]$toolsToolStripMenuItem.DropDownItems.Add($runRemovalToolToolStripMenuItem)
	[void]$toolsToolStripMenuItem.DropDownItems.Add($runManualRemovalToolStripMenuItem)
	$toolsToolStripMenuItem.ForeColor = [System.Drawing.Color]::Black 
	$toolsToolStripMenuItem.Name = 'toolsToolStripMenuItem'
	$toolsToolStripMenuItem.Size = New-Object System.Drawing.Size(46, 20)
	$toolsToolStripMenuItem.Text = 'Tools'
	#
	# runMERToolStripMenuItem
	#
	$runMERToolStripMenuItem.Name = 'runMERToolStripMenuItem'
	$runMERToolStripMenuItem.Size = New-Object System.Drawing.Size(187, 22)
	$runMERToolStripMenuItem.Text = 'Run MER'
	$runMERToolStripMenuItem.add_Click($runMERToolStripMenuItem_Click)
	#
	# runRemovalToolToolStripMenuItem
	#
	$runRemovalToolToolStripMenuItem.Name = 'runRemovalToolToolStripMenuItem'
	$runRemovalToolToolStripMenuItem.Size = New-Object System.Drawing.Size(187, 22)
	$runRemovalToolToolStripMenuItem.Text = 'Run Removal Tool'
	$runRemovalToolToolStripMenuItem.add_Click($runRemovalToolToolStripMenuItem_Click)
	#
	# runManualRemovalToolStripMenuItem
	#
	$runManualRemovalToolStripMenuItem.Name = 'runManualRemovalToolStripMenuItem'
	$runManualRemovalToolStripMenuItem.Size = New-Object System.Drawing.Size(187, 22)
	$runManualRemovalToolStripMenuItem.Text = 'Run Manual Removal'
	$runManualRemovalToolStripMenuItem.add_Click($runManualRemovalToolStripMenuItem_Click)
	#
	# agentToolStripMenuItem
	#
	[void]$agentToolStripMenuItem.DropDownItems.Add($reinstallAgentToolStripMenuItem)
	[void]$agentToolStripMenuItem.DropDownItems.Add($toolstripseparator2)
	[void]$agentToolStripMenuItem.DropDownItems.Add($changeEPOToolStripMenuItem)
	$agentToolStripMenuItem.Name = 'agentToolStripMenuItem'
	$agentToolStripMenuItem.Size = New-Object System.Drawing.Size(235, 22)
	$agentToolStripMenuItem.Text = 'Agent'
	#
	# endpointSecurityToolStripMenuItem
	#
	[void]$endpointSecurityToolStripMenuItem.DropDownItems.Add($reinstallENSToolStripMenuItem)
	[void]$endpointSecurityToolStripMenuItem.DropDownItems.Add($installFWToolStripMenuItem)
	$endpointSecurityToolStripMenuItem.Name = 'endpointSecurityToolStripMenuItem'
	$endpointSecurityToolStripMenuItem.Size = New-Object System.Drawing.Size(235, 22)
	$endpointSecurityToolStripMenuItem.Text = 'Endpoint Security'
	#
	# fileAndRemovableProtectionToolStripMenuItem
	#
	[void]$fileAndRemovableProtectionToolStripMenuItem.DropDownItems.Add($reinstallFRPToolStripMenuItem)
	$fileAndRemovableProtectionToolStripMenuItem.Name = 'fileAndRemovableProtectionToolStripMenuItem'
	$fileAndRemovableProtectionToolStripMenuItem.Size = New-Object System.Drawing.Size(235, 22)
	$fileAndRemovableProtectionToolStripMenuItem.Text = 'File and Removable Protection'
	#
	# dataLossPreventionjToolStripMenuItem
	#
	[void]$dataLossPreventionjToolStripMenuItem.DropDownItems.Add($reinstallDLPToolStripMenuItem)
	$dataLossPreventionjToolStripMenuItem.Name = 'dataLossPreventionjToolStripMenuItem'
	$dataLossPreventionjToolStripMenuItem.Size = New-Object System.Drawing.Size(235, 22)
	$dataLossPreventionjToolStripMenuItem.Text = 'Data Loss Prevention'
	#
	# reinstallAgentToolStripMenuItem
	#
	$reinstallAgentToolStripMenuItem.Name = 'reinstallAgentToolStripMenuItem'
	$reinstallAgentToolStripMenuItem.Size = New-Object System.Drawing.Size(140, 22)
	$reinstallAgentToolStripMenuItem.Text = 'Install Agent'
	$reinstallAgentToolStripMenuItem.add_Click($reinstallAgentToolStripMenuItem_Click)
	#
	# toolstripseparator2
	#
	$toolstripseparator2.Name = 'toolstripseparator2'
	$toolstripseparator2.Size = New-Object System.Drawing.Size(137, 6)
	#
	# changeEPOToolStripMenuItem
	#
	$changeEPOToolStripMenuItem.Enabled = $False
	$changeEPOToolStripMenuItem.Name = 'changeEPOToolStripMenuItem'
	$changeEPOToolStripMenuItem.Size = New-Object System.Drawing.Size(140, 22)
	$changeEPOToolStripMenuItem.Text = 'Change EPO'
	$changeEPOToolStripMenuItem.add_Click($changeEPOToolStripMenuItem_Click)
	#
	# testConnectionToolStripMenuItem
	#
	$testConnectionToolStripMenuItem.Name = 'testConnectionToolStripMenuItem'
	$testConnectionToolStripMenuItem.Size = New-Object System.Drawing.Size(166, 22)
	$testConnectionToolStripMenuItem.Text = 'Test Connection'
	$testConnectionToolStripMenuItem.add_Click($testConnectionToolStripMenuItem_Click)
	#
	# forceAgentSyncToolStripMenuItem
	#
	$forceAgentSyncToolStripMenuItem.Name = 'forceAgentSyncToolStripMenuItem'
	$forceAgentSyncToolStripMenuItem.Size = New-Object System.Drawing.Size(166, 22)
	$forceAgentSyncToolStripMenuItem.Text = 'Force Agent Sync'
	$forceAgentSyncToolStripMenuItem.add_Click($forceAgentSyncToolStripMenuItem_Click)
	#
	# checkLogsToolStripMenuItem
	#
	$checkLogsToolStripMenuItem.Name = 'checkLogsToolStripMenuItem'
	$checkLogsToolStripMenuItem.Size = New-Object System.Drawing.Size(166, 22)
	$checkLogsToolStripMenuItem.Text = 'Check Logs'
	$checkLogsToolStripMenuItem.add_Click($checkLogsToolStripMenuItem_Click)
	#
	# fRPToolStripMenuItem
	#
	[void]$fRPToolStripMenuItem.DropDownItems.Add($fRPToolToolStripMenuItem)
	[void]$fRPToolStripMenuItem.DropDownItems.Add($toolstripseparator3)
	[void]$fRPToolStripMenuItem.DropDownItems.Add($removeFRPCacheToolStripMenuItem)
	[void]$fRPToolStripMenuItem.DropDownItems.Add($removeFRPUserCacheToolStripMenuItem)
	[void]$fRPToolStripMenuItem.DropDownItems.Add($removeFRPAllUsersCacheToolStripMenuItem)
	[void]$fRPToolStripMenuItem.DropDownItems.Add($uninstallFRPToolStripMenuItem)
	$fRPToolStripMenuItem.Name = 'fRPToolStripMenuItem'
	$fRPToolStripMenuItem.Size = New-Object System.Drawing.Size(166, 22)
	$fRPToolStripMenuItem.Text = 'FRP'
	#
	# fRPToolToolStripMenuItem
	#
	$fRPToolToolStripMenuItem.Name = 'fRPToolToolStripMenuItem'
	$fRPToolToolStripMenuItem.Size = New-Object System.Drawing.Size(224, 22)
	$fRPToolToolStripMenuItem.Text = 'FRP Tools'
	$fRPToolToolStripMenuItem.add_Click($fRPToolToolStripMenuItem_Click)
	#
	# uninstallFRPToolStripMenuItem
	#
	$uninstallFRPToolStripMenuItem.Name = 'uninstallFRPToolStripMenuItem'
	$uninstallFRPToolStripMenuItem.Size = New-Object System.Drawing.Size(224, 22)
	$uninstallFRPToolStripMenuItem.Text = 'Uninstall FRP'
	$uninstallFRPToolStripMenuItem.add_Click($uninstallFRPToolStripMenuItem_Click)
	#
	# toolstripseparator3
	#
	$toolstripseparator3.Name = 'toolstripseparator3'
	$toolstripseparator3.Size = New-Object System.Drawing.Size(221, 6)
	#
	# removeFRPCacheToolStripMenuItem
	#
	$removeFRPCacheToolStripMenuItem.Name = 'removeFRPCacheToolStripMenuItem'
	$removeFRPCacheToolStripMenuItem.Size = New-Object System.Drawing.Size(224, 22)
	$removeFRPCacheToolStripMenuItem.Text = 'Remove FRP Cache'
	$removeFRPCacheToolStripMenuItem.add_Click($removeFRPCacheToolStripMenuItem_Click)
	#
	# removeFRPUserCacheToolStripMenuItem
	#
	$removeFRPUserCacheToolStripMenuItem.Name = 'removeFRPUserCacheToolStripMenuItem'
	$removeFRPUserCacheToolStripMenuItem.Size = New-Object System.Drawing.Size(224, 22)
	$removeFRPUserCacheToolStripMenuItem.Text = 'Remove FRP User Cache'
	$removeFRPUserCacheToolStripMenuItem.add_Click($removeFRPUserCacheToolStripMenuItem_Click)
	#
	# removeFRPAllUsersCacheToolStripMenuItem
	#
	$removeFRPAllUsersCacheToolStripMenuItem.Name = 'removeFRPAllUsersCacheToolStripMenuItem'
	$removeFRPAllUsersCacheToolStripMenuItem.Size = New-Object System.Drawing.Size(224, 22)
	$removeFRPAllUsersCacheToolStripMenuItem.Text = 'Remove FRP All Users Cache'
	$removeFRPAllUsersCacheToolStripMenuItem.add_Click($removeFRPAllUsersCacheToolStripMenuItem_Click)
	#
	# reinstallENSToolStripMenuItem
	#
	$reinstallENSToolStripMenuItem.Name = 'reinstallENSToolStripMenuItem'
	$reinstallENSToolStripMenuItem.Size = New-Object System.Drawing.Size(152, 22)
	$reinstallENSToolStripMenuItem.Text = 'Install ATP / TP'
	$reinstallENSToolStripMenuItem.add_Click($reinstallENSToolStripMenuItem_Click)
	#
	# reinstallFRPToolStripMenuItem
	#
	$reinstallFRPToolStripMenuItem.Name = 'reinstallFRPToolStripMenuItem'
	$reinstallFRPToolStripMenuItem.Size = New-Object System.Drawing.Size(128, 22)
	$reinstallFRPToolStripMenuItem.Text = 'Install FRP'
	$reinstallFRPToolStripMenuItem.add_Click($reinstallFRPToolStripMenuItem_Click)
	#
	# reinstallDLPToolStripMenuItem
	#
	$reinstallDLPToolStripMenuItem.Name = 'reinstallDLPToolStripMenuItem'
	$reinstallDLPToolStripMenuItem.Size = New-Object System.Drawing.Size(129, 22)
	$reinstallDLPToolStripMenuItem.Text = 'Install DLP'
	$reinstallDLPToolStripMenuItem.add_Click($reinstallDLPToolStripMenuItem_Click)
	#
	# checkForUpdatesToolStripMenuItem1
	#
	$checkForUpdatesToolStripMenuItem1.Name = 'checkForUpdatesToolStripMenuItem1'
	$checkForUpdatesToolStripMenuItem1.Size = New-Object System.Drawing.Size(235, 22)
	$checkForUpdatesToolStripMenuItem1.Text = 'Check for Updates'
	$checkForUpdatesToolStripMenuItem1.add_Click($checkForUpdatesToolStripMenuItem1_Click)
	#
	# toolstripseparator4
	#
	$toolstripseparator4.Name = 'toolstripseparator4'
	$toolstripseparator4.Size = New-Object System.Drawing.Size(232, 6)
	#
	# installFWToolStripMenuItem
	#
	$installFWToolStripMenuItem.Name = 'installFWToolStripMenuItem'
	$installFWToolStripMenuItem.Size = New-Object System.Drawing.Size(152, 22)
	$installFWToolStripMenuItem.Text = 'Install FW'
	$installFWToolStripMenuItem.add_Click($installFWToolStripMenuItem_Click)
	$menustrip1.ResumeLayout()
	$groupbox14.ResumeLayout()
	$groupbox1.ResumeLayout()
	$groupbox5.ResumeLayout()
	$groupbox4.ResumeLayout()
	$groupbox7.ResumeLayout()
	$groupbox8.ResumeLayout()
	$groupbox9.ResumeLayout()
	$groupbox10.ResumeLayout()
	$groupbox2.ResumeLayout()
	$picturebox1.EndInit()
	$picturebox2.EndInit()
	$ESS.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $ESS.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$ESS.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$ESS.add_FormClosed($Form_Cleanup_FormClosed)
	#Show the Form
	return $ESS.ShowDialog()

} #End Function

#Call the form
Show-ESS_psf | Out-Null

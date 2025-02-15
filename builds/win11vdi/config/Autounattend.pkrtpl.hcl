<?xml version="1.0" encoding="utf-8"?>
<unattend xmlns="urn:schemas-microsoft-com:unattend">
	<settings pass="windowsPE">
        <component name="Microsoft-Windows-PnpCustomizationsWinPE" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" processorArchitecture="amd64" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
            <DriverPaths>
                <PathAndCredentials wcm:action="add" wcm:keyValue="A">
                    <Path>E:\Program Files\VMware\VMware Tools\Drivers\pvscsi\Win8\amd64</Path>
                </PathAndCredentials>
            </DriverPaths>
        </component>
		<component name="Microsoft-Windows-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State">
			<DiskConfiguration>
                <Disk wcm:action="add">
                    <CreatePartitions>
                        <CreatePartition wcm:action="add">
                            <Type>EFI</Type>
                            <Size>512</Size>
                            <Order>1</Order>
                        </CreatePartition>
                        <CreatePartition wcm:action="add">
                            <Extend>false</Extend>
                            <Type>MSR</Type>
                            <Order>2</Order>
                            <Size>128</Size>
                        </CreatePartition>
                        <CreatePartition wcm:action="add">
                            <Order>3</Order>
                            <Type>Primary</Type>
                            <Extend>true</Extend>
                        </CreatePartition>
                    </CreatePartitions>
                    <ModifyPartitions>
                        <ModifyPartition wcm:action="add">
                            <Format>FAT32</Format>
                            <Order>1</Order>
                            <PartitionID>1</PartitionID>
                        </ModifyPartition>
                        <ModifyPartition wcm:action="add">
                            <Order>2</Order>
                            <PartitionID>2</PartitionID>
                        </ModifyPartition>
                        <ModifyPartition wcm:action="add">
                            <Format>NTFS</Format>
                            <Label>Windows</Label>
                            <Order>3</Order>
                            <PartitionID>3</PartitionID>
                        </ModifyPartition>
                    </ModifyPartitions>
                    <DiskID>0</DiskID>
                    <WillWipeDisk>true</WillWipeDisk>
                </Disk>
            </DiskConfiguration>
            <ImageInstall>
                <OSImage>
                    <InstallFrom>
                        <MetaData wcm:action="add">
                            <Key>/IMAGE/NAME</Key>
                            <Value>Windows 10 ${vm_windows_image}</Value>
                        </MetaData>
                    </InstallFrom>
                    <InstallTo>
                        <DiskID>0</DiskID>
                        <PartitionID>3</PartitionID>
                    </InstallTo>
                    <WillShowUI>OnError</WillShowUI>
                    <InstallToAvailablePartition>false</InstallToAvailablePartition>
                </OSImage>
            </ImageInstall>
			<ComplianceCheck>
				<DisplayReport>OnError</DisplayReport>
			</ComplianceCheck>
			<UserData>
				<AcceptEula>true</AcceptEula>
				<ProductKey>
					<Key>NPPR9-FWDCX-D2C8J-H872K-2YT43</Key>
				</ProductKey>
			</UserData>
		</component>
		<component name="Microsoft-Windows-International-Core-WinPE" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<SetupUILanguage>
				<UILanguage>en-US</UILanguage>
			</SetupUILanguage>
			<InputLocale>${vm_guestos_keyboard}</InputLocale>
            <SystemLocale>${vm_guestos_systemlocale}</SystemLocale>
            <UILanguage>${vm_guestos_systemlocale}</UILanguage>
            <UserLocale>${vm_guestos_language}</UserLocale>
		</component>
	</settings>
	<settings pass="oobeSystem">
		<component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<AutoLogon>
				<Password>
					<Value>${admin_password}</Value>
					<PlainText>true</PlainText>
				</Password>
				<Enabled>true</Enabled>
				<LogonCount>1</LogonCount>
				<Username>Administrator</Username>
			</AutoLogon>
            <FirstLogonCommands>
                <SynchronousCommand wcm:action="add">
                    <Order>1</Order>
                    <Description>Set Execution Policy 64 Bit</Description>
                    <CommandLine>cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"</CommandLine>
                    <RequiresUserInput>true</RequiresUserInput>
                </SynchronousCommand>
                <SynchronousCommand wcm:action="add">
                    <Order>2</Order>
                    <Description>Set Execution Policy 32 Bit</Description>
                    <CommandLine>C:\Windows\SysWOW64\cmd.exe /c powershell -Command "Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force"</CommandLine>
                    <RequiresUserInput>true</RequiresUserInput>
                </SynchronousCommand>
                <SynchronousCommand wcm:action="add">
                    <CommandLine>cmd.exe /c e:\setup64 /s /v "/qb REBOOT=R"</CommandLine>
                    <Order>3</Order>
                    <Description>Install VMware Tools</Description>
                </SynchronousCommand>
                <SynchronousCommand wcm:action="add">
                    <CommandLine>powershell -ExecutionPolicy Bypass -File a:\initialise.ps1</CommandLine>
                    <Description>Basic configuration</Description>
                    <Order>99</Order>
                </SynchronousCommand>
            </FirstLogonCommands>
			<OOBE>
				<HideEULAPage>true</HideEULAPage>
				<HideLocalAccountScreen>true</HideLocalAccountScreen>
				<HideOEMRegistrationScreen>true</HideOEMRegistrationScreen>
				<HideOnlineAccountScreens>true</HideOnlineAccountScreens>
				<HideWirelessSetupInOOBE>true</HideWirelessSetupInOOBE>
				<SkipMachineOOBE>true</SkipMachineOOBE>
				<SkipUserOOBE>true</SkipUserOOBE>
			</OOBE>
			<UserAccounts>
				<AdministratorPassword>
					<Value>${admin_password}</Value> 
					<PlainText>true</PlainText> 
				</AdministratorPassword>
			</UserAccounts>
		</component>
	</settings>
	<settings pass="specialize">
		<component name="Microsoft-Windows-Shell-Setup" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
			<ComputerName>*</ComputerName>
			<RegisteredOwner>v12n</RegisteredOwner>
			<RegisteredOrganization>v12n</RegisteredOrganization>
		</component>
		<component name="Networking-MPSSVC-Svc" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <FirewallGroups>
                <FirewallGroup wcm:action="add" wcm:keyValue="WindowsRemoteManagement">
                    <Active>true</Active>
                    <Group>Windows Remote Management</Group>
                    <Profile>all</Profile>
                </FirewallGroup>
            </FirewallGroups>
        </component>
		<component name="Microsoft-Windows-ServerManager-SvrMgrNc" processorArchitecture="amd64" publicKeyToken="31bf3856ad364e35" language="neutral" versionScope="nonSxS" xmlns:wcm="http://schemas.microsoft.com/WMIConfig/2002/State" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
            <DoNotOpenServerManagerAtLogon>true</DoNotOpenServerManagerAtLogon>
        </component>
	</settings>
</unattend>
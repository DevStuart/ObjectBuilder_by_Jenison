#define MyAppName "ObjectBuilder"
#define MyAppVersion "0.5.5"
#define MyAppPublisher "ObjectBuilder Community"
#define MyAppURL "https://github.com/punkice3407/ObjectBuilder"
#define MyAppExeName "ObjectBuilder.exe"

[Setup]
AppId={{7F8B2C4E-6261-4B2D-A450-4F547285514E}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=dist
OutputBaseFilename=ObjectBuilder_Setup_v{#MyAppVersion}
SetupIconFile=assets\icon\app\app.ico
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
UninstallDisplayIcon={app}\{#MyAppExeName}
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog

VersionInfoVersion=0.5.5.0
VersionInfoCompany=ObjectBuilder Community
VersionInfoDescription=ObjectBuilder Installer
VersionInfoTextVersion=0.5.5
VersionInfoCopyright=Copyright (C) 2014-2026 ObjectBuilder
VersionInfoProductName=ObjectBuilder
VersionInfoProductVersion=0.5.5.0

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "bin\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

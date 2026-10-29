; Inno Setup script for Market-desk (built by scripts\package-windows.ps1, which passes
; AppVersion, SourceDir and OutputDir). Installs per user, so no administrator rights are
; needed; settings, layouts and caches live in %APPDATA%\Market-desk and are kept on uninstall.

#ifndef AppVersion
  #define AppVersion "0.0.0"
#endif
#ifndef SourceDir
  #define SourceDir "..\..\dist\market-desk"
#endif
#ifndef OutputDir
  #define OutputDir "..\..\dist"
#endif

[Setup]
AppId={{6F1C3A52-8E0B-4C51-9B7A-2D5E7C1F4A90}
AppName=Market-desk
AppVersion={#AppVersion}
AppPublisher=Market-desk
DefaultDirName={localappdata}\Programs\market-desk
DefaultGroupName=Market-desk
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible
OutputDir={#OutputDir}
OutputBaseFilename=market-desk-{#AppVersion}-setup-x64
SetupIconFile=..\..\app\assets\icon.ico
UninstallDisplayIcon={app}\market-desk.exe
Compression=lzma2
SolidCompression=yes
WizardStyle=modern

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{#SourceDir}\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs

[Icons]
Name: "{group}\Market-desk"; Filename: "{app}\market-desk.exe"
Name: "{userdesktop}\Market-desk"; Filename: "{app}\market-desk.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\market-desk.exe"; Description: "{cm:LaunchProgram,Market-desk}"; Flags: nowait postinstall skipifsilent

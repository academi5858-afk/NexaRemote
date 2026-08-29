[CmdletBinding()]
param(
    [switch]$SkipWindows,
    [switch]$SkipAndroid
)

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$dist = Join-Path $repo 'dist'
$toolRoot = Split-Path -Parent $repo
$env:ANDROID_SDK_ROOT = Join-Path $toolRoot 'android-sdk'
$env:ANDROID_NDK_HOME = Join-Path $env:ANDROID_SDK_ROOT 'ndk\27.2.12479018'
$env:JAVA_HOME = 'C:\Program Files\Android\Android Studio\jbr'
$env:Path = "$(Join-Path $toolRoot 'flutter-sdk\bin');C:\Users\chris\.cargo\bin;$env:Path"
New-Item -ItemType Directory -Force -Path $dist | Out-Null

Push-Location $repo
try {
    git submodule update --init --recursive

    if (-not $SkipWindows) {
        $developerMode = Get-ItemPropertyValue `
            -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' `
            -Name 'AllowDevelopmentWithoutDevLicense' -ErrorAction SilentlyContinue
        if ($developerMode -ne 1) {
            throw 'Windows Developer Mode must be enabled before building the Flutter host. Open Settings > System > For developers, enable Developer Mode, then rerun this script.'
        }
        cmd /c scripts\native-shell.cmd ..\vcpkg\downloads\tools\python\python-3.12.7-x64-1\python.exe build.py --portable --hwcodec --flutter --vram --skip-portable-pack
        $windowsOut = Join-Path $repo 'flutter\build\windows\x64\runner\Release'
        Copy-Item $windowsOut (Join-Path $dist 'NexaRemote-Windows-portable') -Recurse -Force
        $exe = Join-Path $dist 'NexaRemote-Windows-portable\rustdesk.exe'
        if (Test-Path $exe) {
            Rename-Item $exe 'Nexa Remote.exe' -Force
        }
    }

    if (-not $SkipAndroid) {
        throw 'The Android package must be built by the Nexa Remote release GitHub Actions workflow until the Rust native Android dependency set is cross-compiled. This prevents producing an APK that lacks the remote-desktop engine.'
    }

    Copy-Item 'LICENCE','THIRD_PARTY_NOTICES.md','NEXA_README.md' $dist -Force
    Get-ChildItem $dist -File -Recurse | Get-FileHash -Algorithm SHA256 |
        ForEach-Object { '{0}  {1}' -f $_.Hash, $_.Path.Substring($dist.Length + 1) } |
        Set-Content (Join-Path $dist 'SHA256SUMS.txt')
} finally {
    Pop-Location
}

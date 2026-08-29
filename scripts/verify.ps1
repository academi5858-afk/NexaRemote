[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$repo = Split-Path -Parent $PSScriptRoot
$toolRoot = Split-Path -Parent $repo
$env:ANDROID_SDK_ROOT = Join-Path $toolRoot 'android-sdk'
$env:JAVA_HOME = 'C:\Program Files\Android\Android Studio\jbr'
$env:Path = "$(Join-Path $toolRoot 'flutter-sdk\bin');C:\Users\chris\.cargo\bin;$env:Path"

Push-Location $repo
try {
    git diff --check
    cmd /c scripts\native-shell.cmd rustup run 1.75.0-x86_64-pc-windows-msvc cargo check --features flutter
    Push-Location flutter
    try {
        flutter pub get
        flutter analyze --no-fatal-infos
    } finally { Pop-Location }
} finally { Pop-Location }

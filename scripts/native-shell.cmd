@echo off
setlocal
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64
set "NEXA_TOOLS=%~dp0..\.."
for %%I in ("%NEXA_TOOLS%") do set "NEXA_TOOLS=%%~fI"
set "VCPKG_ROOT=%NEXA_TOOLS%\vcpkg"
set "VCPKG_DEFAULT_HOST_TRIPLET=x64-windows-static"
set "LIBCLANG_PATH=%VCPKG_ROOT%\downloads\tools\clang\clang-15.0.6\bin"
set "ANDROID_SDK_ROOT=%NEXA_TOOLS%\android-sdk"
set "ANDROID_NDK_HOME=%ANDROID_SDK_ROOT%\ndk\27.2.12479018"
set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
set "RUSTUP_TOOLCHAIN=1.75.0-x86_64-pc-windows-msvc"
set "PATH=%NEXA_TOOLS%\flutter-sdk\bin;C:\Users\chris\.cargo\bin;%JAVA_HOME%\bin;%PATH%"
%*

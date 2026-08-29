# Nexa Remote

Nexa Remote is a mobile-first remote-access client for computers you own or are
authorized to administer. The first supported pairing is an Android phone with
one Windows computer saved as **HOME-PC**.

## What is included

- Encrypted interactive desktop, mouse, touch and keyboard control
- Clipboard synchronization and remote audio
- Remote folder browsing, upload and download
- Unattended access using a locally stored permanent password
- Recent/favorite peer persistence, automatic reconnect and Windows service start
- Direct, relay and self-hosted rendezvous-server connectivity

The transport, capture, input and codec engine is derived from RustDesk 1.4.6.
Nexa Remote is distributed under GPL-3.0; see `LICENCE` and
`THIRD_PARTY_NOTICES.md`. It does not include a mechanism to evade firewalls,
endpoint controls, workplace policy, or administrator restrictions.

## Pair HOME-PC

1. Install Nexa Remote on Windows and choose **Install service**.
2. In Security settings, enable unattended access and set a strong permanent
   password. Keep the generated device ID private.
3. Install the Android APK. Enter the Windows device ID and connect once.
4. Authenticate with the permanent password, select **Remember password**, then
   favorite the peer and rename it **HOME-PC**.
5. Android will reconnect after ordinary network changes. If a managed network
   blocks the connection, use an approved network or an administrator-approved
   self-hosted relay; do not bypass the policy.

Release builds are created by `scripts/build-release.ps1`. Unsigned local builds
use development signing and are intended for personal sideloading only.


# Security model

- Nexa Remote is only for systems the operator owns or is authorized to access.
- Sessions use the inherited RustDesk end-to-end encrypted transport.
- Unattended access is opt-in and requires a user-created permanent password.
- The Windows service runs only after an explicit local installation/elevation.
- The product does not disable endpoint protection or alter organizational policy.
- Public rendezvous/relay defaults can be replaced with an approved self-hosted
  RustDesk OSS server through Network settings.
- Release signing keys are never committed. Local APKs fall back to Android's
  development signing key and Windows packages remain unsigned unless a code
  signing certificate is supplied by the owner.


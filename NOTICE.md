# NOTICE

This repository packages and redistributes upstream software published by
[The Nushell Project](https://github.com/nushell). The Apache-2.0 license in
[`LICENSE`](LICENSE) covers the OCX pipeline files authored here. It does
**not** cover any upstream-derived asset — each package's redistributed bytes
carry their own license, recorded below.

Each package's logo is reproduced for catalog identification only, under
nominative fair use. The marks remain the property of their respective owners
and no endorsement is implied.

| Package | GHCR path | Upstream SPDX |
|---|---|---|
| `nushell` | `ghcr.io/ocx-contrib/nushell/nushell` | `MIT` |

---

## `nushell`

Upstream: <https://github.com/nushell/nushell>
Published to `ghcr.io/ocx-contrib/nushell/nushell`.

| Component | SPDX | Holder |
|---|---|---|
| Nushell (`nu`, `nu_plugin_*`) | **MIT** | Copyright (c) 2019 - 2025 The Nushell Project Developers |
| `less` (`less.exe`, Windows bundles only) | **MIT** | Copyright (c) 2020 J Taylor |

Permissive; redistribution of the compiled binaries is granted provided the
copyright notice and permission notice are retained. Upstream ships its
`LICENSE` inside every release archive, so the notice travels with the bytes
in the published bundle — the Windows archives additionally ship
`LICENSE-for-less.txt` for the vendored pager. The terms are those of
<https://github.com/nushell/nushell/blob/main/LICENSE>. The published binaries
statically link third-party Rust crates under permissive licenses, enumerated
in upstream's `Cargo.lock`.

The Nushell name and logo are used for catalog identification under nominative
fair use.

No modifications are made to any upstream artifact in this repository; they are
republished byte-for-byte inside an OCX bundle.

# Stable smoke test — assert on the contract (exit code, version shape,
# computed result), never on help/version prose. Nushell reworks its
# banner freely; the version digits and arithmetic result are the contract.
NU = "nu.exe" if ocx.target_platform.os == ocx.os.Windows else "nu"

# Tier 1 + 2: liveness + version SHAPE (not a vendor string, not the exact version).
r_version = ocx.run(NU, "--version")
expect.ok(r_version)
expect.matches(r_version.stdout, r"\d+\.\d+\.\d+")

# Tier 3: functional behavior — evaluate an expression in the embedded
# pipeline and assert the computed result. This exercises the real
# interpreter path, a far stronger liveness proof than --version.
r_eval = ocx.run(NU, "-c", "1 + 1")
expect.ok(r_eval)
expect.contains(r_eval.stdout, "2")

# Tier 3b: the `version` builtin returns a structured record; project the
# `version` field and assert the semver SHAPE. Proves the structured-data
# pipeline (Nushell's defining feature) works end to end.
r_struct = ocx.run(NU, "-c", "version | get version")
expect.ok(r_struct)
expect.matches(r_struct.stdout, r"\d+\.\d+\.\d+")

# No non-PATH env var declared in metadata.json — Tier 4 omitted (PATH-only
# bundle; PATH itself is proven by Tier 1 liveness).

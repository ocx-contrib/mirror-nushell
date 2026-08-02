# Stable smoke test — assert on the contract (exit code, version shape,
# computed result), never on help/version prose. Nushell reworks its banner
# freely; the version digits and the computed results are the contract.
#
# Every invocation passes `-n` (`--no-config-file`): the runner's real HOME may
# carry a nushell config from some other install, and sourcing it would let an
# unrelated `$env.config` red this test. Measured on 0.114.1, `nu -n -c …`
# creates nothing under HOME/XDG_CONFIG_HOME — non-interactive mode writes no
# history and reads no config — so the flag is the whole hermeticity story and
# no env overlay is needed.
NU = "nu.exe" if ocx.target_platform.os == ocx.os.Windows else "nu"

# Tier 1 + 2: liveness + version SHAPE (not a vendor string, not the exact
# version — this mirror publishes every release, so the digits move).
r_version = ocx.run(NU, "-n", "--version")
expect.ok(r_version)
expect.matches(r_version.stdout, r"\d+\.\d+\.\d+")

# Tier 3: functional behavior — evaluate an expression in the real interpreter
# and assert the COMPUTED result. A stub that prints a version string cannot
# fake arithmetic.
r_eval = ocx.run(NU, "-n", "-c", "2 + 2")
expect.ok(r_eval)
expect.contains(r_eval.stdout, "4")

# Tier 3b: the structured-data pipeline — Nushell's defining feature and the
# reason this package exists. A list flows into a builtin that reduces it, so
# both the value type and the pipeline plumbing are exercised, not just the
# expression evaluator.
r_pipeline = ocx.run(NU, "-n", "-c", "[1 2 3] | math sum")
expect.ok(r_pipeline)
expect.contains(r_pipeline.stdout, "6")

# No non-PATH env var declared in metadata.json — Tier 4 omitted (PATH-only
# bundle; PATH itself is proven by Tier 1 liveness).

# QUICKSTART — text-to-cad-muse

[English](QUICKSTART.md) | [中文](QUICKSTART.zh-CN.md)

Get from zero to your first CAD part in ~5 minutes.

## 1. Install (one command)

```bash
./setup.sh
```

This installs [uv](https://docs.astral.sh/uv/) (if missing), pins
`cadgen==0.7.21` via `uvx`, **disables telemetry**, and runs
`cadgen doctor` to verify the Open CASCADE kernel loads.

Re-run safe: `./setup.sh check` only verifies, never reinstalls.

## 2. Build the example part

```bash
export PATH="$HOME/.local/bin:$PATH"
uvx --no-config --managed-python --python 3.13 \
  --from cadgen==0.7.21 python examples/plate.py
```

You get:

- `STEP/plate.step` — engineering file (SolidWorks-ready)
- `STL/plate.stl` — 3D-printing file

…plus a preview render for chat:

```bash
uvx --no-config --managed-python --python 3.13 \
  --from cadgen==0.7.21 cadgen snapshot STEP/plate.step preview/plate.png
```

## 3. Describe your own part

A model is a plain Python script: one `@step`-decorated function returning a
build123d shape. Copy `examples/plate.py`, change the numbers, run it.

```
"a 100x60x8 aluminum plate, four Ø6 through-holes at the corners"
  → agent writes the script → builds → sends you STEP + preview PNG
  → "make the holes bigger" → change two numbers → rebuild in ~1 second
```

Millimeters, XY plane, +Z up. Keep solids closed and positive-volume.
Read [SKILL.md](SKILL.md) for the full agent playbook (task table, modeling
rules, repair loop, Chinese-input handling).

## Troubleshooting

| Symptom | Fix |
|---|---|
| `uv: command not found` | `export PATH="$HOME/.local/bin:$PATH"` (setup.sh prints this) |
| `cadgen doctor` kernel FAIL | Re-run `./setup.sh`; needs network on first run (downloads the CAD runtime) |
| First run is slow | Normal — it downloads Python 3.13 + cadgen + OCC once, then caches |
| Snapshot looks wrong | Check the script's dimensions first; the preview renders the saved file, not the source |
| VM restarted and cadgen broke | Run `./setup.sh check`; if FAIL, re-run `./setup.sh` — everything lives under `~`, no files lost |

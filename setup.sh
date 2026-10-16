#!/usr/bin/env bash
# setup.sh — install text-to-cad-muse: uv + cadgen (pinned), telemetry off, verify
#
#   ./setup.sh          install uv (if missing) + cadgen, then verify
#   ./setup.sh check    verify an existing install (re-run safe)
#   ./setup.sh clean    prune uv's download cache (frees disk, keeps the pinned cadgen)
#
# Env overrides:
#   CADGEN_VERSION      e.g. 0.7.21        (default 0.7.21)
#   UV_BIN_DIR          where uv lives     (default $HOME/.local/bin)
#
set -euo pipefail

CADGEN_VERSION="${CADGEN_VERSION:-0.7.21}"
UV_BIN_DIR="${UV_BIN_DIR:-$HOME/.local/bin}"
export PATH="$UV_BIN_DIR:$PATH"

CADGEN="uvx --no-config --managed-python --python 3.13 --from cadgen==${CADGEN_VERSION} cadgen"
CADGEN_PY="uvx --no-config --managed-python --python 3.13 --from cadgen==${CADGEN_VERSION} python"

install_uv() {
  if command -v uv >/dev/null 2>&1; then
    echo "OK: uv $(uv --version)"
    return 0
  fi
  echo "Installing uv..."
  curl -LsSf https://astral.sh/uv/install.sh | sh
  export PATH="$UV_BIN_DIR:$PATH"
  echo "OK: uv $(uv --version)"
}

first_run_note() {
  echo "NOTE: first run downloads Python 3.13 + cadgen + the CAD runtime."
  echo "      It needs a network connection and takes a few minutes once."
}

do_install() {
  install_uv
  first_run_note
  echo "Disabling cadgen telemetry (your parts stay yours)..."
  # shellcheck disable=SC2086
  $CADGEN telemetry off
  do_check
}

do_check() {
  if ! command -v uv >/dev/null 2>&1; then
    echo "FAIL: uv not found. Run ./setup.sh (not check) first,"
    echo "      or: export PATH=\"$UV_BIN_DIR:\$PATH\""
    return 1
  fi
  echo "--- cadgen doctor ---"
  # shellcheck disable=SC2086
  $CADGEN doctor "$PWD"
}

do_clean() {
  export PATH="$UV_BIN_DIR:$PATH"
  if ! command -v uv >/dev/null 2>&1; then
    echo "uv not found, nothing to clean."
    return 0
  fi
  uv cache prune
}

case "${1:-install}" in
  check) do_check ;;
  clean) do_clean ;;
  install|"") do_install ;;
  *) echo "usage: $0 [install|check|clean]" >&2; exit 2 ;;
esac

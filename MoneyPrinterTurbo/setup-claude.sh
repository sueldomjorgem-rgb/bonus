#!/usr/bin/env bash
# Reinstala MoneyPrinterTurbo y lo deja configurado con el proveedor claude_code.
# Uso: ./setup-claude.sh   (desde esta carpeta)
set -euo pipefail
cd "$(dirname "$0")"
command -v uv >/dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh
uv sync --frozen
[ -f config.toml ] || cp config.example.toml config.toml
sed -i 's/^llm_provider = .*/llm_provider = "claude_code"/' config.toml
CLAUDE_BIN="$(command -v claude || true)"
[ -n "$CLAUDE_BIN" ] && sed -i "s|^claude_code_cli_path = .*|claude_code_cli_path = \"$CLAUDE_BIN\"|" config.toml
echo "Listo. Añade pexels_api_keys en config.toml y exporta CLAUDE_CODE_OAUTH_TOKEN si hace falta."
echo "Web UI: uv run streamlit run webui/Main.py   |   API: uv run python main.py"

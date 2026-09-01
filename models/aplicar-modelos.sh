#!/bin/bash
# Padroniza os modelos do lab no Ollama conforme a recomendacao dos autores.
# Reproduzivel: rode em qualquer maquina com Ollama instalado.
#   bash aplicar-modelos.sh
set -e
cd "$(dirname "$0")"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "[1/3] normalizando Modelfiles (LF) ..."
for f in Modelfile.dolphin3 Modelfile.dolphin3-tools Modelfile.rocinante; do
  tr -d '\r' < "$f" > "$TMP/$f"
done

echo "[2/3] garantindo bases + aplicando configs ..."
ollama pull dolphin3
ollama pull hf.co/bartowski/Rocinante-12B-v1.1-GGUF:IQ4_XS
ollama create dolphin3       -f "$TMP/Modelfile.dolphin3"
ollama create dolphin3-tools -f "$TMP/Modelfile.dolphin3-tools"
ollama create rocinante      -f "$TMP/Modelfile.rocinante"

echo "[3/3] parametros efetivos:"
for m in dolphin3 dolphin3-tools rocinante; do
  echo "===== $m ====="
  ollama show "$m" --parameters 2>/dev/null || ollama show "$m" 2>/dev/null | sed -n '/Parameters/,/License/p'
done
echo "OK - modelos padronizados."

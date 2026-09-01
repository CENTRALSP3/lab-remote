# Configuração padrão dos modelos (fonte da verdade)

Parâmetros aplicados a cada modelo instalado, **conforme a recomendação do autor**
quando ela existe, e defaults sensatos do modelo-base quando o autor não especifica.
Aplicados no **Ollama** (Modelfiles abaixo) e usados pelo **Open WebUI** (que herda os
parâmetros do Ollama; o modelo custom *Pentester Autonomo* espelha o `dolphin3-tools`).

## Como aplicar / reaplicar (padronização)
```bash
bash aplicar-modelos.sh
```
Isso baixa as bases (se preciso) e recria `dolphin3`, `dolphin3-tools` e `rocinante`
exatamente com os parâmetros abaixo. Idempotente e reproduzível em qualquer máquina.

## Tabela de parâmetros

| Modelo | Autor | Temp | top_p | top_k | min_p | rep_pen | DRY | num_ctx | Fonte do sampling |
|---|---|---|---|---|---|---|---|---|---|
| **dolphin3** | CognitiveComputations | 0.7 | 0.9 | 40 | 0.05 | 1.1 | — | 8192 | Autor não especifica → defaults do base Llama-3.1 |
| **dolphin3-tools** *(agente)* | (derivado do Dolphin 3.0) | 0.4 | 0.9 | 40 | 0.05 | 1.1 | — | 16384 | Base Dolphin + temp menor p/ tool-calling confiável |
| **rocinante** | TheDrummer | 0.7 | 0.95 | — | 0.02 | 1.05 | (Ollama sem DRY) | 8192 | Card do autor: *"Temp 0.7 … Use DRY"* |

Observações:
- **Rocinante:** o autor dá faixa **0.7 (equilibrado) → 1.2 (mais criativo)**. Fixado 0.7 como
  padrão; suba a temperatura no chat quando quiser mais ousadia. O autor recomenda o sampler
  **DRY**, mas esta build do Ollama não o suporta → usamos `repeat_penalty 1.05` como equivalente
  (o Modelfile documenta como ativar DRY se você usar um frontend/versão compatível).
- **dolphin3-tools / Pentester Autonomo:** temperatura 0.4 é proposital — modelos 8B em loop de
  ferramentas ficam mais confiáveis com temperatura baixa (menos alucinação de tool-call).
- Templates de chat: **ChatML** em todos; `dolphin3-tools` adiciona o bloco Hermes de `<tool_call>`.

## Arquivos
- `Modelfile.dolphin3` · `Modelfile.dolphin3-tools` · `Modelfile.rocinante`
- `aplicar-modelos.sh` — aplica tudo.

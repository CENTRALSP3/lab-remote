# Meu Lab — Acesso Remoto

Portal (GitHub Pages) que serve de **atalho de acesso direto** ao Open WebUI
hospedado na minha máquina base, a partir de qualquer computador.

- **Base:** meu PC roda o Open WebUI + Ollama + Kali (faz o trabalho pesado).
- **Acesso:** privado via **Tailscale** (tailnet-only) — o lab **não** é exposto na internet.
- **Página:** apenas um portal/launcher — **sem tokens, sem segredos**.

## Como usar
Abra a página do portal e clique em **Abrir Open WebUI**. Se o computador ainda
não estiver na tailnet, siga as instruções da própria página (instalar o Tailscale
ou usar o conector portátil em [`connector/`](connector/)).

## Conteúdo
- `index.html` — o portal.
- `connector/` — kit conector portátil (Tailscale userspace) + `LEIA-ME.txt`.

# Tales' dotfiles

Setup de terminal Linux: zsh + [zinit](https://github.com/zdharma-continuum/zinit) +
[starship](https://starship.rs) + [mise](https://mise.jdx.dev) para runtimes e ferramentas CLI.
Sem oh-my-zsh, sem nvm — trocados por alternativas mais rápidas em 2026.

## Instalação em uma máquina nova

```sh
git clone git@github.com:talesaraujo/dotfiles.git ~/Projects/dotfiles
cd ~/Projects/dotfiles
./install.sh
```

O `install.sh`:
1. Cria symlinks de `.zshenv`, `.zshrc`, `.aliases`, `.gitconfig`, `.tmux.conf`,
   `.config/starship.toml` e `.config/mise/config.toml` pra dentro de `$HOME`
   (fazendo backup de qualquer arquivo pré-existente em
   `~/.config/dotfiles-backup-<timestamp>/`).
2. Instala o [mise](https://mise.jdx.dev) (`curl -fsSL https://mise.run | sh`) se ainda não existir.
3. Roda `mise install`, que lê `.config/mise/config.toml` e instala node, starship,
   tmux e todo o resto — tudo em userspace, sem precisar de `sudo`/`dnf`/`apt`.

zinit se auto-instala na primeira vez que o `.zshrc` é carregado — não precisa de passo manual.

Depois, se zsh não for o shell padrão: `chsh -s $(which zsh)`.

## O que compõe o setup

| Camada | Ferramenta | Por quê |
|---|---|---|
| Plugin manager | [zinit](https://github.com/zdharma-continuum/zinit) | Único gerenciador (sem oh-my-zsh por baixo); plugins carregam em turbo mode (`wait lucid`), não bloqueiam o prompt |
| Prompt | [starship](https://starship.rs) | Rápido, configurável, independente de shell |
| Runtimes (node, etc.) | [mise](https://mise.jdx.dev) | Substitui nvm/pyenv/asdf; auto-switch por diretório via `.mise.toml`, sem lazy-load hack — é rápido por padrão |
| cd inteligente | [zoxide](https://github.com/ajeetdsouza/zoxide) | `z <termo>` pula pro diretório mais usado que bate com o termo |
| listagem | [eza](https://github.com/eza-community/eza) | `ls`/`ll`/`la`/`lt` com ícones e status git |
| syntax highlight de arquivo | [bat](https://github.com/sharkdp/bat) | `cat` com highlight, tema `ansi` (segue as cores do terminal) |
| busca em arquivos/histórico | [fzf](https://github.com/junegunn/fzf) | `ctrl-t` (arquivos), `**<tab>` (fuzzy completion em qualquer comando) |
| histórico de shell | [atuin](https://atuin.sh) | `ctrl-r` — histórico pesquisável com contexto de diretório/data, sobrescreve o `ctrl-r` padrão do fzf |
| env vars por projeto | [direnv](https://direnv.net) | carrega `.envrc` automaticamente ao entrar num diretório |
| grep/find rápidos | ripgrep (`rg`), fd (`fd`) | substitutos mais rápidos de `grep -r`/`find` |
| multiplexer | tmux | config mínima em `.tmux.conf` (mouse on, splits com `\|`/`-`) |

Todas as ferramentas da tabela (exceto zinit e starship, que se auto-instalam via
script) são geridas pelo **mise** — ver `.config/mise/config.toml`. Isso significa
que atualizar tudo de uma vez é `mise upgrade`, e não existe dependência de
pacote de distro (`dnf`/`apt`) pra nenhuma delas.

## Arquivos

```
.zshenv               # PATH — carregado por todo shell (interativo ou não)
.zshrc                # zinit, plugins, prompt, ferramentas modernas
.aliases               # aliases pessoais (navegação, git, scripts diversos)
.gitconfig             # aliases de git (st, lg, lgg, incoming/outgoing, ...)
.tmux.conf             # config mínima do tmux
.config/starship.toml  # tema do prompt
.config/mise/config.toml  # lista de ferramentas/versões geridas pelo mise
.scripts/              # scripts avulsos (proton, distro-uptime, ...)
vscode/settings.json   # settings pessoais do VS Code
install.sh             # bootstrap: symlinks + instalação das ferramentas
```

## Uso rápido

```sh
mise use node@20             # troca versão global de node
mise use node@20 --path .    # fixa versão só nesse projeto (cria .mise.toml)

z projeto                    # cd inteligente pro diretório mais usado que bate com "projeto"
zi                            # seletor interativo de diretórios recentes/frequentes

ls / ll / la / lt            # eza — lt lista em árvore

ctrl-r                        # atuin — busca fuzzy no histórico
ctrl-t                        # fzf — busca de arquivo com preview
comando **<tab>               # fzf — fuzzy completion de path em qualquer comando

echo 'export API_KEY=x' > .envrc && direnv allow   # variáveis de ambiente por diretório

gst / gaa / gco / gp / gl    # aliases de git (do plugin git do oh-my-zsh, carregado via zinit snippet)
```

## Histórico

Este repo já passou por várias eras — WSL2 + Windows Terminal, oh-my-zsh completo,
nvm com lazy-load quebrado. A versão atual (2026) roda nativamente em Linux
(Fedora), sem nada Windows-specific. O README anterior linkava pro
[dotfiles original do mathiasbynens](https://github.com/mathiasbynens/dotfiles),
que inspirou a estrutura inicial — pouco do conteúdo original sobrou.

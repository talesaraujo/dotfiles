# ~/.zshrc — zinit puro (sem oh-my-zsh). PATH/exports base ficam em ~/.zshenv.

#----------------------------- Histórico --------------------------------#
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

#----------------------------- Opções básicas ----------------------------#
setopt AUTO_CD
setopt EXTENDED_GLOB
setopt CORRECT

# Aliases pessoais (navegação, utilitários, scripts) — ver .aliases
source "$HOME/.aliases"

#----------------------------- Zinit bootstrap ---------------------------#
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

#----------------------------- Plugins (turbo mode) -----------------------#
# wait lucid = carrega em background, não bloqueia o prompt.
# atinit"zicompinit; zicdreplay" adia o compinit para o momento do turbo load.
zinit wait lucid for \
  atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
  blockf \
    zsh-users/zsh-completions

# Aliases de git do oh-my-zsh (gaa, gco, gst, ...), sem carregar o framework inteiro
# (carregado sync: é só um arquivo de aliases, custo desprezível)
zinit snippet OMZP::git

#----------------------------- Completion styling -------------------------#
zmodload zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-zZ-a}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#----------------------------- Extra settings ------------------------------#
# Desliga o reverse-search padrão do zsh nesses binds pra não conflitar com fzf
bindkey -r "^s"; bindkey -r "^t"

# Força no git less behaviour
unset LESS

#----------------------------- mise (node/runtimes) ------------------------#
eval "$(mise activate zsh)"

#----------------------------- Prompt --------------------------------------#
eval "$(starship init zsh)"

#----------------------------- Ferramentas modernas -------------------------#
eval "$(zoxide init zsh)"      # z / zi — cd inteligente por frequência
eval "$(fzf --zsh)"            # ctrl-r (histórico), ctrl-t (arquivos), **<tab>
eval "$(direnv hook zsh)"      # variáveis de ambiente por diretório (.envrc)
eval "$(atuin init zsh)"       # histórico pesquisável e sincronizável

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {} 2>/dev/null || eza --tree --color=always {} 2>/dev/null'"

export BAT_THEME="ansi"        # segue o esquema de cores do próprio terminal

alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias lt="eza --tree --icons"
alias cat="bat"
alias neofetch="fastfetch"

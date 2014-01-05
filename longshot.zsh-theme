if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="yellow"; fi

# return code with special char
# local return_code="%(?..%F{red}%? ↵%f)"
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$fg[green]%}%n@%m%{${reset_color}%}'
local current_dir='%{$terminfo[bold]$fg[green]%}%~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{${reset_color}%}'
local time="%{$fg[cyan]%}%D@%*%f%{${reset_color}%}"
local prompt="%{${fg[$CARETCOLOR]}%}»%{${reset_color}%}"

# local title='\[\e]0;%n@%m:\w\a\]'
# local user='%F{green}%n@%m:%B%~%b%f'
# local git_branch='%F{yellow}$(git_prompt_info)%f'
# local jobs='%(?.%F{magenta}jobs:%j,!:%!.%F{red}jobs:%j,!:%!,\$?:%?)%f'
# local time="%F{cyan}%D@%*%f"

PROMPT="
╭─${user_host}:${current_dir} ${git_branch}
╰─[${time}] %B%b ${prompt}  "
RPS1='$(vi_mode_prompt_info 2>/dev/null) ${return_code}'
# RPS1='${return_code}'

MODE_INDICATOR="%{$fg_bold[magenta]%}<%{$reset_color%}%{$fg[magenta]%}<<%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}○%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"

# PROMPT="
# [${user}] ${git_branch}
# [${jobs}]
# [${time}] %{${fg_bold[$CARETCOLOR]}%}»%{${reset_color}%}  "

# RPROMPT="${return_code}"
# 
# ${jobs}"

# ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
# ZSH_THEME_GIT_PROMPT_DIRTY=""
# ZSH_THEME_GIT_PROMPT_CLEAN=""
# ZSH_THEME_GIT_PROMPT_ADDED="%F{green} ✚"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%F{blue} ✹"
# ZSH_THEME_GIT_PROMPT_DELETED="%F{red} ✖"
# ZSH_THEME_GIT_PROMPT_RENAMED="%F{magenta} ➜"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%F{yellow} ═"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%F{cyan} ✭"

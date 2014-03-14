if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="yellow"; fi

function prompt_char {
	if [ $UID -eq 0 ]; then echo "${root_prompt}"; else echo "${prompt}"; fi
}

# return code with special char
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_host='%{$fg[cyan]%}%n%{${reset_color}@%{$fg[cyan]%}%m%{${reset_color}%}'
local current_dir='%{$fg[blue]%}%~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{${reset_color}%}'
local time="%{$fg[blue]%}%D@%*%f%{${reset_color}%}"
local root_prompt="%{${fg[red]}%}»%{${reset_color}%}"
local prompt="%{${fg[$CARETCOLOR]}%}»%{${reset_color}%}"

# OLD
# PROMPT="
# ╭─${user_host}:${current_dir} ${git_branch}
# ╰─[${time}] %B%b ${prompt}  "
RPS1='$(vi_mode_prompt_info 2>/dev/null) ${return_code}'
# RPS1='${return_code}'

MODE_INDICATOR="%{$fg_bold[magenta]%}<%{$reset_color%}%{$fg[magenta]%}<<%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}○%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"

PROMPT="%(?, ,${return_code}
)
${user_host}:${current_dir}:${git_branch}
%_$(prompt_char) "

RPROMPT='${time}'

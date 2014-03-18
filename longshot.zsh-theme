function prompt_char {
	if [ $UID -eq 0 ]; then echo "${root_prompt}"; else echo "${prompt}"; fi
}

# return code with special char
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local sep="%{$FG[007]%}:%{${reset_color}%}"
local user_host='%{$FG[046]%}%n%{${reset_color}%{$FG[007]%}@%{${reset_color}%}%{$FG[046]%}%m%{${reset_color}%}'
local current_dir='%{$FG[027]%}%~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{${reset_color}%}'
local time="%{$BG[021]%}%{$FG[003]%}%D@%*%f%{${reset_color}%}"
local root_prompt="%{${fg[red]}%}»%{${reset_color}%}"
local prompt="%{${fg[yellow]}%}»%{${reset_color}%}"
local smiley="%{$FG[007]%}[%{${reset_color}%}%(?,%{$FG[046]%}:%)%{$reset_color%},%{$FG[196]%}:(%{$reset_color%})%{$FG[007]%}]%{${reset_color}%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}branch:"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}○%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""

# main prompt/PS1
PROMPT="%(?, ,${return_code}
)
${user_host}${sep}${current_dir}${sep}${git_branch}
${smiley}%_$(prompt_char) "

# main prompt right
RPROMPT='${time}'

async_init

declare -Ag prompt_color_mappings=(
  "foreground" "default"
  "primary" "blue"
  "secondary" "green"
  "notice" "yellow"
  "accent" "default"

  "info_positive" "green"
  "info_negative" "red"
  "info_neutral_1" "yellow"
  "info_neutral_2" "blue"
  "info_special" "cyan"
)

declare -Ag prompt_colors=(
  "prompt" $prompt_color_mappings[foreground]
  "current_directory" $prompt_color_mappings[primary]
  "symbol" $prompt_color_mappings[secondary]
  "symbol_root" $prompt_color_mappings[notice]

  "right_prompt_prefix" $prompt_color_mappings[accent]
  "left_prompt_prefix" $prompt_color_mappings[accent]
  "virtual_env" $prompt_color_mappings[accent]

  "symbol_error" $prompt_color_mappings[info_negative]
  "error_code" $prompt_color_mappings[info_negative]

  "host_user_connector" $prompt_color_mappings[accent]
  "host" $prompt_color_mappings[info_neutral_1]
  "user" $prompt_color_mappings[info_neutral_1]

  "git_branch" $prompt_color_mappings[primary]
  "git_rebasing" $prompt_color_mappings[primary]
  "git_status_deleted" $prompt_color_mappings[info_negative]
  "git_status_staged" $prompt_color_mappings[info_positive]
  "git_status_stash" $prompt_color_mappings[info_neutral_1]
  "git_status_modified" $prompt_color_mappings[info_neutral_1]
  "git_status_new" $prompt_color_mappings[info_neutral_2]
  "git_status_diverged" $prompt_color_mappings[info_neutral_2]
  "git_status_ahead" $prompt_color_mappings[info_neutral_2]
  "git_status_behind" $prompt_color_mappings[info_neutral_2]
  "git_status_renamed" $prompt_color_mappings[info_special]
  "git_status_unmerged" $prompt_color_mappings[info_special]
)

prompt_git_home() {
  local prompt_current_directory="$1"
  local prompt_git_toplevel="$2"
  local prompt_git_home=""
  if [ "$prompt_git_toplevel" != "" -a "$prompt_git_toplevel" != "$prompt_current_directory" ]; then
    local prompt_repo_name=`basename $prompt_git_toplevel`
    prompt_git_home="$prompt_repo_name"
  fi;
  if [ "$prompt_git_home" != "" ]; then
    # check how many directories are beprompteen
    local prompt_current_nesting="${prompt_current_directory//[^\/]}"
    local prompt_repo_nesting="${prompt_git_toplevel//[^\/]}"
    local prompt_diff=`expr ${#prompt_current_nesting} - ${#prompt_repo_nesting}`
    if [ $prompt_diff -eq 1 ]; then
      echo "$prompt_git_home/"
    else
      echo "$prompt_git_home/.../"
    fi;
  else
    echo ""
  fi;
}

prompt_git_branch() {
  echo "$(command git symbolic-ref --short -q HEAD)"
}

prompt_git_status() {
  local prompt_git_status_response=$(command git status --porcelain -b 2> /dev/null)

  local prompt_git_status_display=""

  # rebasing
  if $(command grep "^## HEAD (no branch)" <<< "$prompt_git_status_response" &> /dev/null); then
    prompt_git_status_display="%F{$prompt_colors[git_rebasing]}rebasing"
  else
    # staged changes
    if $(command grep "^A. " <<< "$prompt_git_status_response" &> /dev/null) ||
      $(command grep "^M. " <<< "$prompt_git_status_response" &> /dev/null) ||
      $(command grep "^D. " <<< "$prompt_git_status_response" &> /dev/null); then
          prompt_git_status_display+=" %F{$prompt_colors[git_status_staged]}󰐕"
    fi

    # new file
    if $(command grep "?? " <<< "$prompt_git_status_response" &> /dev/null); then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_new]}󰙴"
    fi

    # modified
    if $(command grep "^.M " <<< "$prompt_git_status_response" &> /dev/null); then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_modified]}󰎂"
    fi

    # renamed
    if $(command grep "^R. " <<< "$prompt_git_status_response" &> /dev/null); then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_renamed]}󱦰"
    fi

    # deleted
    if $(command grep "^.D " <<< "$prompt_git_status_response" &> /dev/null); then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_deleted]}󰅖"
    fi

    # unmerged
    if $(command grep "^UU " <<< "$prompt_git_status_response" &> /dev/null); then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_unmerged]}󰘭"
    fi

    local prompt_is_ahead=false
    if $(command grep "^## .*ahead" <<< "$prompt_git_status_response" &> /dev/null); then
      prompt_is_ahead=true
    fi

    local prompt_is_behind=false
    if $(command grep "^## .*behind" <<< "$prompt_git_status_response" &> /dev/null); then
      prompt_is_behind=true
    fi

    if [[ "$prompt_is_ahead" == true && "$prompt_is_behind" == true ]]; then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_diverged]}󱦲󱦳"
    elif [[ "$prompt_is_ahead" == true ]]; then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_ahead]}󱦲"
    elif [[ "$prompt_is_behind" == true ]]; then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_behind]}󱦳"
    fi

    # stashed
    local prompt_stash_count=`git stash list | wc -l`
    if [[ $prompt_stash_count -gt 0 ]]; then
      prompt_git_status_display+=" %F{$prompt_colors[git_status_stash]}$"
    fi
  fi

  echo "$prompt_git_status_display"
}

BREAK_LINE="
"

local prompt_prompt_symbol="󰁔 "

local prompt_base_symbol_color="%F{$prompt_colors[symbol]}"
if [[ $(id -u) -eq 0 ]]; then
  prompt_base_symbol_color="%F{$prompt_colors[symbol_root]}"
fi

local prompt_prompt_color="%(?,$prompt_base_symbol_color,%F{$prompt_colors[symbol_error]})"
local prompt_return_code="%(?,,%F{$prompt_colors[error_code]}%? )"

prompt_user_host="%F{$prompt_colors[host]}%n%F{$prompt_colors[host_user_connector]}@%F{$prompt_colors[user]}%m"
prompt_prompt="$prompt_prompt_color$prompt_prompt_symbol %F{$prompt_colors[prompt]}"

prompt_current_directory_color="$prompt_colors[current_directory]"
prompt_git_branch_color="$prompt_colors[git_branch]"

prompt_get_virtual_env() {
  if [[ -z $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    local prompt_virtual_env=""
    if [[ ! -z $VIRTUAL_ENV ]]; then
      prompt_virtual_env="($(basename $VIRTUAL_ENV)) "
    elif [[ ! -z $CONDA_PROMPT_MODIFIER ]]; then
      prompt_virtual_env="$(basename $CONDA_PROMPT_MODIFIER)"
    fi;

    if [[ $prompt_virtual_env != "" ]]; then
      echo "%F{$prompt_colors[virtual_env]}$prompt_virtual_env"
    fi;
  fi;
}

prompt_get_displayed_wd() {
  local prompt_git_branch=$prompt_prompt_data[prompt_git_branch]
  local prompt_git_home=$prompt_prompt_data[prompt_git_home]

  local prompt_home_relative_wd="%~"
  local prompt_git_relative_wd="$prompt_git_home%c"

  local prompt_displayed_wd="$prompt_git_relative_wd"

  echo "%F{$prompt_current_directory_color}$prompt_displayed_wd"
}

prompt_get_left_prompt_prefix() {
  local prompt_left_prompt_prefix=""

  prompt_left_prompt_prefix="%F{$prompt_colors[left_prompt_prefix]}"

  echo $prompt_left_prompt_prefix
}

prompt_get_right_prompt_prefix() {
  local prompt_right_prompt_prefix=""

  prompt_right_prompt_prefix="%F{$prompt_colors[right_prompt_prefix]}"

  echo $prompt_right_prompt_prefix
}

prompt_redraw() {
  local prompt_displayed_wd="$(prompt_get_displayed_wd)  "

  local prompt_full_prompt="$(prompt_get_virtual_env)$(prompt_get_left_prompt_prefix)$prompt_prompt"

  local prompt_git_info="$prompt_prompt_data[prompt_git_branch]$prompt_prompt_data[prompt_git_status]"

  local prompt_git_arrow_info=""
  if [ "$prompt_git_info" != "" ]; then
    prompt_git_arrow_info=" %F{$prompt_git_branch_color}$prompt_git_info"
  fi;

  local prompt_right_prompt_prefix="$(prompt_get_right_prompt_prefix)"

  PROMPT="$prompt_full_prompt$prompt_displayed_wd"
  RPROMPT="$prompt_right_prompt_prefix$prompt_return_code$prompt_git_arrow_info"

  zle -R && zle reset-prompt
}

prompt_async_init_worker() {
  async_start_worker prompt_worker -n
  async_register_callback prompt_worker prompt_prompt_callback
}

prompt_prompt_callback() {
  local prompt_name=$1 prompt_code=$2 prompt_output=$3
  if (( prompt_code == 2 )) || (( prompt_code == 3 )) || (( prompt_code == 130 )); then
    # reinit async workers
    async_stop_worker prompt_worker
    prompt_async_init_worker
    prompt_async_init_tasks
  elif (( prompt_code )); then
    prompt_async_init_tasks
  fi;
  prompt_prompt_data[$prompt_name]=$prompt_output
  prompt_redraw
}

prompt_async_init_tasks() {
  typeset -Ag prompt_prompt_data

  local prompt_current_pwd="$PWD"
  async_worker_eval prompt_worker builtin cd -q $prompt_current_pwd

  local prompt_git_toplevel="$(git rev-parse --show-toplevel 2>/dev/null)"

  if [[ "$prompt_current_pwd" != $prompt_prompt_data[prompt_current_pwd] ]]; then
    async_flush_jobs prompt_worker
    prompt_prompt_data[prompt_git_home]=
  fi;

  if [[ "$prompt_git_toplevel" != $prompt_prompt_data[prompt_git_toplevel] ]]; then
    async_flush_jobs prompt_worker
    prompt_prompt_data[prompt_git_branch]=
    prompt_prompt_data[prompt_git_status]=
  fi;

  prompt_prompt_data[prompt_git_toplevel]="$prompt_git_toplevel"
  prompt_prompt_data[prompt_current_pwd]="$prompt_current_pwd"
  async_job prompt_worker prompt_git_branch
  async_job prompt_worker prompt_git_status

  prompt_redraw
}

# prompt cursor fix when exiting vim
prompt_fix_cursor() {
  local prompt_cursor="\e[3 q"
  echo -ne "$prompt_cursor"
}

prompt_setup() {
  prompt_async_init_worker
  prompt_async_init_tasks

  zmodload zsh/zle
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd prompt_fix_cursor
  add-zsh-hook precmd prompt_async_init_tasks

  PROMPT="$prompt_prompt"
}
prompt_setup

zle_highlight=( default:fg=$prompt_colors[prompt] )

# === Powerlevel10k Configuration by iWas <3 === #

# Temporary Options
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

# === Main === #
() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
  
  # ZSH Version Check
  autoload -Uz is-at-least && is-at-least 5.1 || return

  # === Left Prompt Elements === #
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    # OS Identifier
    os_icon
    # Current Path / Directory
    dir
    # Git Status
    vcs
    # Terraform context
    terraform
    # Command Duration
    command_execution_time
    # Context
    context
  )

  # === Right Prompt Elements === #
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

  # Character Set
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_ICON_PADDING=none
  typeset -g POWERLEVEL9K_ICON_BEFORE_CONTENT=
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # Left Prompt Connections
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX='%240F╭─'
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_PREFIX='%240F├─'
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX='%240F╰─'
  # Right Prompt Connections
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_SUFFIX='%240F─╮'
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_SUFFIX='%240F─┤'
  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_SUFFIX='%240F─╯'

  # Left-Right Prompt Filler
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR=' '
  typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_BACKGROUND=
  typeset -g POWERLEVEL9K_MULTILINE_NEWLINE_PROMPT_GAP_BACKGROUND=
  if [[ $POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_CHAR != ' ' ]]; then
    # Filler Color
    typeset -g POWERLEVEL9K_MULTILINE_FIRST_PROMPT_GAP_FOREGROUND=240
    # Start Filler
    typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_FIRST_SEGMENT_END_SYMBOL='%{%}'
    # End Filler
    typeset -g POWERLEVEL9K_EMPTY_LINE_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='%{%}'
  fi
  # Background Color
  typeset -g POWERLEVEL9K_BACKGROUND=236
  # Left Same-color Separator
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%244F\uE0B1'
  # Right Same-color Separator
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%244F\uE0B3'
  # Left Different-color Separator
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B0'
  # Right Different-color Separator
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B2'
  # Left Prompt > Left End
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0BA'
  # Left Prompt > Right End
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B0'
  # Left Prompt > Terminator
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  # Right Prompt > Left End
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B2'
  # Right Prompt > Right End
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0BC'

  # === os_icon (OS Identifier) === #
  typeset -g POWERLEVEL9K_OS_ICON_FOREGROUND=255

  # === prompt_char (Prompt Symbol) === #
  typeset -g POWERLEVEL9K_PROMPT_CHAR_BACKGROUND=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=76
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=196
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIOWR_CONTENT_EXPANSION='▶'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_{LEFT,RIGHT}_WHITESPACE=

  # === dir (Current Path / Directory) === #
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=31
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=103
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=39
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  local anchor_files=(
    .bzr
    .citc
    .git
    .hg
    .node-version
    .python-version
    .go-version
    .ruby-version
    .lua-version
    .java-version
    .perl-version
    .php-version
    .tool-version
    .shorten_folder_marker
    .svn
    .terraform
    CVS
    Cargo.toml
    composer.json
    go.mod
    package.json
    stack.yaml
  )
  typeset -g POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
  typeset -g POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=80
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3

  # === vcs (Git Status) === #
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
  function my_git_formatter() {
    emulate -L zsh
    if [[ -n $P9K_CONTENT ]]; then
      typeset -g my_git_format=$P9K_CONTENT
      return
    fi
    if (( $1 )); then
      local       meta='%246F'  # grey foreground
      local      clean='%76F'   # green foreground
      local   modified='%178F'  # yellow foreground
      local  untracked='%39F'   # blue foreground
      local conflicted='%196F'  # red foreground
    else
      local       meta='%244F'  # grey foreground
      local      clean='%244F'  # grey foreground
      local   modified='%244F'  # grey foreground
      local  untracked='%244F'  # grey foreground
      local conflicted='%244F'  # grey foreground
    fi
    local res
    if [[ -n $VCS_STATUS_LOCAL_BRANCH ]]; then
      local branch=${(V)VCS_STATUS_LOCAL_BRANCH}
      (( $#branch > 32 )) && branch[13,-13]="…"
      res+="${clean}${(g::)POWERLEVEL9K_VCS_BRANCH_ICON}${branch//\%/%%}"
    fi
    if [[ -n $VCS_STATUS_TAG
          && -z $VCS_STATUS_LOCAL_BRANCH
        ]]; then
      local tag=${(V)VCS_STATUS_TAG}
      (( $#tag > 32 )) && tag[13,-13]="…"
      res+="${meta}#${clean}${tag//\%/%%}"
    fi
    [[ -z $VCS_STATUS_LOCAL_BRANCH && -z $VCS_STATUS_TAG ]] &&
      res+="${meta}@${clean}${VCS_STATUS_COMMIT[1,8]}"
    if [[ -n ${VCS_STATUS_REMOTE_BRANCH:#$VCS_STATUS_LOCAL_BRANCH} ]]; then
      res+="${meta}:${clean}${(V)VCS_STATUS_REMOTE_BRANCH//\%/%%}"
    fi
    if [[ $VCS_STATUS_COMMIT_SUMMARY == (|*[^[:alnum:]])(wip|WIP)(|[^[:alnum:]]*) ]]; then
      res+=" ${modified}wip"
    fi
    (( VCS_STATUS_COMMITS_BEHIND )) && res+=" ${clean}⇣${VCS_STATUS_COMMITS_BEHIND}"
    (( VCS_STATUS_COMMITS_AHEAD && !VCS_STATUS_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_COMMITS_AHEAD  )) && res+="${clean}⇡${VCS_STATUS_COMMITS_AHEAD}"
    (( VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" ${clean}⇠${VCS_STATUS_PUSH_COMMITS_BEHIND}"
    (( VCS_STATUS_PUSH_COMMITS_AHEAD && !VCS_STATUS_PUSH_COMMITS_BEHIND )) && res+=" "
    (( VCS_STATUS_PUSH_COMMITS_AHEAD  )) && res+="${clean}⇢${VCS_STATUS_PUSH_COMMITS_AHEAD}"
    (( VCS_STATUS_STASHES        )) && res+=" ${clean}*${VCS_STATUS_STASHES}"
    [[ -n $VCS_STATUS_ACTION     ]] && res+=" ${conflicted}${VCS_STATUS_ACTION}"
    (( VCS_STATUS_NUM_CONFLICTED )) && res+=" ${conflicted}~${VCS_STATUS_NUM_CONFLICTED}"
    (( VCS_STATUS_NUM_STAGED     )) && res+=" ${modified}+${VCS_STATUS_NUM_STAGED}"
    (( VCS_STATUS_NUM_UNSTAGED   )) && res+=" ${modified}!${VCS_STATUS_NUM_UNSTAGED}"
    (( VCS_STATUS_NUM_UNTRACKED  )) && res+=" ${untracked}${(g::)POWERLEVEL9K_VCS_UNTRACKED_ICON}${VCS_STATUS_NUM_UNTRACKED}"
    (( VCS_STATUS_HAS_UNSTAGED == -1 )) && res+=" ${modified}─"
    typeset -g my_git_format=$res
  }
  functions -M my_git_formatter 2>/dev/null
  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=-1
  typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'
  typeset -g POWERLEVEL9K_VCS_DISABLE_GITSTATUS_FORMATTING=true
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${$((my_git_formatter(1)))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_LOADING_CONTENT_EXPANSION='${$((my_git_formatter(0)))+${my_git_format}}'
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED,CONFLICTED,COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=-1
  typeset -g POWERLEVEL9K_VCS_VISUAL_IDENTIFIER_COLOR=76
  typeset -g POWERLEVEL9K_VCS_LOADING_VISUAL_IDENTIFIER_COLOR=244
  typeset -g POWERLEVEL9K_VCS_PREFIX='%246Fon '
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=76
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=76
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=178

  # === status (Exit Code) === #
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=true
  typeset -g POWERLEVEL9K_STATUS_OK_FOREGROUND=70
  typeset -g POWERLEVEL9K_STATUS_OK_VISUAL_IDENTIFIER_EXPANSION='✔'
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=70
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✔'
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=160
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=160
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_FOREGROUND=160
  typeset -g POWERLEVEL9K_STATUS_ERROR_PIPE_VISUAL_IDENTIFIER_EXPANSION='✘'

  # === command_execution_time (Command Duration) === #
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=248
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PREFIX='%246Ftook '

  # === background_jobs (Background Jobs) === #
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=false
  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=37

  # === direnv (Direnv Status) === #
  typeset -g POWERLEVEL9K_DIRENV_FOREGROUND=178

  # === asdf (Asdf Version Manager === #
  typeset -g POWERLEVEL9K_ASDF_FOREGROUND=66
  typeset -g POWERLEVEL9K_ASDF_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_ASDF_SHOW_SYSTEM=true
  typeset -g POWERLEVEL9K_ASDF_SHOW_ON_UPGLOB=
  typeset -g POWERLEVEL9K_ASDF_RUBY_FOREGROUND=168
  typeset -g POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=37
  typeset -g POWERLEVEL9K_ASDF_GOLANG_FOREGROUND=37
  typeset -g POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=70
  typeset -g POWERLEVEL9K_ASDF_RUST_FOREGROUND=37
  typeset -g POWERLEVEL9K_ASDF_DOTNET_CORE_FOREGROUND=134
  typeset -g POWERLEVEL9K_ASDF_FLUTTER_FOREGROUND=38
  typeset -g POWERLEVEL9K_ASDF_LUA_FOREGROUND=32
  typeset -g POWERLEVEL9K_ASDF_JAVA_FOREGROUND=32
  typeset -g POWERLEVEL9K_ASDF_PERL_FOREGROUND=67
  typeset -g POWERLEVEL9K_ASDF_ERLANG_FOREGROUND=125
  typeset -g POWERLEVEL9K_ASDF_ELIXIR_FOREGROUND=129
  typeset -g POWERLEVEL9K_ASDF_POSTGRES_FOREGROUND=31
  typeset -g POWERLEVEL9K_ASDF_PHP_FOREGROUND=99
  typeset -g POWERLEVEL9K_ASDF_HASKELL_FOREGROUND=172
  typeset -g POWERLEVEL9K_ASDF_JULIA_FOREGROUND=70

  # === nordvpn (Nordvpn Connection Status [Linux Only]) === #
  typeset -g POWERLEVEL9K_NORDVPN_FOREGROUND=39
  typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_CONTENT_EXPANSION=
  typeset -g POWERLEVEL9K_NORDVPN_{DISCONNECTED,CONNECTING,DISCONNECTING}_VISUAL_IDENTIFIER_EXPANSION=

  # === ranger (Ranger Shell) === #
  typeset -g POWERLEVEL9K_RANGER_FOREGROUND=178

  # === nnn (Nnn Shell) === #
  typeset -g POWERLEVEL9K_NNN_FOREGROUND=72

  # === xplr (Xplr Shell) === #
  typeset -g POWERLEVEL9K_XPLR_FOREGROUND=72

  # === vim_shell (Vim Shell Indicator) === #
  typeset -g POWERLEVEL9K_VIM_SHELL_FOREGROUND=34

  # === midnight_commander (Midnight Commander Shell) === #
  typeset -g POWERLEVEL9K_MIDNIGHT_COMMANDER_FOREGROUND=178

  # === nix_shell: nix shell) === #
  typeset -g POWERLEVEL9K_NIX_SHELL_FOREGROUND=74

  # === disk_usage (Disk Usage) === #
  typeset -g POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND=35
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND=220
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND=160
  typeset -g POWERLEVEL9K_DISK_USAGE_WARNING_LEVEL=90
  typeset -g POWERLEVEL9K_DISK_USAGE_CRITICAL_LEVEL=95
  typeset -g POWERLEVEL9K_DISK_USAGE_ONLY_WARNING=false

  # === vi_mode (Vi Mode) === #
  typeset -g POWERLEVEL9K_VI_COMMAND_MODE_STRING=NORMAL
  typeset -g POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND=106
  typeset -g POWERLEVEL9K_VI_VISUAL_MODE_STRING=VISUAL
  typeset -g POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND=68
  typeset -g POWERLEVEL9K_VI_OVERWRITE_MODE_STRING=OVERTYPE
  typeset -g POWERLEVEL9K_VI_MODE_OVERWRITE_FOREGROUND=172
  typeset -g POWERLEVEL9K_VI_INSERT_MODE_STRING=
  typeset -g POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND=66

  # === ram (Free RAM) === #
  typeset -g POWERLEVEL9K_RAM_FOREGROUND=66

  # === swap (Used Swap) === #
  typeset -g POWERLEVEL9K_SWAP_FOREGROUND=96

  # === load (CPU Load) === #
  typeset -g POWERLEVEL9K_LOAD_WHICH=5
  typeset -g POWERLEVEL9K_LOAD_NORMAL_FOREGROUND=66
  typeset -g POWERLEVEL9K_LOAD_WARNING_FOREGROUND=178
  typeset -g POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND=166

  # === todo (TODO Items) === #
  typeset -g POWERLEVEL9K_TODO_FOREGROUND=110
  typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_TOTAL=true
  typeset -g POWERLEVEL9K_TODO_HIDE_ZERO_FILTERED=false

  # === timewarrior (Timewarrior Tracking Status) === #
  typeset -g POWERLEVEL9K_TIMEWARRIOR_FOREGROUND=110
  typeset -g POWERLEVEL9K_TIMEWARRIOR_CONTENT_EXPANSION='${P9K_CONTENT:0:24}${${P9K_CONTENT:24}:+…}'

  # === taskwarrior (Taskwarrior Task Count) === #
  typeset -g POWERLEVEL9K_TASKWARRIOR_FOREGROUND=74

  # === context (user@hostname) === #
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=178
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=180
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=180
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE=''
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION=

  # === virtualenv (Python Virtual Environment) === #
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=37
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=false
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false
  typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

  # === anaconda (Conda Environment) === #
  typeset -g POWERLEVEL9K_ANACONDA_FOREGROUND=37
  typeset -g POWERLEVEL9K_ANACONDA_CONTENT_EXPANSION='${${${${CONDA_PROMPT_MODIFIER#\(}% }%\)}:-${CONDA_PREFIX:t}}'

  # === pyenv (Python Environment) === #
  typeset -g POWERLEVEL9K_PYENV_FOREGROUND=37
  typeset -g POWERLEVEL9K_PYENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_PYENV_SHOW_SYSTEM=true
  typeset -g POWERLEVEL9K_PYENV_CONTENT_EXPANSION='${P9K_CONTENT}${${P9K_CONTENT:#$P9K_PYENV_PYTHON_VERSION(|/*)}:+ $P9K_PYENV_PYTHON_VERSION}'

  # === goenv (Go Environment) === #
  typeset -g POWERLEVEL9K_GOENV_FOREGROUND=37
  typeset -g POWERLEVEL9K_GOENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_GOENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_GOENV_SHOW_SYSTEM=true

  # === nodenv (Node.js Version from Nodenv) === #
  typeset -g POWERLEVEL9K_NODENV_FOREGROUND=70
  typeset -g POWERLEVEL9K_NODENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_NODENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_NODENV_SHOW_SYSTEM=true

  ##############[ nvm: node.js version from nvm (https://github.com/nvm-sh/nvm) ]###############
  typeset -g POWERLEVEL9K_NVM_FOREGROUND=70

  ############[ nodeenv: node.js environment (https://github.com/ekalinin/nodeenv) ]############
  typeset -g POWERLEVEL9K_NODEENV_FOREGROUND=70
  typeset -g POWERLEVEL9K_NODEENV_SHOW_NODE_VERSION=false
  typeset -g POWERLEVEL9K_NODEENV_{LEFT,RIGHT}_DELIMITER=

  ##############################[ node_version: node.js version ]###############################
  typeset -g POWERLEVEL9K_NODE_VERSION_FOREGROUND=70
  typeset -g POWERLEVEL9K_NODE_VERSION_PROJECT_ONLY=true

  #######################[ go_version: go version (https://golang.org) ]########################
  typeset -g POWERLEVEL9K_GO_VERSION_FOREGROUND=37
  typeset -g POWERLEVEL9K_GO_VERSION_PROJECT_ONLY=true

  #################[ rust_version: rustc version (https://www.rust-lang.org) ]##################
  typeset -g POWERLEVEL9K_RUST_VERSION_FOREGROUND=37
  typeset -g POWERLEVEL9K_RUST_VERSION_PROJECT_ONLY=true

  ###############[ dotnet_version: .NET version (https://dotnet.microsoft.com) ]################
  typeset -g POWERLEVEL9K_DOTNET_VERSION_FOREGROUND=134
  typeset -g POWERLEVEL9K_DOTNET_VERSION_PROJECT_ONLY=true

  #####################[ php_version: php version (https://www.php.net/) ]######################
  typeset -g POWERLEVEL9K_PHP_VERSION_FOREGROUND=99
  typeset -g POWERLEVEL9K_PHP_VERSION_PROJECT_ONLY=true

  ##########[ laravel_version: laravel php framework version (https://laravel.com/) ]###########
  typeset -g POWERLEVEL9K_LARAVEL_VERSION_FOREGROUND=161

  ####################[ java_version: java version (https://www.java.com/) ]####################
  typeset -g POWERLEVEL9K_JAVA_VERSION_FOREGROUND=32
  typeset -g POWERLEVEL9K_JAVA_VERSION_PROJECT_ONLY=true
  typeset -g POWERLEVEL9K_JAVA_VERSION_FULL=false

  ###[ package: name@version from package.json (https://docs.npmjs.com/files/package.json) ]####
  typeset -g POWERLEVEL9K_PACKAGE_FOREGROUND=117

  #############[ rbenv: ruby version from rbenv (https://github.com/rbenv/rbenv) ]##############
  typeset -g POWERLEVEL9K_RBENV_FOREGROUND=168
  typeset -g POWERLEVEL9K_RBENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_RBENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_RBENV_SHOW_SYSTEM=true

  #######################[ rvm: ruby version from rvm (https://rvm.io) ]########################
  typeset -g POWERLEVEL9K_RVM_FOREGROUND=168
  typeset -g POWERLEVEL9K_RVM_SHOW_GEMSET=false
  typeset -g POWERLEVEL9K_RVM_SHOW_PREFIX=false

  ###########[ fvm: flutter version management (https://github.com/leoafarias/fvm) ]############
  typeset -g POWERLEVEL9K_FVM_FOREGROUND=38

  ##########[ luaenv: lua version from luaenv (https://github.com/cehoffman/luaenv) ]###########
  typeset -g POWERLEVEL9K_LUAENV_FOREGROUND=32
  typeset -g POWERLEVEL9K_LUAENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_LUAENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_LUAENV_SHOW_SYSTEM=true

  ###############[ jenv: java version from jenv (https://github.com/jenv/jenv) ]################
  typeset -g POWERLEVEL9K_JENV_FOREGROUND=32
  typeset -g POWERLEVEL9K_JENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_JENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_JENV_SHOW_SYSTEM=true

  ###########[ plenv: perl version from plenv (https://github.com/tokuhirom/plenv) ]############
  typeset -g POWERLEVEL9K_PLENV_FOREGROUND=67
  typeset -g POWERLEVEL9K_PLENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_PLENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_PLENV_SHOW_SYSTEM=true

  ###########[ perlbrew: perl version from perlbrew (https://github.com/gugod/App-perlbrew) ]############
  typeset -g POWERLEVEL9K_PERLBREW_FOREGROUND=67
  typeset -g POWERLEVEL9K_PERLBREW_PROJECT_ONLY=true
  typeset -g POWERLEVEL9K_PERLBREW_SHOW_PREFIX=false

  ############[ phpenv: php version from phpenv (https://github.com/phpenv/phpenv) ]############
  typeset -g POWERLEVEL9K_PHPENV_FOREGROUND=99
  typeset -g POWERLEVEL9K_PHPENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_PHPENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_PHPENV_SHOW_SYSTEM=true

  #######[ scalaenv: scala version from scalaenv (https://github.com/scalaenv/scalaenv) ]#######
  typeset -g POWERLEVEL9K_SCALAENV_FOREGROUND=160
  typeset -g POWERLEVEL9K_SCALAENV_SOURCES=(shell local global)
  typeset -g POWERLEVEL9K_SCALAENV_PROMPT_ALWAYS_SHOW=false
  typeset -g POWERLEVEL9K_SCALAENV_SHOW_SYSTEM=true

  ##########[ haskell_stack: haskell version from stack (https://haskellstack.org/) ]###########
  typeset -g POWERLEVEL9K_HASKELL_STACK_FOREGROUND=172
  typeset -g POWERLEVEL9K_HASKELL_STACK_SOURCES=(shell local)
  typeset -g POWERLEVEL9K_HASKELL_STACK_ALWAYS_SHOW=true

  ################[ terraform: terraform workspace (https://www.terraform.io) ]#################
  typeset -g POWERLEVEL9K_TERRAFORM_SHOW_DEFAULT=true
  typeset -g POWERLEVEL9K_TERRAFORM_CLASSES=(
      # '*prod*'  PROD
      # '*test*'  TEST
      '*'         OTHER)
  typeset -g POWERLEVEL9K_TERRAFORM_OTHER_FOREGROUND=38

  # === terraform_version (Terraform Version) === #
  typeset -g POWERLEVEL9K_TERRAFORM_VERSION_FOREGROUND=38

  # === kubecontext (Current Kubernetes Context) === #
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito|k9s|helmfile|flux|fluxctl|stern|kubeseal|skaffold'
  typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=(
      # '*prod*'  PROD
      # '*test*'  TEST
      '*'       DEFAULT)
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=134
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'
  typeset -g POWERLEVEL9K_KUBECONTEXT_PREFIX='%246Fat '

  # === aws (AWS Profile) === #
  typeset -g POWERLEVEL9K_AWS_SHOW_ON_COMMAND='aws|awless|terraform|pulumi|terragrunt'
  typeset -g POWERLEVEL9K_AWS_CLASSES=(
      # '*prod*'  PROD
      # '*test*'  TEST
      '*'       DEFAULT)
  typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=208
  typeset -g POWERLEVEL9K_AWS_CONTENT_EXPANSION='${P9K_AWS_PROFILE//\%/%%}${P9K_AWS_REGION:+ ${P9K_AWS_REGION//\%/%%}}'

  # === aws_eb_env (AWS Elastic Beanstalk Environment) === #
  typeset -g POWERLEVEL9K_AWS_EB_ENV_FOREGROUND=70

  # === azure (Azure Account Name) === #
  typeset -g POWERLEVEL9K_AZURE_SHOW_ON_COMMAND='az|terraform|pulumi|terragrunt'
  typeset -g POWERLEVEL9K_AZURE_FOREGROUND=32

  # === gcloud (Google Cloud Account and Project) === #
  typeset -g POWERLEVEL9K_GCLOUD_SHOW_ON_COMMAND='gcloud|gcs|gsutil'
  typeset -g POWERLEVEL9K_GCLOUD_FOREGROUND=32
  typeset -g POWERLEVEL9K_GCLOUD_PARTIAL_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_ID//\%/%%}'
  typeset -g POWERLEVEL9K_GCLOUD_COMPLETE_CONTENT_EXPANSION='${P9K_GCLOUD_PROJECT_NAME//\%/%%}'
  typeset -g POWERLEVEL9K_GCLOUD_REFRESH_PROJECT_NAME_SECONDS=60
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_SHOW_ON_COMMAND='terraform|pulumi|terragrunt'
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_CLASSES=(
      # '*:*prod*:*'  PROD
      # '*:*test*:*'  TEST
      '*'             DEFAULT)
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_FOREGROUND=32
  typeset -g POWERLEVEL9K_GOOGLE_APP_CRED_DEFAULT_CONTENT_EXPANSION='${P9K_GOOGLE_APP_CRED_PROJECT_ID//\%/%%}'

  # === toolbox (Toolbox Name) === #
  typeset -g POWERLEVEL9K_TOOLBOX_FOREGROUND=178
  typeset -g POWERLEVEL9K_TOOLBOX_CONTENT_EXPANSION='${P9K_TOOLBOX_NAME:#fedora-toolbox-*}'
  typeset -g POWERLEVEL9K_TOOLBOX_PREFIX='%246Fin '

  # === public_ip (Public IP Address) === #
  typeset -g POWERLEVEL9K_PUBLIC_IP_FOREGROUND=94

  # === vpn_ip (VPN Indicator) === #
  typeset -g POWERLEVEL9K_VPN_IP_FOREGROUND=81
  typeset -g POWERLEVEL9K_VPN_IP_CONTENT_EXPANSION=
  typeset -g POWERLEVEL9K_VPN_IP_INTERFACE='(gpd|wg|(.*tun)|tailscale)[0-9]*'
  typeset -g POWERLEVEL9K_VPN_IP_SHOW_ALL=false

  # === ip (IP Address and Bandwidth) === #
  typeset -g POWERLEVEL9K_IP_FOREGROUND=38
  typeset -g POWERLEVEL9K_IP_CONTENT_EXPANSION='${P9K_IP_RX_RATE:+%70F⇣$P9K_IP_RX_RATE }${P9K_IP_TX_RATE:+%215F⇡$P9K_IP_TX_RATE }%38F$P9K_IP_IP'
  typeset -g POWERLEVEL9K_IP_INTERFACE='[ew].*'

  # === proxy (System-wide Proxy [HTTP/HTTPS/FTP]) === #
  typeset -g POWERLEVEL9K_PROXY_FOREGROUND=68

  # === battery (Internal Battery) === #
  typeset -g POWERLEVEL9K_BATTERY_LOW_THRESHOLD=20
  typeset -g POWERLEVEL9K_BATTERY_LOW_FOREGROUND=160
  typeset -g POWERLEVEL9K_BATTERY_{CHARGING,CHARGED}_FOREGROUND=70
  typeset -g POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND=178
  typeset -g POWERLEVEL9K_BATTERY_STAGES='\uf58d\uf579\uf57a\uf57b\uf57c\uf57d\uf57e\uf57f\uf580\uf581\uf578'
  typeset -g POWERLEVEL9K_BATTERY_VERBOSE=false

  # === wifi (WiFi Speed) === #
  typeset -g POWERLEVEL9K_WIFI_FOREGROUND=68

  # === time (Current Time) === #
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=66
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M:%S}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false
  typeset -g POWERLEVEL9K_TIME_PREFIX='%246Fat '
  function prompt_example() {
    p10k segment -f 208 -i '⭐' -t 'hello, %n'
  }
  function instant_prompt_example() {
    prompt_example
  }
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true
  (( ! $+functions[p10k] )) || p10k reload
}

# Configuration Wizard File Overwritting
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}
(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'

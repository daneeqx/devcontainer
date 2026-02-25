# History
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # share across sessions
setopt HIST_IGNORE_ALL_DUPS   # no duplicates
setopt HIST_IGNORE_SPACE      # ignore commands starting with space
setopt HIST_REDUCE_BLANKS     # trim whitespace

# Navigation
setopt AUTO_CD                # cd by typing dir name
setopt AUTO_PUSHD             # pushd on every cd
setopt PUSHD_IGNORE_DUPS      # no duplicate dirs in stack
setopt PUSHD_SILENT           # quiet pushd/popd

# Completion
setopt COMPLETE_IN_WORD       # complete from cursor position
setopt ALWAYS_TO_END          # move cursor to end after completion
setopt MENU_COMPLETE          # cycle through completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case-insensitive

# Misc
setopt INTERACTIVE_COMMENTS   # allow # comments in shell
setopt NO_BEEP                # silence

# Terminal Options
setopt AUTO_CD           # implicate cd for non-commands
setopt CD_ABLE_VARS       # read vars in cd
#setopt CORRECT            # correct spelling
setopt COMPLETE_IN_WORD       # complete commands anywhere in the word
setopt NOTIFY              # Notify when jobs finish
setopt CHASE_LINKS         # Follow links in cds
setopt AUTO_PUSHD          # Push dirs into history
setopt ALWAYS_TO_END       # Move to the end on complete completion
setopt LIST_ROWS_FIRST     # Row orientation for menu
setopt MULTIOS             # Allow Multiple pipes
setopt MAGIC_EQUAL_SUBST   # Expand inside equals
setopt NOBGNICE
setopt EXTENDED_GLOB
setopt NO_CASE_GLOB
setopt GLOB_COMPLETE
setopt NUMERIC_GLOB_SORT
setopt NO_FLOW_CONTROL
setopt IGNORE_EOF

# Environment variables
export EDITOR="vim"
export LESS="-g -i -M -F -R -X -x4"

# Prompt
export PROMPT="%B%%%b "
export RPROMPT="%B%~%b"

# Command aliases
alias a="open -a"
alias nw="/Applications/node-webkit.app/Contents/MacOS/node-webkit"

# Case insensitivity, partial matching, substitution
#zstyle ':completion:*' matcher-list 'm:{A-Z}={a-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
#zstyle ':completion:*' completer _complete _list _oldlist _expand _ignored _match _correct _approximate _prefix

# Fuzzy completion
#zstyle ':completion:*' completer _complete _match _approximate
#zstyle ':completion:*:match:*' original only
#zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Load modules
autoload -U compinit
compinit


#bindkey
bindkey -e

# Fuzzy completion of files/dirs on ^X^I
fuzzy_complete() {
    words=( ${(z)BUFFER} );
    pieces=( ${(s:/:)words[-1]} );
    globpt=${(j:*:)${(s::)pieces[-1]}};
    (( $#pieces == 1 )) && pieces=( . $pieces );
    matches=( $pieces[1,-2]/*${~globpt}* );
    (( $#matches == 1 )) && BUFFER="${words[1,-2]} ${(q)matches[1]}" && CURSOR=$#BUFFER || zle -M "Completions: $matches"
}
zle -N fuzzy_complete
bindkey '^X^I' fuzzy_complete

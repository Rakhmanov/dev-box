#!/usr/bin/env bash
#
# This script is part of Just installtion 
#  and not meant to be used in isolation.
#

# Bootstrap
source "$(dirname "$0")/../_bootstrap.sh"


## Example #1
MARKER='KREW_ROOT'
BLOCK=$(cat <<'EOF'
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
EOF
)
add_once_to_file "$MARKER" "$BLOCK"

# Example #2
MARKER='KREW_ROOT'
BLOCK=$(cat <<'EOF'
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
EOF
)
add_once_to_file "$MARKER" "$BLOCK" "~/.path_additions

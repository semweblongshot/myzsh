#
# proxy
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_PROXY_SHOW="${SPACESHIP_PROXY_SHOW=true}"
SPACESHIP_PROXY_SYMBOL="${SPACESHIP_PROXY_SYMBOL="👿 "}"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current virtual environment (Python).
spaceship_proxy() {
  [[ $SPACESHIP_PROXY_SHOW == false ]] && return
  [[ -z "${http_proxy}" ]] && return

  local proxy="GE "

  spaceship::section \
    'red' \
    "$SPACESHIP_PROXY_PREFIX" \
    "$SPACESHIP_PROXY_SYMBOL${proxy}" \
    "$SPACESHIP_PROXY_SUFFIX"
}

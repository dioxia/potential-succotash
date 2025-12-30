#!/usr/bin/env bash

set -euo pipefail
trap 'ret=$?; echo "${RED}Error in ${0} at line ${LINENO}${NOCOLOUR}"; exit $ret' ERR
IFS=$'\n\t'

# STANDARD COLOURS
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
BLACK='\033[0;30m'

# BRIGHT COLOURS
BRIGHT_RED='\033[1;31m'
BRIGHT_GREEN='\033[1;32m'
BRIGHT_YELLOW='\033[1;33m'
BRIGHT_BLUE='\033[1;34m'
BRIGHT_MAGENTA='\033[1;35m'
BRIGHT_CYAN='\033[1;36m'
BRIGHT_WHITE='\033[1;37m'

# OTHER FUN COLOURS
ORANGE='\033[38;5;214m'   # 256-colour orange
PURPLE='\033[38;5;93m'    # 256-colour purple
PINK='\033[38;5;205m'     # 256-colour pink
LIGHT_GRAY='\033[38;5;250m'
DARK_GRAY='\033[38;5;238m'

# RESET
NOCOLOUR='\033[0m'

# HELPERS
info() {
  echo -e "${BRIGHT_CYAN} [💡] INFO${NOCOLOUR} $*${BRIGHT_CYAN} [💡]"
}

warn() {
  echo -e "${BRIGHT_YELLOW} [❗] WARN${NOCOLOUR} $*${BRIGHT_YELLOW} [❗]"
}

error() {
  echo -e "${BRIGHT_RED} [☢️ ] ERROR${NOCOLOUR} $*${BRIGHT_RED} [☢️ ]"
}

success() {
  echo -e "${BRIGHT_GREEN} [✅] SUCCESS${NOCOLOUR} $*${BRIGHT_GREEN} [✅]"
}

# 4. Set timezone to Europe/London
# --------------------------------
# Link localtime to Europe/London
ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
# Update /etc/timezone
echo 'Europe/London' > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# 5. Export TZ environment variable (optional, for scripts)
# ---------------------------------------------------------
# Add to /etc/profile.d/tz.sh so that infoin shells inherit TZ
cat << 'EOF' > /etc/profile.d/tz.sh
export TZ="Europe/London"
EOF
chmod 644 /etc/profile.d/tz.sh

# 6. Verification (infoged to builder output)
# ------------------------------------------
# Print current locale settings and date/time for debugging
info "Current locale settings:"
locale

info "Current date and time (Europe/London):"
date

success

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

# 1. Enable and generate en_GB.UTF-8 locale
# -----------------------------------------
# Uncomment the en_GB.UTF-8 line in /etc/locale.gen
sed -i "s/^# *\(en_GB.UTF-8 UTF-8\)/\1/" /etc/locale.gen
# Generate locales non-interactively
locale-gen
update-locale LANG=en_GB.UTF-8 LANGUAGE=en_GB:en LC_ALL=en_GB.UTF-8

# 2. Set system-wide default locale
# ---------------------------------
# Ensure other relevant variables are set
cat << 'EOF' >> /etc/default/locale
LANG=en_GB.UTF-8
LANGUAGE=en_GB:en
LC_CTYPE="en_GB.UTF-8"
LC_NUMERIC="en_GB.UTF-8"
LC_TIME="en_GB.UTF-8"
LC_COLLATE="en_GB.UTF-8"
LC_MONETARY="en_GB.UTF-8"
LC_MESSAGES="en_GB.UTF-8"
LC_PAPER="en_GB.UTF-8"
LC_NAME="en_GB.UTF-8"
LC_ADDRESS="en_GB.UTF-8"
LC_TELEPHONE="en_GB.UTF-8"
LC_MEASUREMENT="en_GB.UTF-8"
LC_IDENTIFICATION="en_GB.UTF-8"
LC_ALL="en_GB.UTF-8"
EOF

# 3. Configure keyboard layout to UK (gb)
# ---------------------------------------
# Update /etc/default/keyboard
sed -i "s/^XKBLAYOUT=.*/XKBLAYOUT=\"gb\"/" /etc/default/keyboard
dpkg-reconfigure -f noninteractive keyboard-configuration

success

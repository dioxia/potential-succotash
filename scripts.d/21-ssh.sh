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

# Enable ssh server
touch /boot/ssh

# Disable password authentication
# sed -i 's/\#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

info "SETTING UP SSH ACCESS"

# Add public keys
mkdir -p /home/pi/.ssh
cat << EOF >> /home/pi/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCdwT5Ftny67046XkMTBUHrC4ajuIHAN0OYNaSGJWsMskVGVRm1jzMeYDZLnRg640eJxC23wEpN3GMTFHCFeciKC1ER7bo5ZlnZc1AxD3rjJNyhac0TKylVlziD4ZnAlrbLAFaoyHJ5Ft6Ed7Kt6Pw3RSYx/wWT6VZKtE2B+P/snYs5fjiYwxW7TQvJ3XcFj5VgQFEG2qPyG3TXUFlwIYmn0rEBQTh1XlFmxa93cTNyC4P8JnJnz4ZDDYsfyy/yAl9fX9/Q+gS+VIc9yX7wNOqOIg6LAizX0Ypn44Xd+G/4xalC6RhHR1tTKNdU6/L9hp8Xe1enqIpEFnbw/S7M60Aqs3oHQeyGKCEwLHKLXsCMqUlETA0o8mu/mBeROwemPcKVPQzqXbAzFLWw6FBAxLf2bsc/4NxFSUcEKafm9RWoVoTc+3qYfUWBgYMjQIOSX5TV2VGkwRcpvnXcXQI0cb9vKV3DblNlz00ywYlhowErix2eFZk8NC8uH1fC6N34yIU= wdconinc@herakles
EOF

# Permissions
chmod 700 /home/pi/.ssh/
chmod 600 /home/pi/.ssh/authorized_keys

success

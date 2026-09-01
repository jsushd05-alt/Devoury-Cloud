#!/usr/bin/env bash

# ============================================================
# DEVOURY CLOUD — SERVER TOOLS
# ============================================================

set -uo pipefail

# ────────────────────────────────────────────────────────────
# COLORS
# ────────────────────────────────────────────────────────────

CYAN='\033[1;36m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
GRAY='\033[0;37m'
NC='\033[0m'

# ────────────────────────────────────────────────────────────
# PAUSE
# ────────────────────────────────────────────────────────────

pause() {
    echo
    read -rp " ${CYAN}➜${NC} Press Enter to continue..."
}

# ────────────────────────────────────────────────────────────
# BUTTON
# ────────────────────────────────────────────────────────────

button() {
    local number="$1"
    local title="$2"

    printf " ${CYAN}╭──────────────────────────────────╮${NC}\n"
    printf " ${CYAN}│${NC} ${WHITE}[ %s ]${NC} %-25s ${CYAN}│${NC}\n" \
        "$number" "$title"
    printf " ${CYAN}╰──────────────────────────────────╯${NC}\n"
}

# ────────────────────────────────────────────────────────────
# HEADER
# ────────────────────────────────────────────────────────────

header() {

    clear

    echo -e "${GREEN}"

    cat <<'EOF'
 ██████╗ ███████╗██╗   ██╗ ██████╗  ██████╗ ██╗   ██╗
 ██╔══██╗██╔════╝██║   ██║██╔═══██╗██╔═══██╗╚██╗ ██╔╝
 ██║  ██║█████╗  ██║   ██║██║   ██║██║   ██║ ╚████╔╝
 ██║  ██║██╔══╝  ╚██╗ ██╔╝██║   ██║██║   ██║  ╚██╔╝
 ██████╔╝███████╗ ╚████╔╝ ╚██████╔╝╚██████╔╝   ██║
 ╚═════╝ ╚══════╝  ╚═══╝   ╚═════╝  ╚═════╝    ╚═╝
EOF

    echo -e "${NC}"

    echo -e "              ${PURPLE}DEVOURY TOOLS${NC}"
    echo -e "        ${GRAY}Server Utilities${NC}"

    echo
}

# ────────────────────────────────────────────────────────────
# MAIN MENU
# ────────────────────────────────────────────────────────────

tools_menu() {

    while true; do

        header

        echo -e "${GRAY}╭──────────────────────────────────────────────────────────╮${NC}"

        printf "${GRAY}│${NC} ${WHITE}HOST${NC} %-20s ${GRAY}│${NC} ${WHITE}USER${NC} %-18s ${GRAY}│${NC}\n" \
            "$(hostname)" "$(whoami)"

        echo -e "${GRAY}╰──────────────────────────────────────────────────────────╯${NC}"

        echo

        echo -e "${WHITE}DEVOURY TOOLS${NC}"
        echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"

        button "1" "Root Access"
        button "2" "Tailscale"
        button "3" "Zerotier"
        button "4" "Cloudflare DNS"

        echo

        button "5" "System Info"
        button "6" "Port Forward"

        echo

        button "7" "Web Terminal"
        button "8" "RDP Installer"
        button "9" "SSL Panel"

        echo

        echo -e "${GRAY}────────────────────────────────────────────────────────────${NC}"
        echo -e " ${RED}[ 0 ]${NC} Back"
        echo

        echo -ne "${CYAN}➜${NC} ${WHITE}Select an option:${NC} "
        read -r t

        case "$t" in

            1)
                clear
                echo -e "${CYAN}▶ Launching Root Access...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/tools/root.sh")

                pause
                ;;

            2)
                clear
                echo -e "${CYAN}▶ Launching Tailscale...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/tools/tailscale.sh")

                pause
                ;;

            3)
                clear
                echo -e "${CYAN}▶ Launching Zerotier...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/tools/zerotier.sh")

                pause
                ;;

            4)
                clear
                echo -e "${CYAN}▶ Launching Cloudflare DNS...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/tools/cloudflare.sh")

                pause
                ;;

            5)
                clear
                echo -e "${CYAN}▶ Fetching System Information...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/tools/info.sh")

                pause
                ;;

            6)
                clear
                echo -e "${CYAN}▶ Launching Port Forward...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/tools/localtonet.sh")

                pause
                ;;

            7)
                clear
                echo -e "${CYAN}▶ Launching Web Terminal...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/tools/terminal.sh")

                pause
                ;;

            8)
                clear
                echo -e "${CYAN}▶ Launching RDP Installer...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/The-Coding-Hub/refs/heads/main/srv/tools/rdp.sh")

                pause
                ;;

            9)
                clear
                echo -e "${CYAN}▶ Launching SSL Panel...${NC}"
                echo

                bash <(curl -fsSL \
                "https://raw.githubusercontent.com/nobita329/hub/refs/heads/main/Codinghub/toolbox/mengssl.sh")

                pause
                ;;

            0|back|exit)
                break
                ;;

            *)
                echo
                echo -e "${RED}✘ Invalid option.${NC}"
                sleep 1
                ;;

        esac

    done
}

# ────────────────────────────────────────────────────────────
# START
# ────────────────────────────────────────────────────────────

tools_menu

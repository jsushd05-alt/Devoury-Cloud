#!/bin/bash

# ============================================================
# DEVOURY CLOUD — PANEL MANAGER
# ============================================================

set -u

# ============================================================
# COLORS
# ============================================================

CYAN='\033[1;36m'
BLUE='\033[1;34m'
PURPLE='\033[1;35m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m'

# ============================================================
# SYSTEM METRICS
# ============================================================

get_metrics() {

    UPTIME="$(uptime -p 2>/dev/null | sed 's/^up //' || echo "Unknown")"

    LOAD="$(uptime 2>/dev/null |
        awk -F'load average:' '{print $2}' |
        cut -d',' -f1 |
        xargs)"

    [[ -z "$UPTIME" ]] && UPTIME="Unknown"
    [[ -z "$LOAD" ]] && LOAD="--"
}

# ============================================================
# BUTTON
# ============================================================

button() {

    local number="$1"
    local title="$2"

    printf "  ${CYAN}╭──────────────────────────────╮${NC}\n"
    printf "  ${CYAN}│${NC} ${WHITE}[ %s ] %-22s${CYAN}│${NC}\n" \
        "$number" "$title"
    printf "  ${CYAN}╰──────────────────────────────╯${NC}\n"
}

# ============================================================
# PAUSE
# ============================================================

pause() {

    echo
    read -rp "Press Enter to return..."
}

# ============================================================
# HEADER
# ============================================================

draw_header() {

    get_metrics

    clear

    echo -e "${GREEN}"

    cat <<'EOF'
 ██████╗ ███████╗██╗   ██╗ ██████╗   ██████╗ ██╗   ██╗
 ██╔══██╗██╔════╝██║   ██║██╔═══██╗ ██╔══██╗╚██╗ ██╔╝
 ██║  ██║█████╗  ██║   ██║██║     ██║ ██████╔╝ ╚████╔╝
 ██║  ██║██╔══╝  ╚██╗ ██╔╝██║    ██║ ██╔══██╗   ╚██╔╝
 ██████╔╝███████╗ ╚████╔╝ ╚██████╔╝ ██║  ██║    ██║
 ╚═════╝ ╚══════╝  ╚═══╝   ╚═════╝   ╚═╝  ╚═╝    ╚═╝
EOF

    echo -e "${NC}"

    echo -e "             ${PURPLE}DEVOURY CLOUD${NC}"
    echo -e "             ${GRAY}Panel Manager${NC}"

    echo

    echo -e "${GRAY}╭──────────────────────────────────────────────────────────────╮${NC}"

    printf "${GRAY}│${NC} ${WHITE}SYSTEM${NC} ${GREEN}● ONLINE${NC} ${GRAY}│${NC} ${WHITE}UPTIME${NC} %-18s ${GRAY}│${NC}\n" \
        "$UPTIME"

    echo -e "${GRAY}╰──────────────────────────────────────────────────────────────╯${NC}"

    echo
}

# ============================================================
# PANEL MENU
# ============================================================

panel_menu() {

    while true; do

        draw_header

        echo -e "${WHITE}AVAILABLE DEPLOYMENTS${NC}"
        echo -e "${GRAY}──────────────────────────────────────────────────────────────${NC}"
        echo

        button "1" "Pterodactyl"
        button "2" "Jexactyl"
        button "3" "JexPanel"
        button "4" "Reviacity1"
        button "5" "CtrlPanel"
        button "6" "Paynter"
        button "7" "Convoy"
        button "8" "FeatherPanel"
        button "9" "Mythicaldash"
        button "10" "Mythicaldashv3"
        button "11" "VPS Panel"

        echo

        echo -e "${GRAY}──────────────────────────────────────────────────────────────${NC}"
        echo -e " ${RED}[ 0 ]${NC} Exit"
        echo

        echo -ne "${CYAN}➜${NC} ${WHITE}Select an option:${NC} "
        read -r choice

        case "$choice" in

            1)
                clear
                echo -e "${CYAN}Launching Pterodactyl...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/pterodactyl/run.sh"
                )
                pause
                ;;

            2)
                clear
                echo -e "${CYAN}Launching Jexactyl...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/jexactyl/run.sh"
                )
                pause
                ;;

            3)
                clear
                echo -e "${CYAN}Launching JexPanel...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/jexpanel/run.sh"
                )
                pause
                ;;

            4)
                clear
                echo -e "${CYAN}Launching Reviacity1...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/reviacity1/run.sh"
                )
                pause
                ;;

            5)
                clear
                echo -e "${CYAN}Launching CtrlPanel...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/ctrlpanel/run.sh"
                )
                pause
                ;;

            6)
                clear
                echo -e "${CYAN}Launching Paynter...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/paynter/run.sh"
                )
                pause
                ;;

            7)
                clear
                echo -e "${CYAN}Launching Convoy...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/hub/refs/heads/main/Codinghub/panel/convoy/run.sh"
                )
                pause
                ;;

            8)
                clear
                echo -e "${CYAN}Launching FeatherPanel...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/featherpanel/run.sh"
                )
                pause
                ;;

            9)
                clear
                echo -e "${CYAN}Launching Mythicaldash...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/mythicaldash/run.sh"
                )
                pause
                ;;

            10)
                clear
                echo -e "${CYAN}Launching Mythicaldashv3...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/mythicaldashv3/run.sh"
                )
                pause
                ;;

            11)
                clear
                echo -e "${CYAN}Launching VPS Panel...${NC}"
                echo
                bash <(
                    curl -fsSL \
                    "https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/panel/vps-panel/run.sh"
                )
                pause
                ;;

            0)
                clear
                echo
                echo -e "${CYAN}DEVOURY CLOUD${NC}"
                echo -e "${GRAY}Panel Manager closed.${NC}"
                echo
                exit 0
                ;;

            *)
                echo
                echo -e "${RED}Invalid option.${NC}"
                sleep 1
                ;;

        esac

    done
}

# ============================================================
# START
# ============================================================

panel_menu

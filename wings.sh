#!/bin/bash

# ==================================================
#              DEVOURY CONTROL PANEL
# ==================================================

# --- COLORS ---
R="\e[31m"
G="\e[32m"
Y="\e[33m"
B="\e[34m"
C="\e[36m"
M="\e[35m"
W="\e[37m"
N="\e[0m"

# ==================================================
# HELPER FUNCTIONS
# ==================================================

pause() {
    echo ""
    read -n 1 -s -r -p "   Press any key to continue..."
    echo ""
}

header() {
    clear

    echo -e "${C}╔══════════════════════════════════════════════╗${N}"
    echo -e "${C}║${W}             DEVOURY CONTROL PANEL            ${C}║${N}"
    echo -e "${C}╚══════════════════════════════════════════════╝${N}"
    echo ""
}

status() {
    echo -e "   ${C}Host :${N} $(hostname)"
    echo -e "   ${C}User :${N} $(whoami)"
    echo ""
}

# ==================================================
# SSL CONFIGURATION
# ==================================================

ssl_setup() {
    header

    echo -e "   ${C}SSL CONFIGURATION${N}"
    echo ""

    PUBLIC_IP=$(curl -4 -s --max-time 2 https://ipinfo.io/ip || echo "Unknown")

    echo -e "   ${Y}Detected IP :${N} $PUBLIC_IP"
    echo ""
    echo -ne "   ${C}Enter Domain :${N} "
    read DOMAIN

    if [ -z "$DOMAIN" ]; then
        echo -e "\n   ${R}Setup aborted.${N}"
        pause
        return
    fi

    echo ""
    echo -e "   ${Y}Installing dependencies...${N}"

    apt update -y >/dev/null 2>&1
    apt install -y certbot python3-certbot-nginx >/dev/null 2>&1

    echo ""
    echo -e "   ${Y}Requesting SSL certificate...${N}"

    rm -rf "/etc/letsencrypt/live/$DOMAIN"
    rm -rf "/etc/letsencrypt/archive/$DOMAIN"
    rm -f "/etc/letsencrypt/renewal/$DOMAIN.conf"

    certbot certonly --nginx \
        -d "$DOMAIN" \
        --non-interactive \
        --agree-tos \
        --email "ssl@$DOMAIN"

    echo ""
    echo -e "   ${G}SSL Setup Complete ✔${N}"

    pause
}

# ==================================================
# UNINSTALL
# ==================================================

uninstall_menu() {
    header

    echo -e "   ${R}⚠ DANGER ZONE: UNINSTALL${N}"
    echo ""
    echo -e "   ${R}This will remove Wings, Docker and configs.${N}"
    echo -e "   ${Y}Panel files will remain.${N}"
    echo ""

    echo -ne "   ${R}Are you sure? [y/N]: ${N}"
    read CONFIRM

    [[ "$CONFIRM" != "y" ]] && return

    echo ""
    echo -e "   ${Y}Stopping Wings...${N}"

    systemctl disable --now wings 2>/dev/null
    rm -f /etc/systemd/system/wings.service

    echo -e "   ${Y}Removing Wings files...${N}"

    rm -rf /etc/pterodactyl
    rm -rf /var/lib/pterodactyl
    rm -rf /usr/local/bin/wings
    rm -rf /etc/systemd/system/wings.service

    systemctl daemon-reload 2>/dev/null

    echo ""
    echo -e "   ${Y}Pruning Docker...${N}"

    docker system prune -a -f >/dev/null 2>&1

    echo ""
    echo -ne "   ${C}Delete Database? [y/N]: ${N}"
    read DEL_DB

    if [[ "$DEL_DB" == "y" ]]; then
        echo -ne "   ${C}Database Name: ${N}"
        read DBN

        echo -ne "   ${C}Database User: ${N}"
        read DBU

        mysql -e "DROP DATABASE IF EXISTS \`$DBN\`; DROP USER IF EXISTS '$DBU'@'127.0.0.1';" 2>/dev/null

        echo -e "   ${G}Database cleared ✔${N}"
    fi

    echo ""
    echo -e "   ${G}Uninstallation Finished ✔${N}"

    pause
}

# ==================================================
# MAIN MENU
# ==================================================

while true; do

    header
    status

    echo -e "   ${C}AVAILABLE MODULES${N}"
    echo ""
    echo -e "   ${Y}[1]${N} SSL Configuration"
    echo -e "   ${Y}[2]${N} Install Wings"
    echo -e "   ${Y}[3]${N} Manager"
    echo -e "   ${Y}[4]${N} Database Manager"
    echo -e "   ${Y}[5]${N} Uninstall"
    echo ""
    echo -e "   ${R}[0]${N} Exit"
    echo ""

    echo -ne "   ${C}➤ Select Option :${N} "
    read opt

    case "$opt" in

        1)
            ssl_setup
            ;;

        2)
            header
            echo -e "   ${C}Installing Wings...${N}"
            echo ""

            bash <(curl -fsSL \
            https://raw.githubusercontent.com/nobita329/Nobita-Cloud/refs/heads/main/wings/install.sh)

            pause
            ;;

        3)
            header
            echo -e "   ${C}Opening Manager...${N}"
            echo ""

            bash <(curl -fsSL \
            https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/wings.sh)

            pause
            ;;

        4)
            header
            echo -e "   ${C}Opening Database Manager...${N}"
            echo ""

            bash <(curl -fsSL \
            https://raw.githubusercontent.com/nobita329/ptero/refs/heads/main/ptero/wings/db.sh)

            pause
            ;;

        5)
            uninstall_menu
            ;;

        0)
            clear
            echo -e "${R}   Goodbye!${N}"
            exit 0
            ;;

        *)
            echo ""
            echo -e "   ${R}Invalid Option${N}"
            sleep 1
            ;;

    esac

done

#!/data/data/com.termux/files/usr/bin/bash

# Cấu hình mặc định
CONFIG_FILE="$HOME/.xmr_miner_config"
DEFAULT_POOL="asia.hashvault.pro:443"
DEFAULT_ALGO="rx"
DEFAULT_THREADS=$(nproc --all)
DEFAULT_AUTOSTART="no"

RED='\033[1;31m'; GREEN='\033[1;32m'; BLUE='\033[1;34m'; CYAN='\033[1;36m'; YELLOW='\033[1;33m'; NC='\033[0m'

# Kiểm tra và cài đặt các gói cần thiết
install_dependencies() {
  echo -e "${YELLOW}[*] Kiểm tra và cài đặt các gói cần thiết...${NC}"
  pkg install -y git curl clang cmake build-essential neofetch jq > /dev/null 2>&1
  echo -e "${GREEN}[✓] Các gói đã được cài đặt.${NC}"
}

# Hiển thị banner
show_banner() {
  clear
  neofetch
  echo -e "${CYAN}"
  echo "╔═══════════════════════════════════════════════╗"
  echo "║       SCRIPT ĐÀO XMR TỰ ĐỘNG - TERMUX         ║"
  echo "╚═══════════════════════════════════════════════╝"
  echo -e "${NC}"
}

# Kiểm tra kết nối mạng
check_internet() {
  ping -c 1 8.8.8.8 > /dev/null 2>&1
  return $?
}

# Cài đặt XMRig
install_xmrig() {
  echo -e "${YELLOW}[*] Đang cài đặt XMRig...${NC}"
  if [ -d "$HOME/xmrig" ]; then
    echo -e "${BLUE}[*] Đã phát hiện thư mục XMRig, cập nhật...${NC}"
    cd "$HOME/xmrig"
    git pull
  else
    git clone https://github.com/xmrig/xmrig.git "$HOME/xmrig"
    cd "$HOME/xmrig"
  fi

  mkdir -p build
  cd build
  cmake -DWITH_HWLOC=OFF ..
  make -j$(nproc)

  if [ -f "./xmrig" ]; then
    echo -e "${GREEN}[✓] XMRig đã được cài đặt thành công!${NC}"
  else
    echo -e "${RED}[X] Cài đặt XMRig thất bại!${NC}"
    exit 1
  fi
}

# Thiết lập cấu hình
setup_config() {
  echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║          THIẾT LẬP CẤU HÌNH ĐÀO XMR           ║${NC}"
  echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"

  [ -f "$CONFIG_FILE" ] && source "$CONFIG_FILE"

  read -p "Nhập địa chỉ ví XMR (hiện tại: ${WALLET:-Chưa thiết lập}): " new_wallet
  read -p "Nhập tên worker (hiện tại: ${WORKER:-Chưa thiết lập}): " new_worker
  read -p "Nhập số luồng CPU (0-$DEFAULT_THREADS, hiện tại: ${THREADS:-$DEFAULT_THREADS}): " new_threads
  read -p "Tự động chạy khi mở Termux? (yes/no, hiện tại: ${AUTOSTART:-$DEFAULT_AUTOSTART}): " new_autostart

  WALLET=${new_wallet:-$WALLET}
  WORKER=${new_worker:-$WORKER}
  THREADS=${new_threads:-$THREADS}
  AUTOSTART=${new_autostart:-$AUTOSTART}

  if [[ ! $THREADS =~ ^[0-9]+$ ]] || [ "$THREADS" -gt "$DEFAULT_THREADS" ] || [ "$THREADS" -eq 0 ]; then
    THREADS=$DEFAULT_THREADS
    echo -e "${YELLOW}[!] Số luồng không hợp lệ, dùng mặc định: $THREADS${NC}"
  fi

  # Lưu cấu hình
  cat <<EOF > "$CONFIG_FILE"
WALLET="$WALLET"
WORKER="$WORKER"
THREADS="$THREADS"
AUTOSTART="$AUTOSTART"
POOL="$DEFAULT_POOL"
ALGO="$DEFAULT_ALGO"
EOF

  echo -e "${GREEN}[✓] Đã lưu cấu hình tại $CONFIG_FILE${NC}"

  setup_autostart
}

# Thiết lập tự chạy bằng .bashrc
setup_autostart() {
  AUTOSTART_CMD="bash $0 --mining"

  if [ "$AUTOSTART" = "yes" ]; then
    if ! grep -Fxq "$AUTOSTART_CMD" "$HOME/.bashrc"; then
      echo "$AUTOSTART_CMD" >> "$HOME/.bashrc"
      echo -e "${GREEN}[✓] Đã bật chế độ tự động chạy khi mở Termux.${NC}"
    else
      echo -e "${BLUE}[*] Tự động chạy đã được bật từ trước.${NC}"
    fi
  else
    sed -i "\|$AUTOSTART_CMD|d" "$HOME/.bashrc"
    echo -e "${BLUE}[*] Đã tắt chế độ tự động chạy.${NC}"
  fi
}

# Bắt đầu đào
start_mining() {
  if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}[X] Chưa thiết lập cấu hình!${NC}"
    sleep 2
    setup_config
    return
  fi

  source "$CONFIG_FILE"

  if [ -z "$WALLET" ] || [ -z "$WORKER" ]; then
    echo -e "${RED}[X] Thiếu ví hoặc worker!${NC}"
    sleep 2
    setup_config
    return
  fi

  echo -e "${YELLOW}[*] Kiểm tra kết nối mạng...${NC}"
  attempts=0; max_attempts=10
  while ! check_internet; do
    echo -e "${RED}[!] Không có mạng. Thử lại sau 10s...${NC}"
    attempts=$((attempts + 1))
    [ "$attempts" -ge "$max_attempts" ] && echo -e "${RED}[X] Thoát.${NC}" && return
    sleep 10
  done

  echo -e "${GREEN}[✓] Mạng OK. Bắt đầu đào...${NC}"
  echo -e "${CYAN}╔═══════════════════════════════════════════════╗${NC}"
  echo -e "${CYAN}║ THÔNG TIN MINER                               ║${NC}"
  echo -e "${CYAN}║ Ví: $WALLET${NC}"
  echo -e "${CYAN}║ Worker: $WORKER${NC}"
  echo -e "${CYAN}║ Pool: $POOL${NC}"
  echo -e "${CYAN}║ Luồng CPU: $THREADS/${DEFAULT_THREADS}${NC}"
  echo -e "${CYAN}╚═══════════════════════════════════════════════╝${NC}"
  sleep 2

  while true; do
    echo -e "${BLUE}==> Đang chạy XMRig...${NC}"
    cd "$HOME/xmrig/build" || { echo -e "${RED}[X] Không tìm thấy thư mục XMRig!${NC}"; install_xmrig; continue; }
    ./xmrig -o "$POOL" -a "$ALGO" -u "$WALLET" -p "$WORKER" -t "$THREADS"
    echo -e "${RED}[!] XMRig dừng. Restart sau 10s...${NC}"
    sleep 10
  done
}

# Xử lý tham số dòng lệnh
if [ "$1" == "--mining" ]; then
  start_mining
  exit 0
fi

# Menu chính
while true; do
  show_banner
  echo -e "${CYAN}Chọn chức năng:${NC}"
  echo "1. Bắt đầu đào"
  echo "2. Thiết lập cấu hình"
  echo "3. Cài đặt/cập nhật XMRig"
  echo "0. Thoát"
  read -p "> Nhập lựa chọn: " choice

  case $choice in
    1) start_mining ;;
    2) setup_config ;;
    3) install_dependencies; install_xmrig ;;
    0) echo -e "${YELLOW}Tạm biệt!${NC}"; exit 0 ;;
    *) echo -e "${RED}Lựa chọn không hợp lệ.${NC}" ;;
  esac
  echo -e "${YELLOW}Nhấn Enter để tiếp tục...${NC}"
  read
done

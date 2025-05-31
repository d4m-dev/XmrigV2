# XMRig Auto Miner cho Termux

Một script tự động hóa quá trình đào Monero (XMR) trên Android sử dụng Termux với các tính năng:
- ✅ Tự động cài đặt XMRig và các phụ thuộc
- 🔄 Tự động khởi động lại khi bị dừng
- ⚙️ Lưu cấu hình cho các lần chạy sau
- 🚀 Tự động chạy khi mở Termux
- 📊 Hiển thị thông tin hệ thống

> **Lưu ý quan trọng:** Việc đào tiền điện tử có thể làm giảm tuổi thọ thiết bị và tiêu tốn năng lượng. Hãy đảm bảo bạn hiểu rõ các rủi ro trước khi sử dụng.

## 📋 Yêu cầu hệ thống
- Android 7.0 trở lên
- Termux ([tải từ F-Droid](https://f-droid.org/repo/com.termux_118.apk))
- Kết nối Internet ổn định
- Khuyến nghị ít nhất 6GB RAM

## 🚀 Cài đặt và sử dụng

### 1️⃣ Cài đặt Termux và cập nhật gói
```bash
pkg update -y && pkg upgrade -y
```

### 2️⃣ Tải xuống script đào XMR
```bash
git clone https://github.com/d4m-dev/XmrigV2.git
```

### 3️⃣ Chạy script và thiết lập cấu hình
```bash
cd XmrigV2 && chmod +x xmrig.sh && ./xmrig.sh
```
Lần đầu chạy, bạn cần nhập:
- Địa chỉ ví Monero (XMR)
- Tên worker (tùy chọn)
- Số luồng CPU muốn dùng
- Có tự động chạy khi mở Termux không

### 4️⃣ Bắt đầu đào
Chọn "1. Bắt đầu đào" từ menu hoặc chạy trực tiếp:
```bash
./xmrig.sh --mining
```

## ⚙️ Cấu hình nâng cao

Cấu hình được lưu tại `~/.xmr_miner_config`. Bạn có thể sửa trực tiếp hoặc dùng menu script.

Ví dụ nội dung:
```bash
WALLET="85BvvbNHc2wCZUYw..."
WORKER="N20U-001"
THREADS="4"
AUTOSTART="yes"
POOL="asia.hashvault.pro:443"
ALGO="rx"
```

## ❓ Câu hỏi thường gặp

**Làm sao dừng script?**  
Nhấn `Ctrl+C` hoặc chọn "0. Thoát".

**Thay đổi pool đào?**  
Sửa `POOL` trong file cấu hình hoặc menu script.

**Tự động không chạy khi mở Termux?**  
Kiểm tra bạn đã chọn "yes". Nếu vẫn lỗi, thử:
```bash
termux-reload-settings
```

> ⚠️ **Cảnh báo:** Một số thiết bị Android chặn chạy nền để tiết kiệm pin. Hãy cho phép Termux chạy không bị giới hạn trong cài đặt.

## 📊 Các lệnh hữu ích

| Lệnh | Mô tả |
|------|-------|
| `./xmrig.sh` | Khởi động menu chính |
| `./xmrig.sh --mining` | Chạy chế độ đào trực tiếp |
| `nano ~/.xmr_miner_config` | Sửa cấu hình thủ công |
| `pgrep -f xmrig` | Kiểm tra XMRig có đang chạy không |
| `pkill -f xmrig` | Dừng XMRig |

> ❗ **Quan trọng:** Script này chỉ mang tính giáo dục. Hãy tuân thủ pháp luật và chính sách dịch vụ của bạn khi sử dụng.

---
**Nguồn:** [d4m-dev/XmrigV2 trên GitHub](https://github.com/d4m-dev/XmrigV2/)

---
#
## 🔧 Sửa lỗi thường gặp

### 1. Lỗi thiếu package
```bash
pkg update && pkg install -y git clang cmake
```

### 2. Lỗi biên dịch
```bash
cd ~/xmrig
rm -rf build
mkdir build && cd build
cmake -DWITH_HWLOC=OFF ..
make -j4
```

### 3. Lỗi kết nối pool
Kiểm tra pool:
```bash
ping xmr.hashvault.pro
```

Thay đổi pool trong config:
```bash
nano ~/.xmr_miner_config
```
#### Đổi thành: POOL="xmr.2miners.com:2222"

## 📊 Theo dõi hiệu suất
```bash
watch -n 5 "pgrep -l xmrig; sensors"
```

> ⚠️ **Lưu ý**: Đảm bảo thiết bị không quá nóng!
```

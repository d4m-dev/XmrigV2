<div>
<style>
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    line-height: 1.6;
    color: #333;
    max-width: 900px;
    margin: 0 auto;
    padding: 20px;
    background-color: #f5f5f5;
}
.container {
    background-color: white;
    border-radius: 8px;
    padding: 30px;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
}
h1, h2, h3 {
    color: #2c3e50;
}
h1 {
    border-bottom: 2px solid #3498db;
    padding-bottom: 10px;
}
h2 {
    margin-top: 25px;
    color: #2980b9;
}
code {
    background-color: #f8f9fa;
    padding: 2px 5px;
    border-radius: 3px;
    font-family: 'Courier New', Courier, monospace;
}
pre {
    background-color: #282c34;
    color: #abb2bf;
    padding: 15px;
    border-radius: 5px;
    overflow-x: auto;
}
.note {
    background-color: #e7f5ff;
    border-left: 4px solid #3498db;
    padding: 12px;
    margin: 15px 0;
}
.warning {
    background-color: #fff3bf;
    border-left: 4px solid #ffd43b;
    padding: 12px;
    margin: 15px 0;
}
.danger {
    background-color: #ffc9c9;
    border-left: 4px solid #ff6b6b;
    padding: 12px;
    margin: 15px 0;
}
.command {
    background-color: #2d2d2d;
    color: #f8f8f2;
    padding: 10px 15px;
    border-radius: 5px;
    display: inline-block;
    margin: 5px 0;
}
.step {
    margin-bottom: 20px;
}
.step-number {
    display: inline-block;
    background-color: #3498db;
    color: white;
    width: 25px;
    height: 25px;
    text-align: center;
    border-radius: 50%;
    margin-right: 10px;
    font-weight: bold;
}
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}
th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}
th {
    background-color: #f1f1f1;
}
</style>

<div class="container">
    <h1>XMRig Auto Miner cho Termux</h1>
    <p>Một script tự động hóa quá trình đào Monero (XMR) trên thiết bị Android sử dụng Termux với các tính năng:</p>
    <ul>
        <li>✅ Tự động cài đặt XMRig và các phụ thuộc</li>
        <li>🔄 Tự động khởi động lại khi bị dừng</li>
        <li>⚙️ Lưu cấu hình cho các lần chạy sau</li>
        <li>🚀 Tự động chạy khi mở Termux</li>
        <li>📊 Hiển thị thông tin hệ thống</li>
    </ul>

    <div class="note">
        <strong>Lưu ý quan trọng:</strong> Việc đào tiền điện tử có thể làm giảm tuổi thọ thiết bị và tiêu tốn nhiều năng lượng. Hãy đảm bảo bạn hiểu rõ các rủi ro trước khi sử dụng.
    </div>

    <h2>📋 Yêu cầu hệ thống</h2>
    <ul>
        <li>Thiết bị Android 7.0 trở lên</li>
        <li>Termux (tải từ <a href="https://f-droid.org/repo/com.termux_118.apk" target="_blank">F-Droid</a>)</li>
        <li>Kết nối Internet ổn định</li>
        <li>Khuyến nghị ít nhất 2GB RAM</li>
    </ul>

    <h2>🚀 Cài đặt và sử dụng</h2>

    <div class="step">
        <div class="step-number">1</div>
        <h3>Cài đặt Termux và cập nhật gói</h3>
        <p>Mở Termux và chạy các lệnh sau:</p>
        <div class="command">pkg update -y && pkg upgrade -y</div>
    </div>

    <div class="step">
        <div class="step-number">2</div>
        <h3>Tải xuống script đào XMR</h3>
        <p>Chạy lệnh sau để tải script:</p>
        <pre>curl -L https://raw.githubusercontent.com/your-repo/xmrig-termux/main/xmrig.sh -o xmrig.sh
chmod +x xmrig.sh</pre>
    </div>

    <div class="step">
        <div class="step-number">3</div>
        <h3>Chạy script và thiết lập cấu hình</h3>
        <p>Khởi động script và làm theo hướng dẫn:</p>
        <div class="command">./xmrig.sh</div>
        <p>Lần đầu chạy, script sẽ yêu cầu bạn nhập:</p>
        <ul>
            <li>Địa chỉ ví Monero (XMR) của bạn</li>
            <li>Tên worker (tùy chọn)</li>
            <li>Số luồng CPU muốn sử dụng</li>
            <li>Có tự động chạy khi mở Termux không</li>
        </ul>
    </div>

    <div class="step">
        <div class="step-number">4</div>
        <h3>Bắt đầu đào</h3>
        <p>Sau khi thiết lập, chọn tùy chọn <strong>"1. Bắt đầu đào"</strong> từ menu chính.</p>
        <div class="note">
            <strong>Mẹo:</strong> Bạn có thể chạy trực tiếp ở chế độ đào bằng lệnh:
            <div class="command">./xmrig.sh --mining</div>
        </div>
    </div>

    <h2>⚙️ Cấu hình nâng cao</h2>
    <p>Tất cả cấu hình được lưu tại <code>~/.xmr_miner_config</code>. Bạn có thể chỉnh sửa trực tiếp file này hoặc dùng menu thiết lập trong script.</p>

    <h3>Các thông số có thể tùy chỉnh:</h3>
    <pre>WALLET="85BvvbNHc2wCZUYwUqojbqYHFBAixfdjRME2CE5kccLWcHv4J5n7L7QFxXF7HT5G2XYyM62pMLf5oaCH2hwmtzPa83Rfkcu"
WORKER="N20U-001"
THREADS="4"
AUTOSTART="yes"
POOL="asia.hashvault.pro:443"
ALGO="rx"</pre>

    <h2>❓ Câu hỏi thường gặp</h2>

    <h3>Làm cách nào để dừng script?</h3>
    <p>Nhấn <strong>Ctrl+C</strong> để dừng quá trình đào. Để thoát hoàn toàn, chọn tùy chọn <strong>"0. Thoát"</strong> từ menu chính.</p>

    <h3>Tôi có thể thay đổi pool đào không?</h3>
    <p>Có, bạn có thể chỉnh sửa file cấu hình và thay đổi thông số <code>POOL</code> hoặc dùng menu thiết lập trong script.</p>

    <h3>Tại sao script không chạy tự động khi mở Termux?</h3>
    <p>Kiểm tra lại bạn đã chọn "yes" khi thiết lập tự động chạy chưa. Nếu vẫn không hoạt động, thử chạy lại lệnh sau:</p>
    <div class="command">termux-reload-settings</div>

    <div class="warning">
        <strong>Cảnh báo:</strong> Một số thiết bị có thể tự động dừng các tiến trình chạy nền để tiết kiệm pin. Hãy đảm bảo Termux được thêm vào danh sách ứng dụng không bị giới hạn trong cài đặt pin của bạn.
    </div>

    <h2>📊 Các lệnh hữu ích</h2>
    <table>
        <tr>
            <th>Lệnh</th>
            <th>Mô tả</th>
        </tr>
        <tr>
            <td><code>./xmrig.sh</code></td>
            <td>Khởi động menu chính</td>
        </tr>
        <tr>
            <td><code>./xmrig.sh --mining</code></td>
            <td>Chạy trực tiếp ở chế độ đào</td>
        </tr>
        <tr>
            <td><code>nano ~/.xmr_miner_config</code></td>
            <td>Chỉnh sửa cấu hình thủ công</td>
        </tr>
        <tr>
            <td><code>pgrep -f xmrig</code></td>
            <td>Kiểm tra xem XMRig có đang chạy không</td>
        </tr>
        <tr>
            <td><code>pkill -f xmrig</code></td>
            <td>Dừng tất cả tiến trình XMRig</td>
        </tr>
    </table>

    <div class="danger">
        <strong>Quan trọng:</strong> Script này chỉ dành cho mục đích giáo dục. Hãy đảm bảo bạn tuân thủ luật pháp địa phương và chính sách của nhà cung cấp dịch vụ khi sử dụng.
    </div>
</div>
</div>

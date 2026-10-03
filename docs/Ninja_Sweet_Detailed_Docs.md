# 🥷 Hướng Dẫn Chi Tiết Dự Án Ninja Sweet 🥷

Chào mừng bạn đến với mã nguồn của Ninja Sweet! File này được viết để giải thích **cực kỳ chi tiết** từng thành phần trong dự án này. Cho dù bạn là người mới tinh (newbie) chưa từng biết lập trình, chỉ cần đọc kỹ là bạn sẽ hiểu máy chủ game Ninja Sweet đang hoạt động như thế nào.

---

## 🏗️ 1. Bức Tranh Toàn Cảnh (Tổng quan)
Dự án này đã được **"Docker hóa"**. 
Nói một cách đơn giản, thay vì bạn phải cài đặt lằng nhằng môi trường Java, cài đặt phần mềm Cơ Sở Dữ Liệu (MySQL/MariaDB) lên máy vi tính của bạn, thì **Docker sẽ làm ảo thuật**. Nó tạo ra các **"thùng chứa" (Container)**. Mỗi thùng chứa là một "máy vi tính thu nhỏ" giam lỏng một chương trình riêng biệt bên trong.

Dự án Ninja Sweet của chúng ta có **2 THÙNG CHỨA**:
1. **Thùng chứa Cơ sở dữ liệu (Database)**: Nơi giữ tài khoản, item, chỉ số nhân vật của người chơi.
2. **Thùng chứa Máy chủ Game (Game Server)**: Nơi chứa trí tuệ của game, xử lý đánh quái, nhặt đồ, di chuyển.

Hai thùng chứa này sẽ tự động được nối mạng nội bộ với nhau!

---

## 📁 2. Giải Thích Từng Thư Mục & File

### 🗄️ Thư mục `database/` (Cơ Sở Dữ Liệu)
Thư mục này dùng để tạo ra máy chủ lưu trữ dữ liệu (MariaDB).
- **`Dockerfile`**: File hướng dẫn Docker cách tạo ra thư mục chứa Database này. Nó bảo Docker hãy dùng hệ điều hành thu nhỏ có sẵn MariaDB.
- **`setup/nsoz.sql`**: Đây là **bản thiết kế** của dữ liệu. Khi Database lần ĐẦU TIÊN được khởi động lên, nó hoàn toàn trống rỗng. Docker sẽ tự động lấy file `nsoz.sql` này để tạo cấu trúc bảng (bảng `User`, bảng `Item`) và điền dữ liệu gốc vào.

*Lưu ý: Dữ liệu thực tế khi người chơi tạo nick (level, đồ) sẽ không lưu vào đây, mà được lưu ra một thư mục ảo tên là `database-data/` xuất hiện khi bạn chạy game, để tránh mất dữ liệu khi tắt máy.*

---

### 🎮 Thư mục `game-server/` (Trái Tim Của Game)
Đây là nơi chứa toàn bộ mã nguồn lập trình game Ninja Sweet bằng ngôn ngữ Java.
- **`src/` (Mã nguồn):** Chứa các file `.java`, chứa tư duy logic của game (ví dụ: đánh quái thì rơi đồ gì, tính sát thương bao nhiêu).
- **`pom.xml` (Hóa đơn nguyên liệu):** Ứng dụng Java cần rất nhiều thư viện ngoài (như thư viện kết nối SQL, thư viện đọc file JSON). File này nói cho chương trình **Maven** biết cần phải tải những thư viện nào từ trên mạng về để ghép lại cùng mã nguồn của bạn.
- **`Dockerfile`:** Rất quan trọng! Quá trình tạo máy chủ Game trải qua 2 bước (Multi-stage build) thay vì 1 bước:
  - *Bước Build:* Nó tạo một cái máy ảo tải Java Maven về, dùng `pom.xml` tải nguyên liệu, rồi đóng gói/nén mã nguồn `src/` của bạn thành 1 tệp tin duy nhất là `Nso-jar-with-dependencies.jar`.
  - *Bước Chạy:* Nó vứt bỏ cỗ máy nặng nề ở bước trên, chỉ lấy dung lượng cực nhẹ gồm cái file `.jar` đó đem sang một máy ảo sạch sẽ khác để chạy tiết kiệm RAM.
- **`entrypoint.sh`:** Tập lệnh mồi. Máy chủ NSO cần các thư mục thiết lập mặt định (`data/` chứa file map, npc...). Tập lệnh này sẽ mồi những file mặc định đó vào cấu hình bên ngoài nếu bạn chưa có.

---

### ⚙️ Thư mục `zzz/` (Cấu Hình Sự Kiện & Data)
Lẽ ra thư mục này nằm chôn sâu trong Game Server, nhưng chúng ta đã móc nó ra ngoài thành công cụ để bạn **ĐIỀU KHIỂN GAME TỪ BÊN NGOÀI**.
Bất chấp việc Game Server (thùng chứa Docker) của bạn bị phá hủy và tạo lại nhiều lần, thì thư mục `zzz/` vẫn ở ngoài máy thực tế không thể mất.
- **`config.properties`:** Nơi bạn chỉnh sửa IP kết nối (`mariadb-nso`), cổng kết nối, hệ số điểm kinh nghiệm (exp), và sự kiện của server. Nếu bạn muốn nhân đôi EXP, bạn chỉ cần sửa ở đây!
- **Các thư mục con khác (`data/`, `res/`,v.v)**: Chứa danh sách kỹ năng, NPC, bản đồ.

---

### 🌐 File `docker-compose.yml` (Nhạc Trưởng)
Đây là "bản phác đồ" cho Docker biết cần tạo các thùng chứa như thế nào để phối hợp chúng lại.
- Trích đoạn `nso-db`: Nó dặn Docker hãy vào thư mục `database/` build thùng chứa CSDL trước, thiết lập mật khẩu `root_password`, tạo database tên là `nso`, và ánh xạ dữ liệu ra `database-data` để không bị mất tài khoản.
- Trích đoạn `nso-server`: Nó dặn Docker hãy vào thư mục `game-server/` build mã nguồn Java, đợi cho Database chạy xong (`depends_on`) thì hãy bật Java lên. Luôn ánh xạ cấu hình `zzz` vào trong container cho phần mềm Java đọc được. Mở khóa cổng kết nối (Port: 14444) để người chơi có thể tải app trên điện thoại/PC kết nối vào IP máy bạn và chơi.

---

### 🚫 File `.gitignore` 
Khi bạn dùng Git để chuẩn bị đưa source code của mình lưu trữ lên GitHub/GitLab. File này là "danh sách đen".
Nó bảo Git rằng: "Ê mầy đừng gửi thư mục `database-data/` chứa data cá nhân của tao lên Github, cũng đừng đưa đống code rác biên dịch Java `target/` nặng nề lên". Nó giữ cho dự án khi gửi lên mạng chỉ chứa *những dòng mã gốc thực sự (thuần khiết nhất)*. 

---
### 🚀 CÁCH KHỞI ĐỘNG NHANH
Mở Terminal, đứng ở thư mục dự án và gõ:
```bash
docker compose up -d --build
```
Hệ thống sẽ tự động lắp ráp và sau vài phút bạn có thể vào game!

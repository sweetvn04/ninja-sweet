# QUY TẮC BẮT BUỘC DÀNH CHO AGENT / AI ASSISTANT - DỰ ÁN NINJA SCHOOL ONLINE

Các quy tắc dưới đây là **QUY TẮC TỐI CAO (HIGHEST PRIORITY RULES)** áp dụng cho toàn bộ mã nguồn trong thư mục `ninja-school/`.

---

### 1. QUY TẮC ĐỌC RULE TRƯỚC KHI HÀNH ĐỘNG & HỎI KHI KHÔNG RÕ
- Agent BẮT BUỘC phải đọc lại và ghi nhớ toàn bộ các quy tắc trong `ninja-school/AGENTS.md` trước khi thực hiện bất kỳ hành động nào.
- Khi thực hiện, nếu có bất kỳ điều gì không rõ ràng, mơ hồ hoặc chưa chắc chắn:
  * Phải dừng lại và hỏi người dùng ngay lập tức. TUYỆT ĐỐI KHÔNG ĐƯỢC TỰ Ý ĐOÁN HOẶC LÀM BỪA.

---

### 2. NGUỒN MÃ NGUỒN DUY NHẤT (SINGLE SOURCE OF TRUTH)
- Mọi chỉnh sửa mã nguồn Server cho Ninja School thực hiện tại:
  `ninja-school/server/`
- Mọi chỉnh sửa Client cho Ninja School thực hiện tại:
  `ninja-school/client/`

---

### 3. THEO DÕI VÀ CẬP NHẬT LỘ TRÌNH (ROADMAP PROGRESS)
- BẮT BUỘC phải duy trì và liên tục cập nhật trạng thái tiến độ vào file:
  `ninja-school/ROADMAP_PROGRESS.md`

---

### 4. QUẢN LÝ PHIÊN BẢN BẰNG GIT (GIT COMMIT TRACKING)
- Server Ninja School được commit tại `ninja-school/server/` (remote `origin/develop` liên kết `git@github.com:sweetvn04/ninja-sweet.git`).
- Client Ninja School được theo dõi tại `ninja-school/client/`.
- Mọi thay đổi hoàn tất phải được commit ngay với message tuân thủ chuẩn Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`).

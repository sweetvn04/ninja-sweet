# ---------- STAGE 1: BUILD MA NGUON ----------
FROM maven:3.9.6-eclipse-temurin-21 AS builder

WORKDIR /build
# Copy file thiết kế pom.xml và thư mục mã nguồn src vào
COPY pom.xml .
COPY src ./src

# Chạy lệnh biên dịch ra file Nso-jar-with-dependencies.jar 
# (Quá trình này sẽ sinh ra thư mục target/ ở trong máy ảo)
RUN mvn clean package -DskipTests

# ---------- STAGE 2: RUN (MÁY CHỦ GAME) ----------
FROM eclipse-temurin:21-jre

# Cài đặt xvfb và các thư viện đồ họa cần thiết
RUN apt-get update && apt-get install -y \
    xvfb \
    libxrender1 \
    libxtst6 \
    libxi6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# CHỈ LẤY lại cục file .jar thành quả từ STAGE 1 ở trên đưa vào đây (giúp Image siêu nhẹ)
COPY --from=builder /build/target/Nso-jar-with-dependencies.jar .

# Copy kịch bản nạp dữ liệu chúng ta mới viết ban nãy
COPY entrypoint.sh .
COPY config.properties ./config.properties
COPY Data ./Data
COPY item_roi ./item_roi

RUN mkdir -p logs && chmod +x entrypoint.sh

EXPOSE 14444

ENTRYPOINT [ "/app/entrypoint.sh" ]

# Sử dụng lệnh chạy trực tiếp qua sh để đảm bảo log không bị nuốt
CMD ["sh", "-c", "xvfb-run --auto-servernum --server-args='-screen 0 1024x768x24' java -Djava.awt.headless=false -server -Dfile.encoding=UTF-8 -Xms512M -Xmx1024M -jar Nso-jar-with-dependencies.jar"]
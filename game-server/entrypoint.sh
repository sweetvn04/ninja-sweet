#!/bin/sh

DATA_DIR="/app/nso_data"

if [ -d "$DATA_DIR" ]; then
    # Nếu chưa có cấu hình bên ngoài, ta copy toàn bộ cấu hình gốc từ image ra ngoài
    if [ ! -f "$DATA_DIR/config.properties" ]; then
        echo "================"
        echo "INITIALIZING NEW VOLUME DATA..."
        echo "================"
        cp /app/config.properties "$DATA_DIR/config.properties"
        cp -r /app/Data "$DATA_DIR/"
        cp -r /app/item_roi "$DATA_DIR/"
        cp -r /app/logs "$DATA_DIR/"
    fi

    # Tạo Symbolic link để Image gọi dữ liệu từ bên ngoài volume
    rm -rf /app/config.properties /app/Data /app/item_roi /app/logs
    
    ln -s "$DATA_DIR/config.properties" /app/config.properties
    ln -s "$DATA_DIR/Data" /app/Data
    ln -s "$DATA_DIR/item_roi" /app/item_roi
    ln -s "$DATA_DIR/logs" /app/logs
fi

# Tiếp tục khởi động CMD của Image
exec "$@"

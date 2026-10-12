#!/bin/bash

# Exit ngay nếu có lệnh bị lỗi
set -e

echo "=== 1. Tạo Custom Bridge Network ==="
docker network create app-net

echo "=== 2. Tạo Named Volume ==="
docker volume create db-data

echo "=== 3. Khởi chạy PostgreSQL Database Container ==="
docker run -d \
  --name db-server \
  --network app-net \
  -v db-data:/var/lib/postgresql/data \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=mypassword \
  -e POSTGRES_DB=mydb \
  postgres:15-alpine

# Chờ 5 giây để PostgreSQL khởi động hoàn tất
sleep 5

echo "=== 4. Khởi chạy Backend Container ==="
# Sử dụng image alpine đơn giản có sẵn ping/curl để test kết nối DNS nội bộ
docker run -d \
  --name app-container \
  --network app-net \
  -e DB_HOST=db-server \
  -e DB_PORT=5432 \
  -e DB_USER=myuser \
  -e DB_PASS=mypassword \
  -e DB_NAME=mydb \
  alpine tail -f /dev/null

echo "=== 5. Test Data Persistence (Tính bền vững dữ liệu) ==="
echo "-> Tạo bảng và thêm dữ liệu mẫu vào db-server..."
docker exec -i db-server psql -U myuser -d mydb -c "CREATE TABLE test_data (id SERIAL PRIMARY KEY, val VARCHAR(50));"
docker exec -i db-server psql -U myuser -d mydb -c "INSERT INTO test_data (val) VALUES ('Persistence Test OK');"

echo "-> Xóa cứng container db-server (docker rm -f)..."
docker rm -f db-server

echo "=== 6. Re-create Database Container mới gắn cùng Volume db-data ==="
docker run -d \
  --name db-server \
  --network app-net \
  -v db-data:/var/lib/postgresql/data \
  -e POSTGRES_USER=myuser \
  -e POSTGRES_PASSWORD=mypassword \
  -e POSTGRES_DB=mydb \
  postgres:15-alpine

sleep 5

echo "-> Kiểm tra dữ liệu trong container db-server mới:"
docker exec -i db-server psql -U myuser -d mydb -c "SELECT * FROM test_data;"

echo "=== HOÀN THÀNH SCRIPT ==="
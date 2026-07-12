# Sử dụng image chính thức của llama.cpp cho server HTTP
FROM ghcr.io/ggml-org/llama.cpp:server

# Thiết lập biến môi trường
ENV PORT=8080
ENV MODEL_URL="https://huggingface.co/unsloth/Phi-4-mini-instruct-GGUF/resolve/main/qwen2.5-1.5b-instruct-q4_k_m.gguf"

# Tải mô hình về khi build hoặc chạy (Ở đây tải trực tiếp bằng curl vào thư mục chứa)
RUN apt-get update && apt-get install -y curl && rm -rf /lib/apt/lists/*
RUN curl -L ${MODEL_URL} -o /model.gguf

# Expose port của Railway
EXPOSE 8080

# Chạy server llama.cpp với giao thức tương thích OpenAI API
CMD ["-m", "/model.gguf", "-c", "2048", "--port", "8080", "--host", "0.0.0.0"]
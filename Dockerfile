# Use CUDA runtime for GPU support
FROM nvidia/cuda:12.2.0-runtime-ubuntu22.04

# Install system dependencies
RUN apt-get update && apt-get install -y \
    python3 python3-pip git ffmpeg curl && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy minimal requirements
COPY requirements.txt .

# Install PyTorch with CUDA 12.1
RUN pip3 install --no-cache-dir torch==2.1.0+cu121 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# Clone HunyuanVideo repo
RUN git clone https://github.com/Tencent-Hunyuan/HunyuanVideo.git ./HunyuanVideo

# Copy your FastAPI app
COPY app.py .

# Expose the port FastAPI will run on
EXPOSE 8000

# Run the FastAPI app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

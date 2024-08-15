# Start from the PyTorch base image
FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel-ubuntu22.04

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    HF_HOME=/workspace/hf_home \
    TRANSFORMERS_CACHE=/workspace/hf_home

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-venv \
    nvidia-cuda-toolkit \
    libgl1-mesa-glx \
    unzip \
    git \
    curl \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set up workspace
WORKDIR /workspace

# Clone SimpleTuner repository
RUN git clone --depth 1 --branch release https://github.com/bghira/SimpleTuner.git

WORKDIR /workspace/SimpleTuner

# Create HF_HOME directory
RUN mkdir -p /workspace/hf_home

# Copy models (if needed)
COPY models/* /workspace/hf_home/models/

# Set up Python environment
RUN python3.11 -m venv .venv \
    && . .venv/bin/activate \
    && pip install --no-cache-dir -U pip poetry \
    && poetry config virtualenvs.create false \
    && poetry install --no-root \
    && pip uninstall -y deepspeed bitsandbytes diffusers \
    && pip install --no-cache-dir git+https://github.com/huggingface/diffusers

# Copy additional files
COPY owo/* .
COPY configs/* ./config/

# Set permissions for start script
RUN chmod +x start.sh

# Set the entrypoint
CMD ["./start.sh"]
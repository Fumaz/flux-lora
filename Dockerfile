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
WORKDIR /usr/src/app

RUN mkdir -p ./configs

# Copy additional files
COPY owo/* .
COPY configs/* ./configs

# Set permissions for start script
RUN chmod +x /usr/src/app/start.sh

# Set the entrypoint
CMD ["/usr/src/app/start.sh"]
FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel-ubuntu22.04

RUN apt-get update && apt-get install -y \
    python3.11 \
    python3.11-venv \
    nvidia-cuda-toolkit \
    libgl1-mesa-glx \
    unzip \
    git \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

RUN git clone --branch=release https://github.com/bghira/SimpleTuner.git

WORKDIR /workspace/SimpleTuner

RUN python3.11 -m venv .venv
RUN source .venv/bin/activate
RUN pip install -U poetry pip openai --no-cache-dir
RUN poetry install --no-root
RUN pip uninstall -y deepspeed bitsandbytes diffusers
RUN pip install -y --no-cache-dir git+https://github.com/huggingface/diffusers

RUN mkdir -p /workspace/hf_home

ENV HF_HOME=/workspace/hf_home
ENV TRANSFORMERS_CACHE=/workspace/hf_home

# Set up HF_TOKEN and WANDB_API_KEY

COPY . .

CMD ["bash", "start.sh"]
source /workspace/SimpleTuner/.venv/bin/activate
python3.11 /usr/src/app/script.py

wget $DATASET_URL -O dataset.zip
unzip -o dataset.zip -d /workspace/SimpleTuner/dataset

cd /workspace/SimpleTuner
export HF_HOME=/workspace/hf_home
export TRANSFORMERS_CACHE=/workspace/hf_home
huggingface-cli login --token $HF_TOKEN
bash train.sh
source /workspace/SimpleTuner/.venv/bin/activate
python3.11 /usr/src/app/script.py

wget $DATASET_URL -O dataset.zip
mkdir -p /usr/src/app/output/dataset
unzip -o dataset.zip -d /usr/src/app/output/dataset
rm -rf /usr/src/app/output/dataset/__MACOSX
ls -la /usr/src/app/output/dataset
mkdir -p /workspace/SimpleTuner/dataset
unzip -o dataset.zip -d /workspace/SimpleTuner/dataset
rm -rf /workspace/SimpleTuner/dataset/__MACOSX

cd /workspace/SimpleTuner
export HF_HOME=/workspace/hf_home
export TRANSFORMERS_CACHE=/workspace/hf_home
huggingface-cli login --token $HF_TOKEN
mkdir -p /root/.cache/huggingface
touch /root/.cache/huggingface/token
echo $HF_TOKEN > /root/.cache/huggingface/token
bash train.sh
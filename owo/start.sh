source /workspace/SimpleTuner/.venv/bin/activate
python3.11 /usr/src/app/script.py

wget $DATASET_URL -O dataset.zip
unzip -o dataset.zip -d /workspace/SimpleTuner/dataset

bash /workspace/SimpleTuner/train.sh
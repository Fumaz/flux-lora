source .venv/bin/activate
python3.11 script.py

wget $DATASET_URL -O dataset.zip
unzip dataset.zip -d dataset

bash train.sh
python3.11 script.py

wget $DATASET_URL -O dataset.zip
unzip dataset.zip

mv dataset/* dataset

bash train.sh
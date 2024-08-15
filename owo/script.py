import os
import re
import shutil

def replace_in_config(config_path):
    patterns = {
        r'export FLUX=.*': 'export FLUX=true',
        r'export MODEL_NAME=.*': 'export MODEL_NAME=black-forest-labs/FLUX.1-dev',
        r'export TRACKER_RUN_NAME=.*': 'export TRACKER_RUN_NAME=docker',
        r'export MAX_NUM_STEPS=.*': 'export MAX_NUM_STEPS=' + os.environ.get('MAX_NUM_STEPS'),
        r'export OUTPUT_DIR=.*': 'export OUTPUT_DIR=/usr/src/app/output/models',
        r'export PUSH_TO_HUB=.*': 'export PUSH_TO_HUB=true',
        r'export TRACKER_PROJECT_NAME=.*': 'export TRACKER_PROJECT_NAME=' + os.environ.get('TRACKER_PROJECT_NAME'),
        r'export HUB_MODEL_NAME=.*': 'export HUB_MODEL_NAME=' + os.environ.get('HUB_MODEL_NAME'),
        r'export VALIDATION_PROMPT=.*': 'export VALIDATION_PROMPT=' + os.environ.get('VALIDATION_PROMPT'),
        r'export VALIDATION_GUIDANCE=.*': 'export VALIDATION_GUIDANCE=3.5',
        r'export VALIDATION_GUIDANCE_REAL=.*': 'export VALIDATION_GUIDANCE_REAL=3.5',
        r'export VALIDATION_NUM_INFERENCE_STEPS=.*': 'export VALIDATION_NUM_INFERENCE_STEPS=28',
        r'export VALIDATION_NEGATIVE_PROMPT=.*': 'export VALIDATION_NEGATIVE_PROMPT=""',
        r'export TRAINING_SEED=.*': 'export TRAINING_SEED=' + os.environ.get('TRAINING_SEED')
    }
    
    with open(config_path, 'r') as f:
        content = f.read()
    
    for pattern, replacement in patterns.items():
        content = re.sub(pattern, replacement, content)
    
    with open(config_path, 'w') as f:
        f.write(content)

def copy_configs(src, dst):
    if not os.path.exists(dst):
        os.makedirs(dst)
    
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.isdir(s):
            copy_configs(s, d)
        else:
            shutil.copy2(s, d)

def main():
    dest_path = '/workspace/SimpleTuner/config'
    configs_path = '/usr/src/app/configs'
    
    copy_configs(configs_path, dest_path)
    
    config_path = '/workspace/SimpleTuner/config/config.env'
    if os.path.exists(config_path):
        replace_in_config(config_path)
        print('Configuration updated successfully.')
    else:
        print('config.env file not found')
        exit(1)

if __name__ == "__main__":
    main()
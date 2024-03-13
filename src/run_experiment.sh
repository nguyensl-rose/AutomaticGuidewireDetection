#export COMET_API_KEY=sRP5pkOCVbBvNJk2kgwOyw9OQ
#export COMET_WORKSPACE=mochaab
#export COMET_PROJECT_NAME=yolov5experiments
#export COMET_AUTO_LOG_GRAPH=True
#export COMET_AUTO_LOG_PARAMETERS=True
#export COMET_AUTO_LOG_HISTOGRAM_WEIGHTS=True
#export COMET_AUTO_LOG_METRICS=True
#export COMET_AUTO_LOG_ENV_DETAILS=True
#export COMET_MAX_IMAGE_PREDICTIONS=200
#export COMET_EVAL_BATCH_LOGGING_INTERVAL=1
#export COMET_EVAL_LOG_CONFUSION_MATRIX=True
#export COMET_MAX_IMAGE_UPLOADS=200
#export COMET_LOG_PREDICTIONS=True
#export COMET_LOGGING_FILE={user}.log

# $bbox_interval=1
# $save_period=1
epoch_clinic=1 #000
epoch_lab=1 #000

# 1. CLINICAL DATA
echo "1. TRAIN ON CLINICAL DATASET"
python yolov5/train.py --img 640 --batch 64 --epochs $epoch_clinic --data "../data/guidewiredetection_clinic.yaml" --weights yolov5s.pt --bbox_interval 1
newest_folder_train=$(ls -lt "../../runs/train/" | grep '^d' | head -n 1 | awk '{print $9}')
echo "Trained weights: $newest_folder_train"

echo "2. VALIDATION ON TEST DATASET"
python yolov5/val.py --weights runs/train/$newest_folder_train/weights/best.pt --data "../data/guidewiredetection_clinic.yaml" --img 640 --task test --conf-thres 0.5 --save-hybrid

echo "3. VALIDATION ON VAL DATASET"
python yolov5/val.py --weights runs/train/$newest_folder_train/weights/best.pt --data "../data/guidewiredetection_clinic.yaml" --img 640 --conf-thres 0.5 --save-hybrid

echo "4. DETECT ON TEST DATASET"
# python detect.py --weights runs/train/$newest_folder_train/weights/best.pt --source '../data/CUSTOM_FLUO_W_BG/images/test/SR_p2_og_hf_vf_rot90_colch_34.png'
python yolov5/detect.py --weights runs/train/$newest_folder_train/weights/best.pt --source '../data/CLINIC_TEST_SR_100/images/'
#python yolov5/detect.py --weights runs/train/$newest_folder_train/weights/best.pt --source '../../data/fluoroscopytestdata/'



# 2. LAB DATA
echo "1. TRAIN ON LAB DATASET"
python yolov5/train.py --img 640 --batch 64 --epochs $epoch_lab --data "../data/guidewiredetection_lab.yaml" --weights yolov5s.pt --bbox_interval 1
newest_folder_train_auto=$(ls -lt "runs/train/" | grep '^d' | head -n 1 | awk '{print $9}')
echo "Trained weights: $newest_folder_train_auto"

echo "2. VALIDATION ON TEST DATASET"
python yolov5/val.py --weights runs/train/$newest_folder_train_auto/weights/best.pt --data "../data/guidewiredetection_lab.yaml" --img 640 --task test --conf-thres 0.5 --save-hybrid

echo "3. VALIDATION ON VAL DATASET"
python yolov5/val.py --weights runs/train/$newest_folder_train_auto/weights/best.pt --data "../data/guidewiredetection_lab.yaml" --img 640 --conf-thres 0.5  --save-hybrid

echo "4. DETECT ON TEST DATASET"
# python detect.py --weights runs/train/$newest_folder_train_auto/weights/best.pt --source '../data/CUSTOM_AUTO_W_BG/images/test/GW_p2_hf_vf_saferot_40.png'
python yolov5/detect.py --weights runs/train/$newest_folder_train_auto/weights/best.pt --source '../data/LAB_TEST_SR_100/images/'
#python yolov5/detect.py --weights runs/train/$newest_folder_train_auto/weights/best.pt --source '../data/fluoroscopytestdata/'
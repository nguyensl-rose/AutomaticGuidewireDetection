A few notes to get started:
- Clone the yolov5 repository (https://github.com/ultralytics/yolov5) into src/yolov5
- Adjust the paths in data/guidewiredetection_clinic.yaml to your training data (or better: create a new yaml file, make sure to change the paths in the `run_experiment.sh` script as well)
- Run the `run_experiment.sh` script for training and validation. Of course, you can also adjust the steps and hyperparameters there.
- This only shows how to work with yolo and how training was done. This is not intended to be used for a final project.
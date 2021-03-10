from imutils import paths
from os import path
from ObjectDetector.ObjectDetector_old import ObjectDetector
from ObjectDetector.ObjectDetector import ObjectDetector
from FaceDetector.FaceDetectorHog import FaceDetectorHoG
from FaceDetector.FaceDetectorDNN import FaceDetectorDNN
from FaceDetector.FaceDetectorHaar import FaceDetectorHaar
from FaceDetector.FaceDetectorMMOD import FaceDetectorMMOD
import argparse
import re
from configparser import ConfigParser
import cv2
import time
import numpy as np
import dlib


# =============================*
# | Convert String to Boolean  |
# *============================*
def _convert_boolean(string):
    if re.match('(y|Y|Yes|yes|True|true)', string):
        return True
    else:
        return False


# ==========================================*
# | Create Object Detector From config.ini  |
# *=========================================*
def create_object_detector():
    config = ConfigParser()
    config.read('Data/Config/detector.ini')
    config = config['object']
    NET = None

    if path.isfile(config['yolo_labels_path']):
        LABELS = open(config['yolo_labels_path']).read().strip().split("\n")
        np.random.seed(42)
        COLORS = np.random.randint(0, 255, size=(len(LABELS), 3), dtype="uint8")
    else:
        raise Exception("Error : LabelPath no such file or directory : {0}".format(config['yolo_labels_path']))

    if path.isfile(config['yolo_weights_path']) and path.isfile(config['yolo_config_path']):
        NET = cv2.dnn.readNetFromDarknet(config['yolo_config_path'], config['yolo_weights_path'])

    elif not path.isfile(config['yolo_weights_path']):
        raise Exception("Error : weightsPath no such file or directory : {0}".format(config['yolo_weights_path']))

    elif not path.isfile(config['yolo_config_path']):
        raise Exception("Error : config_path no such file or directory : {0}".format(config['yolo_config_path']))

    obj = ObjectDetector(float(config['confidence']),
                            float(config['threshold']),
                            [LABELS, COLORS, NET],
                            _convert_boolean(config['yolo_show_percent']),
                            _convert_boolean(config['yolo_override_ZM']),
                            config['detect_pattern'])
    # clean the RAM
    del config
    del LABELS
    del COLORS
    del NET

    return obj


# ========================================*
# | Create Face Detector From config.ini  |
# *=======================================*
def create_face_detector():
    config = ConfigParser()
    config.read('Data/Config/detector.ini')
    config = config['General']
    face_detector = None

    if config['face_detector_process'] == "DNN":
        config = ConfigParser()
        config.read('Data/Config/detector.ini')
        config = config['FaceDetectorDNN']

        if path.isfile(config['modelFile']) and path.isfile(config['configFile']):
            if config['process_model'] == "CAFFE":
                NET = cv2.dnn.readNetFromCaffe(config['configFile'], config['modelFile'])
            else:
                NET = cv2.dnn.readNetFromTensorflow(config['configFile'], config['configFile'])

            face_detector = FaceDetectorDNN(NET, float(config['conf_threshold']))
            del NET
        else:
            if not path.isfile(config['modelFile']):
                raise Exception("[ERROR] No such file or Directory : {0}".format(config['modelFile']))
            elif not path.isfile(config['configFile']):
                raise Exception("[ERROR] No such file or Directory : {0}".format(config['configFile']))

    elif config['face_detector_process'] == "Haar":
        config = ConfigParser()
        config.read('Data/Config/detector.ini')
        config = config['FaceDetectorHaar']

        if path.isfile(config['haarcascade_frontalface_default']):

            face_detector = FaceDetectorHaar(int(config['max_multiscale']),
                                             float(config['min_multiscale']),
                                             cv2.CascadeClassifier(config['haarcascade_frontalface_default']))
        else:
            raise Exception("[ERROR] HaarCasecade Model No such file or Directory : ".format(config['haarcascade_frontalface_default']))

    elif config['face_detector_process'] == "MMOD":
        config = ConfigParser()
        config.read('Data/Config/detector.ini')
        config = config['FaceDetectorMMOD']

        if path.isfile(config['cnn_face_detection_model_v1']):
            face_detector = FaceDetectorMMOD(dlib.cnn_face_detection_model_v1("Data/Model/mmod_human_face_detector.dat"))
        else:
            raise Exception("[ERROR] MMOD Model no such file or directory : ".format(config['cnn_face_detection_model_v1']))

    elif config['face_detector_process'] == "HoG":
        face_detector = FaceDetectorHoG()

    else:
        raise Exception("ERROR No FaceDetector Selected into detector.ini")

    del config
    return face_detector


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument('-p', '--eventpath', help='Path of Events Directory', default='IMAGE_TO_DETECT')
    args, u = ap.parse_known_args()
    args = vars(args)

    config = ConfigParser()
    config.read('Data/Config/detector.ini')
    config = config['General']

    if path.isdir(args['eventpath']):
        images = list(paths.list_images(args['eventpath']))
        cpt = 0
        object_detector = create_object_detector()
        face_detector = create_face_detector()
        if len(images) > 1:
            for image in images:
                start = time.time()
                cpt += 1

                print("\nProcessing Image {0}/{1}".format(cpt, len(images)))
                object_detector.image_path = image
                yolo_result = object_detector.run()

                if yolo_result.find('person') and _convert_boolean(config['use_facial_recognizion']):
                    print("Recognizing Process...")
                    face_detector.image_path = image
                    cv2.imshow("DEBUG", face_detector.detectFace())
                    # TODO RECOGNIZING

                elif yolo_result.find('car') and _convert_boolean(config['use_alpr']):
                    print("CAR AND ALPR")
                    # TODO ALPR RECOGNIZING
                print("Processing Time {0} Seconds".format(round(time.time()-start, 2)))
        else:
            print("No Detect Images")

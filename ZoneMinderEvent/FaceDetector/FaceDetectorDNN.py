import cv2
from configparser import ConfigParser
from os import path


class FaceDetectorDNN:
    def __init__(self, threshold, NET):
        self._net = NET
        self._conf_threshold = threshold
        self.image_path = ""

    # *=======================*
    # |  Detect Face Process  |
    # *=======================*
    def detectFace(self):
        frame = cv2.imread(self.image_path)
        frameOpencvDnn = frame.copy()
        frameHeight = frameOpencvDnn.shape[0]
        frameWidth = frameOpencvDnn.shape[1]
        blob = cv2.dnn.blobFromImage(frameOpencvDnn, 1.0, (300, 300), [104, 117, 123], False, False)

        self._net.setInput(blob)
        detections = self._net.forward()
        bboxes = []
        cv2.putText(frameOpencvDnn, "OpenCV DNN", (10, 50), cv2.FONT_HERSHEY_SIMPLEX, 1.4, (0, 0, 255), 3, cv2.LINE_AA)

        for i in range(detections.shape[2]):
            confidence = detections[0, 0, i, 2]
            if confidence > self._conf_threshold:
                x1 = int(detections[0, 0, i, 3] * frameWidth)
                y1 = int(detections[0, 0, i, 4] * frameHeight)
                x2 = int(detections[0, 0, i, 5] * frameWidth)
                y2 = int(detections[0, 0, i, 6] * frameHeight)
                bboxes.append([x1, y1, x2, y2])
                cv2.rectangle(frameOpencvDnn, (x1, y1), (x2, y2), (0, 255, 0), int(round(frameHeight / 150)), 8)

        # cv2.imshow("DEBUG", frameOpencvDnn)
        # cv2.waitKey(0)

        del frameHeight
        del frameWidth
        del blob
        del detections
        del bboxes

        return frameOpencvDnn

    # *===========================*
    # | cleanning object into RAM |
    # *===========================*
    def cleanning_ram(self):
        del self._net
        del self._conf_threshold
import cv2
from configparser import ConfigParser
from os import path


class FaceDetectorHaar:
    def __init__(self, max_multiscale, min_multiscale, face_cascade):
        self._min_multiscale = min_multiscale
        self._max_multiscale = max_multiscale
        self._faceCascade = face_cascade
        self.image_path = ""

    # *=======================*
    # |  Detect Face Process  |
    # *=======================*
    def detectFace(self, inHeight=300, inWidth=0):
        frame = cv2.imread(self.image_path)
        frameOpenCVHaar = frame.copy()
        frameHeight = frameOpenCVHaar.shape[0]
        frameWidth = frameOpenCVHaar.shape[1]
        if not inWidth:
            inWidth = int((frameWidth / frameHeight) * inHeight)

        scaleHeight = frameHeight / inHeight
        scaleWidth = frameWidth / inWidth

        frameOpenCVHaarSmall = cv2.resize(frameOpenCVHaar, (inWidth, inHeight))
        frameGray = cv2.cvtColor(frameOpenCVHaarSmall, cv2.COLOR_BGR2GRAY)

        faces = self._faceCascade.detectMultiScale(frameGray, self._min_multiscale, self._max_multiscale)

        bboxes = []
        cv2.putText(frameOpenCVHaar, "OpenCV HaarCascade", (10, 50), cv2.FONT_HERSHEY_SIMPLEX, 1.4, (0, 0, 255), 3,
                    cv2.LINE_AA)

        if len(faces) < 1:
            return None
        else:
            for (x, y, w, h) in faces:
                x1 = x
                y1 = y
                x2 = x + w
                y2 = y + h
                cvRect = [int(x1 * scaleWidth), int(y1 * scaleHeight), int(x2 * scaleWidth), int(y2 * scaleHeight)]
                bboxes.append(cvRect)
                cv2.rectangle(frameOpenCVHaar, (cvRect[0], cvRect[1]), (cvRect[2], cvRect[3]), (0, 255, 0),
                              int(round(frameHeight / 150)), 4)

            # cv2.imshow("DEBUG", frameOpenCVHaar)
            # cv2.waitKey(0)

            return frameOpenCVHaar

    # *===============================*
    # |  Put the rectangle with Text  |
    # *===============================*
    def create_rect(self, name, bbox, frame, frameHeight):
        cpt = 0

        for cvRect in bbox:
            cv2.putText(frame, name[cpt], (10, 50), cv2.FONT_HERSHEY_SIMPLEX, 1.4, (0, 0, 255), 3, cv2.LINE_AA)
            cv2.rectangle(frame, (cvRect[0], cvRect[1]), (cvRect[2], cvRect[3]), (0, 255, 0),
                          int(round(frameHeight / 150)), 4)
            cpt += 1

    # *===========================*
    # | cleanning object into RAM |
    # *===========================*
    def cleanning_ram(self):
        del self._faceCascade
        del self._min_multiscale
        del self._max_multiscale

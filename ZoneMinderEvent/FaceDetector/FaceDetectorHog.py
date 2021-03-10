import cv2
import dlib


class FaceDetectorHoG:
    def __init__(self):
        self._hogFaceDetector = dlib.get_frontal_face_detector()
        self.image_path = ""

    def detectFace(self, inHeight=300, inWidth=0):
        frame = cv2.imread(self.image_path)
        frameDlibHog = frame.copy()
        frameHeight = frameDlibHog.shape[0]
        frameWidth = frameDlibHog.shape[1]
        if not inWidth:
            inWidth = int((frameWidth / frameHeight) * inHeight)

        scaleHeight = frameHeight / inHeight
        scaleWidth = frameWidth / inWidth

        frameDlibHogSmall = cv2.resize(frameDlibHog, (inWidth, inHeight))
        frameDlibHogSmall = cv2.cvtColor(frameDlibHogSmall, cv2.COLOR_BGR2RGB)
        faceRects = self._hogFaceDetector(frameDlibHogSmall, 0)

        # print(frameWidth, frameHeight, inWidth, inHeight)

        bboxes = []
        cv2.putText(frameDlibHog, "OpenCV HoG", (10, 50), cv2.FONT_HERSHEY_SIMPLEX, 1.4, (0, 0, 255), 3, cv2.LINE_AA)
        for faceRect in faceRects:
            cvRect = [int(faceRect.left() * scaleWidth), int(faceRect.top() * scaleHeight),
                      int(faceRect.right() * scaleWidth), int(faceRect.bottom() * scaleHeight)]
            bboxes.append(cvRect)
            cv2.rectangle(frameDlibHog, (cvRect[0], cvRect[1]), (cvRect[2], cvRect[3]), (0, 255, 0),
                          int(round(frameHeight / 150)), 4)

        # Cleanning the ram
        del frameHeight
        del frameWidth
        del inWidth
        del inHeight
        del scaleHeight
        del scaleWidth
        del frameDlibHogSmall
        del faceRects
        del bboxes
        return frameDlibHog

    # *===========================*
    # | cleanning object into RAM |
    # *===========================*
    def _cleanning_ram(self):
        del self._hogFaceDetector
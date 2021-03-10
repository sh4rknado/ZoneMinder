from IPCAM_Model.IpcamJennov import Jennov

IPCAM_1 = Jennov("admin", "ss", "10.0.0.200", "WiFi-2.4-A179", "ss")
IPCAM_2 = Jennov("admin", "ss", "10.0.0.201", "WiFi-2.4-A179", "ss")
IPCAM_3 = Jennov("admin", "ss", "10.0.0.202", "WiFi-2.4-A179", "ss")
IPCAM_4 = Jennov("admin", "ss", "10.0.0.203", "WiFi-2.4-A179", "ss")
IPCAM_5 = Jennov("admin", "ss", "10.0.0.204", "WiFi-2.4-A179", "ss")
IPCAM_6 = Jennov("admin", "ss", "192.168.1.200", "WiFi-2.4-A179", "ss")

IPCAM_LIST = [IPCAM_1, IPCAM_2, IPCAM_3, IPCAM_4, IPCAM_5, IPCAM_6]

for ipcam in IPCAM_LIST:
    print(ipcam.Jennov.set_preset("1"))
    print(ipcam.Jennov.goto_preset("1"))

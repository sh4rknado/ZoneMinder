from IPCAM_Model.IpcamGeneric import IPCAM
from IPCAM_Model.WIFI import Wireless


class Jennov:
    def __init__(self, username, password, ip, ssid, wifipass):
        self.Jennov = IPCAM(username, password, ip)
        self.Wifi = Wireless("1", "3", "1", "0", ssid, wifipass)

    def configure_default(self):
        print("\nConfigure Video Settings\n")
        self.Jennov.set_video_config("41", "P", "1", "2")
        print("\nConfigure Image Settings\n")
        self.Jennov.set_img_config("0", "64", "0", "64", "24", "50", "off", "off",
                                   "65535", "off", "off", "30", "4", "64", "1", "1", "0", "0")
        print("\nConfiguration des flux video\n")
        self.Jennov.set_codec_MainStram("8192", "25", "150", "1", "2", "1920", "1080")
        self.Jennov.set_codec_SubStream("6144", "25", "150", "1", "2", "640", "352")

        print("\nConfiguration des Condec Video/Audio\n")
        self.Jennov.set_audio_codec2("1", "1", "g711a")

        print("\nLa Camera va redémarrer afin d'appliquer les changments")
        self.Jennov.reboot()

    def NetworkConfiguration(self, netmask, gateway, dns1, mac, TypeConnex):
        print("\nConfiguration d'une IP statique\n")
        self.Jennov.set_network_infos("off", self.Jennov.ip, netmask, gateway, "0", dns1, "1.1.1.1", mac, TypeConnex)

    def WireLessConnection(self):
        print("\nConfiguration du WiFi\n")
        self.Jennov.set_wifi(self.Wifi.wifi_enable, self.Wifi.wifi_mode_auth, self.Wifi.wifi_encoder,
                             self.Wifi.wifi_mode, self.Wifi.wifi_ssid, self.Wifi.wifi_passwd)

# -*- coding: utf-8 -*-


class Wireless:
    def __init__(self, wifi_enable, wifi_mode_auth, wifi_encoder, wifi_mode, wifi_ssid, wifi_passwd):
            # wifi_enable
            # 0 : DISABLE
            # 1 : ENABLE
            self.wifi_enable = wifi_enable

            # WIFI Encryption
            # 0: None
            # 1: WEP
            # 2: WPA-PSK
            # 3: WPA2-PSK
            self.wifi_mode_auth = wifi_mode_auth

            # WIFI (ECODER) Key type
            # 0: TKIP
            # 1: AES
            self.wifi_encoder = wifi_encoder

            # WIFI Connection mode:
            # 0: Route mode (default)
            # 1: Peer to peer mode
            self.wifi_mode = wifi_mode

            # Wifi Name
            self.wifi_ssid = wifi_ssid

            # Wifi Password
            self.wifi_passwd = wifi_passwd

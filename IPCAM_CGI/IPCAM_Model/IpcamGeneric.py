# -*- coding: utf-8 -*-

import os


class IPCAM:
	def __init__(self, username_param, password, ip):
		self.username = username_param
		self.password = password
		self.ip = ip
		self.path = "curl --url " + '"' + "http://" + self.username + ":" + self.password + "@" + self.ip + "/cgi-bin/hi3510/"

	# ------------------ < SDCARD Manager > -----------------
	def sdcard_format(self):
		os.system(self.path + "sdfrmt.cgi" + '"')

	def sdcard_disable(self):
		os.system(self.path + "sdstop.cgi" + '"')

	# ------------------ < IPCAM MANAGER  > -----------------
	def reset(self):
		os.system(self.path + "sysreset.cgi" + '"')

	def reboot(self):
		os.system(self.path + "sysreboot.cgi" + '"')

	def backup(self):
		os.system(self.path + "backup.cgi" + '"')

	def get_infos(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getserverinfo" + '"')
		return infos_cam

	# ------------------ < INFRAROUGE CONTROL > -----------------

	def get_infrared(self):
		infrared = os.system(self.path + "param.cgi?cmd=getinfrared" + '"')
		return infrared

	def set_infrared(self, state):  # auto / open / close
		os.system(self.path + "param.cgi?cmd=setinfrared&-infraredstat=" + state + '"')

	# ------------------ < PTZ CONTROL  > -----------------

	# PRESET
	def set_preset(self, nb_preset):  # 1 ->
		os.system(self.path + "preset.cgi?-act=set&-status=1&-number=" + nb_preset + '"')

	def goto_preset(self, nb_preset):  # nb_preset : number mapping
		os.system(self.path + "preset.cgi?-act=goto&-number=" + nb_preset + '"')

	# MOVE
	def move(self, direction, speed, continuous):
		os.system(self.path + "ptzctrl.cgi?-step=" + continuous + "&-act=" + direction + "&-speed=" + speed + '"')

	# direction : up/down/left/right
	# speed 1 - 65
	# continous : 0=enable | 1 disable

	# ZOOM
	def zoom_out(self):
		os.system(self.path + "ptzzoomout.cgi" + '"')

	def zoom_in(self):
		os.system(self.path + "ptzzoomin.cgi" + '"')

	# PTZ Mobile
	def mobile_move(self, direction):

		switcher = {
			"up": "ptzup.cgi",
			"down": "ptzdown.cgi",
			"left": "ptzleft.cgi",
			"right": "ptzright.cgi",
		}

		os.system(self.path + switcher.get(direction, "") + '"')

	# ------------------ < WIFI MANAGER  > -----------------
	def get_wifi(self):
		wifi_settings = os.system(self.path + "param.cgi?cmd=getwirelessattr" + '"')
		return wifi_settings

	def search_wifi(self):
		search_wifi = os.system(self.path + "param.cgi?cmd=searchwireless" + '"')
		return search_wifi

	# IF WIFI IS ALLREADY ETABLISHED => ERROR NETWORK
	def check_wifi(self, wifi_ssid, wifi_auth, wifi_password, wifi_encoder, wifi_mode):
		wifi_path = self.path + "param.cgi?cmd=chkwirelessattr&" + "-wf_ssid=" + wifi_ssid + "&-wf_auth="
		wifi_path2 = wifi_auth + "&-wf_key=" + wifi_password + "&-wf_enc=" + wifi_encoder + "&-wf_mode=" + wifi_mode + '"'
		wifi_handshake = os.system(wifi_path + wifi_path2)
		return wifi_handshake

	def set_wifi(self, wifi_ssid, wifi_auth, wifi_password, wifi_encoder, wifi_mode, wifi_enable):
		wifi_path = "-wf_ssid=" + wifi_ssid + "&-wf_enable=" + wifi_enable + "&-wf_auth=" + wifi_auth + "&-wf_key="
		wifi_path2 = wifi_password + "&-wf_enc=" + wifi_encoder +"&-wf_mode=" + wifi_mode + '"'
		wifi_setting = os.system(self.path + "param.cgi?cmd=setwirelessattr&" + wifi_path + wifi_path2)
		return wifi_setting

	# ------------------ < Audio / Video Manager > -----------------
	# Video Config
	def get_video_config(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getvideoattr" + '"')
		return infos_cam

	# default videomode=41 / vinorm=P / profile=1 / maxchan=2
	def set_video_config(self, videomode, vinorm, profile, maxchn):
		infos_cam = os.system(self.path + "param.cgi?cmd=setvideoattr" + "&-videomode=" + videomode + "&-vinorm=" + vinorm +"&-profile=" + profile + "&-maxchn=" + maxchn + '"')
		return infos_cam

	# Video CODEC CONFIG
	def get_codec(self, channel):  # ch=11 MainStream 1920*1080 / ch=12 SubStream 640*352
		infos_cam = os.system(self.path + "getvencattr.cgi?-chn=" + channel + '"')
		return infos_cam

	def set_codec_MainStram(self, bps_1, fps_1, gop_1,  brmode_1, imagegrade_1, width_1, height_1):
		codec_string = "-chn=11" + "&-bps_1=" + bps_1 + "&-fps_1=" + fps_1 + "&-gop_1=" + gop_1 + "&-brmode_1=" + brmode_1
		codec_string2 = "&-imagegrade_1=" + imagegrade_1 + "&-width_1=" + width_1 + "&-height_1=" + height_1
		os.system(self.path + "param.cgi?cmd=setvencattr&" + codec_string + codec_string2 + '"')

	def set_codec_SubStream(self, bps_2, fps_2, gop_2,  brmode_2, imagegrade_2, width_2, height_2):
		codec_string = "-chn=11" + "&-bps_2=" + bps_2 + "&-fps_2=" + fps_2 + "&-gop_2=" + gop_2 + "&-brmode_2=" + brmode_2
		codec_string2 = "&-imagegrade_2=" + imagegrade_2 + "&-width_2=" + width_2 + "&-height_2=" + height_2
		os.system(self.path + "param.cgi?cmd=setvencattr&" + codec_string + codec_string2 + '"')

	# IMG CONFIG
	def get_img_config(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getimageattr" + '"')
		return infos_cam

	def set_img_config(self, display_mode, brightness, saturation, sharpness, contrast, hue, wdr, night, shutter, flip, mirror, gc, ae, targety, noise, gamma, aemode, imgmode):
		img_config1 = "param.cgi?cmd=setimageattr" + "&-display_mode=" + display_mode + "&-brightness=" + brightness
		img_config2 = "&-saturation=" + saturation + "&-sharpness=" + sharpness + "&-contrast=" + contrast + "&-hue=" + hue
		img_config3 = "&-wdr=" + wdr + "&-night=" + night + "&-shutter=" + shutter + "&-flip=" + flip + "&-mirror=" + mirror
		img_config4 = "&-gc=" + gc + "&-ae=" + ae + "&-targety=" + targety + "&-noise=" + noise + "&-gamma=" + gamma
		img_config5 = "&-aemode=" + aemode + "&-imgmode=" + imgmode
		infos_cam = os.system(self.path + img_config1 + img_config2 + img_config3 + img_config4 + img_config5 + '"')
		return infos_cam

	# OSD CONFIG
	def get_osd(self, region):
		osd_config = "param.cgi?cmd=getoverlayattr&-region=" + region
		infos_cam = os.system(self.path + osd_config + '"')
		return infos_cam

	def set_od_geo(self, place_0, x_0, y_0, name_0):
		osd_config = place_0 + "&-x_0=" + x_0 + "&-y_0=" + y_0 + "&-name_0=" + name_0
		infos_cam = os.system(self.path + "param.cgi?cmd=setoverlayattr&-place_0=" + osd_config + '"')
		return infos_cam

	def set_od_name(self, place_1, x_1, y_1, name_1):
		osd_config = place_1 + "&-x_1=" + x_1 + "&-y_1=" + y_1 + "&-name_1=" + name_1
		infos_cam = os.system(self.path + "param.cgi?cmd=setoverlayattr&-place_1=" + osd_config + '"')
		return infos_cam

	# Mobile SnapShot
	def get_snap_mobile(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getmobilesnapattr" + '"')
		return infos_cam

	def set_snap_mobile(self, msize):  # SubStream msize= 1MaxResol | 2MinResol
		infos_cam = os.system(self.path + "param.cgi?cmd=setmobilesnapattr&-msize=" + msize + '"')
		return infos_cam

	# Audio Codec
	def get_audio_codec(self, channel):
		infos_cam = os.system(self.path + "param.cgi?cmd=getaencattr&-chn=" + channel + '"')
		return infos_cam

	def set_audio_codec(self, channel, aeswitch):
		infos_cam = os.system(self.path + "param.cgi?cmd=setaencattr&-chn=" + channel + "&-aeswitch=" + aeswitch + '"')
		return infos_cam

	def set_audio_codec2(self, channel, aeswitch, aeformat):
		audio_config = "param.cgi?cmd=setaencattr&-chn=" + channel + "&-aeswitch=" + aeswitch + "&-aeformat=" + aeformat
		infos_cam = os.system(self.path + audio_config + '"')
		return infos_cam

	# AUDIO INPUT
	def get_audio_input(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getaudioinvolume" + '"')
		return infos_cam

	def set_audio_input(self, volin_type, volume, aec, denoise):
		audio_config = volin_type + "&-volume=" + volume + "&-aec=" + aec + "&-denoise=" + denoise
		infos_cam = os.system(self.path + "param.cgi?cmd=setaudioinvolume&-volin_type=" + audio_config + '"')
		return infos_cam

	# ------------------ < END Audio / Video Manager > -----------------

	# ------------------ < Network Manager > -----------------

	def get_network_infos(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getnetattr" + '"')
		return infos_cam

	def set_network_infos(self, dhcp, ip, netmask, gateway, dnsstatus, primarydns, secondarydns, mac, networktype):
		network_infos = "param.cgi?cmd=setnetattr&-dhcpflag==" + dhcp + "&-ip=" + ip + "&-netmask=" + netmask + "&-gateway="
		network_infos2 = gateway + "&-dnsstat=" + dnsstatus + "&-fdnsip=" + primarydns + "&-sdnsip=" + secondarydns
		network_infos3 = "&-macaddress=" + mac + "&-networktype=" + networktype
		infos_cam = os.system(self.path + network_infos + network_infos2 + network_infos3 + '"')
		return infos_cam

	# HTTP PORT
	def get_http(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=gethttpport" + '"')
		return infos_cam

	def set_http(self, port):
		infos_cam = os.system(self.path + "param.cgi?cmd=sethttpport&-httpport=" + port + '"')
		return infos_cam

	# RTSP PORT
	def get_rtsp(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getrtspport" + '"')
		return infos_cam

	def set_rtsp(self, port):
		infos_cam = os.system(self.path + "param.cgi[?cmd=setrtspport&-rtspport=" + port + '"')
		return infos_cam

	#  INTERNAL IP
	def get_ip(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getinternetip" + '"')
		return infos_cam

	# UPNP (PORT MAP)
	def get_upnp(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getupnpattr" + '"')
		return infos_cam

	def set_upnp(self, upnp):
		infos_cam = os.system(self.path + "param.cgi?cmd=setupnpattr&-upm_enable=" + upnp + '"')
		return infos_cam

	# DDNS
	def get_ddns(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=get3thddnsattr" + '"')
		return infos_cam

	def set_ddns(self, ddns_enable, ddns_service, ddns_uname, ddns_passwd, ddns_domain):
		ddns_config = "param.cgi?cmd=set3thddnsattr&-d3th_enable=" + ddns_enable + "&-d3th_service=" + ddns_service
		ddns_config1 = "&-d3th_uname=" + ddns_uname + "&-d3th_passwd=" + ddns_passwd + "&-d3th_domain=" + ddns_domain
		infos_cam = os.system(self.path + ddns_config + ddns_config1 + '"')
		return infos_cam

	# ------------------ < END Network Manager > -----------------

	# ------------------ <  PROTOCOL Manager  > -----------------

	# FTP PROTOCOL
	def get_ftp(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getftpattr" + '"')
		return infos_cam

	def set_ftp(self, ftp_ip, ftp_port, ftp_user, ftp_password, ftp_mode, ftp_directory):
		ftp_config = "param.cgi?cmd=setftpattr&-ft_server=" + ftp_ip + "&-ft_port=" + ftp_port + "&-ft_username=" + ftp_user
		ftp_config1 = "&-ft_password=" + ftp_password + "&-ft_mode=" + ftp_mode + "&-ft_dirname=" + ftp_directory
		infos_cam = os.system(self.path + ftp_config + ftp_config1 + '"')
		return infos_cam

	# SMTP PROTOCOL
	def get_smtp(self):
		infos_cam = os.system(self.path + "param.cgi?cmd=getsmtpattr" + '"')
		return infos_cam

	def set_smtp(self, smtp_server, smtp_from, smtp_to, subject, text, login_type, password, port, ssl):
		smtp_config = "param.cgi?cmd=setsmtpattr&-ma_server=" + smtp_server + "&-ma_from=" + smtp_from + "&-ma_to=" + smtp_to
		smtp_config1 = "&-ma_subject=" + subject + "&-ma_text=" + text + "&-ma_logintype=" + login_type + "&-ma_username="
		smtp_config2 = "&-ma_password=" + password + "&-ma_port=" + port + "&-ma_ssl=" + ssl
		infos_cam = os.system(self.path + smtp_config + smtp_config1 + smtp_config2 + '"')
		return infos_cam

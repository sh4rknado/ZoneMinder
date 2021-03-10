-- MariaDB dump 10.17  Distrib 10.5.5-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: zm
-- ------------------------------------------------------
-- Server version	10.5.5-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES latin1 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Config`
--

DROP TABLE IF EXISTS `Config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Config` (
  `Id` smallint(5) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(32) NOT NULL DEFAULT '',
  `Value` text NOT NULL,
  `Type` tinytext NOT NULL,
  `DefaultValue` text DEFAULT NULL,
  `Hint` tinytext DEFAULT NULL,
  `Pattern` tinytext DEFAULT NULL,
  `Format` tinytext DEFAULT NULL,
  `Prompt` tinytext DEFAULT NULL,
  `Help` text DEFAULT NULL,
  `Category` varchar(32) NOT NULL DEFAULT '',
  `Readonly` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Requires` text DEFAULT NULL,
  PRIMARY KEY (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Config`
--

LOCK TABLES `Config` WRITE;
/*!40000 ALTER TABLE `Config` DISABLE KEYS */;
INSERT INTO `Config` VALUES (21,'ZM_ADD_JPEG_COMMENTS','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Add jpeg timestamp annotations as file header comments','\n      JPEG files may have a number of extra fields added to the file\n      header. The comment field may have any kind of text added. This\n      options allows you to have the same text that is used to\n      annotate the image additionally included as a file header\n      comment. If you archive event images to other locations this\n      may help you locate images for particular events or times if\n      you use software that can read comment headers.\n      ','images',0,''),(138,'ZM_AUDIT_CHECK_INTERVAL','900','integer','900','integer','(?^:^(d+)$)',' $1 ','How often to check database and filesystem consistency','\n      The zmaudit daemon exists to check that the saved information\n      in the database and on the filesystem match and are consistent\n      with each other. If an error occurs or if you are using \'fast\n      deletes\' it may be that database records are deleted but files\n      remain. In this case, and similar, zmaudit will remove\n      redundant information to synchronise the two data stores. The\n      default check interval of 900 seconds (15 minutes) is fine for\n      most systems however if you have a very large number of events\n      the process of scanning the database and filesystem may take a\n      long time and impact performance. In this case you may prefer\n      to make this interval much larger to reduce the impact on your\n      system. This option determines how often these checks are\n      performed.\n      ','system',0,''),(139,'ZM_AUDIT_MIN_AGE','86400','integer','86400','integer','(?^:^(d+)$)',' $1 ','The minimum age in seconds event data must be in order to be deleted.','\n      The zmaudit daemon exists to check that the saved information\n      in the database and on the filesystem match and are consistent\n      with each other. Event files or db records that are younger than\n      this setting will not be deleted and a warning will be given.\n      ','system',0,''),(8,'ZM_AUTH_HASH_IPS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Include IP addresses in the authentication hash','\n      When ZoneMinder is running in hashed authenticated mode it can\n      optionally include the requesting IP address in the resultant\n      hash. This adds an extra level of security as only requests\n      from that address may use that authentication key. However in\n      some circumstances, such as access over mobile networks, the\n      requesting address can change for each request which will cause\n      most requests to fail. This option allows you to control\n      whether IP addresses are included in the authentication hash on\n      your system. If you experience intermitent problems with\n      authentication, switching this option off may help.\n      ','system',0,'ZM_OPT_USE_AUTH=1;ZM_AUTH_RELAY=hashed'),(10,'ZM_AUTH_HASH_LOGINS','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Allow login by authentication hash','\n      The normal process for logging into ZoneMinder is via the login\n      screen with username and password. In some circumstances it may\n      be desirable to allow access directly to one or more pages, for\n      instance from a third party application. If this option is\n      enabled then adding an \'auth\' parameter to any request will\n      include a shortcut login bypassing the login screen, if not\n      already logged in. As authentication hashes are time and,\n      optionally, IP limited this can allow short-term access to\n      ZoneMinder screens from other web pages etc. In order to use\n      this the calling application will have to generate the\n      authentication hash itself and ensure it is valid. If you use\n      this option you should ensure that you have modified the\n      ZM_AUTH_HASH_SECRET to something unique to your system.\n      ','system',0,'ZM_OPT_USE_AUTH=1;ZM_AUTH_RELAY=hashed'),(7,'ZM_AUTH_HASH_SECRET','...Change me to something unique...','string','...Change me to something unique...','string','(?^:^(.+)$)',' $1 ','Secret for encoding hashed authentication information','\n      When ZoneMinder is running in hashed authenticated mode it is\n      necessary to generate hashed strings containing encrypted\n      sensitive information such as usernames and password. Although\n      these string are reasonably secure the addition of a random\n      secret increases security substantially.\n      ','system',0,'ZM_OPT_USE_AUTH=1;ZM_AUTH_RELAY=hashed'),(9,'ZM_AUTH_HASH_TTL','2','integer','2','integer','(?^:^(d+)$)',' $1 ','The number of hours that an authentication hash is valid for.','\n      The default has traditionally been 2 hours. A new hash will\n      automatically be regenerated at half this value.\n      ','system',0,'ZM_OPT_USE_AUTH=1;ZM_AUTH_RELAY=hashed'),(6,'ZM_AUTH_RELAY','hashed','string','hashed','hashed|plain|none','(?^i:^([hpn]))',' ($1 =~ /^h/) ? \'hashed\' : ($1 =~ /^p/ ? \'plain\' : \'none\' ) ','Method used to relay authentication information','\n      When ZoneMinder is running in authenticated mode it can pass\n      user details between the web pages and the back end processes.\n      There are two methods for doing this. This first is to use a\n      time limited hashed string which contains no direct username or\n      password details, the second method is to pass the username and\n      passwords around in plaintext. This method is not recommend\n      except where you do not have the md5 libraries available on\n      your system or you have a completely isolated system with no\n      external access. You can also switch off authentication\n      relaying if your system is isolated in other ways.\n      ','system',0,'ZM_OPT_USE_AUTH=1'),(5,'ZM_AUTH_TYPE','builtin','string','builtin','builtin|remote','(?^i:^([br]))',' $1 =~ /^b/ ? \'builtin\' : \'remote\' ','What is used to authenticate ZoneMinder users','\n      ZoneMinder can use two methods to authenticate users when\n      running in authenticated mode. The first is a builtin method\n      where ZoneMinder provides facilities for users to log in and\n      maintains track of their identity. The second method allows\n      interworking with other methods such as http basic\n      authentication which passes an independently authentication\n      \'remote\' user via http. In this case ZoneMinder would use the\n      supplied user without additional authentication provided such a\n      user is configured ion ZoneMinder.\n      ','system',0,'ZM_OPT_USE_AUTH=1'),(2,'ZM_BANDWIDTH_DEFAULT','high','string','high','string','(?^:^(.+)$)',' $1 ','Default setting for bandwidth profile used by web interface','The classic skin for ZoneMinder has different\n      profiles to use for low, medium, or high bandwidth connections.\n      ','system',0,''),(141,'ZM_BULK_FRAME_INTERVAL','100','integer','100','integer','(?^:^(d+)$)',' $1 ','How often a bulk frame should be written to the database','\n      Traditionally ZoneMinder writes an entry into the Frames\n      database table for each frame that is captured and saved. This\n      works well in motion detection scenarios but when in a DVR\n      situation (\'Record\' or \'Mocord\' mode) this results in a huge\n      number of frame writes and a lot of database and disk bandwidth\n      for very little additional information. Setting this to a\n      non-zero value will enabled ZoneMinder to group these non-alarm\n      frames into one \'bulk\' frame entry which saves a lot of\n      bandwidth and space. The only disadvantage of this is that\n      timing information for individual frames is lost but in\n      constant frame rate situations this is usually not significant.\n      This setting is ignored in Modect mode and individual frames\n      are still written if an alarm occurs in Mocord mode also.\n      ','config',0,''),(94,'ZM_CAPTURES_PER_FRAME','1','integer','1','integer','(?^:^(d+)$)',' $1 ','How many images are captured per returned frame, for shared local cameras','\n      If you are using cameras attached to a video capture card which\n      forces multiple inputs to share one capture chip, it can\n      sometimes produce images with interlaced frames reversed\n      resulting in poor image quality and a distinctive comb edge\n      appearance. Increasing this setting allows you to force\n      additional image captures before one is selected as the\n      captured frame. This allows the capture hardware to \'settle\n      down\' and produce better quality images at the price of lesser\n      capture rates. This option has no effect on (a) network\n      cameras, or (b) where multiple inputs do not share a capture\n      chip. This option addresses a similar problem to the\n      ZM_V4L_MULTI_BUFFER option and you should normally change the\n      value of only one of the options at a time.  If you have\n      different capture cards that need different values you can\n      override them in each individual monitor on the source page.\n      ','config',0,''),(151,'ZM_CHECK_FOR_UPDATES','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Check with zoneminder.com for updated versions','\n      From ZoneMinder version 1.17.0 onwards new versions are\n      expected to be more frequent. To save checking manually for\n      each new version ZoneMinder can check with the zoneminder.com\n      website to determine the most recent release. These checks are\n      infrequent, about once per week, and no personal or system\n      information is transmitted other than your current version\n      number. If you do not wish these checks to take place or your\n      ZoneMinder system has no internet access you can switch these\n      check off with this configuration variable\n      ','system',0,''),(20,'ZM_COLOUR_JPEG_FILES','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Colourise greyscale JPEG files','\n      Cameras that capture in greyscale can write their captured\n      images to jpeg files with a corresponding greyscale colour\n      space. This saves a small amount of disk space over colour\n      ones. However some tools such as ffmpeg either fail to work\n      with this colour space or have to convert it beforehand.\n      Setting this option to yes uses up a little more space but\n      makes creation of MPEG files much faster.\n      ','images',0,''),(228,'ZM_COOKIE_LIFETIME','3600','integer','3600','integer','(?^:^(d+)$)',' $1 ','The maximum life of a COOKIE used when setting up PHP\'s session handler.','This will affect how long a session will be valid for since the last request.  Keeping this short helps prevent session hijacking.  Keeping it long allows you to stay logged in longer without refreshing the view.','system',0,''),(36,'ZM_CPU_EXTENSIONS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Use advanced CPU extensions to increase performance','\n      When advanced processor extensions such as SSE2 or SSSE3 are\n      available, ZoneMinder can use them, which should increase\n      performance and reduce system load. Enabling this option on\n      processors that do not support the advanced processors\n      extensions used by ZoneMinder is harmless and will have no\n      effect.\n      ','config',0,''),(144,'ZM_CREATE_ANALYSIS_IMAGES','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Create analysed alarm images with motion outlined','\n      By default during an alarm ZoneMinder records both the raw\n      captured image and one that has been analysed and had areas\n      where motion was detected outlined. This can be very useful\n      during zone configuration or in analysing why events occurred.\n      However it also incurs some overhead and in a stable system may\n      no longer be necessary. This parameter allows you to switch the\n      generation of these images off.\n      ','config',0,''),(152,'ZM_CSP_REPORT_URI','','string','','http://host.your.domain/','(?^:^(?:http://)?(.+)$)',' \'http://\'.$1 ','URI to report unsafe inline javascript violations to','\n    See https://en.wikipedia.org/wiki/Content_Security_Policy for more information.  When the browser detects unsafe inline javascript it will report it to this url, which may warn you of malicious attacks on your ZoneMinder install.','system',0,''),(1,'ZM_CSS_DEFAULT','base','string','base','string','(?^:^(.+)$)',' $1 ','Default set of css files used by web interface','\n      ZoneMinder allows the use of many different web interfaces, and\n      some skins allow the use of different set of CSS files to\n      control the appearance. This option allows you to set the\n      default set of css files used by the website.  Users can change\n      their css later, this merely sets the default.\n      ','system',0,''),(147,'ZM_DEFAULT_ASPECT_RATIO','4:3','string','4:3','string','(?^:^(.+)$)',' $1 ','The default width:height aspect ratio used in monitors','\n      When specifying the dimensions of monitors you can click a\n      checkbox to ensure that the width stays in the correct ratio to\n      the height, or vice versa. This setting allows you to indicate\n      what the ratio of these settings should be. This should be\n      specified in the format <width value>:<height value> and the\n      default of 4:3 normally be acceptable but 11:9 is another\n      common setting. If the checkbox is not clicked when specifying\n      monitor dimensions this setting has no effect.\n      ','config',0,''),(73,'ZM_DUMP_CORES','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Create core files on unexpected process failure.','\n      When an unrecoverable error occurs in a ZoneMinder binary\n      process is has traditionally been trapped and the details\n      written to logs to aid in remote analysis. However in some\n      cases it is easier to diagnose the error if a core file, which\n      is a memory dump of the process at the time of the error, is\n      created. This can be interactively analysed in the debugger and\n      may reveal more or better information than that available from\n      the logs. This option is recommended for advanced users only\n      otherwise leave at the default. Note using this option to\n      trigger core files will mean that there will be no indication\n      in the binary logs that a process has died, they will just\n      stop, however the zmdc log will still contain an entry. Also\n      note that you may have to explicitly enable core file creation\n      on your system via the \'ulimit -c\' command or other means\n      otherwise no file will be created regardless of the value of\n      this option.\n      ','logging',0,''),(219,'ZM_DYN_CURR_VERSION','1.34.20','string','1.34.20','string','(?^:^(.+)$)',' $1 ','\n      What the effective current version of ZoneMinder is, might be\n      different from actual if versions ignored\n      ','','dynamic',1,''),(220,'ZM_DYN_DB_VERSION','1.34.20','string','1.34.20','string','(?^:^(.+)$)',' $1 ','What the version of the database is, from zmupdate','','dynamic',1,''),(223,'ZM_DYN_DONATE_REMINDER_TIME','1601921653','integer','0','integer','(?^:^(d+)$)',' $1 ','When the earliest time to remind about donations will be','','dynamic',1,''),(221,'ZM_DYN_LAST_CHECK','1599329235','integer','','integer','(?^:^(d+)$)',' $1 ','When the last check for version from zoneminder.com was','','dynamic',1,''),(218,'ZM_DYN_LAST_VERSION','1.34.16','string','','string','(?^:^(.+)$)',' $1 ','What the last version of ZoneMinder recorded from zoneminder.com is','','dynamic',1,''),(222,'ZM_DYN_NEXT_REMINDER','','string','','string','(?^:^(.+)$)',' $1 ','When the earliest time to remind about versions will be','','dynamic',1,''),(224,'ZM_DYN_SHOW_DONATE_REMINDER','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Remind about donations or not','','dynamic',1,''),(120,'ZM_EMAIL_ADDRESS','','string','','your.name@your.domain','(?^:^([a-zA-Z0-9_.-]+)@([a-zA-Z0-9_.-]+)$)',' $1@$2 ','The email address to send matching event details to','\n      This option is used to define the email address that any events\n      that match the appropriate filters will be sent to.\n      ','mail',0,'ZM_OPT_EMAIL=1'),(123,'ZM_EMAIL_BODY','\n      Hello,\n\n    An alarm has been detected on your installation of the ZoneMinder.\n\n      The details are as follows :-\n\n      Monitor  : %MN%\n      Event Id : %EI%\n      Length   : %EL%\n      Frames   : %EF% (%EFA%)\n      Scores   : t%EST% m%ESM% a%ESA%\n\n      This alarm was matched by the %FN% filter and can be viewed at %EPS%\n\n      ZoneMinder','text','\n      Hello,\n\n    An alarm has been detected on your installation of the ZoneMinder.\n\n      The details are as follows :-\n\n      Monitor  : %MN%\n      Event Id : %EI%\n      Length   : %EL%\n      Frames   : %EF% (%EFA%)\n      Scores   : t%EST% m%ESM% a%ESA%\n\n      This alarm was matched by the %FN% filter and can be viewed at %EPS%\n\n      ZoneMinder','free text','(?^:^(.+)$)',' $1 ','The body of the email used to send matching event details','\n      This option is used to define the content of the email that is\n      sent for any events that match the appropriate filters.\n      ','mail',0,'ZM_OPT_EMAIL=1'),(130,'ZM_EMAIL_HOST','localhost','string','localhost','host.your.domain','(?^:^([a-zA-Z0-9_.-]+)$)',' $1 ','The host address of your SMTP mail server','\n      If you have chosen SMTP as the method by which to send\n      notification emails or messages then this option allows you to\n      choose which SMTP server to use to send them. The default of\n      localhost may work if you have the sendmail, exim or a similar\n      daemon running however you may wish to enter your ISP\'s SMTP\n      mail server here.\n      ','mail',0,'ZM_OPT_EMAIL=1;ZM_OPT_MESSAGE=1'),(122,'ZM_EMAIL_SUBJECT','ZoneMinder: Alarm - %MN%-%EI% (%ESM% - %ESA% %EFA%)','string','ZoneMinder: Alarm - %MN%-%EI% (%ESM% - %ESA% %EFA%)','string','(?^:^(.+)$)',' $1 ','The subject of the email used to send matching event details','\n      This option is used to define the subject of the email that is\n      sent for any events that match the appropriate filters.\n      ','mail',0,'ZM_OPT_EMAIL=1'),(121,'ZM_EMAIL_TEXT','subject = \"ZoneMinder: Alarm - %MN%-%EI% (%ESM% - %ESA% %EFA%)\"\n      body = \"\n      Hello,\n\n    An alarm has been detected on your installation of the ZoneMinder.\n\n      The details are as follows :-\n\n      Monitor  : %MN%\n      Event Id : %EI%\n      Length   : %EL%\n      Frames   : %EF% (%EFA%)\n      Scores   : t%EST% m%ESM% a%ESA%\n\n      This alarm was matched by the %FN% filter and can be viewed at %EPS%\n\n      ZoneMinder\"','text','subject = \"ZoneMinder: Alarm - %MN%-%EI% (%ESM% - %ESA% %EFA%)\"\n      body = \"\n      Hello,\n\n    An alarm has been detected on your installation of the ZoneMinder.\n\n      The details are as follows :-\n\n      Monitor  : %MN%\n      Event Id : %EI%\n      Length   : %EL%\n      Frames   : %EF% (%EFA%)\n      Scores   : t%EST% m%ESM% a%ESA%\n\n      This alarm was matched by the %FN% filter and can be viewed at %EPS%\n\n      ZoneMinder\"','free text','(?^:^(.+)$)',' $1 ','The text of the email used to send matching event details','\n      This option is used to define the content of the email that is\n      sent for any events that match the appropriate filters.\n      ','hidden',0,'ZM_OPT_EMAIL=1'),(11,'ZM_ENABLE_CSRF_MAGIC','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Enable csrf-magic library','\n      CSRF stands for Cross-Site Request Forgery which, under specific\n      circumstances, can allow an attacker to perform any task your\n      ZoneMinder user account has permission to perform. To accomplish\n      this, the attacker must write a very specific web page and get\n      you to navigate to it, while you are logged into the ZoneMinder\n      web console at the same time. Enabling ZM_ENABLE_CSRF_MAGIC will\n      help mitigate these kinds of attacks.\n      ','system',0,''),(142,'ZM_EVENT_CLOSE_MODE','idle','string','idle','time|idle|alarm','(?^i:^([tia]))',' ($1 =~ /^t/)\n          ? \'time\'\n          : ($1 =~ /^i/ ? \'idle\' : \'time\' )\n          ','When continuous events are closed.','\n      When a monitor is running in a continuous recording mode\n      (Record or Mocord) events are usually closed after a fixed\n      period of time (the section length). However in Mocord mode it\n      is possible that motion detection may occur near the end of a\n      section. This option controls what happens when an alarm occurs\n      in Mocord mode.~~\n      ~~\n      The \'time\' setting means that the event will be\n      closed at the end of the section regardless of alarm activity.~~\n      ~~\n      The \'idle\' setting means that the event will be closed at the\n      end of the section if there is no alarm activity occurring at\n      the time otherwise it will be closed once the alarm is over\n      meaning the event may end up being longer than the normal\n      section length.~~\n      ~~\n      The \'alarm\' setting means that if an alarm\n      occurs during the event, the event will be closed and a new one\n     will be opened.  So events will only be alarmed or continuous.\n     This has the\n      effect of limiting the number of alarms to one per event and\n      the events may be shorter than the section length if an alarm\n      has occurred.\n      ','config',0,''),(146,'ZM_EVENT_IMAGE_DIGITS','5','integer','5','integer','(?^:^(d+)$)',' $1 ','How many significant digits are used in event image numbering','\n      As event images are captured they are stored to the filesystem\n      with a numerical index. By default this index has three digits\n      so the numbers start 001, 002 etc. This works for most\n      scenarios as events with more than 999 frames are rarely\n      captured. However if you have extremely long events and use\n      external applications then you may wish to increase this to\n      ensure correct sorting of images in listings etc. Warning,\n      increasing this value on a live system may render existing\n      events unviewable as the event will have been saved with the\n      previous scheme. Decreasing this value should have no ill\n      effects.\n      ','config',0,''),(37,'ZM_FAST_IMAGE_BLENDS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Use a fast algorithm to blend the reference image','\n      To detect alarms ZoneMinder needs to blend the captured image\n      with the stored reference image to update it for comparison\n      with the next image. The reference blend percentage specified\n      for the monitor controls how much the new image affects the\n      reference image. There are two methods that are available for\n      this. If this option is set then fast calculation which does\n      not use any multiplication or division is used. This\n      calculation is extremely fast, however it limits the possible\n      blend percentages to 50%, 25%, 12.5%, 6.25%, 3.25% and 1.5%.\n      Any other blend percentage will be rounded to the nearest\n      possible one. The alternative is to switch this option off\n      and use standard blending instead, which is slower.\n      ','config',0,''),(52,'ZM_FFMPEG_FORMATS','mpg mpeg wmv asf avi* mov swf 3gp**','string','mpg mpeg wmv asf avi* mov swf 3gp**','string','(?^:^(.+)$)',' $1 ','Formats to allow for ffmpeg video generation','\n      Ffmpeg can generate video in many different formats. This\n      option allows you to list the ones you want to be able to\n      select. As new formats are supported by ffmpeg you can add them\n      here and be able to use them immediately. Adding a \'*\' after a\n      format indicates that this will be the default format used for\n      web video, adding \'**\' defines the default format for phone\n      video.\n      ','images',0,'ZM_OPT_FFMPEG=1'),(50,'ZM_FFMPEG_INPUT_OPTIONS','','string','','string','(?^:^(.+)$)',' $1 ','Additional input options to ffmpeg','\n      Ffmpeg can take many options on the command line to control the\n      quality of video produced. This option allows you to specify\n      your own set that apply to the input to ffmpeg (options that\n      are given before the -i option). Check the ffmpeg documentation\n      for a full list of options which may be used here.\n      ','images',0,'ZM_OPT_FFMPEG=1'),(53,'ZM_FFMPEG_OPEN_TIMEOUT','10','integer','10','integer','(?^:^(d+)$)',' $1 ','Timeout in seconds when opening a stream.','\n      When Ffmpeg is opening a stream, it can take a long time before\n      failing; certain circumstances even seem to be able to lock\n      indefinitely. This option allows you to set a maximum time in\n      seconds to pass before closing the stream and trying to reopen\n      it again.\n      ','images',0,'ZM_OPT_FFMPEG=1'),(51,'ZM_FFMPEG_OUTPUT_OPTIONS','-r 25','string','-r 25','string','(?^:^(.+)$)',' $1 ','Additional output options to ffmpeg','\n      Ffmpeg can take many options on the command line to control the\n      quality of video produced. This option allows you to specify\n      your own set that apply to the output from ffmpeg (options that\n      are given after the -i option). Check the ffmpeg documentation\n      for a full list of options which may be used here. The most\n      common one will often be to force an output frame rate\n      supported by the video encoder.\n      ','images',0,'ZM_OPT_FFMPEG=1'),(96,'ZM_FILTER_EXECUTE_INTERVAL','60','integer','60','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) to run automatic saved filters','\n      ZoneMinder allows you to save filters to the database which\n      allow events that match certain criteria to be emailed, deleted\n      or uploaded to a remote machine etc. The zmfilter daemon loads\n      these and does the actual operation. This option determines how\n      often the filters are executed on the saved event in the\n      database. If you want a rapid response to new events this\n      should be a smaller value, however this may increase the\n      overall load on the system and affect performance of other\n      elements.\n      ','system',0,''),(95,'ZM_FILTER_RELOAD_DELAY','300','integer','300','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) filters are reloaded in zmfilter','\n      ZoneMinder allows you to save filters to the database which\n      allow events that match certain criteria to be emailed, deleted\n      or uploaded to a remote machine etc. The zmfilter daemon loads\n      these and does the actual operation. This option determines how\n      often the filters are reloaded from the database to get the\n      latest versions or new filters. If you don\'t change filters\n      very often this value can be set to a large value.\n      ','system',0,''),(140,'ZM_FORCED_ALARM_SCORE','255','integer','255','integer','(?^:^(d+)$)',' $1 ','Score to give forced alarms','\n      The \'zmu\' utility can be used to force an alarm on a monitor\n      rather than rely on the motion detection algorithms. This\n      option determines what score to give these alarms to\n      distinguish them from regular ones. It must be 255 or less.\n      ','config',0,''),(143,'ZM_FORCE_CLOSE_EVENTS','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Close events at section ends.','\n      When a monitor is running in a continuous recording mode\n      (Record or Mocord) events are usually closed after a fixed\n      period of time (the section length). However in Mocord mode it\n      is possible that motion detection may occur near the end of a\n      section and ordinarily this will prevent the event being closed\n      until the motion has ceased. Switching this option on will\n      force the event closed at the specified time regardless of any\n      motion activity.\n      ','hidden',0,''),(131,'ZM_FROM_EMAIL','','string','','your.name@your.domain','(?^:^([a-zA-Z0-9_.-]+)@([a-zA-Z0-9_.-]+)$)',' $1@$2 ','The email address you wish your event notifications to originate from','\n      The emails or messages that will be sent to you informing you\n      of events can appear to come from a designated email address to\n      help you with mail filtering etc. An address of something like\n      ZoneMinder@your.domain is recommended.\n      ','mail',0,'ZM_OPT_EMAIL=1;ZM_OPT_MESSAGE=1'),(77,'ZM_HOME_CONTENT','ZoneMinder','string','ZoneMinder','string','(?^:^(.+)$)',' $1 ','The content of the home button.','\n      You may wish to set this to empty if you are using css to put a background image on it.\n      ','web',0,''),(76,'ZM_HOME_URL','http://zoneminder.com','string','http://zoneminder.com','string','(?^:^(.+)$)',' $1 ','The url used in the home/logo area of the navigation bar.','\n      By default this takes you to the zoneminder.com website,\n      but perhaps you would prefer it to take you somewhere else.\n      ','web',0,''),(44,'ZM_HTTP_TIMEOUT','2500','integer','2500','integer','(?^:^(d+)$)',' $1 ','How long ZoneMinder waits before giving up on images (milliseconds)','\n      When retrieving remote images ZoneMinder will wait for this\n      length of time before deciding that an image is not going to\n      arrive and taking steps to retry. This timeout is in\n      milliseconds (1000 per second) and will apply to each part of\n      an image if it is not sent in one whole chunk.\n      ','network',0,''),(43,'ZM_HTTP_UA','ZoneMinder','string','ZoneMinder','string','(?^:^(.+)$)',' $1 ','The user agent that ZoneMinder uses to identify itself','\n      When ZoneMinder communicates with remote cameras it will\n      identify itself using this string and it\'s version number. This\n      is normally sufficient, however if a particular cameras expects\n      only to communicate with certain browsers then this can be\n      changed to a different string identifying ZoneMinder as\n      Internet Explorer or Netscape etc.\n      ','network',0,''),(42,'ZM_HTTP_VERSION','1.0','string','1.0','1.1|1.0','(?^:^(1.[01])$)',' $1?$1:\'\' ','The version of HTTP that ZoneMinder will use to connect','\n      ZoneMinder can communicate with network cameras using either of\n      the HTTP/1.1 or HTTP/1.0 standard. A server will normally fall\n      back to the version it supports with no problem so this should\n      usually by left at the default. However it can be changed to\n      HTTP/1.0 if necessary to resolve particular issues.\n      ','network',0,''),(23,'ZM_JPEG_ALARM_FILE_QUALITY','0','integer','0','integer','(?^:^(d+)$)',' $1 ','Set the JPEG quality setting for the saved event files during an alarm (1-100)','\n      This value is equivalent to the regular jpeg file quality\n      setting above except that it only applies to images saved while\n      in an alarm state and then only if this value is set to a\n      higher quality setting than the ordinary file setting. If set\n      to a lower value then it is ignored. Thus leaving it at the\n      default of 0 effectively means to use the regular file quality\n      setting for all saved images. This is to prevent accidentally\n      saving important images at a worse quality setting.\n      ','images',0,''),(22,'ZM_JPEG_FILE_QUALITY','70','integer','70','integer','(?^:^(d+)$)',' $1 ','Set the JPEG quality setting for the saved event files (1-100)','\n      When ZoneMinder detects an event it will save the images\n      associated with that event to files. These files are in the\n      JPEG format and can be viewed or streamed later. This option\n      specifies what image quality should be used to save these\n      files. A higher number means better quality but less\n      compression so will take up more disk space and take longer to\n      view over a slow connection. By contrast a low number means\n      smaller, quicker to view, files but at the price of lower\n      quality images. This setting applies to all images written\n      except if the capture image has caused an alarm and the alarm\n      file quality option is set at a higher value when that is used\n      instead.\n      ','images',0,''),(24,'ZM_JPEG_IMAGE_QUALITY','70','integer','70','integer','(?^:^(d+)$)',' $1 ','Set the JPEG quality setting for the streamed \'live\' images (1-100)','\n      When viewing a \'live\' stream for a monitor ZoneMinder will grab\n      an image from the buffer and encode it into JPEG format before\n      sending it. This option specifies what image quality should be\n      used to encode these images. A higher number means better\n      quality but less compression so will take longer to view over a\n      slow connection. By contrast a low number means quicker to view\n      images but at the price of lower quality images. This option\n      does not apply when viewing events or still images as these are\n      usually just read from disk and so will be encoded at the\n      quality specified by the previous options.\n      ','hidden',0,''),(25,'ZM_JPEG_STREAM_QUALITY','70','integer','70','integer','(?^:^(d+)$)',' $1 ','Set the JPEG quality setting for the streamed \'live\' images (1-100)','\n      When viewing a \'live\' stream for a monitor ZoneMinder will grab\n      an image from the buffer and encode it into JPEG format before\n      sending it. This option specifies what image quality should be\n      used to encode these images. A higher number means better\n      quality but less compression so will take longer to view over a\n      slow connection. By contrast a low number means quicker to view\n      images but at the price of lower quality images. This option\n      does not apply when viewing events or still images as these are\n      usually just read from disk and so will be encoded at the\n      quality specified by the previous options.\n      ','images',0,''),(3,'ZM_LANG_DEFAULT','fr_fr','string','en_gb','string','(?^:^(.+)$)',' $1 ','Default language used by web interface','\n      ZoneMinder allows the web interface to use languages other than\n      English if the appropriate language file has been created and\n      is present. This option allows you to change the default\n      language that is used from the shipped language, British\n      English, to another language\n      ','system',0,''),(92,'ZM_LD_PRELOAD','','string','','/absolute/path/to/somewhere','(?^:^((?:/[^/]*)+?)/?$)',' $1 ','Path to library to preload before launching daemons','\n      Some older cameras require the use of the v4l1 compat\n      library. This setting allows the setting of the path\n      to the library, so that it can be loaded by zmdc.pl\n      before launching zmc.\n      ','config',0,''),(69,'ZM_LOG_ALARM_ERR_COUNT','10','integer','10','integer','(?^:^(d+)$)',' $1 ','Number of errors indicating system alarm state','\n      When ZoneMinder is logging events to the database it can\n      retrospectively examine the number of warnings and errors that\n      have occurred to calculate an overall state of system health.\n      This option allows you to specify how many errors must have\n      occurred within the defined time period to generate an overall\n      system alarm state. A value of zero means errors are not\n      considered. This value is ignored if LOG_LEVEL_DATABASE is set\n      to None.\n      ','logging',0,''),(70,'ZM_LOG_ALARM_FAT_COUNT','1','integer','1','integer','(?^:^(d+)$)',' $1 ','Number of fatal error indicating system alarm state','\n      When ZoneMinder is logging events to the database it can\n      retrospectively examine the number of warnings and errors that\n      have occurred to calculate an overall state of system health.\n      This option allows you to specify how many fatal errors\n      (including panics) must have occurred within the defined time\n      period to generate an overall system alarm state. A value of\n      zero means fatal errors are not considered. This value is\n      ignored if LOG_LEVEL_DATABASE is set to None.\n      ','logging',0,''),(68,'ZM_LOG_ALARM_WAR_COUNT','100','integer','100','integer','(?^:^(d+)$)',' $1 ','Number of warnings indicating system alarm state','\n      When ZoneMinder is logging events to the database it can\n      retrospectively examine the number of warnings and errors that\n      have occurred to calculate an overall state of system health.\n      This option allows you to specify how many warnings must have\n      occurred within the defined time period to generate an overall\n      system alarm state. A value of zero means warnings are not\n      considered. This value is ignored if LOG_LEVEL_DATABASE is set\n      to None.\n      ','logging',0,''),(66,'ZM_LOG_ALERT_ERR_COUNT','1','integer','1','integer','(?^:^(d+)$)',' $1 ','Number of errors indicating system alert state','\n      When ZoneMinder is logging events to the database it can\n      retrospectively examine the number of warnings and errors that\n      have occurred to calculate an overall state of system health.\n      This option allows you to specify how many errors must have\n      occurred within the defined time period to generate an overall\n      system alert state. A value of zero means errors are not\n      considered. This value is ignored if LOG_LEVEL_DATABASE is set\n      to None.\n      ','logging',0,''),(67,'ZM_LOG_ALERT_FAT_COUNT','0','integer','0','integer','(?^:^(d+)$)',' $1 ','Number of fatal error indicating system alert state','\n      When ZoneMinder is logging events to the database it can\n      retrospectively examine the number of warnings and errors that\n      have occurred to calculate an overall state of system health.\n      This option allows you to specify how many fatal errors\n      (including panics) must have occurred within the defined time\n      period to generate an overall system alert state. A value of\n      zero means fatal errors are not considered. This value is\n      ignored if LOG_LEVEL_DATABASE is set to None.\n      ','logging',0,''),(65,'ZM_LOG_ALERT_WAR_COUNT','1','integer','1','integer','(?^:^(d+)$)',' $1 ','Number of warnings indicating system alert state','\n      When ZoneMinder is logging events to the database it can\n      retrospectively examine the number of warnings and errors that\n      have occurred to calculate an overall state of system health.\n      This option allows you to specify how many warnings must have\n      occurred within the defined time period to generate an overall\n      system alert state. A value of zero means warnings are not\n      considered. This value is ignored if LOG_LEVEL_DATABASE is set\n      to None.\n      ','logging',0,''),(64,'ZM_LOG_CHECK_PERIOD','900','integer','900','integer','(?^:^(d+)$)',' $1 ','Time period used when calculating overall system health','\n      When ZoneMinder is logging events to the database it can\n      retrospectively examine the number of warnings and errors that\n      have occurred to calculate an overall state of system health.\n      This option allows you to indicate what period of historical\n      events are used in this calculation. This value is expressed in\n      seconds and is ignored if LOG_LEVEL_DATABASE is set to None.\n      ','logging',0,''),(58,'ZM_LOG_DATABASE_LIMIT','1 day','string','7 day','string','(?^:^(.+)$)',' $1 ','Maximum number of log entries to retain','\n      If you are using database logging then it is possible to\n      quickly build up a large number of entries in the Logs table.\n      This option allows you to specify how many of these entries are\n      kept. If you set this option to a number greater than zero then\n      that number is used to determine the maximum number of rows,\n      less than or equal to zero indicates no limit and is not\n      recommended. You can also set this value to time values such as\n      \'<n> day\' which will limit the log entries to those newer than\n      that time. You can specify \'hour\', \'day\', \'week\', \'month\' and\n      \'year\', note that the values should be singular (no \'s\' at the\n      end). The Logs table is pruned periodically so it is possible\n      for more than the expected number of rows to be present briefly\n      in the meantime.\n      ','logging',0,''),(60,'ZM_LOG_DEBUG','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Switch debugging on','\n      ZoneMinder components usually support debug logging available\n      to help with diagnosing problems. Binary components have\n      several levels of debug whereas more other components have only\n      one. Normally this is disabled to minimize performance\n      penalties and avoid filling logs too quickly. This option lets\n      you switch on other options that allow you to configure\n      additional debug information to be output. Components will pick\n      up this instruction when they are restarted.\n      ','logging',0,''),(63,'ZM_LOG_DEBUG_FILE','','string','','string','(?^:^(.+)$)',' $1 ','Where extra debug is output to','\n      This option allows you to specify a different target for debug\n      output. All components have a default log file which will\n      norally be in /tmp or /var/log and this is where debug will be\n      written to if this value is empty. Adding a path here will\n      temporarily redirect debug, and other logging output, to this\n      file. This option is a simple filename and you are debugging\n      several components then they will all try and write to the same\n      file with undesirable consequences. Appending a \'+\' to the\n      filename will cause the file to be created with a \'.<pid>\'\n      suffix containing your process id. In this way debug from each\n      run of a component is kept separate. This is the recommended\n      setting as it will also prevent subsequent runs from\n      overwriting the same log. You should ensure that permissions\n      are set up to allow writing to the file and directory specified\n      here.\n      ','logging',0,'ZM_LOG_DEBUG=1'),(62,'ZM_LOG_DEBUG_LEVEL','1','integer','1','1|2|3|4|5|6|7|8|9','(?^:^(d+)$)',' $1 ','What level of extra debug should be enabled','\n      There are 9 levels of debug available, with higher numbers\n      being more debug and level 0 being no debug. However not all\n      levels are used by all components. Also if there is debug at a\n      high level it is usually likely to be output at such a volume\n      that it may obstruct normal operation. For this reason you\n      should set the level carefully and cautiously until the degree\n      of debug you wish to see is present. Scripts and the web\n      interface only have one level so this is an on/off type option\n      for them.\n      ','logging',0,'ZM_LOG_DEBUG=1'),(61,'ZM_LOG_DEBUG_TARGET','','string','','string','(?^:^(.+)$)',' $1 ','What components should have extra debug enabled','\n      There are three scopes of debug available. Leaving this option\n      blank means that all components will use extra debug (not\n      recommended). Setting this option to \'_<component>\', e.g. _zmc,\n      will limit extra debug to that component only. Setting this\n      option to \'_<component>_<identity>\', e.g. \'_zmc_m1\' will limit\n      extra debug to that instance of the component only. This is\n      ordinarily what you probably want to do. To debug scripts use\n      their names without the .pl extension, e.g. \'_zmvideo\' and to\n      debug issues with the web interface use \'_web\'. You can specify\n      multiple targets by separating them with \'|\' characters.\n      ','logging',0,'ZM_LOG_DEBUG=1'),(59,'ZM_LOG_FFMPEG','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Log FFMPEG messages','\n       When enabled (default is on), this option will log FFMPEG messages.\n       FFMPEG messages can be useful when debugging streaming issues. However,\n       depending on your distro and FFMPEG version, this may also result in\n       more logs than you\'d typically like to see. If all your streams are working\n       well, you may choose to turn this off.\n      ','logging',0,''),(57,'ZM_LOG_LEVEL_DATABASE','-1','integer','0','None=-5|Panic=-4|Fatal=-3|Error=-2|Warning=-1|Info=0|Debug=1','(?^:^(d+)$)',' $1 ','Save logging output to the database','\n      ZoneMinder logging is now more integrated between\n      components and allows you to specify the destination for\n      logging output and the individual levels for each. This option\n      lets you control the level of logging output that is written to\n      the database. This is a new option which can make viewing\n      logging output easier and more intuitive and also makes it\n      easier to get an overall impression of how the system is\n      performing. If you have a large or very busy system then it is\n      possible that use of this option may slow your system down if\n      the table becomes very large. Ensure you use the\n      LOG_DATABASE_LIMIT option to keep the table to a manageable\n      size. This option controls the maximum level of logging that\n      will be written, so Info includes Warnings and Errors etc. To\n      disable entirely, set this option to None. You should use\n      caution when setting this option to Debug as it can affect\n      severely affect system performance. If you want debug you will\n      also need to set a level and component below\n      ','logging',0,''),(55,'ZM_LOG_LEVEL_FILE','-1','integer','1','None=-5|Panic=-4|Fatal=-3|Error=-2|Warning=-1|Info=0|Debug=1','(?^:^(d+)$)',' $1 ','Save logging output to component files','\n      ZoneMinder logging is now more integrated between\n      components and allows you to specify the destination for\n      logging output and the individual levels for each. This option\n      lets you control the level of logging output that goes to\n      individual log files written by specific components. This is\n      how logging worked previously and although useful for tracking\n      down issues in specific components it also resulted in many\n      disparate log files. To preserve this behaviour you should\n      ensure this value is set to Info or Warning. This option\n      controls the maximum level of logging that will be written, so\n      Info includes Warnings and Errors etc. To disable entirely, set\n      this option to None. You should use caution when setting this\n      option to Debug as it can affect severely affect system\n      performance though file output has less impact than the other\n      options. If you want debug you will also need to set a level\n      and component below\n      ','logging',0,''),(54,'ZM_LOG_LEVEL_SYSLOG','-1','integer','0','None=-5|Panic=-4|Fatal=-3|Error=-2|Warning=-1|Info=0|Debug=1','(?^:^(d+)$)',' $1 ','Save logging output to the system log','\n      ZoneMinder logging is now more integrated between\n      components and allows you to specify the destination for\n      logging output and the individual levels for each. This option\n      lets you control the level of logging output that goes to the\n      system log. ZoneMinder binaries have always logged to the\n      system log but script and web logging is now included. To\n      preserve the previous behaviour you should ensure this value is\n      set to Info or Warning. This option controls the maximum level\n      of logging that will be written, so Info includes Warnings and\n      Errors etc. To disable entirely, set this option to None. You\n      should use caution when setting this option to Debug as it can\n      affect severely affect system performance. If you want debug\n      you will also need to set a level and component below\n      ','logging',0,''),(56,'ZM_LOG_LEVEL_WEBLOG','-1','integer','-5','None=-5|Panic=-4|Fatal=-3|Error=-2|Warning=-1|Info=0|Debug=1','(?^:^(d+)$)',' $1 ','Save logging output to the weblog','\n      ZoneMinder logging is now more integrated between\n      components and allows you to specify the destination for\n      logging output and the individual levels for each. This option\n      lets you control the level of logging output from the web\n      interface that goes to the httpd error log. Note that only web\n      logging from PHP and JavaScript files is included and so this\n      option is really only useful for investigating specific issues\n      with those components. This option controls the maximum level\n      of logging that will be written, so Info includes Warnings and\n      Errors etc. To disable entirely, set this option to None. You\n      should use caution when setting this option to Debug as it can\n      affect severely affect system performance. If you want debug\n      you will also need to set a level and component below\n      ','logging',0,''),(133,'ZM_MAX_RESTART_DELAY','600','integer','600','integer','(?^:^(d+)$)',' $1 ','Maximum delay (in seconds) for daemon restart attempts.','\n      The zmdc (zm daemon control) process controls when processeses\n      are started or stopped and will attempt to restart any that\n      fail. If a daemon fails frequently then a delay is introduced\n      between each restart attempt. If the daemon stills fails then\n      this delay is increased to prevent extra load being placed on\n      the system by continual restarts. This option controls what\n      this maximum delay is.\n      ','system',0,''),(47,'ZM_MAX_RTP_PORT','40499','integer','40499','integer','(?^:^(d+)$)',' $1 ','Maximum port that ZoneMinder will listen for RTP traffic on','\n      When ZoneMinder communicates with MPEG4 capable cameras using\n      RTP with the unicast method it must open ports for the camera\n      to connect back to for control and streaming purposes. This\n      setting specifies the maximum port number that ZoneMinder will\n      use. Ordinarily two adjacent ports are used for each camera,\n      one for control packets and one for data packets. This port\n      should be set to an even number, you may also need to open up a\n      hole in your firewall to allow cameras to connect back if you\n      wish to use unicasting. You should also ensure that you have\n      opened up at least two ports for each monitor that will be\n      connecting to unicasting network cameras.\n      ','network',0,''),(39,'ZM_MAX_SUSPEND_TIME','30','integer','30','integer','(?^:^(d+)$)',' $1 ','Maximum time that a monitor may have motion detection suspended','\n      ZoneMinder allows monitors to have motion detection to be\n      suspended, for instance while panning a camera. Ordinarily this\n      relies on the operator resuming motion detection afterwards as\n      failure to do so can leave a monitor in a permanently suspended\n      state. This setting allows you to set a maximum time which a\n      camera may be suspended for before it automatically resumes\n      motion detection. This time can be extended by subsequent\n      suspend indications after the first so continuous camera\n      movement will also occur while the monitor is suspended.\n      ','config',0,''),(125,'ZM_MESSAGE_ADDRESS','','string','','your.name@your.domain','(?^:^([a-zA-Z0-9_.-]+)@([a-zA-Z0-9_.-]+)$)',' $1@$2 ','The email address to send matching event details to','\n      This option is used to define the short message email address\n      that any events that match the appropriate filters will be sent\n      to.\n      ','mail',0,'ZM_OPT_MESSAGE=1'),(128,'ZM_MESSAGE_BODY','ZM alarm detected - %EL% secs, %EF%/%EFA% frames, t%EST%/m%ESM%/a%ESA% score.','text','ZM alarm detected - %EL% secs, %EF%/%EFA% frames, t%EST%/m%ESM%/a%ESA% score.','free text','(?^:^(.+)$)',' $1 ','The body of the message used to send matching event details','\n      This option is used to define the content of the message that\n      is sent for any events that match the appropriate filters.\n      ','mail',0,'ZM_OPT_MESSAGE=1'),(127,'ZM_MESSAGE_SUBJECT','ZoneMinder: Alarm - %MN%-%EI%','string','ZoneMinder: Alarm - %MN%-%EI%','string','(?^:^(.+)$)',' $1 ','The subject of the message used to send matching event details','\n      This option is used to define the subject of the message that\n      is sent for any events that match the appropriate filters.\n      ','mail',0,'ZM_OPT_MESSAGE=1'),(126,'ZM_MESSAGE_TEXT','subject = \"ZoneMinder: Alarm - %MN%-%EI%\"\n      body = \"ZM alarm detected - %EL% secs, %EF%/%EFA% frames, t%EST%/m%ESM%/a%ESA% score.\"','text','subject = \"ZoneMinder: Alarm - %MN%-%EI%\"\n      body = \"ZM alarm detected - %EL% secs, %EF%/%EFA% frames, t%EST%/m%ESM%/a%ESA% score.\"','free text','(?^:^(.+)$)',' $1 ','The text of the message used to send matching event details','\n      This option is used to define the content of the message that\n      is sent for any events that match the appropriate filters.\n      ','hidden',0,'ZM_OPT_MESSAGE=1'),(46,'ZM_MIN_RTP_PORT','40200','integer','40200','integer','(?^:^(d+)$)',' $1 ','Minimum port that ZoneMinder will listen for RTP traffic on','\n      When ZoneMinder communicates with MPEG4 capable cameras using\n      RTP with the unicast method it must open ports for the camera\n      to connect back to for control and streaming purposes. This\n      setting specifies the minimum port number that ZoneMinder will\n      use. Ordinarily two adjacent ports are used for each camera,\n      one for control packets and one for data packets. This port\n      should be set to an even number, you may also need to open up a\n      hole in your firewall to allow cameras to connect back if you\n      wish to use unicasting.\n      ','network',0,''),(45,'ZM_MIN_STREAMING_PORT','','integer','','integer','(?^:^(d+)$)',' $1 ','Alternate port range to contact for streaming video.','\n    Due to browsers only wanting to open 6 connections, if you have more\n    than 6 monitors, you can have trouble viewing more than 6.  This setting\n    specified the beginning of a port range that will be used to contact ZM\n    on.  Each monitor will use this value plus the Monitor Id to stream\n    content.  So a value of 2000 here will cause a stream for Monitor 1 to\n    hit port 2001.  Please ensure that you configure apache appropriately\n    to respond on these ports.','network',0,''),(27,'ZM_MPEG_LIVE_FORMAT','swf','string','swf','string','(?^:^(.+)$)',' $1 ','What format \'live\' video streams are played in','\n      When using MPEG mode ZoneMinder can output live video. However\n      what formats are handled by the browser varies greatly between\n      machines. This option allows you to specify a video format\n      using a file extension format, so you would just enter the\n      extension of the file type you would like and the rest is\n      determined from that. The default of \'asf\' works well under\n      Windows with Windows Media Player but I\'m currently not sure\n      what, if anything, works on a Linux platform. If you find out\n      please let me know! If this option is left blank then live\n      streams will revert to being in motion jpeg format\n      ','images',0,''),(28,'ZM_MPEG_REPLAY_FORMAT','swf','string','swf','string','(?^:^(.+)$)',' $1 ','What format \'replay\' video streams are played in','\n      When using MPEG mode ZoneMinder can replay events in encoded\n      video format. However what formats are handled by the browser\n      varies greatly between machines. This option allows you to\n      specify a video format using a file extension format, so you\n      would just enter the extension of the file type you would like\n      and the rest is determined from that. The default of \'asf\'\n      works well under Windows with Windows Media Player and \'mpg\',\n      or \'avi\' etc should work under Linux. If you know any more then\n      please let me know! If this option is left blank then live\n      streams will revert to being in motion jpeg format\n      ','images',0,''),(26,'ZM_MPEG_TIMED_FRAMES','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Tag video frames with a timestamp for more realistic streaming','\n      When using streamed MPEG based video, either for live monitor\n      streams or events, ZoneMinder can send the streams in two ways.\n      If this option is selected then the timestamp for each frame,\n      taken from it\'s capture time, is included in the stream. This\n      means that where the frame rate varies, for instance around an\n      alarm, the stream will still maintain it\'s \'real\' timing. If\n      this option is not selected then an approximate frame rate is\n      calculated and that is used to schedule frames instead. This\n      option should be selected unless you encounter problems with\n      your preferred streaming method.\n      ','images',0,''),(41,'ZM_NETCAM_REGEXPS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Use regular expression matching with network cameras','\n      Traditionally ZoneMinder has used complex regular regular\n      expressions to handle the multitude of formats that network\n      cameras produce. In versions from 1.21.1 the default is to use\n      a simpler and faster built in pattern matching methodology.\n      This works well with most networks cameras but if you have\n      problems you can try the older, but more flexible, regular\n      expression based method by selecting this option. Note, to use\n      this method you must have libpcre installed on your system.\n      ','hidden',0,'ZM_OPT_REMOTE_CAMERAS=1'),(129,'ZM_NEW_MAIL_MODULES','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Use a newer perl method to send emails','\n      Traditionally ZoneMinder has used the MIME::Entity perl module\n      to construct and send notification emails and messages. Some\n      people have reported problems with this module not being\n      present at all or flexible enough for their needs. If you are\n      one of those people this option allows you to select a new\n      mailing method using MIME::Lite and Net::SMTP instead. This\n      method was contributed by Ross Melin and should work for\n      everyone but has not been extensively tested so currently is\n      not selected by default.\n      ','mail',0,'ZM_OPT_EMAIL=1;ZM_OPT_MESSAGE=1'),(38,'ZM_OPT_ADAPTIVE_SKIP','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should frame analysis try and be efficient in skipping frames','\n      In previous versions of ZoneMinder the analysis daemon would\n      attempt to keep up with the capture daemon by processing the\n      last captured frame on each pass. This would sometimes have the\n      undesirable side-effect of missing a chunk of the initial\n      activity that caused the alarm because the pre-alarm frames\n      would all have to be written to disk and the database before\n      processing the next frame, leading to some delay between the\n      first and second event frames. Setting this option enables a\n      newer adaptive algorithm where the analysis daemon attempts to\n      process as many captured frames as possible, only skipping\n      frames when in danger of the capture daemon overwriting yet to\n      be processed frames. This skip is variable depending on the\n      size of the ring buffer and the amount of space left in it.\n      Enabling this option will give you much better coverage of the\n      beginning of alarms whilst biasing out any skipped frames\n      towards the middle or end of the event. However you should be\n      aware that this will have the effect of making the analysis\n      daemon run somewhat behind the capture daemon during events and\n      for particularly fast rates of capture it is possible for the\n      adaptive algorithm to be overwhelmed and not have time to react\n      to a rapid build up of pending frames and thus for a buffer\n      overrun condition to occur.\n      ','config',0,''),(30,'ZM_OPT_CAMBOZOLA','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Is the (optional) cambozola java streaming client installed','\n      Cambozola is a handy low fat cheese flavoured Java applet that\n      ZoneMinder uses to view image streams on browsers such as\n      Internet Explorer that don\'t natively support this format. If\n      you use this browser it is highly recommended to install this\n      from the [cambozola project site](http://www.charliemouse.com/code/cambozola/).\n      However, if it is not installed still images at a lower refresh rate can\n      still be viewed.\n      ','images',0,''),(149,'ZM_OPT_CONTROL','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Support controllable (e.g. PTZ) cameras','\n      ZoneMinder includes limited support for controllable cameras. A\n      number of sample protocols are included and others can easily\n      be added. If you wish to control your cameras via ZoneMinder\n      then select this option otherwise if you only have static\n      cameras or use other control methods then leave this option\n      off.\n      ','system',0,''),(119,'ZM_OPT_EMAIL','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should ZoneMinder email you details of events that match corresponding filters','\n      In ZoneMinder you can create event filters that specify whether\n      events that match certain criteria should have their details\n      emailed to you at a designated email address. This will allow\n      you to be notified of events as soon as they occur and also to\n      quickly view the events directly. This option specifies whether\n      this functionality should be available. The email created with\n      this option can be any size and is intended to be sent to a\n      regular email reader rather than a mobile device.\n      ','mail',0,''),(90,'ZM_OPT_FAST_DELETE','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Delete only event database records for speed','\n      Normally an event created as the result of an alarm consists of\n      entries in one or more database tables plus the various files\n      associated with it. When deleting events in the browser it can\n      take a long time to remove all of this if your are trying to do\n      a lot of events at once. It is recommended that you set this\n      option which means that the browser client only deletes the key\n      entries in the events table, which means the events will no\n      longer appear in the listing, and leaves the zmaudit daemon to\n      clear up the rest later. Note that this feature is less relevant\n      with modern hardware. Recommend this feature be left off.\n      ','system',0,''),(48,'ZM_OPT_FFMPEG','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Is the ffmpeg video encoder/decoder installed','\n      ZoneMinder can optionally encode a series of video images into\n      an MPEG encoded movie file for viewing, downloading or storage.\n      This option allows you to specify whether you have the ffmpeg\n      tools installed. Note that creating MPEG files can be fairly\n      CPU and disk intensive and is not a required option as events\n      can still be reviewed as video streams without it.\n      ','images',0,''),(17,'ZM_OPT_GOOG_RECAPTCHA_SECRETKEY','...Insert your recaptcha secret-key here...','string','...Insert your recaptcha secret-key here...','string','(?^:^(.+)$)',' $1 ','Your recaptcha secret-key','You need to generate your keys from\n      the Google reCaptcha website.\n      Please refer to the [recaptcha project site](https://www.google.com/recaptcha/)\n      for more details.\n      ','system',0,'ZM_OPT_USE_GOOG_RECAPTCHA=1'),(16,'ZM_OPT_GOOG_RECAPTCHA_SITEKEY','','string','','string','(?^:^(.+)$)',' $1 ','Your recaptcha site-key','You need to generate your keys from\n      the Google reCaptcha website.\n      Please refer to the [recaptcha project site](https://www.google.com/recaptcha/)\n      for more details.\n      ','system',0,'ZM_OPT_USE_GOOG_RECAPTCHA=1'),(124,'ZM_OPT_MESSAGE','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should ZoneMinder message you with details of events that match corresponding filters','\n      In ZoneMinder you can create event filters that specify whether\n      events that match certain criteria should have their details\n      sent to you at a designated short message email address. This\n      will allow you to be notified of events as soon as they occur.\n      This option specifies whether this functionality should be\n      available. The email created by this option will be brief and\n      is intended to be sent to an SMS gateway or a minimal mail\n      reader such as a mobile device or phone rather than a regular\n      email reader.\n      ','mail',0,''),(40,'ZM_OPT_REMOTE_CAMERAS','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Are you going to use remote/networked cameras','\n      ZoneMinder can work with both local cameras, ie. those attached\n      physically to your computer and remote or network cameras. If\n      you will be using networked cameras select this option.\n      ','hidden',0,''),(150,'ZM_OPT_TRIGGERS','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Interface external event triggers via socket or device files','\n      ZoneMinder can interact with external systems which prompt or\n      cancel alarms. This is done via the zmtrigger.pl script. This\n      option indicates whether you want to use these external\n      triggers. Most people will say no here.\n      ','system',0,''),(97,'ZM_OPT_UPLOAD','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should ZoneMinder support uploading events from filters','\n      In ZoneMinder you can create event filters that specify whether\n      events that match certain criteria should be uploaded to a\n      remote server for archiving. This option specifies whether this\n      functionality should be available\n      ','upload',0,''),(12,'ZM_OPT_USE_API','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Enable ZoneMinder APIs','\n      ZoneMinder now features a new API using which 3rd party\n      applications can interact with ZoneMinder data. It is\n      STRONGLY recommended that you enable authentication along\n      with APIs. Note that the APIs return sensitive data like\n      Monitor access details which are configured as JSON objects.\n      Which is why we recommend you enabling authentication, especially\n      if you are exposing your ZM instance on the Internet.\n      ','system',0,''),(4,'ZM_OPT_USE_AUTH','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Authenticate user logins to ZoneMinder','\n      ZoneMinder can run in two modes. The simplest is an entirely\n      unauthenticated mode where anyone can access ZoneMinder and\n      perform all tasks. This is most suitable for installations\n      where the web server access is limited in other ways. The other\n      mode enables user accounts with varying sets of permissions.\n      Users must login or authenticate to access ZoneMinder and are\n      limited by their defined permissions.\n      ','system',0,''),(14,'ZM_OPT_USE_EVENTNOTIFICATION','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Enable 3rd party Event Notification Server','\n      zmeventnotification is a 3rd party event notification server\n      that is used to get notifications for alarms detected by ZoneMinder\n      in real time. zmNinja requires this server for push notifications to\n      mobile phones. This option only enables the server if its already installed.\n      Please visit the [zmeventserver project site](https://github.com/pliablepixels/zmeventserver)\n      for installation instructions.\n      ','system',0,''),(15,'ZM_OPT_USE_GOOG_RECAPTCHA','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Add Google reCaptcha to login page','\n      This option allows you to include a google\n      reCaptcha validation at login. This means in addition to providing\n      a valid usernane and password, you will also have to\n      pass the reCaptcha test. Please note that enabling this\n      option results in the zoneminder login page reach out\n      to google servers for captcha validation. Also please note\n      that enabling this option will break 3rd party clients\n      like zmNinja and zmView as they also need to login to ZoneMinder\n      and they will fail the reCaptcha test.\n      ','system',0,'ZM_OPT_USE_AUTH=1'),(13,'ZM_OPT_USE_LEGACY_API_AUTH','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Enable legacy API authentication','\n      Starting version 1.34.0, ZoneMinder uses a more secure \n      Authentication mechanism using JWT tokens. Older versions used a less secure MD5 based auth hash. It is recommended you turn this off after you are sure you don\'t need it. If you are using a 3rd party app that relies on the older API auth mechanisms, you will have to update that app if you turn this off. Note that zmNinja 1.3.057 onwards supports the new token system\n      ','system',0,''),(83,'ZM_OPT_X10','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Support interfacing with X10 devices','\n      If you have an X10 Home Automation setup in your home you can\n      use ZoneMinder to initiate or react to X10 signals if your\n      computer has the appropriate interface controller. This option\n      indicates whether X10 options will be available in the browser\n      client.\n      ','x10',0,''),(31,'ZM_PATH_CAMBOZOLA','cambozola.jar','string','cambozola.jar','relative/path/to/somewhere','(?^:^((?:[^/].*)?)/?$)',' $1 ','Web path to (optional) cambozola java streaming client','\n      Cambozola is a handy low fat cheese flavoured Java applet that\n      ZoneMinder uses to view image streams on browsers such as\n      Internet Explorer that don\'t natively support this format. If\n      you use this browser it is highly recommended to install this\n      from the [cambozola project site](http://www.charliemouse.com/code/cambozola/).\n      However if it is not installed still images at a lower refresh rate can\n      still be viewed. Leave this as \'cambozola.jar\' if cambozola is\n      installed in the same directory as the ZoneMinder web client\n      files.\n      ','images',0,'ZM_OPT_CAMBOZOLA=1'),(49,'ZM_PATH_FFMPEG','/usr/bin/ffmpeg','string','/usr/bin/ffmpeg','/absolute/path/to/somewhere','(?^:^((?:/[^/]*)+?)/?$)',' $1 ','Path to (optional) ffmpeg mpeg encoder','This path should point to where ffmpeg has been installed.','images',0,'ZM_OPT_FFMPEG=1'),(29,'ZM_RAND_STREAM','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Add a random string to prevent caching of streams','\n      Some browsers can cache the streams used by ZoneMinder. In\n      order to prevent this a harmless random string can be appended\n      to the url to make each invocation of the stream appear unique.\n      ','images',0,''),(72,'ZM_RECORD_DIAG_IMAGES','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Record intermediate alarm diagnostic images, can be very slow','\n      In addition to recording event statistics you can also record\n      the intermediate diagnostic images that display the results of\n      the various checks and processing that occur when trying to\n      determine if an alarm event has taken place. There are several\n      of these images generated for each frame and zone for each\n      alarm or alert frame so this can have a massive impact on\n      performance. Only switch this setting on for debug or analysis\n      purposes and remember to switch it off again once no longer\n      required.\n      ','logging',0,''),(229,'ZM_RECORD_DIAG_IMAGES_FIFO','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ',' Recording intermediate alarm diagnostic use fifo instead of files (faster)','This tries to lessen the load of recording diag images by sending them to a memory FIFO pipe instead of creating each file.','logging',0,''),(71,'ZM_RECORD_EVENT_STATS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Record event statistical information, switch off if too slow','\n      This version of ZoneMinder records detailed information about\n      events in the Stats table. This can help in profiling what the\n      optimum settings are for Zones though this is tricky at\n      present. However in future releases this will be done more\n      easily and intuitively, especially with a large sample of\n      events. The default option of \'yes\' allows this information to\n      be collected now in readiness for this but if you are concerned\n      about performance you can switch this off in which case no\n      Stats information will be saved.\n      ','logging',0,''),(32,'ZM_RELOAD_CAMBOZOLA','0','integer','0','integer','(?^:^(d+)$)',' $1 ','After how many seconds should Cambozola be reloaded in live view','\n      Cambozola allows for the viewing of streaming MJPEG however it\n      caches the entire stream into cache space on the computer,\n      setting this to a number > 0 will cause it to automatically\n      reload after that many seconds to avoid filling up a hard\n      drive.\n      ','images',0,''),(137,'ZM_RUN_AUDIT','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Run zmaudit to check data consistency','\n      The zmaudit daemon exists to check that the saved information\n      in the database and on the filesystem match and are consistent\n      with each other. If an error occurs or if you are using \'fast\n      deletes\' it may be that database records are deleted but files\n      remain. In this case, and similar, zmaudit will remove\n      redundant information to synchronise the two data stores. This\n      option controls whether zmaudit is run in the background and\n      performs these checks and fixes continuously. This is\n      recommended for most systems however if you have a very large\n      number of events the process of scanning the database and\n      filesystem may take a long time and impact performance. In this\n      case you may prefer to not have zmaudit running unconditionally\n      and schedule occasional checks at other, more convenient,\n      times.\n      ','system',0,''),(159,'ZM_SHM_KEY','0x7a6d0000','hexadecimal','0x7a6d0000','hexadecimal','(?^:^(?:0x)?([0-9a-f]{1,8})$)',' \'0x\'.$1 ','Shared memory root key to use','\n      ZoneMinder uses shared memory to speed up communication between\n      modules. To identify the right area to use shared memory keys\n      are used. This option controls what the base key is, each\n      monitor will have it\'s Id or\'ed with this to get the actual key\n      used. You will not normally need to change this value unless it\n      clashes with another instance of ZoneMinder on the same\n      machine. Only the first four hex digits are used, the lower\n      four will be masked out and ignored.\n      ','system',0,''),(225,'ZM_SHOW_PRIVACY','0','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Present the privacy statment','','dynamic',1,''),(0,'ZM_SKIN_DEFAULT','classic','string','classic','string','(?^:^(.+)$)',' $1 ','Default skin used by web interface','\n      ZoneMinder allows the use of many different web interfaces.\n      This option allows you to set the default skin used by the\n      website. Users can change their skin later, this merely sets\n      the default.\n      ','system',0,''),(226,'ZM_SSMTP_MAIL','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','\n      Use a SSMTP mail server if available.\n      NEW_MAIL_MODULES must be enabled\n      ','\n      SSMTP is a lightweight and efficient method to send email.\n      The SSMTP application is not installed by default.\n      NEW_MAIL_MODULES must also be enabled.\n      Please visit the ZoneMinder [SSMTP Wiki page](http://www.zoneminder.com/wiki/index.php/How_to_get_ssmtp_working_with_Zoneminder)\n      for setup and configuration help.\n      ','mail',0,'ZM_OPT_EMAIL=1;ZM_OPT_MESSAGE=1;ZM_NEW_MAIL_MODULES=1'),(227,'ZM_SSMTP_PATH','','string','','string','(?^:^(.+)$)',' $1 ','SSMTP executable path','\n      Recommend setting the path to the SSMTP application.\n      If path is not defined. Zoneminder will try to determine\n      the path via shell command. Example path: /usr/sbin/ssmtp.\n      ','mail',0,'ZM_SSMTP_MAIL=1'),(134,'ZM_STATS_UPDATE_INTERVAL','60','integer','60','integer','(?^:^(d+)$)',' $1 ','How often to update the database statistics','\n      The zmstats daemon performs various db queries that may take\n      a long time in the background.\n      ','system',0,''),(91,'ZM_STRICT_VIDEO_CONFIG','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Allow errors in setting video config to be fatal','\n      With some video devices errors can be reported in setting the\n      various video attributes when in fact the operation was\n      successful. Switching this option off will still allow these\n      errors to be reported but will not cause them to kill the video\n      capture daemon. Note however that doing this will cause all\n      errors to be ignored including those which are genuine and\n      which may cause the video capture to not function correctly.\n      Use this option with caution.\n      ','config',0,''),(18,'ZM_SYSTEM_SHUTDOWN','0','boolean','true','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Allow Admin users to power off or restart the system from the ZoneMinder UI.','The system will need to have sudo installed and the following added to /etc/sudoers~~\n    ~~\n    http ALL=NOPASSWD: /sbin/shutdown~~\n    ~~\n      to perform the shutdown or reboot','system',0,''),(153,'ZM_TELEMETRY_DATA','1','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Send usage information to ZoneMinder','\n      Enable collection of usage information of the local system and send\n      it to the ZoneMinder development team. This data will be used to\n      determine things like who and where our customers are, how big their\n      systems are, the underlying hardware and operating system, etc.\n      This is being done for the sole purpose of creating a better\n      product for our target audience. This script is intended to be\n      completely transparent to the end user, and can be disabled from\n      the web console under Options. For more details on what information\n      we collect, please refer to our [privacy](?view=privacy) statement.\n      ','system',0,''),(156,'ZM_TELEMETRY_INTERVAL','14*24*60*60','string','14*24*60*60','string','(?^:^(.+)$)',' $1 ','Interval in seconds between telemetry updates.','This value can be expressed as a mathematical expression for ease.','system',0,''),(155,'ZM_TELEMETRY_LAST_UPLOAD','','integer','','integer','(?^:^(d+)$)',' $1 ','When the last ZoneMinder telemetry upload occurred','','dynamic',1,''),(157,'ZM_TELEMETRY_SERVER_ENDPOINT','https://zmanon:2b2d0b4skps@telemetry.zoneminder.com/zmtelemetry/testing5','string','https://zmanon:2b2d0b4skps@telemetry.zoneminder.com/zmtelemetry/testing5','http://host.your.domain/','(?^:^(?:http://)?(.+)$)',' \'http://\'.$1 ','URL that ZoneMinder will send usage data to','','hidden',0,''),(154,'ZM_TELEMETRY_UUID','','string','','string','(?^:^(.+)$)',' $1 ','Unique identifier for ZoneMinder telemetry','\n      This variable is auto-generated once by the system and is used to\n      uniquely identify it among all other ZoneMinder systems in\n      existence.\n      ','dynamic',0,''),(34,'ZM_TIMESTAMP_CODE_CHAR','%','string','%','string','(?^:^(.+)$)',' $1 ','Character to used to identify timestamp codes','\n      There are a few codes one can use to tell ZoneMinder to insert\n      data into the timestamp of each image. Traditionally, the\n      percent (%) character has been used to identify these codes since\n      the current character codes do not conflict with the strftime\n      codes, which can also be used in the timestamp. While this works\n      well for Linux, this does not work well for BSD operating systems.\n      Changing the default character to something else, such as an\n      exclamation point (!), resolves the issue. Note this only affects\n      the timestamp codes built into ZoneMinder. It has no effect on\n      the family of strftime codes one can use.\n      ','config',0,''),(33,'ZM_TIMESTAMP_ON_CAPTURE','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Timestamp images as soon as they are captured','\n      ZoneMinder can add a timestamp to images in two ways. The\n      default method, when this option is set, is that each image is\n      timestamped immediately when captured and so the image held in\n      memory is marked right away. The second method does not\n      timestamp the images until they are either saved as part of an\n      event or accessed over the web. The timestamp used in both\n      methods will contain the same time as this is preserved along\n      with the image. The first method ensures that an image is\n      timestamped regardless of any other circumstances but will\n      result in all images being timestamped even those never saved\n      or viewed. The second method necessitates that saved images are\n      copied before being saved otherwise two timestamps perhaps at\n      different scales may be applied. This has the (perhaps)\n      desirable side effect that the timestamp is always applied at\n      the same resolution so an image that has scaling applied will\n      still have a legible and correctly scaled timestamp.\n      ','config',0,''),(35,'ZM_TIMEZONE','','string','','America/Toronto','(?^:^(.+)$)','$1','The timezone that php should use.','\n      This should be set equal to the system timezone of the mysql server','system',0,''),(158,'ZM_UPDATE_CHECK_PROXY','','string','','string','(?^:^(.+)$)',' $1 ','Proxy url if required to access zoneminder.com','\n      If you use a proxy to access the internet then ZoneMinder needs\n      to know so it can access zoneminder.com to check for updates.\n      If you do use a proxy enter the full proxy url here in the form\n      of http://<proxy host>:<proxy port>/\n      ','system',0,''),(100,'ZM_UPLOAD_ARCH_ANALYSE','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Include the analysis files in the archive','\n      When the archive files are created they can contain either just\n      the captured frames or both the captured frames and, for frames\n      that caused an alarm, the analysed image with the changed area\n      highlighted. This option controls files are included. Only\n      include analysed frames if you have a high bandwidth connection\n      to the remote server or if you need help in figuring out what\n      caused an alarm in the first place as archives with these files\n      in can be considerably larger.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(99,'ZM_UPLOAD_ARCH_COMPRESS','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should archive files be compressed','\n      When the archive files are created they can be compressed.\n      However in general since the images are compressed already this\n      saves only a minimal amount of space versus utilising more CPU\n      in their creation. Only enable if you have CPU to waste and are\n      limited in disk space on your remote server or bandwidth.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(98,'ZM_UPLOAD_ARCH_FORMAT','tar','string','tar','tar|zip','(?^i:^([tz]))',' $1 =~ /^t/ ? \'tar\' : \'zip\' ','What format the uploaded events should be created in.','\n      Uploaded events may be stored in either .tar or .zip format,\n      this option specifies which. Note that to use this you will\n      need to have the Archive::Tar and/or Archive::Zip perl modules\n      installed.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(118,'ZM_UPLOAD_DEBUG','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Switch upload debugging on','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote server. If you are having (or expecting) troubles with\n      uploading events then setting this to \'yes\' permits additional\n      information to be generated by the underlying transfer modules\n      and included in the logs.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(117,'ZM_UPLOAD_FTP_DEBUG','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Switch ftp debugging on','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote ftp server. If you are having (or expecting) troubles\n      with uploading events then setting this to \'yes\' permits\n      additional information to be included in the zmfilter log file.\n      ','hidden',0,'ZM_OPT_UPLOAD=1'),(102,'ZM_UPLOAD_FTP_HOST','','string','','host.your.domain','(?^:^([a-zA-Z0-9_.-]+)$)',' $1 ','The remote server to upload to','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote ftp server. This option indicates the name, or ip\n      address, of the server to use.\n      ','hidden',0,'ZM_OPT_UPLOAD=1'),(109,'ZM_UPLOAD_FTP_LOC_DIR','/var/tmp/zoneminder','string','/var/tmp/zoneminder','/absolute/path/to/somewhere','(?^:^((?:/[^/]*)+?)/?$)',' $1 ','The local directory in which to create upload files','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote ftp server. This option indicates the local directory\n      that ZoneMinder should use for temporary upload files. These\n      are files that are created from events, uploaded and then\n      deleted.\n      ','hidden',0,'ZM_OPT_UPLOAD=1'),(107,'ZM_UPLOAD_FTP_PASS','','string','','string','(?^:^(.+)$)',' $1 ','Your ftp password','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote ftp server. This option indicates the password that\n      ZoneMinder should use to log in for ftp transfer.\n      ','hidden',0,'ZM_OPT_UPLOAD=1'),(116,'ZM_UPLOAD_FTP_PASSIVE','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Use passive ftp when uploading','\n      If your computer is behind a firewall or proxy you may need to\n      set FTP to passive mode. In fact for simple transfers it makes\n      little sense to do otherwise anyway but you can set this to\n      \'No\' if you wish.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(111,'ZM_UPLOAD_FTP_REM_DIR','','string','','relative/path/to/somewhere','(?^:^((?:[^/].*)?)/?$)',' $1 ','The remote directory to upload to','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote ftp server. This option indicates the remote directory\n      that ZoneMinder should use to upload event files to.\n      ','hidden',0,'ZM_OPT_UPLOAD=1'),(113,'ZM_UPLOAD_FTP_TIMEOUT','120','integer','120','integer','(?^:^(d+)$)',' $1 ','How long to allow the transfer to take for each file','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote ftp server. This option indicates the maximum ftp\n      inactivity timeout (in seconds) that should be tolerated before\n      ZoneMinder determines that the transfer has failed and closes\n      down the connection.\n      ','hidden',0,'ZM_OPT_UPLOAD=1'),(105,'ZM_UPLOAD_FTP_USER','','string','','alphanumeric','(?^:^([a-zA-Z0-9-_]+)$)',' $1 ','Your ftp username','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote ftp server. This option indicates the username that\n      ZoneMinder should use to log in for ftp transfer.\n      ','hidden',0,'ZM_OPT_UPLOAD=1'),(103,'ZM_UPLOAD_HOST','','string','','host.your.domain','(?^:^([a-zA-Z0-9_.-]+)$)',' $1 ','The remote server to upload events to','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote server. This option indicates the name, or ip address,\n      of the server to use.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(110,'ZM_UPLOAD_LOC_DIR','/var/tmp/zoneminder','string','/var/tmp/zoneminder','/absolute/path/to/somewhere','(?^:^((?:/[^/]*)+?)/?$)',' $1 ','The local directory in which to create upload files','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote server. This option indicates the local directory that\n      ZoneMinder should use for temporary upload files. These are\n      files that are created from events, uploaded and then deleted.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(108,'ZM_UPLOAD_PASS','','string','','string','(?^:^(.+)$)',' $1 ','Remote server password','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote server. This option indicates the password that\n      ZoneMinder should use to log in for transfer. If you are using\n      certificate based logins for SFTP servers you can leave this\n      option blank.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(104,'ZM_UPLOAD_PORT','','integer','','integer','(?^:^(d+)$)',' $1 ','The port on the remote upload server, if not the default (SFTP only)','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote server. If you are using the SFTP protocol then this\n      option allows you to specify a particular port to use for\n      connection. If this option is left blank then the default, port\n      22, is used. This option is ignored for FTP uploads.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(101,'ZM_UPLOAD_PROTOCOL','ftp','string','ftp','ftp|sftp','(?^i:^([tz]))',' $1 =~ /^f/ ? \'ftp\' : \'sftp\' ','What protocol to use to upload events','\n      ZoneMinder can upload events to a remote server using either\n      FTP or SFTP. Regular FTP is widely supported but not\n      necessarily very secure whereas SFTP (Secure FTP) runs over an\n      ssh connection and so is encrypted and uses regular ssh ports.\n      Note that to use this you will need to have the appropriate\n      perl module, either Net::FTP or Net::SFTP installed depending\n      on your choice.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(112,'ZM_UPLOAD_REM_DIR','','string','','relative/path/to/somewhere','(?^:^((?:[^/].*)?)/?$)',' $1 ','The remote directory to upload to','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote server. This option indicates the remote directory\n      that ZoneMinder should use to upload event files to.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(115,'ZM_UPLOAD_STRICT','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Require strict host key checking for SFTP uploads','\n      You can require SFTP uploads to verify the host key of the remote server\n      for protection against man-in-the-middle attacks. You will need to add the\n      server\'s key to the known_hosts file. On most systems, this will be\n      ~/.ssh/known_hosts, where ~ is the home directory of the web server running\n      ZoneMinder.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(114,'ZM_UPLOAD_TIMEOUT','120','integer','120','integer','(?^:^(d+)$)',' $1 ','How long to allow the transfer to take for each file','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote server. This option indicates the maximum inactivity\n      timeout (in seconds) that should be tolerated before ZoneMinder\n      determines that the transfer has failed and closes down the\n      connection.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(106,'ZM_UPLOAD_USER','','string','','alphanumeric','(?^:^([a-zA-Z0-9-_]+)$)',' $1 ','Remote server username','\n      You can use filters to instruct ZoneMinder to upload events to\n      a remote server. This option indicates the username that\n      ZoneMinder should use to log in for transfer.\n      ','upload',0,'ZM_OPT_UPLOAD=1'),(132,'ZM_URL','','string','','http://host.your.domain/','(?^:^(?:http://)?(.+)$)',' \'http://\'.$1 ','The URL of your ZoneMinder installation','\n      The emails or messages that will be sent to you informing you\n      of events can include a link to the events themselves for easy\n      viewing. If you intend to use this feature then set this option\n      to the url of your installation as it would appear from where\n      you read your email, e.g. http://host.your.domain/zm.php.\n      ','mail',0,'ZM_OPT_EMAIL=1;ZM_OPT_MESSAGE=1'),(148,'ZM_USER_SELF_EDIT','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Allow unprivileged users to change their details','\n      Ordinarily only users with system edit privilege are able to\n      change users details. Switching this option on allows ordinary\n      users to change their passwords and their language settings\n      ','config',0,''),(19,'ZM_USE_DEEP_STORAGE','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Use a deep filesystem hierarchy for events','\n      This option is now the default for new ZoneMinder systems and\n      should not be changed. Previous versions of ZoneMinder stored\n      all events for a monitor under one folder. Enabling\n      USE_DEEP_STORAGE causes ZoneMinder to store events under a\n      folder structure that follows year/month/day/hour/min/second.\n      Storing events this way avoids the limitation of storing more\n      than 32k files in a single folder inherent in some filesystems.\n      It is important to note that you cannot simply change this\n      option. You must stop zoneminder, enable USE_DEEP_STORAGE, and\n      then run \"sudo zmupdate.pl --migrate-events\". FAILURE TO DO\n      SO WILL RESULT IN LOSS OF YOUR DATA! Consult the ZoneMinder\n      WiKi for further details.\n      ','hidden',0,''),(93,'ZM_V4L_MULTI_BUFFER','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Use more than one buffer for Video 4 Linux devices','\n      Performance when using Video 4 Linux devices is usually best if\n      multiple buffers are used allowing the next image to be\n      captured while the previous one is being processed. If you have\n      multiple devices on a card sharing one input that requires\n      switching then this approach can sometimes cause frames from\n      one source to be mixed up with frames from another. Switching\n      this option off prevents multi buffering resulting in slower\n      but more stable image capture. This option is ignored for\n      non-local cameras or if only one input is present on a capture\n      chip. This option addresses a similar problem to the\n      ZM_CAPTURES_PER_FRAME option and you should normally change the\n      value of only one of the options at a time.  If you have\n      different capture cards that need different values you can\n      override them in each individual monitor on the source page.\n      ','config',0,''),(135,'ZM_WATCH_CHECK_INTERVAL','10','integer','10','integer','(?^:^(d+)$)',' $1 ','How often to check the capture daemons have not locked up','\n      The zmwatch daemon checks the image capture performance of the\n      capture daemons to ensure that they have not locked up (rarely\n      a sync error may occur which blocks indefinitely). This option\n      determines how often the daemons are checked.\n      ','system',0,''),(136,'ZM_WATCH_MAX_DELAY','45','decimal','45','decimal','(?^:^(d+(?:.d+)?)$)',' $1 ','The maximum delay allowed since the last captured image','\n      The zmwatch daemon checks the image capture performance of the\n      capture daemons to ensure that they have not locked up (rarely\n      a sync error may occur which blocks indefinitely). This option\n      determines the maximum delay to allow since the last captured\n      frame. The daemon will be restarted if it has not captured any\n      images after this period though the actual restart may take\n      slightly longer in conjunction with the check interval value\n      above.\n      ','system',0,''),(88,'ZM_WEB_ALARM_SOUND','','string','','filename','(?^:^([a-zA-Z0-9-_.]+)$)',' $1 ','The sound to play on alarm, put this in the sounds directory','\n      You can specify a sound file to play if an alarm occurs whilst\n      you are watching a live monitor stream. So long as your browser\n      understands the format it does not need to be any particular\n      type. This file should be placed in the sounds directory\n      defined earlier.\n      ','web',0,'ZM_WEB_SOUND_ON_ALARM=1'),(89,'ZM_WEB_COMPACT_MONTAGE','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Compact the montage view by removing extra detail','\n      The montage view shows the output of all of your active\n      monitors in one window. This include a small menu and status\n      information for each one. This can increase the web traffic and\n      make the window larger than may be desired. Setting this option\n      on removes all this extraneous information and just displays\n      the images.\n      ','web',0,''),(78,'ZM_WEB_CONSOLE_BANNER','','string','','string','(?^:^(.+)$)',' $1 ','Arbitrary text message near the top of the console','\n      Allows the administrator to place an arbitrary text message\n      near the top of the web console. This is useful for the developers\n      to display a message which indicates the running instance of\n      ZoneMinder is a development snapshot, but it can also be used for\n      any other purpose as well.\n      ','web',0,''),(163,'ZM_WEB_EVENTS_PER_PAGE','25','integer','25','integer','(?^:^(d+)$)',' $1 ','How many events to list per page in paged mode','\n      In the event list view you can either list all events or just a\n      page at a time. This option controls how many events are listed\n      per page in paged mode and how often to repeat the column\n      headers in non-paged mode.\n      ','web',0,''),(79,'ZM_WEB_EVENT_DISK_SPACE','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Whether to show disk space used by each event.','\n      Adds another column to the listing of events\n      showing the disk space used by the event.  This will impart a small\n      overhead as it will call du on the event directory.  In practice\n      this overhead is fairly small but may be noticeable on IO-constrained\n      systems.\n      ','web',0,''),(161,'ZM_WEB_EVENT_SORT_FIELD','DateTime','string','DateTime','Id|Name|Cause|MonitorName|DateTime|Length|Frames|AlarmFrames|TotScore|AvgScore|MaxScore','(?^:.)',' $1 ','Default field the event lists are sorted by','\n      Events in lists can be initially ordered in any way you want.\n      This option controls what field is used to sort them. You can\n      modify this ordering from filters or by clicking on headings in\n      the lists themselves. Bear in mind however that the \'Prev\' and\n      \'Next\' links, when scrolling through events, relate to the\n      ordering in the lists and so not always to time based ordering.\n      ','web',0,''),(162,'ZM_WEB_EVENT_SORT_ORDER','asc','string','asc','asc|desc','(?^i:^([ad]))',' $1 =~ /^a/i ? \'asc\' : \'desc\' ','Default order the event lists are sorted by','\n      Events in lists can be initially ordered in any way you want.\n      This option controls what order (ascending or descending) is\n      used to sort them. You can modify this ordering from filters or\n      by clicking on headings in the lists themselves. Bear in mind\n      however that the \'Prev\' and \'Next\' links, when scrolling\n      through events, relate to the ordering in the lists and so not\n      always to time based ordering.\n      ','web',0,''),(169,'ZM_WEB_FILTER_SOURCE','Hostname','string','Hostname','None|Hostname|NoCredentials','(?^i:^([NH]))',' ($1 =~ /^Non/)\n          ? \'None\'\n          : ($1 =~ /^H/ ? \'Hostname\' : \'NoCredentials\' )\n          ','How to filter information in the source column.','\n      This option only affects monitors with a source type of Ffmpeg,\n      Libvlc, or WebSite. This setting controls what information is\n      displayed in the Source column on the console. Selecting \'None\'\n      will not filter anything. The entire source string will be\n      displayed, which may contain sensitive information. Selecting\n      \'NoCredentials\' will strip out usernames and passwords from the\n      string. If there are any port numbers in the string and they are\n      common (80, 554, etc) then those will be removed as well.\n      Selecting \'Hostname\' will filter out all information except for\n      the hostname or ip address. When in doubt, stay with the default\n      \'Hostname\'. This feature uses the php function \'url_parts\' to\n      identify the various pieces of the url. If the url in question\n      is unusual or not standard in some way, then filtering may not\n      produce the desired results.\n      ','web',0,''),(185,'ZM_WEB_H_AJAX_TIMEOUT','3000','integer','3000','integer','(?^:^(d+)$)',' $1 ','How long to wait for Ajax request responses (ms)','\n      The newer versions of the live feed and event views use Ajax to\n      request information from the server and populate the views\n      dynamically. This option allows you to specify a timeout if\n      required after which requests are abandoned. A timeout may be\n      necessary if requests would overwise hang such as on a slow\n      connection. This would tend to consume a lot of browser memory\n      and make the interface unresponsive. Ordinarily no requests\n      should timeout so this setting should be set to a value greater\n      than the slowest expected response. This value is in\n      milliseconds but if set to zero then no timeout will be used.\n      ','highband',0,''),(176,'ZM_WEB_H_CAN_STREAM','auto','string','auto','auto|yes|no','(?^i:^([ayn]))',' ($1 =~ /^y/) ? \'yes\' : ($1 =~ /^n/ ? \'no\' : \'auto\' ) ','Override the automatic detection of browser streaming capability','\n      If you know that your browser can handle image streams of the\n      type \'multipart/x-mixed-replace\' but ZoneMinder does not detect\n      this correctly you can set this option to ensure that the\n      stream is delivered with or without the use of the Cambozola\n      plugin. Selecting \'yes\' will tell ZoneMinder that your browser\n      can handle the streams natively, \'no\' means that it can\'t and\n      so the plugin will be used while \'auto\' lets ZoneMinder decide.\n      ','highband',0,''),(179,'ZM_WEB_H_DEFAULT_RATE','100','integer','100','25|50|100|150|200|400|1000|2500|5000|10000','(?^:^(d+)$)',' $1 ','What the default replay rate factor applied to \'event\' views is (%)','\n      Normally ZoneMinder will display \'event\' streams at their\n      native rate, i.e. as close to real-time as possible. However if\n      you have long events it is often convenient to replay them at a\n      faster rate for review. This option lets you specify what the\n      default replay rate will be. It is expressed as a percentage so\n      100 is normal rate, 200 is double speed etc.\n      ','highband',0,''),(178,'ZM_WEB_H_DEFAULT_SCALE','100','integer','100','25|33|50|75|100|150|200|300|400','(?^:^(d+)$)',' $1 ','What the default scaling factor applied to \'live\' or \'event\' views is (%)','\n      Normally ZoneMinder will display \'live\' or \'event\' streams in\n      their native size. However if you have monitors with large\n      dimensions or a slow link you may prefer to reduce this size,\n      alternatively for small monitors you can enlarge it. This\n      options lets you specify what the default scaling factor will\n      be. It is expressed as a percentage so 100 is normal size, 200\n      is double size etc.\n      ','highband',0,''),(183,'ZM_WEB_H_EVENTS_VIEW','events','string','events','events|timeline','(?^i:^([lt]))',' $1 =~ /^e/ ? \'events\' : \'timeline\' ','What the default view of multiple events should be.','\n      Stored events can be viewed in either an events list format or\n      in a timeline based one. This option sets the default view that\n      will be used. Choosing one view here does not prevent the other\n      view being used as it will always be selectable from whichever\n      view is currently being used.\n      ','highband',0,''),(172,'ZM_WEB_H_REFRESH_CYCLE','10','integer','10','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the cycle watch window swaps to the next monitor','\n      The cycle watch window is a method of continuously cycling\n      between images from all of your monitors. This option\n      determines how often to refresh with a new image.\n      ','highband',0,''),(175,'ZM_WEB_H_REFRESH_EVENTS','5','integer','5','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the event listing is refreshed in the watch window','\n      The monitor window is actually made from several frames. The\n      lower frame contains a listing of the last few events for easy\n      access. This option determines how often this is refreshed.\n      ','highband',0,''),(173,'ZM_WEB_H_REFRESH_IMAGE','3','integer','3','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the watched image is refreshed (if not streaming)','\n      The live images from a monitor can be viewed in either streamed\n      or stills mode. This option determines how often a stills image\n      is refreshed, it has no effect if streaming is selected.\n      ','highband',0,''),(170,'ZM_WEB_H_REFRESH_MAIN','60','integer','60','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the main console window should refresh itself','\n      The main console window lists a general status and the event\n      totals for all monitors. This is not a trivial task and should\n      not be repeated too frequently or it may affect the performance\n      of the rest of the system.\n      ','highband',0,''),(171,'ZM_WEB_H_REFRESH_NAVBAR','60','integer','60','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the navigation header should refresh itself','\n      The navigation header contains the general status information about server load and storage space.\n      ','highband',0,''),(174,'ZM_WEB_H_REFRESH_STATUS','1','integer','1','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the status refreshes itself in the watch window','\n      The monitor window is actually made from several frames. The\n      one in the middle merely contains a monitor status which needs\n      to refresh fairly frequently to give a true indication. This\n      option determines that frequency.\n      ','highband',0,''),(182,'ZM_WEB_H_SCALE_THUMBS','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Scale thumbnails in events, bandwidth versus CPU in rescaling','\n      If unset, this option sends the whole image to the browser\n      which resizes it in the window. If set the image is scaled down\n      on the server before sending a reduced size image to the\n      browser to conserve bandwidth at the cost of CPU on the server.\n      Note that ZM can only perform the resizing if the appropriate\n      PHP graphics functionality is installed. This is usually\n      available in the php-gd package.\n      ','highband',0,''),(184,'ZM_WEB_H_SHOW_PROGRESS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Show the progress of replay in event view.','\n      When viewing events an event navigation panel and progress bar\n      is shown below the event itself. This allows you to jump to\n      specific points in the event, but can also dynamically\n      update to display the current progress of the event replay\n      itself. This progress is calculated from the actual event\n      duration and is not directly linked to the replay itself, so on\n      limited bandwidth connections may be out of step with the\n      replay. This option allows you to turn off the progress\n      display, whilst still keeping the navigation aspect, where\n      bandwidth prevents it functioning effectively.\n      ','highband',0,''),(177,'ZM_WEB_H_STREAM_METHOD','jpeg','string','jpeg','mpeg|jpeg','(?^i:^([mj]))',' $1 =~ /^m/ ? \'mpeg\' : \'jpeg\' ','Which method should be used to send video streams to your browser.','\n      ZoneMinder can be configured to use either mpeg encoded video\n      or a series or still jpeg images when sending video streams.\n      This option defines which is used. If you choose mpeg you\n      should ensure that you have the appropriate plugins available\n      on your browser whereas choosing jpeg will work natively on\n      Mozilla and related browsers and with a Java applet on Internet\n      Explorer\n      ','highband',0,''),(180,'ZM_WEB_H_VIDEO_BITRATE','150000','integer','150000','integer','(?^:^(d+)$)',' $1 ','What the bitrate of the video encoded stream should be set to','\n      When encoding real video via the ffmpeg library a bit rate can\n      be specified which roughly corresponds to the available\n      bandwidth used for the stream. This setting effectively\n      corresponds to a \'quality\' setting for the video. A low value\n      will result in a blocky image whereas a high value will produce\n      a clearer view. Note that this setting does not control the\n      frame rate of the video however the quality of the video\n      produced is affected both by this setting and the frame rate\n      that the video is produced at. A higher frame rate at a\n      particular bit rate result in individual frames being at a\n      lower quality.\n      ','highband',0,''),(181,'ZM_WEB_H_VIDEO_MAXFPS','30','integer','30','integer','(?^:^(d+)$)',' $1 ','What the maximum frame rate for streamed video should be','\n      When using streamed video the main control is the bitrate which\n      determines how much data can be transmitted. However a lower\n      bitrate at high frame rates results in a lower quality image.\n      This option allows you to limit the maximum frame rate to\n      ensure that video quality is maintained. An additional\n      advantage is that encoding video at high frame rates is a\n      processor intensive task when for the most part a very high\n      frame rate offers little perceptible improvement over one that\n      has a more manageable resource requirement. Note, this option\n      is implemented as a cap beyond which binary reduction takes\n      place. So if you have a device capturing at 15fps and set this\n      option to 10fps then the video is not produced at 10fps, but\n      rather at 7.5fps (15 divided by 2) as the final frame rate must\n      be the original divided by a power of 2.\n      ','highband',0,''),(81,'ZM_WEB_ID_ON_CONSOLE','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should the console list the monitor id','\n      Some find it useful to have the id always visible\n      on the console. This option will add a column listing it.\n      ','web',0,''),(164,'ZM_WEB_LIST_THUMBS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Display mini-thumbnails of event images in event lists','\n      Ordinarily the event lists just display text details of the\n      events to save space and time. By switching this option on you\n      can also display small thumbnails to help you identify events\n      of interest. The size of these thumbnails is controlled by the\n      following two options.\n      ','web',0,''),(166,'ZM_WEB_LIST_THUMB_HEIGHT','0','integer','0','integer','(?^:^(d+)$)',' $1 ','The height of the thumbnails that appear in the event lists','\n      This options controls the height of the thumbnail images that\n      appear in the event lists. It should be fairly small to fit in\n      with the rest of the table. If you prefer you can specify a\n      width instead in the previous option but you should only use\n      one of the width or height and the other option should be set\n      to zero. If both width and height are specified then width will\n      be used and height ignored.\n      ','web',0,'ZM_WEB_LIST_THUMBS=1'),(165,'ZM_WEB_LIST_THUMB_WIDTH','48','integer','48','integer','(?^:^(d+)$)',' $1 ','The width of the thumbnails that appear in the event lists','\n      This options controls the width of the thumbnail images that\n      appear in the event lists. It should be fairly small to fit in\n      with the rest of the table. If you prefer you can specify a\n      height instead in the next option but you should only use one\n      of the width or height and the other option should be set to\n      zero. If both width and height are specified then width will be\n      used and height ignored.\n      ','web',0,'ZM_WEB_LIST_THUMBS=1'),(217,'ZM_WEB_L_AJAX_TIMEOUT','10000','integer','10000','integer','(?^:^(d+)$)',' $1 ','How long to wait for Ajax request responses (ms)','\n      The newer versions of the live feed and event views use Ajax to\n      request information from the server and populate the views\n      dynamically. This option allows you to specify a timeout if\n      required after which requests are abandoned. A timeout may be\n      necessary if requests would overwise hang such as on a slow\n      connection. This would tend to consume a lot of browser memory\n      and make the interface unresponsive. Ordinarily no requests\n      should timeout so this setting should be set to a value greater\n      than the slowest expected response. This value is in\n      milliseconds but if set to zero then no timeout will be used.\n      ','lowband',0,''),(208,'ZM_WEB_L_CAN_STREAM','auto','string','auto','auto|yes|no','(?^i:^([ayn]))',' ($1 =~ /^y/) ? \'yes\' : ($1 =~ /^n/ ? \'no\' : \'auto\' ) ','Override the automatic detection of browser streaming capability','\n      If you know that your browser can handle image streams of the\n      type \'multipart/x-mixed-replace\' but ZoneMinder does not detect\n      this correctly you can set this option to ensure that the\n      stream is delivered with or without the use of the Cambozola\n      plugin. Selecting \'yes\' will tell ZoneMinder that your browser\n      can handle the streams natively, \'no\' means that it can\'t and\n      so the plugin will be used while \'auto\' lets ZoneMinder decide.\n      ','lowband',0,''),(211,'ZM_WEB_L_DEFAULT_RATE','100','integer','100','25|50|100|150|200|400|1000|2500|5000|10000','(?^:^(d+)$)',' $1 ','What the default replay rate factor applied to \'event\' views is (%)','\n      Normally ZoneMinder will display \'event\' streams at their\n      native rate, i.e. as close to real-time as possible. However if\n      you have long events it is often convenient to replay them at a\n      faster rate for review. This option lets you specify what the\n      default replay rate will be. It is expressed as a percentage so\n      100 is normal rate, 200 is double speed etc.\n      ','lowband',0,''),(210,'ZM_WEB_L_DEFAULT_SCALE','100','integer','100','25|33|50|75|100|150|200|300|400','(?^:^(d+)$)',' $1 ','What the default scaling factor applied to \'live\' or \'event\' views is (%)','\n      Normally ZoneMinder will display \'live\' or \'event\' streams in\n      their native size. However if you have monitors with large\n      dimensions or a slow link you may prefer to reduce this size,\n      alternatively for small monitors you can enlarge it. This\n      options lets you specify what the default scaling factor will\n      be. It is expressed as a percentage so 100 is normal size, 200\n      is double size etc.\n      ','lowband',0,''),(215,'ZM_WEB_L_EVENTS_VIEW','events','string','events','events|timeline','(?^i:^([lt]))',' $1 =~ /^e/ ? \'events\' : \'timeline\' ','What the default view of multiple events should be.','\n      Stored events can be viewed in either an events list format or\n      in a timeline based one. This option sets the default view that\n      will be used. Choosing one view here does not prevent the other\n      view being used as it will always be selectable from whichever\n      view is currently being used.\n      ','lowband',0,''),(204,'ZM_WEB_L_REFRESH_CYCLE','30','integer','30','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the cycle watch window swaps to the next monitor','\n      The cycle watch window is a method of continuously cycling\n      between images from all of your monitors. This option\n      determines how often to refresh with a new image.\n      ','lowband',0,''),(207,'ZM_WEB_L_REFRESH_EVENTS','180','integer','180','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the event listing is refreshed in the watch window','\n      The monitor window is actually made from several frames. The\n      lower frame contains a listing of the last few events for easy\n      access. This option determines how often this is refreshed.\n      ','lowband',0,''),(205,'ZM_WEB_L_REFRESH_IMAGE','15','integer','15','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the watched image is refreshed (if not streaming)','\n      The live images from a monitor can be viewed in either streamed\n      or stills mode. This option determines how often a stills image\n      is refreshed, it has no effect if streaming is selected.\n      ','lowband',0,''),(202,'ZM_WEB_L_REFRESH_MAIN','300','integer','300','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the main console window should refresh itself','\n      The main console window lists a general status and the event\n      totals for all monitors. This is not a trivial task and should\n      not be repeated too frequently or it may affect the performance\n      of the rest of the system.\n      ','lowband',0,''),(203,'ZM_WEB_L_REFRESH_NAVBAR','180','integer','180','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the navigation header should refresh itself','\n      The navigation header contains the general status information about server load and storage space.\n      ','lowband',0,''),(206,'ZM_WEB_L_REFRESH_STATUS','10','integer','10','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the status refreshes itself in the watch window','\n      The monitor window is actually made from several frames. The\n      one in the middle merely contains a monitor status which needs\n      to refresh fairly frequently to give a true indication. This\n      option determines that frequency.\n      ','lowband',0,''),(214,'ZM_WEB_L_SCALE_THUMBS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Scale thumbnails in events, bandwidth versus CPU in rescaling','\n      If unset, this option sends the whole image to the browser\n      which resizes it in the window. If set the image is scaled down\n      on the server before sending a reduced size image to the\n      browser to conserve bandwidth at the cost of CPU on the server.\n      Note that ZM can only perform the resizing if the appropriate\n      PHP graphics functionality is installed. This is usually\n      available in the php-gd package.\n      ','lowband',0,''),(216,'ZM_WEB_L_SHOW_PROGRESS','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Show the progress of replay in event view.','\n      When viewing events an event navigation panel and progress bar\n      is shown below the event itself. This allows you to jump to\n      specific points in the event, but can also dynamically\n      update to display the current progress of the event replay\n      itself. This progress is calculated from the actual event\n      duration and is not directly linked to the replay itself, so on\n      limited bandwidth connections may be out of step with the\n      replay. This option allows you to turn off the progress\n      display, whilst still keeping the navigation aspect, where\n      bandwidth prevents it functioning effectively.\n      ','lowband',0,''),(209,'ZM_WEB_L_STREAM_METHOD','jpeg','string','jpeg','mpeg|jpeg','(?^i:^([mj]))',' $1 =~ /^m/ ? \'mpeg\' : \'jpeg\' ','Which method should be used to send video streams to your browser.','\n      ZoneMinder can be configured to use either mpeg encoded video\n      or a series or still jpeg images when sending video streams.\n      This option defines which is used. If you choose mpeg you\n      should ensure that you have the appropriate plugins available\n      on your browser whereas choosing jpeg will work natively on\n      Mozilla and related browsers and with a Java applet on Internet\n      Explorer\n      ','lowband',0,''),(212,'ZM_WEB_L_VIDEO_BITRATE','25000','integer','25000','integer','(?^:^(d+)$)',' $1 ','What the bitrate of the video encoded stream should be set to','\n      When encoding real video via the ffmpeg library a bit rate can\n      be specified which roughly corresponds to the available\n      bandwidth used for the stream. This setting effectively\n      corresponds to a \'quality\' setting for the video. A low value\n      will result in a blocky image whereas a high value will produce\n      a clearer view. Note that this setting does not control the\n      frame rate of the video however the quality of the video\n      produced is affected both by this setting and the frame rate\n      that the video is produced at. A higher frame rate at a\n      particular bit rate result in individual frames being at a\n      lower quality.\n      ','lowband',0,''),(213,'ZM_WEB_L_VIDEO_MAXFPS','5','integer','5','integer','(?^:^(d+)$)',' $1 ','What the maximum frame rate for streamed video should be','\n      When using streamed video the main control is the bitrate which\n      determines how much data can be transmitted. However a lower\n      bitrate at high frame rates results in a lower quality image.\n      This option allows you to limit the maximum frame rate to\n      ensure that video quality is maintained. An additional\n      advantage is that encoding video at high frame rates is a\n      processor intensive task when for the most part a very high\n      frame rate offers little perceptible improvement over one that\n      has a more manageable resource requirement. Note, this option\n      is implemented as a cap beyond which binary reduction takes\n      place. So if you have a device capturing at 15fps and set this\n      option to 10fps then the video is not produced at 10fps, but\n      rather at 7.5fps (15 divided by 2) as the final frame rate must\n      be the original divided by a power of 2.\n      ','lowband',0,''),(201,'ZM_WEB_M_AJAX_TIMEOUT','5000','integer','5000','integer','(?^:^(d+)$)',' $1 ','How long to wait for Ajax request responses (ms)','\n      The newer versions of the live feed and event views use Ajax to\n      request information from the server and populate the views\n      dynamically. This option allows you to specify a timeout if\n      required after which requests are abandoned. A timeout may be\n      necessary if requests would overwise hang such as on a slow\n      connection. This would tend to consume a lot of browser memory\n      and make the interface unresponsive. Ordinarily no requests\n      should timeout so this setting should be set to a value greater\n      than the slowest expected response. This value is in\n      milliseconds but if set to zero then no timeout will be used.\n      ','medband',0,''),(192,'ZM_WEB_M_CAN_STREAM','auto','string','auto','auto|yes|no','(?^i:^([ayn]))',' ($1 =~ /^y/) ? \'yes\' : ($1 =~ /^n/ ? \'no\' : \'auto\' ) ','Override the automatic detection of browser streaming capability','\n      If you know that your browser can handle image streams of the\n      type \'multipart/x-mixed-replace\' but ZoneMinder does not detect\n      this correctly you can set this option to ensure that the\n      stream is delivered with or without the use of the Cambozola\n      plugin. Selecting \'yes\' will tell ZoneMinder that your browser\n      can handle the streams natively, \'no\' means that it can\'t and\n      so the plugin will be used while \'auto\' lets ZoneMinder decide.\n      ','medband',0,''),(195,'ZM_WEB_M_DEFAULT_RATE','100','integer','100','25|50|100|150|200|400|1000|2500|5000|10000','(?^:^(d+)$)',' $1 ','What the default replay rate factor applied to \'event\' views is (%)','\n      Normally ZoneMinder will display \'event\' streams at their\n      native rate, i.e. as close to real-time as possible. However if\n      you have long events it is often convenient to replay them at a\n      faster rate for review. This option lets you specify what the\n      default replay rate will be. It is expressed as a percentage so\n      100 is normal rate, 200 is double speed etc.\n      ','medband',0,''),(194,'ZM_WEB_M_DEFAULT_SCALE','100','integer','100','25|33|50|75|100|150|200|300|400','(?^:^(d+)$)',' $1 ','What the default scaling factor applied to \'live\' or \'event\' views is (%)','\n      Normally ZoneMinder will display \'live\' or \'event\' streams in\n      their native size. However if you have monitors with large\n      dimensions or a slow link you may prefer to reduce this size,\n      alternatively for small monitors you can enlarge it. This\n      options lets you specify what the default scaling factor will\n      be. It is expressed as a percentage so 100 is normal size, 200\n      is double size etc.\n      ','medband',0,''),(199,'ZM_WEB_M_EVENTS_VIEW','events','string','events','events|timeline','(?^i:^([lt]))',' $1 =~ /^e/ ? \'events\' : \'timeline\' ','What the default view of multiple events should be.','\n      Stored events can be viewed in either an events list format or\n      in a timeline based one. This option sets the default view that\n      will be used. Choosing one view here does not prevent the other\n      view being used as it will always be selectable from whichever\n      view is currently being used.\n      ','medband',0,''),(188,'ZM_WEB_M_REFRESH_CYCLE','20','integer','20','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the cycle watch window swaps to the next monitor','\n      The cycle watch window is a method of continuously cycling\n      between images from all of your monitors. This option\n      determines how often to refresh with a new image.\n      ','medband',0,''),(191,'ZM_WEB_M_REFRESH_EVENTS','60','integer','60','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the event listing is refreshed in the watch window','\n      The monitor window is actually made from several frames. The\n      lower frame contains a listing of the last few events for easy\n      access. This option determines how often this is refreshed.\n      ','medband',0,''),(189,'ZM_WEB_M_REFRESH_IMAGE','10','integer','10','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the watched image is refreshed (if not streaming)','\n      The live images from a monitor can be viewed in either streamed\n      or stills mode. This option determines how often a stills image\n      is refreshed, it has no effect if streaming is selected.\n      ','medband',0,''),(186,'ZM_WEB_M_REFRESH_MAIN','300','integer','300','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the main console window should refresh itself','\n      The main console window lists a general status and the event\n      totals for all monitors. This is not a trivial task and should\n      not be repeated too frequently or it may affect the performance\n      of the rest of the system.\n      ','medband',0,''),(187,'ZM_WEB_M_REFRESH_NAVBAR','120','integer','120','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the navigation header should refresh itself','\n      The navigation header contains the general status information about server load and storage space.\n      ','medband',0,''),(190,'ZM_WEB_M_REFRESH_STATUS','5','integer','5','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the status refreshes itself in the watch window','\n      The monitor window is actually made from several frames. The\n      one in the middle merely contains a monitor status which needs\n      to refresh fairly frequently to give a true indication. This\n      option determines that frequency.\n      ','medband',0,''),(198,'ZM_WEB_M_SCALE_THUMBS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Scale thumbnails in events, bandwidth versus CPU in rescaling','\n      If unset, this option sends the whole image to the browser\n      which resizes it in the window. If set the image is scaled down\n      on the server before sending a reduced size image to the\n      browser to conserve bandwidth at the cost of CPU on the server.\n      Note that ZM can only perform the resizing if the appropriate\n      PHP graphics functionality is installed. This is usually\n      available in the php-gd package.\n      ','medband',0,''),(200,'ZM_WEB_M_SHOW_PROGRESS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Show the progress of replay in event view.','\n      When viewing events an event navigation panel and progress bar\n      is shown below the event itself. This allows you to jump to\n      specific points in the event, but can also dynamically\n      update to display the current progress of the event replay\n      itself. This progress is calculated from the actual event\n      duration and is not directly linked to the replay itself, so on\n      limited bandwidth connections may be out of step with the\n      replay. This option allows you to turn off the progress\n      display, whilst still keeping the navigation aspect, where\n      bandwidth prevents it functioning effectively.\n      ','medband',0,''),(193,'ZM_WEB_M_STREAM_METHOD','jpeg','string','jpeg','mpeg|jpeg','(?^i:^([mj]))',' $1 =~ /^m/ ? \'mpeg\' : \'jpeg\' ','Which method should be used to send video streams to your browser.','\n      ZoneMinder can be configured to use either mpeg encoded video\n      or a series or still jpeg images when sending video streams.\n      This option defines which is used. If you choose mpeg you\n      should ensure that you have the appropriate plugins available\n      on your browser whereas choosing jpeg will work natively on\n      Mozilla and related browsers and with a Java applet on Internet\n      Explorer\n      ','medband',0,''),(196,'ZM_WEB_M_VIDEO_BITRATE','75000','integer','75000','integer','(?^:^(d+)$)',' $1 ','What the bitrate of the video encoded stream should be set to','\n      When encoding real video via the ffmpeg library a bit rate can\n      be specified which roughly corresponds to the available\n      bandwidth used for the stream. This setting effectively\n      corresponds to a \'quality\' setting for the video. A low value\n      will result in a blocky image whereas a high value will produce\n      a clearer view. Note that this setting does not control the\n      frame rate of the video however the quality of the video\n      produced is affected both by this setting and the frame rate\n      that the video is produced at. A higher frame rate at a\n      particular bit rate result in individual frames being at a\n      lower quality.\n      ','medband',0,''),(197,'ZM_WEB_M_VIDEO_MAXFPS','10','integer','10','integer','(?^:^(d+)$)',' $1 ','What the maximum frame rate for streamed video should be','\n      When using streamed video the main control is the bitrate which\n      determines how much data can be transmitted. However a lower\n      bitrate at high frame rates results in a lower quality image.\n      This option allows you to limit the maximum frame rate to\n      ensure that video quality is maintained. An additional\n      advantage is that encoding video at high frame rates is a\n      processor intensive task when for the most part a very high\n      frame rate offers little perceptible improvement over one that\n      has a more manageable resource requirement. Note, this option\n      is implemented as a cap beyond which binary reduction takes\n      place. So if you have a device capturing at 15fps and set this\n      option to 10fps then the video is not produced at 10fps, but\n      rather at 7.5fps (15 divided by 2) as the final frame rate must\n      be the original divided by a power of 2.\n      ','medband',0,''),(82,'ZM_WEB_POPUP_ON_ALARM','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should the monitor window jump to the top if an alarm occurs','\n      When viewing a live monitor stream you can specify whether you\n      want the window to pop to the front if an alarm occurs when the\n      window is minimised or behind another window. This is most\n      useful if your monitors are over doors for example when they\n      can pop up if someone comes to the doorway.\n      ','web',0,''),(160,'ZM_WEB_REFRESH_METHOD','javascript','string','javascript','javascript|http','(?^i:^([jh]))',' $1 =~ /^j/\n          ? \'javascript\'\n          : \'http\'\n          ','What method windows should use to refresh themselves','\n      Many windows in ZoneMinder need to refresh themselves to keep\n      their information current. This option determines what method\n      they should use to do this. Choosing \'javascript\' means that\n      each window will have a short JavaScript statement in with a\n      timer to prompt the refresh. This is the most compatible\n      method. Choosing \'http\' means the refresh instruction is put in\n      the HTTP header. This is a cleaner method but refreshes are\n      interrupted or cancelled when a link in the window is clicked\n      meaning that the window will no longer refresh and this would\n      have to be done manually.\n      ','hidden',0,''),(80,'ZM_WEB_RESIZE_CONSOLE','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should the console window resize itself to fit','\n      Traditionally the main ZoneMinder web console window has\n      resized itself to shrink to a size small enough to list only\n      the monitors that are actually present. This is intended to\n      make the window more unobtrusize but may not be to everyone\'s\n      tastes, especially if opened in a tab in browsers which support\n      this kind if layout. Switch this option off to have the console\n      window size left to the users preference\n      ','web',0,''),(87,'ZM_WEB_SOUND_ON_ALARM','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Should the monitor window play a sound if an alarm occurs','\n      When viewing a live monitor stream you can specify whether you\n      want the window to play a sound to alert you if an alarm\n      occurs.\n      ','web',0,''),(74,'ZM_WEB_TITLE','ZoneMinder','string','ZoneMinder','string','(?^:^(.+)$)',' $1 ','The title displayed wherever the site references itself.','\n      If you want the site to identify as something other than ZoneMinder, change this here.\n      It can be used to more accurately identify this installation from others.\n      ','web',0,''),(75,'ZM_WEB_TITLE_PREFIX','ZM','string','ZM','string','(?^:^(.+)$)',' $1 ','The title prefix displayed on each window','\n      If you have more than one installation of ZoneMinder it can be\n      helpful to display different titles for each one. Changing this\n      option allows you to customise the window titles to include\n      further information to aid identification.\n      ','web',0,''),(167,'ZM_WEB_USE_OBJECT_TAGS','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Wrap embed in object tags for media content','\n      There are two methods of including media content in web pages.\n      The most common way is use the EMBED tag which is able to give\n      some indication of the type of content. However this is not a\n      standard part of HTML. The official method is to use OBJECT\n      tags which are able to give more information allowing the\n      correct media viewers etc. to be loaded. However these are less\n      widely supported and content may be specifically tailored to a\n      particular platform or player. This option controls whether\n      media content is enclosed in EMBED tags only or whether, where\n      appropriate, it is additionally wrapped in OBJECT tags.\n      Currently OBJECT tags are only used in a limited number of\n      circumstances but they may become more widespread in the\n      future. It is suggested that you leave this option on unless\n      you encounter problems playing some content.\n      ','web',0,''),(168,'ZM_WEB_XFRAME_WARN','1','boolean','yes','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Warn when website X-Frame-Options is set to sameorigin','\n      When creating a Web Site monitor, if the target web site has\n      X-Frame-Options set to sameorigin in the header, the site will\n      not display in ZoneMinder. This is a design feature in most modern\n      browsers. When this condition occurs, ZoneMinder will write a\n      warning to the log file. To get around this, one can install a browser\n      plugin or extension to ignore X-Frame headers, and then the page will\n      display properly. Once the plugin or extension has ben installed,\n      the end user may choose to turn this warning off.\n      ','web',0,''),(145,'ZM_WEIGHTED_ALARM_CENTRES','0','boolean','no','yes|no','(?^i:^([yn]))',' ($1 =~ /^y/) ? \'yes\' : \'no\' ','Use a weighted algorithm to calculate the centre of an alarm','\n      ZoneMinder will always calculate the centre point of an alarm\n      in a zone to give some indication of where on the screen it is.\n      This can be used by the experimental motion tracking feature or\n      your own custom extensions. In the alarmed or filtered pixels\n      mode this is a simple midpoint between the extents of the\n      detected pixels. However in the blob method this can instead be\n      calculated using weighted pixel locations to give more accurate\n      positioning for irregularly shaped blobs. This method, while\n      more precise is also slower and so is turned off by default.\n      ','config',0,''),(86,'ZM_X10_DB_RELOAD_INTERVAL','60','integer','60','integer','(?^:^(d+)$)',' $1 ','How often (in seconds) the X10 daemon reloads the monitors from the database','\n      The zmx10 daemon periodically checks the database to find out\n      what X10 events trigger, or result from, alarms. This option\n      determines how frequently this check occurs, unless you change\n      this area frequently this can be a fairly large value.\n      ','x10',0,'ZM_OPT_X10=1'),(84,'ZM_X10_DEVICE','/dev/ttyS0','string','/dev/ttyS0','/absolute/path/to/somewhere','(?^:^((?:/[^/]*)+?)/?$)',' $1 ','What device is your X10 controller connected on','\n      If you have an X10 controller device (e.g. XM10U) connected to\n      your computer this option details which port it is connected on,\n      the default of /dev/ttyS0 maps to serial or com port 1.\n      ','x10',0,'ZM_OPT_X10=1'),(85,'ZM_X10_HOUSE_CODE','A','string','A','A-P','(?^i:^([A-P]))',' uc($1) ','What X10 house code should be used','\n      X10 devices are grouped together by identifying them as all\n      belonging to one House Code. This option details what that is.\n      It should be a single letter between A and P.\n      ','x10',0,'ZM_OPT_X10=1');
/*!40000 ALTER TABLE `Config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ControlPresets`
--

DROP TABLE IF EXISTS `ControlPresets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ControlPresets` (
  `MonitorId` int(10) unsigned NOT NULL DEFAULT 0,
  `Preset` int(10) unsigned NOT NULL DEFAULT 0,
  `Label` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`MonitorId`,`Preset`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ControlPresets`
--

LOCK TABLES `ControlPresets` WRITE;
/*!40000 ALTER TABLE `ControlPresets` DISABLE KEYS */;
/*!40000 ALTER TABLE `ControlPresets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Controls`
--

DROP TABLE IF EXISTS `Controls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Controls` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Type` enum('Local','Remote','File','Ffmpeg','Libvlc','cURL','WebSite','NVSocket') NOT NULL DEFAULT 'Local',
  `Protocol` varchar(64) DEFAULT NULL,
  `CanWake` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanSleep` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanReset` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanReboot` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanZoom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanAutoZoom` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanZoomAbs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanZoomRel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanZoomCon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinZoomRange` int(10) unsigned DEFAULT NULL,
  `MaxZoomRange` int(10) unsigned DEFAULT NULL,
  `MinZoomStep` int(10) unsigned DEFAULT NULL,
  `MaxZoomStep` int(10) unsigned DEFAULT NULL,
  `HasZoomSpeed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinZoomSpeed` int(10) unsigned DEFAULT NULL,
  `MaxZoomSpeed` int(10) unsigned DEFAULT NULL,
  `CanFocus` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanAutoFocus` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanFocusAbs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanFocusRel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanFocusCon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinFocusRange` int(10) unsigned DEFAULT NULL,
  `MaxFocusRange` int(10) unsigned DEFAULT NULL,
  `MinFocusStep` int(10) unsigned DEFAULT NULL,
  `MaxFocusStep` int(10) unsigned DEFAULT NULL,
  `HasFocusSpeed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinFocusSpeed` int(10) unsigned DEFAULT NULL,
  `MaxFocusSpeed` int(10) unsigned DEFAULT NULL,
  `CanIris` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanAutoIris` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanIrisAbs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanIrisRel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanIrisCon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinIrisRange` int(10) unsigned DEFAULT NULL,
  `MaxIrisRange` int(10) unsigned DEFAULT NULL,
  `MinIrisStep` int(10) unsigned DEFAULT NULL,
  `MaxIrisStep` int(10) unsigned DEFAULT NULL,
  `HasIrisSpeed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinIrisSpeed` int(10) unsigned DEFAULT NULL,
  `MaxIrisSpeed` int(10) unsigned DEFAULT NULL,
  `CanGain` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanAutoGain` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanGainAbs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanGainRel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanGainCon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinGainRange` int(10) unsigned DEFAULT NULL,
  `MaxGainRange` int(10) unsigned DEFAULT NULL,
  `MinGainStep` int(10) unsigned DEFAULT NULL,
  `MaxGainStep` int(10) unsigned DEFAULT NULL,
  `HasGainSpeed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinGainSpeed` int(10) unsigned DEFAULT NULL,
  `MaxGainSpeed` int(10) unsigned DEFAULT NULL,
  `CanWhite` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanAutoWhite` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanWhiteAbs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanWhiteRel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanWhiteCon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinWhiteRange` int(10) unsigned DEFAULT NULL,
  `MaxWhiteRange` int(10) unsigned DEFAULT NULL,
  `MinWhiteStep` int(10) unsigned DEFAULT NULL,
  `MaxWhiteStep` int(10) unsigned DEFAULT NULL,
  `HasWhiteSpeed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinWhiteSpeed` int(10) unsigned DEFAULT NULL,
  `MaxWhiteSpeed` int(10) unsigned DEFAULT NULL,
  `HasPresets` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `NumPresets` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `HasHomePreset` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanSetPresets` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanMove` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanMoveDiag` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanMoveMap` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanMoveAbs` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanMoveRel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanMoveCon` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `CanPan` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinPanRange` int(10) DEFAULT NULL,
  `MaxPanRange` int(10) DEFAULT NULL,
  `MinPanStep` int(10) DEFAULT NULL,
  `MaxPanStep` int(10) DEFAULT NULL,
  `HasPanSpeed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinPanSpeed` int(10) DEFAULT NULL,
  `MaxPanSpeed` int(10) DEFAULT NULL,
  `HasTurboPan` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `TurboPanSpeed` int(10) DEFAULT NULL,
  `CanTilt` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinTiltRange` int(10) DEFAULT NULL,
  `MaxTiltRange` int(10) DEFAULT NULL,
  `MinTiltStep` int(10) DEFAULT NULL,
  `MaxTiltStep` int(10) DEFAULT NULL,
  `HasTiltSpeed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `MinTiltSpeed` int(10) DEFAULT NULL,
  `MaxTiltSpeed` int(10) DEFAULT NULL,
  `HasTurboTilt` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `TurboTiltSpeed` int(10) DEFAULT NULL,
  `CanAutoScan` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `NumScanPaths` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Controls`
--

LOCK TABLES `Controls` WRITE;
/*!40000 ALTER TABLE `Controls` DISABLE KEYS */;

INSERT INTO `Controls` (`Id`, `Name`, `Type`, `Protocol`, `CanWake`, `CanSleep`, `CanReset`, `CanReboot`, `CanZoom`, `CanAutoZoom`, `CanZoomAbs`, `CanZoomRel`, `CanZoomCon`, `MinZoomRange`, `MaxZoomRange`, `MinZoomStep`, `MaxZoomStep`, `HasZoomSpeed`, `MinZoomSpeed`, `MaxZoomSpeed`, `CanFocus`, `CanAutoFocus`, `CanFocusAbs`, `CanFocusRel`, `CanFocusCon`, `MinFocusRange`, `MaxFocusRange`, `MinFocusStep`, `MaxFocusStep`, `HasFocusSpeed`, `MinFocusSpeed`, `MaxFocusSpeed`, `CanIris`, `CanAutoIris`, `CanIrisAbs`, `CanIrisRel`, `CanIrisCon`, `MinIrisRange`, `MaxIrisRange`, `MinIrisStep`, `MaxIrisStep`, `HasIrisSpeed`, `MinIrisSpeed`, `MaxIrisSpeed`, `CanGain`, `CanAutoGain`, `CanGainAbs`, `CanGainRel`, `CanGainCon`, `MinGainRange`, `MaxGainRange`, `MinGainStep`, `MaxGainStep`, `HasGainSpeed`, `MinGainSpeed`, `MaxGainSpeed`, `CanWhite`, `CanAutoWhite`, `CanWhiteAbs`, `CanWhiteRel`, `CanWhiteCon`, `MinWhiteRange`, `MaxWhiteRange`, `MinWhiteStep`, `MaxWhiteStep`, `HasWhiteSpeed`, `MinWhiteSpeed`, `MaxWhiteSpeed`, `HasPresets`, `NumPresets`, `HasHomePreset`, `CanSetPresets`, `CanMove`, `CanMoveDiag`, `CanMoveMap`, `CanMoveAbs`, `CanMoveRel`, `CanMoveCon`, `CanPan`, `MinPanRange`, `MaxPanRange`, `MinPanStep`, `MaxPanStep`, `HasPanSpeed`, `MinPanSpeed`, `MaxPanSpeed`, `HasTurboPan`, `TurboPanSpeed`, `CanTilt`, `MinTiltRange`, `MaxTiltRange`, `MinTiltStep`, `MaxTiltStep`, `HasTiltSpeed`, `MinTiltSpeed`, `MaxTiltSpeed`, `HasTurboTilt`, `TurboTiltSpeed`, `CanAutoScan`, `NumScanPaths`) VALUES
(1, 'Pelco-D', 'Local', 'PelcoD', 1, 1, 0, 0, 1, 1, 0, 0, 1, NULL, NULL, NULL, NULL, 1, 0, 3, 1, 1, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, 0, 1, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, 0, 1, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 20, 1, 1, 1, 1, 0, 0, 0, 1, 1, NULL, NULL, NULL, NULL, 1, 0, 63, 1, 254, 1, NULL, NULL, NULL, NULL, 1, 0, 63, 1, 254, 0, 0),
(2, 'Pelco-P', 'Local', 'PelcoP', 1, 1, 0, 0, 1, 1, 0, 0, 1, NULL, NULL, NULL, NULL, 1, 0, 3, 1, 1, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, 0, 1, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, 0, 1, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 20, 1, 1, 1, 1, 0, 0, 0, 1, 1, NULL, NULL, NULL, NULL, 1, 0, 63, 1, 254, 1, NULL, NULL, NULL, NULL, 1, 0, 63, 1, 254, 0, 0),
(3, 'Sony VISCA', 'Local', 'Visca', 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 16384, 10, 4000, 1, 1, 6, 1, 1, 1, 0, 1, 0, 1536, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 3, 1, 1, 1, 1, 0, 1, 1, 0, 1, -15578, 15578, 100, 10000, 1, 1, 50, 1, 254, 1, -7789, 7789, 100, 5000, 1, 1, 50, 1, 254, 0, 0),
(4, 'Axis API v2', 'Remote', 'AxisV2', 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 9999, 10, 2500, 0, NULL, NULL, 1, 1, 0, 1, 0, 0, 9999, 10, 2500, 0, NULL, NULL, 1, 1, 0, 1, 0, 0, 9999, 10, 2500, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 12, 1, 1, 1, 1, 1, 0, 1, 0, 1, -360, 360, 1, 90, 0, NULL, NULL, 0, NULL, 1, -360, 360, 1, 90, 0, NULL, NULL, 0, NULL, 0, 0),
(5, 'Panasonic IP', 'Remote', 'PanasonicIP', 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 8, 1, 1, 1, 0, 1, 0, 0, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0),
(6, 'Neu-Fusion NCS370', 'Remote', 'Ncs370', 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 24, 1, 0, 1, 1, 0, 0, 0, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0),
(7, 'AirLink SkyIPCam 7xx', 'Remote', 'SkyIPCam7xx', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 8, 1, 1, 1, 0, 1, 0, 1, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0),
(8, 'Pelco-D', 'Ffmpeg', 'PelcoD', 1, 1, 0, 0, 1, 1, 0, 0, 1, NULL, NULL, NULL, NULL, 1, 0, 3, 1, 1, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, 0, 1, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, 0, 1, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 20, 1, 1, 1, 1, 0, 0, 0, 1, 1, NULL, NULL, NULL, NULL, 1, 0, 63, 1, 254, 1, NULL, NULL, NULL, NULL, 1, 0, 63, 1, 254, 0, 0),
(9, 'Pelco-P', 'Ffmpeg', 'PelcoP', 1, 1, 0, 0, 1, 1, 0, 0, 1, NULL, NULL, NULL, NULL, 1, 0, 3, 1, 1, 0, 0, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, 0, 1, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 1, 0, 1, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 20, 1, 1, 1, 1, 0, 0, 0, 1, 1, NULL, NULL, NULL, NULL, 1, 0, 63, 1, 254, 1, NULL, NULL, NULL, NULL, 1, 0, 63, 1, 254, 0, 0),
(10, 'Foscam FI8620', 'Ffmpeg', 'FI8620_Y2k', 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 10, 1, 10, 1, 1, 63, 1, 1, 0, 0, 1, 1, 63, 1, 63, 1, 1, 63, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 255, 1, 8, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 360, 1, 360, 1, 1, 63, 0, 0, 1, 1, 90, 1, 90, 1, 1, 63, 0, 0, 0, 0),
(11, 'Foscam FI8608W', 'Ffmpeg', 'FI8608W_Y2k', 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 255, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 255, 1, 8, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 128, 0, 0, 1, 0, 0, 0, 0, 1, 1, 128, 0, 0, 0, 0),
(12, 'Foscam FI8908W', 'Remote', 'FI8908W', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(13, 'Foscam FI9821W', 'Ffmpeg', 'FI9821W_Y2k', 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 100, 1, 1, 0, 0, 1, 0, 100, 0, 100, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 100, 0, 100, 1, 0, 100, 1, 16, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 360, 0, 360, 1, 0, 4, 0, 0, 1, 0, 90, 0, 90, 1, 0, 4, 0, 0, 0, 0),
(14, 'Loftek Sentinel', 'Remote', 'LoftekSentinel', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 255, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 6, 1, 1, 0, 0, 0, 1, 10, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(15, 'Toshiba IK-WB11A', 'Remote', 'Toshiba_IK_WB11A', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(16, 'WanscamPT', 'Remote', 'Wanscam', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 16, 0, 0, 0, 0, 0, 1, 16, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(17, '3S Domo N5071', 'Remote', '3S', 0, 0, 1, 0, 1, 0, 1, 1, 0, 0, 9999, 0, 9999, 0, 0, 0, 1, 1, 1, 1, 0, 0, 9999, 20, 9999, 0, 0, 0, 1, 1, 1, 1, 0, 0, 9999, 1, 9999, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 64, 1, 0, 1, 1, 0, 0, 0, 0, 1, -180, 180, 40, 100, 1, 40, 100, 0, 0, 1, -180, 180, 40, 100, 1, 40, 100, 0, 0, 0, 0),
(18, 'ONVIF Camera', 'Ffmpeg', 'onvif', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 255, 16, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 6, 1, 1, 0, 0, 0, 1, 10, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(19, 'Foscam 9831W', 'Ffmpeg', 'FI9831W', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 16, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 360, 0, 360, 1, 0, 4, 0, 0, 1, 0, 90, 0, 90, 0, 0, 0, 0, 0, 0, 0),
(20, 'Foscam FI8918W', 'Ffmpeg', 'FI8918W', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 360, 0, 360, 1, 0, 4, 0, 0, 1, 0, 90, 0, 90, 1, 0, 4, 0, 0, 0, 0),
(21, 'SunEyes SP-P1802SWPTZ', 'Libvlc', 'SPP1802SWPTZ', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 8, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 64, 0, 0, 1, 0, 0, 0, 0, 1, 0, 64, 0, 0, 0, 0),
(22, 'Wanscam HW0025', 'Libvlc', 'WanscamHW0025', 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 16, 1, 1, 1, 1, 0, 1, 1, 0, 1, 0, 350, 0, 0, 1, 0, 10, 0, 0, 1, 0, 0, 0, 0, 1, 0, 10, 0, 0, 0, 0),
(23, 'IPCC 7210W', 'Remote', 'IPCC7210W', 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 16, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(24, 'Vivotek ePTZ', 'Remote', 'Vivotek_ePTZ', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 5, 0, 0, 1, 0, 0, 0, 0, 1, 0, 5, 0, 0, 0, 0),
(25, 'Netcat ONVIF', 'Ffmpeg', 'Netcat', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 100, 5, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 100, 5, 5, 0, 0, 0, 1, 255, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(26, 'Keekoon', 'Remote', 'Keekoon', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 6, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(27, 'HikVision', 'Local', '', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 20, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 100, 0, 0, 1, 0, 0, 0, 0, 1, 1, 100, 1, 0, 0, 0),
(28, 'Maginon Supra IPC', 'cURL', 'MaginonIPC', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 4, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(29, 'Floureon 1080P', 'Ffmpeg', 'Floureon', 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 18, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 20, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 8, 0, 0, 1, 0, 0, 0, 0, 1, 1, 8, 0, 0, 0, 0),
(30, 'Reolink RLC-423', 'Ffmpeg', 'Reolink', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 64, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(31, 'Reolink RLC-411', 'Ffmpeg', 'Reolink', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(32, 'Reolink RLC-420', 'Ffmpeg', 'Reolink', 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(33, 'D-LINK DCS-3415', 'Remote', 'DCS3415', 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(34, 'D-Link DCS-5020L', 'Remote', 'DCS5020L', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 24, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 30, 0, 0, 0, 0, 0, 1, 0, 0, 1, 30, 0, 0, 0, 0, 0, 0, 0),
(35, 'IOS Camera', 'Ffmpeg', 'IPCAMIOS', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(36, 'Dericam P2', 'Ffmpeg', 'DericamP2', 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 10, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 45, 0, 0, 1, 0, 0, 0, 0, 1, 1, 45, 0, 0, 0, 0),
(37, 'Trendnet', 'Remote', 'Trendnet', 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(38, 'PSIA', 'Remote', 'PSIA', 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 20, 0, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, -100, 100, 0, 0, 1, 0, 0, 0, 0, 1, -100, 100, 0, 0, 0, 0),
(39, 'Dahua', 'Ffmpeg', 'Dahua', 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 20, 1, 1, 1, 1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(40, 'FOSCAMR2C', 'Libvlc', 'FOSCAMR2C', 1, 1, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 12, 0, 1, 1, 1, 0, 0, 0, 1, 1, NULL, NULL, NULL, NULL, 1, 0, 4, 0, NULL, 1, NULL, NULL, NULL, NULL, 1, 0, 4, 0, NULL, 0, 0),
(41, 'Amcrest HTTP API', 'Ffmpeg', 'Amcrest_HTTP', 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5),
(42, 'Jennov', 'Ffmpeg', 'Jennov', 0, 0, 1, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, 0, 0, 0, 0, NULL, NULL, NULL, NULL, 0, NULL, NULL, 1, 8, 1, 1, 1, 1, 0, 0, 0, 1, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 1, NULL, NULL, NULL, NULL, 0, NULL, NULL, 0, NULL, 0, 0);
/*!40000 ALTER TABLE `Controls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Devices`
--

DROP TABLE IF EXISTS `Devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Devices` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` tinytext NOT NULL,
  `Type` enum('X10') NOT NULL DEFAULT 'X10',
  `KeyString` varchar(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Devices`
--

LOCK TABLES `Devices` WRITE;
/*!40000 ALTER TABLE `Devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `Devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events` (
  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `MonitorId` int(10) unsigned NOT NULL DEFAULT 0,
  `StorageId` smallint(5) unsigned DEFAULT 0,
  `SecondaryStorageId` smallint(5) unsigned DEFAULT 0,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Cause` varchar(32) NOT NULL DEFAULT '',
  `StartTime` datetime DEFAULT NULL,
  `EndTime` datetime DEFAULT NULL,
  `Width` smallint(5) unsigned NOT NULL DEFAULT 0,
  `Height` smallint(5) unsigned NOT NULL DEFAULT 0,
  `Length` decimal(10,2) NOT NULL DEFAULT 0.00,
  `Frames` int(10) unsigned DEFAULT NULL,
  `AlarmFrames` int(10) unsigned DEFAULT NULL,
  `DefaultVideo` varchar(64) NOT NULL DEFAULT '',
  `SaveJPEGs` tinyint(4) DEFAULT NULL,
  `TotScore` int(10) unsigned NOT NULL DEFAULT 0,
  `AvgScore` smallint(5) unsigned DEFAULT 0,
  `MaxScore` smallint(5) unsigned DEFAULT 0,
  `Archived` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Videoed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Uploaded` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Emailed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Messaged` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Executed` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Notes` text DEFAULT NULL,
  `StateId` int(10) unsigned NOT NULL,
  `Orientation` enum('ROTATE_0','ROTATE_90','ROTATE_180','ROTATE_270','FLIP_HORI','FLIP_VERT') NOT NULL DEFAULT 'ROTATE_0',
  `DiskSpace` bigint(20) unsigned DEFAULT NULL,
  `Scheme` enum('Deep','Medium','Shallow') NOT NULL DEFAULT 'Medium',
  `Locked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `Events_MonitorId_idx` (`MonitorId`),
  KEY `Events_StorageId_idx` (`StorageId`),
  KEY `Events_StartTime_idx` (`StartTime`),
  KEY `Events_EndTime_DiskSpace` (`EndTime`,`DiskSpace`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER event_insert_trigger AFTER INSERT ON Events
FOR EACH ROW
  BEGIN

  INSERT INTO Events_Hour (EventId,MonitorId,StartTime,DiskSpace) VALUES (NEW.Id,NEW.MonitorId,NEW.StartTime,0);
  INSERT INTO Events_Day (EventId,MonitorId,StartTime,DiskSpace) VALUES (NEW.Id,NEW.MonitorId,NEW.StartTime,0);
  INSERT INTO Events_Week (EventId,MonitorId,StartTime,DiskSpace) VALUES (NEW.Id,NEW.MonitorId,NEW.StartTime,0);
  INSERT INTO Events_Month (EventId,MonitorId,StartTime,DiskSpace) VALUES (NEW.Id,NEW.MonitorId,NEW.StartTime,0);
  UPDATE Monitors SET
  HourEvents = COALESCE(HourEvents,0)+1,
  DayEvents = COALESCE(DayEvents,0)+1,
  WeekEvents = COALESCE(WeekEvents,0)+1,
  MonthEvents = COALESCE(MonthEvents,0)+1,
  TotalEvents = COALESCE(TotalEvents,0)+1
  WHERE Id=NEW.MonitorId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER event_update_trigger AFTER UPDATE ON Events 
FOR EACH ROW
BEGIN
  declare diff BIGINT default 0;

  set diff = COALESCE(NEW.DiskSpace,0) - COALESCE(OLD.DiskSpace,0);
  IF ( NEW.StorageId = OLD.StorageID ) THEN
    IF ( diff ) THEN
      UPDATE Storage SET DiskSpace = GREATEST(COALESCE(DiskSpace,0) + diff,0) WHERE Id = OLD.StorageId;
    END IF;
  ELSE
    IF ( NEW.DiskSpace ) THEN
      UPDATE Storage SET DiskSpace = COALESCE(DiskSpace,0) + NEW.DiskSpace WHERE Id = NEW.StorageId;
    END IF;
    IF ( OLD.DiskSpace ) THEN
      UPDATE Storage SET DiskSpace = GREATEST(COALESCE(DiskSpace,0) - OLD.DiskSpace,0) WHERE Id = OLD.StorageId;
    END IF;
  END IF;

  UPDATE Events_Hour SET DiskSpace=NEW.DiskSpace WHERE EventId=NEW.Id;
  UPDATE Events_Day SET DiskSpace=NEW.DiskSpace WHERE EventId=NEW.Id;
  UPDATE Events_Week SET DiskSpace=NEW.DiskSpace WHERE EventId=NEW.Id;
  UPDATE Events_Month SET DiskSpace=NEW.DiskSpace WHERE EventId=NEW.Id;

  IF ( NEW.Archived != OLD.Archived ) THEN
    IF ( NEW.Archived ) THEN
      INSERT INTO Events_Archived (EventId,MonitorId,DiskSpace) VALUES (NEW.Id,NEW.MonitorId,NEW.DiskSpace);
      UPDATE Monitors SET ArchivedEvents = COALESCE(ArchivedEvents,0)+1, ArchivedEventDiskSpace = COALESCE(ArchivedEventDiskSpace,0) + COALESCE(NEW.DiskSpace,0) WHERE Id=NEW.MonitorId;
    ELSEIF ( OLD.Archived ) THEN
      DELETE FROM Events_Archived WHERE EventId=OLD.Id;
      UPDATE Monitors
        SET
          ArchivedEvents = GREATEST(COALESCE(ArchivedEvents,0)-1,0),
          ArchivedEventDiskSpace = GREATEST(COALESCE(ArchivedEventDiskSpace,0) - COALESCE(OLD.DiskSpace,0),0)
        WHERE Id=OLD.MonitorId;
    ELSE
      IF ( OLD.DiskSpace != NEW.DiskSpace ) THEN
        UPDATE Events_Archived SET DiskSpace=NEW.DiskSpace WHERE EventId=NEW.Id;
        UPDATE Monitors SET
          ArchivedEventDiskSpace = GREATEST(COALESCE(ArchivedEventDiskSpace,0) - COALESCE(OLD.DiskSpace,0) + COALESCE(NEW.DiskSpace,0),0)
          WHERE Id=OLD.MonitorId;
      END IF;
    END IF;
  ELSEIF ( NEW.Archived AND diff ) THEN
    UPDATE Events_Archived SET DiskSpace=NEW.DiskSpace WHERE EventId=NEW.Id;
  END IF;

  IF ( diff ) THEN
    UPDATE Monitors
      SET
        TotalEventDiskSpace = GREATEST(COALESCE(TotalEventDiskSpace,0) - COALESCE(OLD.DiskSpace,0) + COALESCE(NEW.DiskSpace,0),0)
      WHERE Id=OLD.MonitorId;
  END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER event_delete_trigger BEFORE DELETE ON Events
FOR EACH ROW
BEGIN
  IF ( OLD.DiskSpace ) THEN
    UPDATE Storage SET DiskSpace = GREATEST(COALESCE(DiskSpace,0) - COALESCE(OLD.DiskSpace,0),0) WHERE Id = OLD.StorageId;
  END IF;
  DELETE FROM Events_Hour WHERE EventId=OLD.Id;
  DELETE FROM Events_Day WHERE EventId=OLD.Id;
  DELETE FROM Events_Week WHERE EventId=OLD.Id;
  DELETE FROM Events_Month WHERE EventId=OLD.Id;
  IF ( OLD.Archived ) THEN
    DELETE FROM Events_Archived WHERE EventId=OLD.Id;
    UPDATE Monitors SET
      ArchivedEvents = GREATEST(COALESCE(ArchivedEvents,1) - 1,0),
      ArchivedEventDiskSpace = GREATEST(COALESCE(ArchivedEventDiskSpace,0) - COALESCE(OLD.DiskSpace,0),0),
      TotalEvents = GREATEST(COALESCE(TotalEvents,1) - 1,0),
      TotalEventDiskSpace = GREATEST(COALESCE(TotalEventDiskSpace,0) - COALESCE(OLD.DiskSpace,0),0)
      WHERE Id=OLD.MonitorId;
  ELSE
    UPDATE Monitors SET
    TotalEvents = GREATEST(COALESCE(TotalEvents,1)-1,0),
    TotalEventDiskSpace=GREATEST(COALESCE(TotalEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0)
    WHERE Id=OLD.MonitorId;
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Events_Archived`
--

DROP TABLE IF EXISTS `Events_Archived`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events_Archived` (
  `EventId` bigint(20) unsigned NOT NULL,
  `MonitorId` int(10) unsigned NOT NULL,
  `DiskSpace` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`EventId`),
  KEY `Events_Archived_MonitorId_idx` (`MonitorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events_Archived`
--

LOCK TABLES `Events_Archived` WRITE;
/*!40000 ALTER TABLE `Events_Archived` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events_Archived` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Events_Day`
--

DROP TABLE IF EXISTS `Events_Day`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events_Day` (
  `EventId` bigint(20) unsigned NOT NULL,
  `MonitorId` int(10) unsigned NOT NULL,
  `StartTime` datetime DEFAULT NULL,
  `DiskSpace` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`EventId`),
  KEY `Events_Day_MonitorId_idx` (`MonitorId`),
  KEY `Events_Day_StartTime_idx` (`StartTime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events_Day`
--

LOCK TABLES `Events_Day` WRITE;
/*!40000 ALTER TABLE `Events_Day` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events_Day` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Events_Day_update_trigger AFTER UPDATE ON Events_Day
FOR EACH ROW
  BEGIN
    declare diff BIGINT default 0;

    set diff = COALESCE(NEW.DiskSpace,0) - COALESCE(OLD.DiskSpace,0);
    IF ( diff ) THEN
      IF ( NEW.MonitorID != OLD.MonitorID ) THEN
        UPDATE Monitors SET DayEventDiskSpace=GREATEST(COALESCE(DayEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0) WHERE Monitors.Id=OLD.MonitorId;
        UPDATE Monitors SET DayEventDiskSpace=COALESCE(DayEventDiskSpace,0)+COALESCE(NEW.DiskSpace,0) WHERE Monitors.Id=NEW.MonitorId;
      ELSE
        UPDATE Monitors SET DayEventDiskSpace=GREATEST(COALESCE(DayEventDiskSpace,0)+diff,0) WHERE Monitors.Id=NEW.MonitorId;
      END IF;
    END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Events_Day_delete_trigger BEFORE DELETE ON Events_Day
FOR EACH ROW BEGIN
  UPDATE Monitors SET
  DayEvents = GREATEST(COALESCE(DayEvents,1)-1,0),
  DayEventDiskSpace=GREATEST(COALESCE(DayEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0)
  WHERE Id=OLD.MonitorId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Events_Hour`
--

DROP TABLE IF EXISTS `Events_Hour`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events_Hour` (
  `EventId` bigint(20) unsigned NOT NULL,
  `MonitorId` int(10) unsigned NOT NULL,
  `StartTime` datetime DEFAULT NULL,
  `DiskSpace` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`EventId`),
  KEY `Events_Hour_MonitorId_idx` (`MonitorId`),
  KEY `Events_Hour_StartTime_idx` (`StartTime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events_Hour`
--

LOCK TABLES `Events_Hour` WRITE;
/*!40000 ALTER TABLE `Events_Hour` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events_Hour` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Events_Hour_update_trigger AFTER UPDATE ON Events_Hour
FOR EACH ROW
  BEGIN
    declare diff BIGINT default 0;

    set diff = COALESCE(NEW.DiskSpace,0) - COALESCE(OLD.DiskSpace,0);
    IF ( diff ) THEN
      IF ( NEW.MonitorID != OLD.MonitorID ) THEN
        UPDATE Monitors SET HourEventDiskSpace=GREATEST(COALESCE(HourEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0) WHERE Monitors.Id=OLD.MonitorId;
        UPDATE Monitors SET HourEventDiskSpace=COALESCE(HourEventDiskSpace,0)+COALESCE(NEW.DiskSpace,0) WHERE Monitors.Id=NEW.MonitorId;
      ELSE
        UPDATE Monitors SET HourEventDiskSpace=COALESCE(HourEventDiskSpace,0)+diff WHERE Monitors.Id=NEW.MonitorId;
      END IF;
    END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Events_Hour_delete_trigger BEFORE DELETE ON Events_Hour
FOR EACH ROW BEGIN
  UPDATE Monitors SET
  HourEvents = GREATEST(COALESCE(HourEvents,1)-1,0),
  HourEventDiskSpace=GREATEST(COALESCE(HourEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0)
  WHERE Id=OLD.MonitorId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Events_Month`
--

DROP TABLE IF EXISTS `Events_Month`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events_Month` (
  `EventId` bigint(20) unsigned NOT NULL,
  `MonitorId` int(10) unsigned NOT NULL,
  `StartTime` datetime DEFAULT NULL,
  `DiskSpace` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`EventId`),
  KEY `Events_Month_MonitorId_idx` (`MonitorId`),
  KEY `Events_Month_StartTime_idx` (`StartTime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events_Month`
--

LOCK TABLES `Events_Month` WRITE;
/*!40000 ALTER TABLE `Events_Month` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events_Month` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Events_Month_update_trigger AFTER UPDATE ON Events_Month
FOR EACH ROW
  BEGIN
    declare diff BIGINT default 0;

    set diff = COALESCE(NEW.DiskSpace,0) - COALESCE(OLD.DiskSpace,0);
    IF ( diff ) THEN
      IF ( NEW.MonitorID != OLD.MonitorID ) THEN
        UPDATE Monitors SET MonthEventDiskSpace=GREATEST(COALESCE(MonthEventDiskSpace,0)-COALESCE(OLD.DiskSpace),0) WHERE Monitors.Id=OLD.MonitorId;
        UPDATE Monitors SET MonthEventDiskSpace=COALESCE(MonthEventDiskSpace,0)+COALESCE(NEW.DiskSpace) WHERE Monitors.Id=NEW.MonitorId;
      ELSE
        UPDATE Monitors SET MonthEventDiskSpace=GREATEST(COALESCE(MonthEventDiskSpace,0)+diff,0) WHERE Monitors.Id=NEW.MonitorId;
      END IF;
    END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Events_Month_delete_trigger BEFORE DELETE ON Events_Month
FOR EACH ROW BEGIN
  UPDATE Monitors SET
  MonthEvents = GREATEST(COALESCE(MonthEvents,1)-1,0),
  MonthEventDiskSpace=GREATEST(COALESCE(MonthEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0)
  WHERE Id=OLD.MonitorId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Events_Week`
--

DROP TABLE IF EXISTS `Events_Week`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Events_Week` (
  `EventId` bigint(20) unsigned NOT NULL,
  `MonitorId` int(10) unsigned NOT NULL,
  `StartTime` datetime DEFAULT NULL,
  `DiskSpace` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`EventId`),
  KEY `Events_Week_MonitorId_idx` (`MonitorId`),
  KEY `Events_Week_StartTime_idx` (`StartTime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events_Week`
--

LOCK TABLES `Events_Week` WRITE;
/*!40000 ALTER TABLE `Events_Week` DISABLE KEYS */;
/*!40000 ALTER TABLE `Events_Week` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Events_Week_update_trigger AFTER UPDATE ON Events_Week
FOR EACH ROW
  BEGIN
    declare diff BIGINT default 0;

    set diff = COALESCE(NEW.DiskSpace,0) - COALESCE(OLD.DiskSpace,0);
    IF ( diff ) THEN
      IF ( NEW.MonitorID != OLD.MonitorID ) THEN
        UPDATE Monitors SET WeekEventDiskSpace=GREATEST(COALESCE(WeekEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0) WHERE Monitors.Id=OLD.MonitorId;
        UPDATE Monitors SET WeekEventDiskSpace=COALESCE(WeekEventDiskSpace,0)+COALESCE(NEW.DiskSpace,0) WHERE Monitors.Id=NEW.MonitorId;
      ELSE
        UPDATE Monitors SET WeekEventDiskSpace=GREATEST(COALESCE(WeekEventDiskSpace,0)+diff,0) WHERE Monitors.Id=NEW.MonitorId;
      END IF;
    END IF;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Events_Week_delete_trigger BEFORE DELETE ON Events_Week
FOR EACH ROW BEGIN
  UPDATE Monitors SET
  WeekEvents = GREATEST(COALESCE(WeekEvents,1)-1,0),
  WeekEventDiskSpace=GREATEST(COALESCE(WeekEventDiskSpace,0)-COALESCE(OLD.DiskSpace,0),0)
  WHERE Id=OLD.MonitorId;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Filters`
--

DROP TABLE IF EXISTS `Filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Filters` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Query_json` text NOT NULL,
  `AutoArchive` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoVideo` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoUpload` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoEmail` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoMessage` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoExecute` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoExecuteCmd` tinytext DEFAULT NULL,
  `AutoDelete` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoMove` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoMoveTo` smallint(5) unsigned NOT NULL DEFAULT 0,
  `AutoCopy` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AutoCopyTo` smallint(5) unsigned NOT NULL DEFAULT 0,
  `UpdateDiskSpace` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Background` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Concurrent` tinyint(1) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Filters`
--

LOCK TABLES `Filters` WRITE;
/*!40000 ALTER TABLE `Filters` DISABLE KEYS */;
INSERT INTO `Filters` VALUES (1,'PurgeWhenFull','{\"sort_field\":\"Id\",\"terms\":[{\"val\":0,\"attr\":\"Archived\",\"op\":\"=\"},{\"cnj\":\"and\",\"val\":95,\"attr\":\"DiskPercent\",\"op\":\">=\"}],\"limit\":100,\"sort_asc\":1}',0,0,0,0,0,0,'',1,0,0,0,0,0,1,0),(2,'Update DiskSpace','{\"terms\":[{\"attr\":\"DiskSpace\",\"op\":\"IS\",\"val\":\"NULL\"}]}',0,0,0,0,0,0,'',0,0,0,0,0,1,1,0);
/*!40000 ALTER TABLE `Filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Frames`
--

DROP TABLE IF EXISTS `Frames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Frames` (
  `Id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `EventId` bigint(20) unsigned NOT NULL DEFAULT 0,
  `FrameId` int(10) unsigned NOT NULL DEFAULT 0,
  `Type` enum('Normal','Bulk','Alarm') NOT NULL DEFAULT 'Normal',
  `TimeStamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Delta` decimal(8,2) NOT NULL DEFAULT 0.00,
  `Score` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `EventId_idx` (`EventId`),
  KEY `Type` (`Type`),
  KEY `TimeStamp` (`TimeStamp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Frames`
--

LOCK TABLES `Frames` WRITE;
/*!40000 ALTER TABLE `Frames` DISABLE KEYS */;
/*!40000 ALTER TABLE `Frames` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Groups`
--

DROP TABLE IF EXISTS `Groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Groups` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `ParentId` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Groups`
--

LOCK TABLES `Groups` WRITE;
/*!40000 ALTER TABLE `Groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `Groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Groups_Monitors`
--

DROP TABLE IF EXISTS `Groups_Monitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Groups_Monitors` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `GroupId` int(10) unsigned NOT NULL,
  `MonitorId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Id`),
  KEY `Groups_Monitors_GroupId_idx` (`GroupId`),
  KEY `Groups_Monitors_MonitorId_idx` (`MonitorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Groups_Monitors`
--

LOCK TABLES `Groups_Monitors` WRITE;
/*!40000 ALTER TABLE `Groups_Monitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `Groups_Monitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Logs`
--

DROP TABLE IF EXISTS `Logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Logs` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `TimeKey` decimal(16,6) NOT NULL,
  `Component` varchar(32) NOT NULL,
  `ServerId` int(10) unsigned DEFAULT NULL,
  `Pid` int(10) DEFAULT NULL,
  `Level` tinyint(3) NOT NULL,
  `Code` char(3) NOT NULL,
  `Message` text NOT NULL,
  `File` varchar(255) DEFAULT NULL,
  `Line` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `TimeKey` (`TimeKey`),
  KEY `Logs_TimeKey_idx` (`TimeKey`),
  KEY `Logs_Level_idx` (`Level`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Logs`
--

LOCK TABLES `Logs` WRITE;
/*!40000 ALTER TABLE `Logs` DISABLE KEYS */;
INSERT INTO `Logs` VALUES (1,1599329233.020790,'zmpkg',NULL,100328,0,'INF','Sanity checking States table...','zmpkg.pl',NULL),(2,1599329233.174520,'zmpkg',NULL,100328,0,'INF','Command: start','zmpkg.pl',NULL),(3,1599329233.716580,'zmdc',NULL,100337,0,'INF','Server starting at 20/09/05 20:07:13','zmdc.pl',NULL),(4,1599329234.846200,'zmdc',NULL,100337,0,'INF','Socket should be open at /run/zoneminder/zmdc.sock','zmdc.pl',NULL),(5,1599329234.922130,'zmpkg',NULL,100328,0,'INF','Single server configuration detected. Starting up services.','zmpkg.pl',NULL),(6,1599329235.183610,'zmdc',NULL,100337,0,'INF','\'zmfilter.pl --filter_id=1 --daemon\' starting at 20/09/05 20:07:15, pid = 100365','zmdc.pl',NULL),(7,1599329235.183620,'zmdc',NULL,100365,0,'INF','\'zmfilter.pl --filter_id=1 --daemon\' started at 20/09/05 20:07:15','zmdc.pl',NULL),(8,1599329235.425870,'zmdc',NULL,100337,0,'INF','\'zmfilter.pl --filter_id=2 --daemon\' starting at 20/09/05 20:07:15, pid = 100370','zmdc.pl',NULL),(9,1599329235.426430,'zmdc',NULL,100370,0,'INF','\'zmfilter.pl --filter_id=2 --daemon\' started at 20/09/05 20:07:15','zmdc.pl',NULL),(10,1599329235.590750,'zmfilter_1',NULL,100365,0,'INF','Scanning for events using filter id \'1\'','zmfilter.pl',NULL),(11,1599329235.599110,'zmdc',NULL,100337,0,'INF','\'zmwatch.pl\' starting at 20/09/05 20:07:15, pid = 100377','zmdc.pl',NULL),(12,1599329235.599120,'zmdc',NULL,100377,0,'INF','\'zmwatch.pl\' started at 20/09/05 20:07:15','zmdc.pl',NULL),(13,1599329235.760740,'zmwatch',NULL,100377,0,'INF','Watchdog starting, pausing for 30 seconds','zmwatch.pl',NULL),(14,1599329235.780040,'zmdc',NULL,100337,0,'INF','\'zmupdate.pl -c\' starting at 20/09/05 20:07:15, pid = 100383','zmdc.pl',NULL),(15,1599329235.780560,'zmdc',NULL,100383,0,'INF','\'zmupdate.pl -c\' started at 20/09/05 20:07:15','zmdc.pl',NULL),(16,1599329235.828990,'zmfilter_2',NULL,100370,0,'INF','Scanning for events using filter id \'2\'','zmfilter.pl',NULL),(17,1599329235.993960,'zmupdate',NULL,100383,0,'INF','Checking for updates','zmupdate.pl',NULL),(18,1599329236.043860,'zmdc',NULL,100337,0,'INF','\'zmstats.pl\' starting at 20/09/05 20:07:16, pid = 100390','zmdc.pl',NULL),(19,1599329236.043870,'zmdc',NULL,100390,0,'INF','\'zmstats.pl\' started at 20/09/05 20:07:16','zmdc.pl',NULL),(20,1599329236.193900,'zmstats',NULL,100390,0,'INF','Stats Daemon starting in 30 seconds','zmstats.pl',NULL),(21,1599329236.730480,'zmupdate',NULL,100383,0,'INF','Got version: \'1.34.16\'','zmupdate.pl',NULL),(22,1599329592.414660,'zmpkg',NULL,100472,0,'INF','Sanity checking States table...','zmpkg.pl',NULL),(23,1599329592.423420,'zmpkg',NULL,100472,0,'INF','Command: stop','zmpkg.pl',NULL),(24,1599329592.785130,'zmdc',NULL,100337,0,'INF','Server exiting at 20/09/05 20:13:12','zmdc.pl',NULL),(25,1599329592.793620,'zmdc',NULL,100337,0,'INF','\'zmfilter.pl --filter_id=2 --daemon\' sending stop to pid 100370 at 20/09/05 20:13:12','zmdc.pl',NULL),(26,1599329592.799570,'zmdc',NULL,100337,0,'INF','\'zmstats.pl\' sending stop to pid 100390 at 20/09/05 20:13:12','zmdc.pl',NULL),(27,1599329592.799790,'zmfilter_2',NULL,100370,0,'INF','Received TERM, exiting','zmfilter.pl',NULL),(28,1599329592.811640,'zmdc',NULL,100337,0,'INF','\'zmfilter.pl --filter_id=1 --daemon\' sending stop to pid 100365 at 20/09/05 20:13:12','zmdc.pl',NULL),(29,1599329592.823940,'zmfilter_1',NULL,100365,0,'INF','Received TERM, exiting','zmfilter.pl',NULL),(30,1599329592.823630,'zmdc',NULL,100337,0,'INF','\'zmwatch.pl\' sending stop to pid 100377 at 20/09/05 20:13:12','zmdc.pl',NULL),(31,1599329592.835510,'zmdc',NULL,100337,0,'INF','\'zmupdate.pl -c\' sending stop to pid 100383 at 20/09/05 20:13:12','zmdc.pl',NULL),(32,1599329592.868250,'zmdc',NULL,100337,0,'INF','\'zmfilter.pl --filter_id=1 --daemon\' exited normally','zmdc.pl',NULL),(33,1599329592.871650,'zmdc',NULL,100337,0,'INF','\'zmstats.pl\' exited, signal 14','zmdc.pl',NULL),(34,1599329592.877570,'zmdc',NULL,100337,0,'INF','\'zmfilter.pl --filter_id=2 --daemon\' exited normally','zmdc.pl',NULL),(35,1599329592.883570,'zmdc',NULL,100337,0,'INF','\'zmwatch.pl\' exited, signal 14','zmdc.pl',NULL),(36,1599329593.890370,'zmdc',NULL,100337,0,'INF','\'zmupdate.pl -c\' exited, signal 14','zmdc.pl',NULL),(37,1599329593.895700,'zmdc',NULL,100337,0,'INF','Server shutdown at 20/09/05 20:13:13','zmdc.pl',NULL),(38,1599329605.079820,'zmpkg',NULL,425,0,'INF','Sanity checking States table...','zmpkg.pl',NULL),(39,1599329605.094350,'zmpkg',NULL,425,0,'INF','Command: start','zmpkg.pl',NULL),(40,1599329605.625170,'zmdc',NULL,442,0,'INF','Server starting at 20/09/05 20:13:25','zmdc.pl',NULL),(41,1599329606.725490,'zmdc',NULL,442,0,'INF','Socket should be open at /run/zoneminder/zmdc.sock','zmdc.pl',NULL),(42,1599329606.831320,'zmpkg',NULL,425,0,'INF','Single server configuration detected. Starting up services.','zmpkg.pl',NULL),(43,1599329607.072480,'zmdc',NULL,442,0,'INF','\'zmfilter.pl --filter_id=1 --daemon\' starting at 20/09/05 20:13:27, pid = 478','zmdc.pl',NULL),(44,1599329607.072490,'zmdc',NULL,478,0,'INF','\'zmfilter.pl --filter_id=1 --daemon\' started at 20/09/05 20:13:27','zmdc.pl',NULL),(45,1599329607.235110,'zmdc',NULL,442,0,'INF','\'zmfilter.pl --filter_id=2 --daemon\' starting at 20/09/05 20:13:27, pid = 483','zmdc.pl',NULL),(46,1599329607.237890,'zmdc',NULL,483,0,'INF','\'zmfilter.pl --filter_id=2 --daemon\' started at 20/09/05 20:13:27','zmdc.pl',NULL),(47,1599329607.426810,'zmfilter_1',NULL,478,0,'INF','Scanning for events using filter id \'1\'','zmfilter.pl',NULL),(48,1599329607.437910,'zmdc',NULL,442,0,'INF','\'zmwatch.pl\' starting at 20/09/05 20:13:27, pid = 490','zmdc.pl',NULL),(49,1599329607.440270,'zmdc',NULL,490,0,'INF','\'zmwatch.pl\' started at 20/09/05 20:13:27','zmdc.pl',NULL),(50,1599329607.591800,'zmwatch',NULL,490,0,'INF','Watchdog starting, pausing for 30 seconds','zmwatch.pl',NULL),(51,1599329607.599060,'zmfilter_2',NULL,483,0,'INF','Scanning for events using filter id \'2\'','zmfilter.pl',NULL),(52,1599329607.608890,'zmdc',NULL,442,0,'INF','\'zmupdate.pl -c\' starting at 20/09/05 20:13:27, pid = 498','zmdc.pl',NULL),(53,1599329607.608890,'zmdc',NULL,498,0,'INF','\'zmupdate.pl -c\' started at 20/09/05 20:13:27','zmdc.pl',NULL),(54,1599329607.800350,'zmdc',NULL,442,0,'INF','\'zmstats.pl\' starting at 20/09/05 20:13:27, pid = 503','zmdc.pl',NULL),(55,1599329607.800360,'zmdc',NULL,503,0,'INF','\'zmstats.pl\' started at 20/09/05 20:13:27','zmdc.pl',NULL),(56,1599329607.990980,'zmstats',NULL,503,0,'INF','Stats Daemon starting in 30 seconds','zmstats.pl',NULL),(57,1599329667.543449,'web_php',NULL,402,-2,'ERR','There was no monitor to display.','skins/classic/views/cycle.php',91),(58,1599329877.300131,'web_php',NULL,402,-2,'ERR','There was no monitor to display.','skins/classic/views/cycle.php',91);
/*!40000 ALTER TABLE `Logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manufacturers`
--

DROP TABLE IF EXISTS `Manufacturers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Manufacturers` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manufacturers`
--

LOCK TABLES `Manufacturers` WRITE;
/*!40000 ALTER TABLE `Manufacturers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Manufacturers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Maps`
--

DROP TABLE IF EXISTS `Maps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Maps` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `Filename` varchar(64) NOT NULL DEFAULT '',
  `NumCoords` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Coords` tinytext NOT NULL,
  `ParentId` int(1) unsigned DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Maps`
--

LOCK TABLES `Maps` WRITE;
/*!40000 ALTER TABLE `Maps` DISABLE KEYS */;
/*!40000 ALTER TABLE `Maps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Models`
--

DROP TABLE IF EXISTS `Models`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Models` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `ManufacturerId` int(10) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `ManufacturerId` (`ManufacturerId`,`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Models`
--

LOCK TABLES `Models` WRITE;
/*!40000 ALTER TABLE `Models` DISABLE KEYS */;
/*!40000 ALTER TABLE `Models` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MonitorPresets`
--

DROP TABLE IF EXISTS `MonitorPresets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MonitorPresets` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Type` enum('Local','Remote','File','Ffmpeg','Libvlc','cURL','WebSite','NVSocket') NOT NULL DEFAULT 'Local',
  `Device` tinytext DEFAULT NULL,
  `Channel` tinyint(3) unsigned DEFAULT NULL,
  `Format` int(10) unsigned DEFAULT NULL,
  `Protocol` varchar(16) DEFAULT NULL,
  `Method` varchar(16) DEFAULT NULL,
  `Host` varchar(64) DEFAULT NULL,
  `Port` varchar(8) DEFAULT NULL,
  `Path` varchar(255) DEFAULT NULL,
  `SubPath` varchar(64) DEFAULT NULL,
  `Width` smallint(5) unsigned DEFAULT NULL,
  `Height` smallint(5) unsigned DEFAULT NULL,
  `Palette` int(10) unsigned DEFAULT NULL,
  `MaxFPS` decimal(5,3) DEFAULT NULL,
  `Controllable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ControlId` varchar(16) DEFAULT NULL,
  `ControlDevice` varchar(255) DEFAULT NULL,
  `ControlAddress` varchar(255) DEFAULT NULL,
  `DefaultRate` smallint(5) unsigned NOT NULL DEFAULT 100,
  `DefaultScale` smallint(5) unsigned NOT NULL DEFAULT 100,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MonitorPresets`
--

LOCK TABLES `MonitorPresets` WRITE;
/*!40000 ALTER TABLE `MonitorPresets` DISABLE KEYS */;
INSERT INTO `MonitorPresets` VALUES (1,'Axis IP, 320x240, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=320x240',NULL,320,240,3,NULL,0,NULL,NULL,NULL,100,100),(2,'Axis IP, 320x240, mpjpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=320x240&req_fps=5',NULL,320,240,3,NULL,0,NULL,NULL,NULL,100,100),(3,'Axis IP, 320x240, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/jpg/image.cgi?resolution=320x240',NULL,320,240,3,NULL,0,NULL,NULL,NULL,100,100),(4,'Axis IP, 320x240, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/jpg/image.cgi?resolution=320x240',NULL,320,240,3,5.000,0,NULL,NULL,NULL,100,100),(5,'Axis IP, 640x480, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=640x480',NULL,640,480,3,NULL,0,NULL,NULL,NULL,100,100),(6,'Axis IP, 640x480, mpjpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=640x480&req_fps=5',NULL,640,480,3,NULL,0,NULL,NULL,NULL,100,100),(7,'Axis IP, 640x480, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/jpg/image.cgi?resolution=640x480',NULL,640,480,3,NULL,0,NULL,NULL,NULL,100,100),(8,'Axis IP, 640x480, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/jpg/image.cgi?resolution=640x480',NULL,640,480,3,5.000,0,NULL,NULL,NULL,100,100),(9,'Axis IP, 320x240, mpjpeg, B&W','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=320x240&color=0',NULL,320,240,3,NULL,0,NULL,NULL,NULL,100,100),(10,'Axis IP, 640x480, mpjpeg, B&W','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=640x480&color=0',NULL,640,480,3,NULL,0,NULL,NULL,NULL,100,100),(11,'Axis IP PTZ, 320x240, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=320x240',NULL,320,240,3,NULL,1,'4',NULL,'<ip-address>:<port>',100,100),(12,'Axis IP PTZ, 320x240, mpjpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=320x240&req_fps=5',NULL,320,240,3,NULL,1,'4',NULL,'<ip-address>:<port>',100,100),(13,'Axis IP PTZ, 320x240, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/jpg/image.cgi?resolution=320x240',NULL,320,240,3,NULL,1,'4',NULL,'<ip-address>:<port>',100,100),(14,'Axis IP PTZ, 320x240, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/jpg/image.cgi?resolution=320x240',NULL,320,240,3,5.000,1,'4',NULL,'<ip-address>:<port>',100,100),(15,'Axis IP PTZ, 640x480, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=640x480',NULL,640,480,3,NULL,1,'4',NULL,'<ip-address>:<port>',100,100),(16,'Axis IP PTZ, 640x480, mpjpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/mjpg/video.cgi?resolution=640x480&req_fps=5',NULL,640,480,3,NULL,1,'4',NULL,'<ip-address>:<port>',100,100),(17,'Axis IP PTZ, 640x480, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/jpg/image.cgi?resolution=640x480',NULL,640,480,3,NULL,1,'4',NULL,'<ip-address>:<port>',100,100),(18,'Axis IP PTZ, 640x480, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/axis-cgi/jpg/image.cgi?resolution=640x480',NULL,640,480,3,5.000,1,'4',NULL,'<ip-address>:<port>',100,100),(19,'Axis IP, mpeg4, unicast','Remote','rtsp',0,255,'rtsp','rtpUni','<ip-address>','554','/mpeg4/media.amp','/trackID=',NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(20,'Axis IP, mpeg4, multicast','Remote','rtsp',0,255,'rtsp','rtpMulti','<ip-address>','554','/mpeg4/media.amp','/trackID=',NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(21,'Axis IP, mpeg4, RTP/RTSP','Remote','rtsp',0,255,'rtsp','rtpRtsp','<ip-address>','554','/mpeg4/media.amp','/trackID=',NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(22,'Axis IP, mpeg4, RTP/RTSP/HTTP','Remote',NULL,NULL,NULL,'rtsp','rtpRtspHttp','<ip-address>','554','/mpeg4/media.amp','/trackID=',NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(23,'D-link DCS-930L, 640x480, mjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/mjpeg.cgi',NULL,640,480,3,NULL,0,NULL,NULL,NULL,100,100),(24,'D-Link DCS-5020L, 640x480, mjpeg','Remote','http',0,0,'http','simple','<username>:<pwd>@<ip-address>','80','/video.cgi',NULL,640,480,0,NULL,1,'34',NULL,'<username>:<pwd>@<ip-address>',100,100),(25,'Panasonic IP, 320x240, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/nphMotionJpeg?Resolution=320x240&Quality=Standard',NULL,320,240,3,NULL,0,NULL,NULL,NULL,100,100),(26,'Panasonic IP, 320x240, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/SnapshotJPEG?Resolution=320x240&Quality=Standard',NULL,320,240,3,NULL,0,NULL,NULL,NULL,100,100),(27,'Panasonic IP, 320x240, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/SnapshotJPEG?Resolution=320x240&Quality=Standard',NULL,320,240,3,5.000,0,NULL,NULL,NULL,100,100),(28,'Panasonic IP, 640x480, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/nphMotionJpeg?Resolution=640x480&Quality=Standard',NULL,640,480,3,NULL,0,NULL,NULL,NULL,100,100),(29,'Panasonic IP, 640x480, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/SnapshotJPEG?Resolution=640x480&Quality=Standard',NULL,640,480,3,NULL,0,NULL,NULL,NULL,100,100),(30,'Panasonic IP, 640x480, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/SnapshotJPEG?Resolution=640x480&Quality=Standard',NULL,640,480,3,5.000,0,NULL,NULL,NULL,100,100),(31,'Panasonic IP PTZ, 320x240, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/nphMotionJpeg?Resolution=320x240&Quality=Standard',NULL,320,240,3,NULL,1,'5',NULL,'<ip-address>:<port>',100,100),(32,'Panasonic IP PTZ, 320x240, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/SnapshotJPEG?Resolution=320x240&Quality=Standard',NULL,320,240,3,NULL,1,'5',NULL,'<ip-address>:<port>',100,100),(33,'Panasonic IP PTZ, 320x240, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/SnapshotJPEG?Resolution=320x240&Quality=Standard',NULL,320,240,3,5.000,1,'5',NULL,'<ip-address>:<port>',100,100),(34,'Panasonic IP PTZ, 640x480, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/nphMotionJpeg?Resolution=640x480&Quality=Standard',NULL,640,480,3,NULL,1,'5',NULL,'<ip-address>:<port>',100,100),(35,'Panasonic IP PTZ, 640x480, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/SnapshotJPEG?Resolution=640x480&Quality=Standard',NULL,640,480,3,NULL,1,'5',NULL,'<ip-address>:<port>',100,100),(36,'Panasonic IP PTZ, 640x480, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/SnapshotJPEG?Resolution=640x480&Quality=Standard',NULL,640,480,3,5.000,1,'5',NULL,'<ip-address>:<port>',100,100),(37,'Gadspot IP, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/Jpeg/CamImg.jpg',NULL,NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(38,'Gadspot IP, jpeg, max 5 FPS','Remote','http',0,0,'http','simple','<ip-address>','80','/Jpeg/CamImg.jpg',NULL,NULL,NULL,3,5.000,0,NULL,NULL,NULL,100,100),(39,'Gadspot IP, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/GetData.cgi',NULL,NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(40,'Gadspot IP, mpjpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/Jpeg/CamImg.jpg',NULL,NULL,NULL,3,5.000,0,NULL,NULL,NULL,100,100),(41,'IP Webcam by Pavel Khlebovich 1920x1080','Remote','/dev/video<?>',0,255,'http','simple','<ip-address>','8080','/video','',1920,1080,0,NULL,0,'0','','',100,100),(42,'VEO Observer, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/Jpeg/CamImg.jpg',NULL,NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(43,'Blue Net Video Server, jpeg','Remote','http',0,0,'http','simple','<ip-address>','80','/cgi-bin/image.cgi?control=0&id=admin&passwd=admin',NULL,320,240,3,NULL,0,NULL,NULL,NULL,100,100),(44,'ACTi IP, mpeg4, unicast','Remote',NULL,NULL,NULL,'rtsp','rtpUni','<ip-address>','7070','','/track',NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(45,'Axis FFMPEG H.264','Ffmpeg',NULL,NULL,NULL,NULL,NULL,'rtsp://<host/address>/axis-media/media.amp?videocodec=h264',NULL,NULL,NULL,640,480,3,NULL,0,NULL,NULL,NULL,100,100),(46,'Vivotek FFMPEG','Ffmpeg',NULL,NULL,NULL,NULL,NULL,'rtsp://<host/address>:554/live.sdp',NULL,NULL,NULL,352,240,NULL,NULL,0,NULL,NULL,NULL,100,100),(47,'Axis FFMPEG','Ffmpeg',NULL,NULL,NULL,NULL,NULL,'rtsp://<host/address>/axis-media/media.amp',NULL,NULL,NULL,640,480,NULL,NULL,0,NULL,NULL,NULL,100,100),(48,'ACTi TCM FFMPEG','Ffmpeg',NULL,NULL,NULL,NULL,NULL,'rtsp://admin:123456@<host/address>:7070',NULL,NULL,NULL,320,240,NULL,NULL,0,NULL,NULL,NULL,100,100),(49,'BTTV Video (V4L2), PAL, 320x240','Local','/dev/video<?>',0,255,NULL,'v4l2',NULL,NULL,NULL,NULL,320,240,1345466932,NULL,0,NULL,NULL,NULL,100,100),(50,'BTTV Video (V4L2), PAL, 320x240, max 5 FPS','Local','/dev/video<?>',0,255,NULL,'v4l2',NULL,NULL,NULL,NULL,320,240,1345466932,5.000,0,NULL,NULL,NULL,100,100),(51,'BTTV Video (V4L2), PAL, 640x480','Local','/dev/video<?>',0,255,NULL,'v4l2',NULL,NULL,NULL,NULL,640,480,1345466932,NULL,0,NULL,NULL,NULL,100,100),(52,'BTTV Video (V4L2), PAL, 640x480, max 5 FPS','Local','/dev/video<?>',0,255,NULL,'v4l2',NULL,NULL,NULL,NULL,640,480,1345466932,5.000,0,NULL,NULL,NULL,100,100),(53,'BTTV Video (V4L2), NTSC, 320x240','Local','/dev/video<?>',0,45056,NULL,'v4l2',NULL,NULL,NULL,NULL,320,240,1345466932,NULL,0,NULL,NULL,NULL,100,100),(54,'BTTV Video (V4L2), NTSC, 320x240, max 5 FPS','Local','/dev/video<?>',0,45056,NULL,'v4l2',NULL,NULL,NULL,NULL,320,240,1345466932,5.000,0,NULL,NULL,NULL,100,100),(55,'BTTV Video (V4L2), NTSC, 640x480','Local','/dev/video<?>',0,45056,NULL,'v4l2',NULL,NULL,NULL,NULL,640,480,1345466932,NULL,0,NULL,NULL,NULL,100,100),(56,'BTTV Video (V4L2), NTSC, 640x480, max 5 FPS','Local','/dev/video<?>',0,45056,NULL,'v4l2',NULL,NULL,NULL,NULL,640,480,1345466932,5.000,0,NULL,NULL,NULL,100,100),(57,'BTTV Video (V4L1), PAL, 320x240','Local','/dev/video<?>',0,0,NULL,'v4l1',NULL,NULL,NULL,NULL,320,240,13,NULL,0,NULL,NULL,NULL,100,100),(58,'BTTV Video (V4L1), PAL, 320x240, max 5 FPS','Local','/dev/video<?>',0,0,NULL,'v4l1',NULL,NULL,NULL,NULL,320,240,13,5.000,0,NULL,NULL,NULL,100,100),(59,'BTTV Video (V4L1), PAL, 640x480','Local','/dev/video<?>',0,0,NULL,'v4l1',NULL,NULL,NULL,NULL,640,480,13,NULL,0,NULL,NULL,NULL,100,100),(60,'BTTV Video (V4L1), PAL, 640x480, max 5 FPS','Local','/dev/video<?>',0,0,NULL,'v4l1',NULL,NULL,NULL,NULL,640,480,13,5.000,0,NULL,NULL,NULL,100,100),(61,'BTTV Video (V4L1), NTSC, 320x240','Local','/dev/video<?>',0,1,NULL,'v4l1',NULL,NULL,NULL,NULL,320,240,13,NULL,0,NULL,NULL,NULL,100,100),(62,'BTTV Video (V4L1), NTSC, 320x240, max 5 FPS','Local','/dev/video<?>',0,1,NULL,'v4l1',NULL,NULL,NULL,NULL,320,240,13,5.000,0,NULL,NULL,NULL,100,100),(63,'BTTV Video (V4L1), NTSC, 640x480','Local','/dev/video<?>',0,1,NULL,'v4l1',NULL,NULL,NULL,NULL,640,480,13,NULL,0,NULL,NULL,NULL,100,100),(64,'BTTV Video (V4L1), NTSC, 640x480, max 5 FPS','Local','/dev/video<?>',0,1,NULL,'v4l1',NULL,NULL,NULL,NULL,640,480,13,5.000,0,NULL,NULL,NULL,100,100),(65,'Remote ZoneMinder','Remote',NULL,NULL,NULL,'http','simple','<ip-address>','80','/cgi-bin/nph-zms?mode=jpeg&monitor=<monitor-id>&scale=100&maxfps=5&buffer=0',NULL,NULL,NULL,3,NULL,0,NULL,NULL,NULL,100,100),(66,'Foscam FI8620 FFMPEG H.264','Ffmpeg',NULL,NULL,NULL,NULL,'','','','rtsp://<username>:<pwd>@<ip-address>:554/11',NULL,704,576,0,NULL,1,'10','<admin_pwd>','<ip-address>',100,100),(67,'Foscam FI8608W FFMPEG H.264','Ffmpeg',NULL,NULL,NULL,NULL,'','','','rtsp://<username>:<pwd>@<ip-address>:554/11',NULL,640,480,0,NULL,1,'11','<admin_pwd>','<ip-address>',100,100),(68,'Foscam FI9821W FFMPEG H.264','Ffmpeg',NULL,NULL,NULL,NULL,'','','','rtsp://<username>:<pwd>@<ip-address>:88/videoMain',NULL,1280,720,0,NULL,1,'12','<admin_pwd>','<ip-address>',100,100),(69,'Loftek Sentinel PTZ, 640x480, mjpeg','Remote','http',0,0,NULL,NULL,'<ip-address>','80','/videostream.cgi?user=<username>&pwd=<password>&resolution=32&rate=11',NULL,640,480,4,NULL,1,'13','','<username>:<pwd>@<ip-address>',100,100),(70,'Airlink 777W PTZ, 640x480, mjpeg','Remote','http',0,0,NULL,NULL,'<username>:<password>@<ip-address>','80','/cgi/mjpg/mjpg.cgi',NULL,640,480,4,NULL,1,'7','','<username>:<pwd>@<ip-address>',100,100),(71,'SunEyes SP-P1802SWPTZ','Libvlc','/dev/video<?>',0,255,'','rtpMulti','','80','rtsp://<ip-address>:554/11','',1920,1080,0,0.000,1,'16','-speed=64','<ip-address>:<port>',100,33),(72,'Qihan IP, 1280x720, RTP/RTSP','Ffmpeg','rtsp',0,255,'rtsp','rtpRtsp',NULL,'554','rtsp://<ip-address>/tcp_live/ch0_0',NULL,1280,720,3,NULL,0,NULL,NULL,NULL,100,100),(73,'Qihan IP, 1920x1080, RTP/RTSP','Ffmpeg','rtsp',0,255,'rtsp','rtpRtsp',NULL,'554','rtsp://<ip-address>/tcp_live/ch0_0',NULL,1920,1080,3,NULL,0,NULL,NULL,NULL,100,100);
/*!40000 ALTER TABLE `MonitorPresets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Monitor_Status`
--

DROP TABLE IF EXISTS `Monitor_Status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Monitor_Status` (
  `MonitorId` int(10) unsigned NOT NULL,
  `Status` enum('Unknown','NotRunning','Running','Connected','Signal') NOT NULL DEFAULT 'Unknown',
  `CaptureFPS` decimal(10,2) NOT NULL DEFAULT 0.00,
  `AnalysisFPS` decimal(5,2) NOT NULL DEFAULT 0.00,
  `CaptureBandwidth` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`MonitorId`)
) ENGINE=MEMORY DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monitor_Status`
--

LOCK TABLES `Monitor_Status` WRITE;
/*!40000 ALTER TABLE `Monitor_Status` DISABLE KEYS */;
/*!40000 ALTER TABLE `Monitor_Status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Monitors`
--

DROP TABLE IF EXISTS `Monitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Monitors` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Notes` text DEFAULT NULL,
  `ServerId` int(10) unsigned DEFAULT NULL,
  `StorageId` smallint(5) unsigned DEFAULT 0,
  `Type` enum('Local','Remote','File','Ffmpeg','Libvlc','cURL','WebSite','NVSocket') NOT NULL DEFAULT 'Local',
  `Function` enum('None','Monitor','Modect','Record','Mocord','Nodect') NOT NULL DEFAULT 'Monitor',
  `Enabled` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `LinkedMonitors` varchar(255) DEFAULT NULL,
  `Triggers` set('X10') NOT NULL DEFAULT '',
  `Device` tinytext NOT NULL DEFAULT '',
  `Channel` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Format` int(10) unsigned NOT NULL DEFAULT 0,
  `V4LMultiBuffer` tinyint(1) unsigned DEFAULT NULL,
  `V4LCapturesPerFrame` tinyint(3) unsigned DEFAULT NULL,
  `Protocol` varchar(16) DEFAULT NULL,
  `Method` varchar(16) DEFAULT '',
  `Host` varchar(64) DEFAULT NULL,
  `Port` varchar(8) NOT NULL DEFAULT '',
  `SubPath` varchar(64) NOT NULL DEFAULT '',
  `Path` varchar(255) DEFAULT NULL,
  `Options` varchar(255) DEFAULT NULL,
  `User` varchar(64) DEFAULT NULL,
  `Pass` varchar(64) DEFAULT NULL,
  `Width` smallint(5) unsigned NOT NULL DEFAULT 0,
  `Height` smallint(5) unsigned NOT NULL DEFAULT 0,
  `Colours` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `Palette` int(10) unsigned NOT NULL DEFAULT 0,
  `Orientation` enum('ROTATE_0','ROTATE_90','ROTATE_180','ROTATE_270','FLIP_HORI','FLIP_VERT') NOT NULL DEFAULT 'ROTATE_0',
  `Deinterlacing` int(10) unsigned NOT NULL DEFAULT 0,
  `DecoderHWAccelName` varchar(64) DEFAULT NULL,
  `DecoderHWAccelDevice` varchar(255) DEFAULT NULL,
  `SaveJPEGs` tinyint(4) NOT NULL DEFAULT 3,
  `VideoWriter` tinyint(4) NOT NULL DEFAULT 0,
  `OutputCodec` enum('h264','mjpeg','mpeg1','mpeg2') DEFAULT NULL,
  `OutputContainer` enum('auto','mp4','mkv') DEFAULT NULL,
  `EncoderParameters` text DEFAULT NULL,
  `RecordAudio` tinyint(4) NOT NULL DEFAULT 0,
  `RTSPDescribe` tinyint(1) unsigned DEFAULT NULL,
  `Brightness` mediumint(7) NOT NULL DEFAULT -1,
  `Contrast` mediumint(7) NOT NULL DEFAULT -1,
  `Hue` mediumint(7) NOT NULL DEFAULT -1,
  `Colour` mediumint(7) NOT NULL DEFAULT -1,
  `EventPrefix` varchar(32) NOT NULL DEFAULT 'Event-',
  `LabelFormat` varchar(64) DEFAULT NULL,
  `LabelX` smallint(5) unsigned NOT NULL DEFAULT 0,
  `LabelY` smallint(5) unsigned NOT NULL DEFAULT 0,
  `LabelSize` smallint(5) unsigned NOT NULL DEFAULT 1,
  `ImageBufferCount` smallint(5) unsigned NOT NULL DEFAULT 100,
  `WarmupCount` smallint(5) unsigned NOT NULL DEFAULT 25,
  `PreEventCount` smallint(5) unsigned NOT NULL DEFAULT 10,
  `PostEventCount` smallint(5) unsigned NOT NULL DEFAULT 10,
  `StreamReplayBuffer` int(10) unsigned NOT NULL DEFAULT 1000,
  `AlarmFrameCount` smallint(5) unsigned NOT NULL DEFAULT 1,
  `SectionLength` int(10) unsigned NOT NULL DEFAULT 600,
  `MinSectionLength` int(10) unsigned NOT NULL DEFAULT 10,
  `FrameSkip` smallint(5) unsigned NOT NULL DEFAULT 0,
  `MotionFrameSkip` smallint(5) unsigned NOT NULL DEFAULT 0,
  `AnalysisFPSLimit` decimal(5,2) DEFAULT NULL,
  `AnalysisUpdateDelay` smallint(5) unsigned NOT NULL DEFAULT 0,
  `MaxFPS` decimal(5,2) DEFAULT NULL,
  `AlarmMaxFPS` decimal(5,2) DEFAULT NULL,
  `FPSReportInterval` smallint(5) unsigned NOT NULL DEFAULT 250,
  `RefBlendPerc` tinyint(3) unsigned NOT NULL DEFAULT 6,
  `AlarmRefBlendPerc` tinyint(3) unsigned NOT NULL DEFAULT 6,
  `Controllable` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `ControlId` int(10) unsigned DEFAULT NULL,
  `ControlDevice` varchar(255) DEFAULT NULL,
  `ControlAddress` varchar(255) DEFAULT NULL,
  `AutoStopTimeout` decimal(5,2) DEFAULT NULL,
  `TrackMotion` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `TrackDelay` smallint(5) unsigned DEFAULT NULL,
  `ReturnLocation` tinyint(3) NOT NULL DEFAULT -1,
  `ReturnDelay` smallint(5) unsigned DEFAULT NULL,
  `DefaultRate` smallint(5) unsigned NOT NULL DEFAULT 100,
  `DefaultScale` smallint(5) unsigned NOT NULL DEFAULT 100,
  `DefaultCodec` enum('auto','MP4','MJPEG') NOT NULL DEFAULT 'auto',
  `SignalCheckPoints` int(10) unsigned NOT NULL DEFAULT 0,
  `SignalCheckColour` varchar(32) NOT NULL DEFAULT '#0000BE',
  `WebColour` varchar(32) NOT NULL DEFAULT 'red',
  `Exif` tinyint(1) unsigned NOT NULL DEFAULT 0,
  `Sequence` smallint(5) unsigned DEFAULT NULL,
  `TotalEvents` int(10) DEFAULT NULL,
  `TotalEventDiskSpace` bigint(20) DEFAULT NULL,
  `HourEvents` int(10) DEFAULT NULL,
  `HourEventDiskSpace` bigint(20) DEFAULT NULL,
  `DayEvents` int(10) DEFAULT NULL,
  `DayEventDiskSpace` bigint(20) DEFAULT NULL,
  `WeekEvents` int(10) DEFAULT NULL,
  `WeekEventDiskSpace` bigint(20) DEFAULT NULL,
  `MonthEvents` int(10) DEFAULT NULL,
  `MonthEventDiskSpace` bigint(20) DEFAULT NULL,
  `ArchivedEvents` int(10) DEFAULT NULL,
  `ArchivedEventDiskSpace` bigint(20) DEFAULT NULL,
  `ZoneCount` tinyint(4) NOT NULL DEFAULT 0,
  `Refresh` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `Monitors_ServerId_idx` (`ServerId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Monitors`
--

LOCK TABLES `Monitors` WRITE;
/*!40000 ALTER TABLE `Monitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `Monitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MontageLayouts`
--

DROP TABLE IF EXISTS `MontageLayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MontageLayouts` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` text NOT NULL,
  `Positions` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MontageLayouts`
--

LOCK TABLES `MontageLayouts` WRITE;
/*!40000 ALTER TABLE `MontageLayouts` DISABLE KEYS */;
INSERT INTO `MontageLayouts` VALUES (1,'Freeform','{ \"default\":{\"float\":\"left\",\"left\":\"0px\",\"right\":\"0px\",\"top\":\"0px\",\"bottom\":\"0px\"} }'),(2,'2 Wide','{ \"default\":{\"float\":\"left\", \"width\":\"49%\",\"left\":\"0px\",\"right\":\"0px\",\"top\":\"0px\",\"bottom\":\"0px\"} }'),(3,'3 Wide','{ \"default\":{\"float\":\"left\", \"width\":\"33%\",\"left\":\"0px\",\"right\":\"0px\",\"top\":\"0px\",\"bottom\":\"0px\"} }'),(4,'4 Wide','{ \"default\":{\"float\":\"left\", \"width\":\"24.5%\",\"left\":\"0px\",\"right\":\"0px\",\"top\":\"0px\",\"bottom\":\"0px\"} }'),(5,'5 Wide','{ \"default\":{\"float\":\"left\", \"width\":\"19%\",\"left\":\"0px\",\"right\":\"0px\",\"top\":\"0px\",\"bottom\":\"0px\"} }');
/*!40000 ALTER TABLE `MontageLayouts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Servers`
--

DROP TABLE IF EXISTS `Servers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Servers` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Protocol` text DEFAULT NULL,
  `Hostname` text DEFAULT NULL,
  `Port` int(10) unsigned DEFAULT NULL,
  `PathToIndex` text DEFAULT NULL,
  `PathToZMS` text DEFAULT NULL,
  `PathToApi` text DEFAULT NULL,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `State_Id` int(10) unsigned DEFAULT NULL,
  `Status` enum('Unknown','NotRunning','Running') NOT NULL DEFAULT 'Unknown',
  `CpuLoad` decimal(5,1) DEFAULT NULL,
  `TotalMem` bigint(20) unsigned DEFAULT NULL,
  `FreeMem` bigint(20) unsigned DEFAULT NULL,
  `TotalSwap` bigint(20) unsigned DEFAULT NULL,
  `FreeSwap` bigint(20) unsigned DEFAULT NULL,
  `zmstats` tinyint(1) NOT NULL DEFAULT 0,
  `zmaudit` tinyint(1) NOT NULL DEFAULT 0,
  `zmtrigger` tinyint(1) NOT NULL DEFAULT 0,
  `zmeventnotification` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `Servers_Name_idx` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Servers`
--

LOCK TABLES `Servers` WRITE;
/*!40000 ALTER TABLE `Servers` DISABLE KEYS */;
/*!40000 ALTER TABLE `Servers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `States`
--

DROP TABLE IF EXISTS `States`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `States` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Definition` text NOT NULL,
  `IsActive` tinyint(3) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `States`
--

LOCK TABLES `States` WRITE;
/*!40000 ALTER TABLE `States` DISABLE KEYS */;
INSERT INTO `States` VALUES (1,'default','',1);
/*!40000 ALTER TABLE `States` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Stats`
--

DROP TABLE IF EXISTS `Stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Stats` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MonitorId` int(10) unsigned NOT NULL DEFAULT 0,
  `ZoneId` int(10) unsigned NOT NULL DEFAULT 0,
  `EventId` bigint(20) unsigned NOT NULL,
  `FrameId` int(10) unsigned NOT NULL DEFAULT 0,
  `PixelDiff` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `AlarmPixels` int(10) unsigned NOT NULL DEFAULT 0,
  `FilterPixels` int(10) unsigned NOT NULL DEFAULT 0,
  `BlobPixels` int(10) unsigned NOT NULL DEFAULT 0,
  `Blobs` smallint(5) unsigned NOT NULL DEFAULT 0,
  `MinBlobSize` int(10) unsigned NOT NULL DEFAULT 0,
  `MaxBlobSize` int(10) unsigned NOT NULL DEFAULT 0,
  `MinX` smallint(5) unsigned NOT NULL DEFAULT 0,
  `MaxX` smallint(5) unsigned NOT NULL DEFAULT 0,
  `MinY` smallint(5) unsigned NOT NULL DEFAULT 0,
  `MaxY` smallint(5) unsigned NOT NULL DEFAULT 0,
  `Score` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `EventId` (`EventId`),
  KEY `MonitorId` (`MonitorId`),
  KEY `ZoneId` (`ZoneId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Stats`
--

LOCK TABLES `Stats` WRITE;
/*!40000 ALTER TABLE `Stats` DISABLE KEYS */;
/*!40000 ALTER TABLE `Stats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Storage`
--

DROP TABLE IF EXISTS `Storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Storage` (
  `Id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `Path` varchar(64) NOT NULL DEFAULT '',
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Type` enum('local','s3fs') NOT NULL DEFAULT 'local',
  `Url` varchar(255) DEFAULT NULL,
  `DiskSpace` bigint(20) DEFAULT NULL,
  `Scheme` enum('Deep','Medium','Shallow') NOT NULL DEFAULT 'Medium',
  `ServerId` int(10) unsigned DEFAULT NULL,
  `DoDelete` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Storage`
--

LOCK TABLES `Storage` WRITE;
/*!40000 ALTER TABLE `Storage` DISABLE KEYS */;
INSERT INTO `Storage` VALUES (1,'/mnt/VIDEO','Default','local',NULL,NULL,'Medium',0,1);
/*!40000 ALTER TABLE `Storage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TriggersX10`
--

DROP TABLE IF EXISTS `TriggersX10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TriggersX10` (
  `MonitorId` int(10) unsigned NOT NULL DEFAULT 0,
  `Activation` varchar(32) DEFAULT NULL,
  `AlarmInput` varchar(32) DEFAULT NULL,
  `AlarmOutput` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`MonitorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TriggersX10`
--

LOCK TABLES `TriggersX10` WRITE;
/*!40000 ALTER TABLE `TriggersX10` DISABLE KEYS */;
/*!40000 ALTER TABLE `TriggersX10` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Users`
--

DROP TABLE IF EXISTS `Users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Users` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Username` varchar(32) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `Password` varchar(64) NOT NULL DEFAULT '',
  `Language` varchar(8) DEFAULT NULL,
  `Enabled` tinyint(3) unsigned NOT NULL DEFAULT 1,
  `Stream` enum('None','View') NOT NULL DEFAULT 'None',
  `Events` enum('None','View','Edit') NOT NULL DEFAULT 'None',
  `Control` enum('None','View','Edit') NOT NULL DEFAULT 'None',
  `Monitors` enum('None','View','Edit') NOT NULL DEFAULT 'None',
  `Groups` enum('None','View','Edit') NOT NULL DEFAULT 'None',
  `Devices` enum('None','View','Edit') NOT NULL DEFAULT 'None',
  `System` enum('None','View','Edit') NOT NULL DEFAULT 'None',
  `MaxBandwidth` varchar(16) DEFAULT NULL,
  `MonitorIds` text DEFAULT NULL,
  `TokenMinExpiry` bigint(20) unsigned NOT NULL DEFAULT 0,
  `APIEnabled` tinyint(3) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `UC_Username` (`Username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Users`
--

LOCK TABLES `Users` WRITE;
/*!40000 ALTER TABLE `Users` DISABLE KEYS */;
INSERT INTO `Users` VALUES (1,'admin','$2b$12$NHZsm6AM2f2LQVROriz79ul3D6DnmFiZC.ZK5eqbF.ZWfwH9bqUJ6','',1,'View','Edit','Edit','Edit','Edit','Edit','Edit','','',0,1);
/*!40000 ALTER TABLE `Users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ZonePresets`
--

DROP TABLE IF EXISTS `ZonePresets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ZonePresets` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Type` enum('Active','Inclusive','Exclusive','Preclusive','Inactive','Privacy') NOT NULL DEFAULT 'Active',
  `Units` enum('Pixels','Percent') NOT NULL DEFAULT 'Pixels',
  `CheckMethod` enum('AlarmedPixels','FilteredPixels','Blobs') NOT NULL DEFAULT 'Blobs',
  `MinPixelThreshold` smallint(5) unsigned DEFAULT NULL,
  `MaxPixelThreshold` smallint(5) unsigned DEFAULT NULL,
  `MinAlarmPixels` int(10) unsigned DEFAULT NULL,
  `MaxAlarmPixels` int(10) unsigned DEFAULT NULL,
  `FilterX` tinyint(3) unsigned DEFAULT NULL,
  `FilterY` tinyint(3) unsigned DEFAULT NULL,
  `MinFilterPixels` int(10) unsigned DEFAULT NULL,
  `MaxFilterPixels` int(10) unsigned DEFAULT NULL,
  `MinBlobPixels` int(10) unsigned DEFAULT NULL,
  `MaxBlobPixels` int(10) unsigned DEFAULT NULL,
  `MinBlobs` smallint(5) unsigned DEFAULT NULL,
  `MaxBlobs` smallint(5) unsigned DEFAULT NULL,
  `OverloadFrames` smallint(5) unsigned NOT NULL DEFAULT 0,
  `ExtendAlarmFrames` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ZonePresets`
--

LOCK TABLES `ZonePresets` WRITE;
/*!40000 ALTER TABLE `ZonePresets` DISABLE KEYS */;
INSERT INTO `ZonePresets` VALUES (1,'Default','Active','Percent','Blobs',25,NULL,3,75,3,3,3,75,2,NULL,1,NULL,0,0),(2,'Fast, low sensitivity','Active','Percent','AlarmedPixels',60,NULL,20,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(3,'Fast, medium sensitivity','Active','Percent','AlarmedPixels',40,NULL,10,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(4,'Fast, high sensitivity','Active','Percent','AlarmedPixels',20,NULL,5,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0),(5,'Best, low sensitivity','Active','Percent','Blobs',60,NULL,36,NULL,7,7,24,NULL,20,NULL,1,NULL,0,0),(6,'Best, medium sensitivity','Active','Percent','Blobs',40,NULL,16,NULL,5,5,12,NULL,10,NULL,1,NULL,0,0),(7,'Best, high sensitivity','Active','Percent','Blobs',20,NULL,8,NULL,3,3,6,NULL,5,NULL,1,NULL,0,0);
/*!40000 ALTER TABLE `ZonePresets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Zones`
--

DROP TABLE IF EXISTS `Zones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Zones` (
  `Id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MonitorId` int(10) unsigned NOT NULL DEFAULT 0,
  `Name` varchar(64) NOT NULL DEFAULT '',
  `Type` enum('Active','Inclusive','Exclusive','Preclusive','Inactive','Privacy') NOT NULL DEFAULT 'Active',
  `Units` enum('Pixels','Percent') NOT NULL DEFAULT 'Pixels',
  `NumCoords` tinyint(3) unsigned NOT NULL DEFAULT 0,
  `Coords` tinytext NOT NULL,
  `Area` int(10) unsigned NOT NULL DEFAULT 0,
  `AlarmRGB` int(10) unsigned DEFAULT 0,
  `CheckMethod` enum('AlarmedPixels','FilteredPixels','Blobs') NOT NULL DEFAULT 'Blobs',
  `MinPixelThreshold` smallint(5) unsigned DEFAULT NULL,
  `MaxPixelThreshold` smallint(5) unsigned DEFAULT NULL,
  `MinAlarmPixels` int(10) unsigned DEFAULT NULL,
  `MaxAlarmPixels` int(10) unsigned DEFAULT NULL,
  `FilterX` tinyint(3) unsigned DEFAULT NULL,
  `FilterY` tinyint(3) unsigned DEFAULT NULL,
  `MinFilterPixels` int(10) unsigned DEFAULT NULL,
  `MaxFilterPixels` int(10) unsigned DEFAULT NULL,
  `MinBlobPixels` int(10) unsigned DEFAULT NULL,
  `MaxBlobPixels` int(10) unsigned DEFAULT NULL,
  `MinBlobs` smallint(5) unsigned DEFAULT NULL,
  `MaxBlobs` smallint(5) unsigned DEFAULT NULL,
  `OverloadFrames` smallint(5) unsigned NOT NULL DEFAULT 0,
  `ExtendAlarmFrames` smallint(5) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`Id`),
  KEY `MonitorId` (`MonitorId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Zones`
--

LOCK TABLES `Zones` WRITE;
/*!40000 ALTER TABLE `Zones` DISABLE KEYS */;
/*!40000 ALTER TABLE `Zones` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Zone_Insert_Trigger AFTER INSERT ON Zones
FOR EACH ROW
  BEGIN
    UPDATE Monitors SET ZoneCount=(SELECT COUNT(*) FROM Zones WHERE MonitorId=NEW.MonitorId) WHERE Id=NEW.MonitorID;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER Zone_Delete_Trigger AFTER DELETE ON Zones
FOR EACH ROW
  BEGIN
    UPDATE Monitors SET ZoneCount=(SELECT COUNT(*) FROM Zones WHERE MonitorId=OLD.MonitorId) WHERE Id=OLD.MonitorID;
  END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-09-05 20:33:22

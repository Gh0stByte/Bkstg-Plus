export ARCHS=armv7 armv7s arm64
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = bkstg
bkstg_FILES = Tweak.xm MBProgressHUD.m
bkstg_FRAMEWORKS = UIKit Photos CoreGraphics QuartzCore AssetsLibrary
bkstg_CFLAGS = -fobjc-arc 

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 Bkstg"

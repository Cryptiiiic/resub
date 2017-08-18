include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = resub
resub_FILES = main.m AppDelegate.m RootViewController.m
resub_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \”resub\”” || true

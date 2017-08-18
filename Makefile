APPLICATION_NAME = resub
ARCHS = armv7 armv7s arm64
DEBUG = 0
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include $(THEOS)/makefiles/common.mk
SUBPROJECTS += resub
SUBPROJECTS += postinst
include $(THEOS_MAKE_PATH)/aggregate.mk

clean::
	@rm -R .theos
	@rm -f packages/*.deb
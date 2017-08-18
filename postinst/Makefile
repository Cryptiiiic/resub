include $(THEOS)/makefiles/common.mk

TOOL_NAME = postinst
postinst_FILES = postinst.c
postinst_CFLAGS += -fvisibility=hidden -DBUILD_POSTINST -DBUILD_RUNONCE
postinst_FRAMEWORKS = CoreFoundation
postinst_FILES = postinst.c
postinst_INSTALL_PATH = /DEBIAN

include $(THEOS_MAKE_PATH)/tool.mk

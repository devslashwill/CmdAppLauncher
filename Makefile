include theos/makefiles/common.mk

TOOL_NAME = cmdapplauncher
cmdapplauncher_FILES = main.mm
cmdapplauncher_PRIVATE_FRAMEWORKS = AppSupport
SUBPROJECTS = tweak

include $(THEOS_MAKE_PATH)/aggregate.mk
include $(THEOS_MAKE_PATH)/tool.mk

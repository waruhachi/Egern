export ARCHS = arm64 arm64e
export TARGET = iphone:16.5:14.0

INSTALL_TARGET_PROCESSES = com.bytecrossing.Egern

SUBPROJECTS += Tweak

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
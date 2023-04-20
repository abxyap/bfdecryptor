GO_EASY_ON_ME = 1
FINALPACKAGE=1
DEBUG=0

ARCHS := arm64 arm64e
TARGET := iphone:clang:16.4:14.5

THEOS_DEVICE_IP = 127.0.0.1 -p 2222

INSTALL_TARGET_PROCESSES = SpringBoard

THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = bfdecryptor

bfdecryptor_EXTRA_FRAMEWORKS = AltList

bfdecryptor_FILES = SSZipArchive/minizip/unzip.c SSZipArchive/minizip/crypt.c SSZipArchive/minizip/ioapi_buf.c SSZipArchive/minizip/ioapi_mem.c SSZipArchive/minizip/ioapi.c SSZipArchive/minizip/minishared.c SSZipArchive/minizip/zip.c SSZipArchive/minizip/aes/aes_ni.c SSZipArchive/minizip/aes/aescrypt.c SSZipArchive/minizip/aes/aeskey.c SSZipArchive/minizip/aes/aestab.c SSZipArchive/minizip/aes/fileenc.c SSZipArchive/minizip/aes/hmac.c SSZipArchive/minizip/aes/prng.c SSZipArchive/minizip/aes/pwd2key.c SSZipArchive/minizip/aes/sha1.c SSZipArchive/SSZipArchive.m DumpDecrypted.m Tweak.x
bfdecryptor_CFLAGS = -fno-objc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += BFDPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk

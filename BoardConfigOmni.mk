# Use invensense stuff in-tree
BOARD_USES_GENERIC_INVENSENSE := false

# Recovery
TARGET_RECOVERY_DEVICE_DIRS += device/samsung/tuna

# TWRP
TW_THEME := portrait_hdpi
RECOVERY_SDCARD_ON_DATA := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
BOARD_HAS_NO_REAL_SDCARD := true
TW_INCLUDE_CRYPTO := true
TW_FLASH_FROM_STORAGE := true
TW_NO_USB_STORAGE := true
TW_NO_SCREEN_BLANK := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/usb-otg"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "usb-otg"
TW_MAX_BRIGHTNESS := 255
TW_BRIGHTNESS_PATH := /sys/class/backlight/s6e8aa0/brightness
TW_CUSTOM_CPU_TEMP_PATH := /sys/devices/platform/omap/omap_temp_sensor.0/temperature

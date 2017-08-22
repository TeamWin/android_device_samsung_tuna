LOCAL_PATH := $(call my-dir)
LZMA_BIN := $(shell which lzma)

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(BOOTIMAGE_EXTRA_DEPS)
	$(call pretty,"Target boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(INTERNAL_MKBOOTIMG_VERSION_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE))
	@echo -e ${PRT_IMG}"----- Made boot image: $@ --------"${CL_RST}

$(INSTALLED_RECOVERYIMAGE_TARGET): $(recovery_ramdisk) $(MKBOOTIMG) $(recovery_kernel)
	@echo -e ${PRT_IMG}"----- Making recovery image ------"${CL_RST}
	@echo ----- Compressing recovery ramdisk with lzma ------
	rm -f $(recovery_uncompressed_ramdisk).lzma
	$(LZMA_BIN) $(recovery_uncompressed_ramdisk)
	$(hide) cp $(recovery_uncompressed_ramdisk).lzma $(recovery_ramdisk)
	$(call build-recoveryimage-target, $@)
	@echo -e ${PRT_IMG}"----- Made recovery image: $@ --------"${CL_RST}

$(recovery_uncompressed_ramdisk): $(MKBOOTFS) \
		$(INSTALLED_RAMDISK_TARGET) \
		$(INSTALLED_BOOTIMAGE_TARGET) \
		$(INTERNAL_RECOVERYIMAGE_FILES) \
		$(recovery_initrc) $(recovery_sepolicy) \
		$(INSTALLED_2NDBOOTLOADER_TARGET) \
		$(recovery_build_prop) $(recovery_resource_deps) $(recovery_root_deps) \
		$(recovery_fstab) \
		$(RECOVERY_INSTALL_OTA_KEYS)
	mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/hw
	cp -f $(TARGET_OUT)/lib/libtf_crypto_sst.so $(TARGET_RECOVERY_ROOT_OUT)/sbin/libtf_crypto_sst.so
	cp -f $(TARGET_OUT_SHARED_LIBRARIES)/hw/keystore.tuna.so $(TARGET_RECOVERY_ROOT_OUT)/vendor/lib/hw/keystore.tuna.so
	$(call build-recoveryramdisk)
	@echo -e ${CL_CYN}"----- Making uncompressed recovery ramdisk ------"${CL_RST}
	$(hide) $(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $@

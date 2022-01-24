rm -rf hardware/qcom-caf/sm8150/display
rm -rf hardware/qcom-caf/sm8150/media
rm -rf hardware/qcom-caf/sm8150/audio
rm -rf vendor/qcom/opensource/interfaces
rm -rf packages/apps/Nfc
rm -rf vendor/nxp/opensource/interfaces/nfc
rm -rf vendor/nxp/opensource/commonsys/external/libnfc-nci
rm -rf vendor/nxp/opensource/commonsys/frameworks
rm -rf vendor/nxp/opensource/commonsys/packages/apps/Nfc
rm -rf vendor/nxp/opensource/sn100x/halimpl
rm -rf vendor/nxp/opensource/sn100x/hidlimpl
git clone https://github.com/ArrowOS/android_hardware_qcom_display.git -b arrow-12.0-caf-sm8150 hardware/qcom-caf/sm8150/display
git clone https://github.com/ArrowOS/android_hardware_qcom_audio.git -b arrow-12.0-caf-sm8150 hardware/qcom-caf/sm8150/audio
git clone https://github.com/ArrowOS/android_hardware_qcom_media.git -b arrow-12.0-caf-sm8150 hardware/qcom-caf/sm8150/media
git clone https://github.com/ArrowOS/android_packages_apps_Nfc.git -b arrow-12.0 packages/apps/Nfc
git clone https://github.com/ArrowOS/android_vendor_nxp_interfaces_opensource_nfc.git -b arrow-12.0 vendor/nxp/opensource/interfaces/nfc
git clone https://github.com/ArrowOS/android_vendor_nxp_opensource_external_libnfc-nci.git -b arrow-12.0 vendor/nxp/opensource/commonsys/external/libnfc-nci
git clone https://github.com/ArrowOS/android_vendor_nxp_opensource_frameworks.git -b arrow-12.0 vendor/nxp/opensource/commonsys/frameworks
git clone https://github.com/ArrowOS/android_vendor_nxp_opensource_packages_apps_Nfc.git -b arrow-12.0 vendor/nxp/opensource/commonsys/packages/apps/Nfc
git clone https://github.com/ArrowOS/android_vendor_nxp_opensource_halimpl.git -b arrow-12.0-sn100x vendor/nxp/opensource/sn100x/halimpl
git clone https://github.com/ArrowOS/android_vendor_nxp_opensource_hidlimpl.git -b arrow-12.0-sn100x vendor/nxp/opensource/sn100x/hidlimpl
git clone https://github.com/ArrowOS/android_vendor_qcom_opensource_interfaces.git -b arrow-12.0 vendor/qcom/opensource/interfaces
rm -rf vendor/nxp/opensource/sn100x/halimpl/SN100x/halimpl/libnxpparser
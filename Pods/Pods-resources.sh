#!/bin/sh

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy.txt
touch "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "rsync -rp ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -rp "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blackArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blackArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blueArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/blueArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/grayArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/grayArrow@2x.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/whiteArrow.png'
install_resource 'EGOTableViewPullRefresh/EGOTableViewPullRefresh/Resources/whiteArrow@2x.png'
install_resource 'UIBubbleTableView/images/bubbleMine.png'
install_resource 'UIBubbleTableView/images/bubbleMine@2x.png'
install_resource 'UIBubbleTableView/images/bubbleSomeone.png'
install_resource 'UIBubbleTableView/images/bubbleSomeone@2x.png'
install_resource 'UIBubbleTableView/images/typingMine.png'
install_resource 'UIBubbleTableView/images/typingMine@2x.png'
install_resource 'UIBubbleTableView/images/typingSomeone.png'
install_resource 'UIBubbleTableView/images/typingSomeone@2x.png'
install_resource 'UMengFeedback/UMFeedback_iOS_1.4/umFeedback.bundle'
install_resource 'UMengSocial/UMSocial_Sdk_All_2.1.3/UMSocial_Sdk_2.1.3/UMSocialSDKResources.bundle'
install_resource 'UMengSocial/UMSocial_Sdk_All_2.1.3/UMSocial_Sdk_2.1.3/SocialSDKXib/UMSCommentDetailController.xib'
install_resource 'UMengSocial/UMSocial_Sdk_All_2.1.3/UMSocial_Sdk_2.1.3/SocialSDKXib/UMSCommentInputController.xib'
install_resource 'UMengSocial/UMSocial_Sdk_All_2.1.3/UMSocial_Sdk_2.1.3/SocialSDKXib/UMSCommentInputControlleriPad.xib'
install_resource 'UMengSocial/UMSocial_Sdk_All_2.1.3/UMSocial_Sdk_2.1.3/SocialSDKXib/UMShareEditViewController.xib'
install_resource 'UMengSocial/UMSocial_Sdk_All_2.1.3/UMSocial_Sdk_2.1.3/SocialSDKXib/UMShareEditViewControlleriPad.xib'
install_resource 'UMengSocial/UMSocial_Sdk_All_2.1.3/UMSocial_Sdk_2.1.3/SocialSDKXib/UMSnsAccountViewController.xib'
install_resource 'UMengSocial/UMSocial_Sdk_All_2.1.3/UMSocial_Sdk_2.1.3/SocialSDKXib/UMSShareListController.xib'

rsync -avr --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rm "$RESOURCES_TO_COPY"

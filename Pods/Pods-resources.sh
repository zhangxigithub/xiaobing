#!/bin/sh
set -e

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy-${TARGETNAME}.txt
> "$RESOURCES_TO_COPY"

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
      echo "mkdir -p ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      mkdir -p "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      echo "cp -fpR ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      cp -fpR "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodel)
      echo xcrun momc "${PODS_ROOT}/$1" ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom
      xcrun momc "${PODS_ROOT}/$1" ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodel`.mom
      ;;
    *.xcdatamodeld)
      echo  xcrun momc "${PODS_ROOT}/$1" ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd
      xcrun momc "${PODS_ROOT}/$1" ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename "$1" .xcdatamodeld`.momd
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
install_resource 'UI7Kit/Resources/UI7BarButtonIconAction.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconAction@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconAdd.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconAdd@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconBookmarks.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconBookmarks@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconCamera.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconCamera@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconCompose.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconCompose@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconFastForward.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconFastForward@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconOrganize.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconOrganize@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconPause.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconPause@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconPlay.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconPlay@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconRefresh.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconRefresh@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconReply.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconReply@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconRewind.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconRewind@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconSearch.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconSearch@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconStop.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconStop@2x.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconTrash.png'
install_resource 'UI7Kit/Resources/UI7BarButtonIconTrash@2x.png'
install_resource 'UI7Kit/Resources/UI7ButtonImageAdd.png'
install_resource 'UI7Kit/Resources/UI7ButtonImageAdd@2x.png'
install_resource 'UI7Kit/Resources/UI7ButtonImageInfo.png'
install_resource 'UI7Kit/Resources/UI7ButtonImageInfo@2x.png'
install_resource 'UI7Kit/Resources/UI7NavigationBarBackButton.png'
install_resource 'UI7Kit/Resources/UI7NavigationBarBackButton@2x.png'
install_resource 'UI7Kit/Resources/UI7SliderThumb.png'
install_resource 'UI7Kit/Resources/UI7SliderThumb@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemBookmarksUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemBookmarksUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemContactsUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemContactsUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemDownloadsUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemDownloadsUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteSelected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteSelected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemFavoriteUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemHistoryUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemHistoryUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMoreUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMoreUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostRecentUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostRecentUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostViewedUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemMostViewedUnselected@2x.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemSearchUnselected.png'
install_resource 'UI7Kit/Resources/UI7TabBarItemSearchUnselected@2x.png'
install_resource 'UIBubbleTableView/images/bubbleMine.png'
install_resource 'UIBubbleTableView/images/bubbleMine@2x.png'
install_resource 'UIBubbleTableView/images/bubbleSomeone.png'
install_resource 'UIBubbleTableView/images/bubbleSomeone@2x.png'
install_resource 'UIBubbleTableView/images/typingMine.png'
install_resource 'UIBubbleTableView/images/typingMine@2x.png'
install_resource 'UIBubbleTableView/images/typingSomeone.png'
install_resource 'UIBubbleTableView/images/typingSomeone@2x.png'
install_resource 'UMengFeedback/UMFeedback_iOS_1.4/umFeedback.bundle'

rsync -avr --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rm -f "$RESOURCES_TO_COPY"

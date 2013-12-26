import QtQuick 2.1
import "UIConstants.js" as UIConstants
import "theme.js" as Theme

Rectangle {
    width: parent.width
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.bottomMargin: UIConstants.DEFAULT_MARGIN * appWindow.scalingFactor
    height: 1
    color: Theme.theme[appWindow.colorscheme].COLOR_SEPARATOR
}

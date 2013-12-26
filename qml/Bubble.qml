import QtQuick 2.1
import "UIConstants.js" as UIConstants
import "theme.js" as Theme

Rectangle {
    height: 35
    width: count_label.width + 15
    radius: 12
    smooth: true
    color: "#0d67b3"
    property int count
    Text {
        id: count_label
        text: count
        font.pixelSize: UIConstants.FONT_LARGE * appWindow.scalingFactor
        color: Theme.theme[appWindow.colorscheme].COLOR_FOREGROUND
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}

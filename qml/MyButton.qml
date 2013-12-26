import QtQuick 2.1
import "UIConstants.js" as UIConstants
import "theme.js" as Theme

Item {
    property int imageSize: 50
    width: 50
    height: 50
    property alias source : image.source
    property alias mouseArea : mouseArea
    property alias image : image

    Rectangle {
        anchors.fill: parent
        color: Theme.theme[appWindow.colorscheme].COLOR_BACKGROUND_CLICKED
        z: -1
        visible: mouseArea.pressed
    }

    Image {
        id: image
        anchors.centerIn: parent
        smooth: true
        height: imageSize
        width: imageSize
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
    }
}


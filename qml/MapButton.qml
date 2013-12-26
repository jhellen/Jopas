import QtQuick 2.1
import "UIConstants.js" as UIConstants
import "theme.js" as Theme

Rectangle {
    id: button

    property int imageSize: 50
    property bool selected: false

    signal clicked

    width: 50
    height: 50
    radius: 10
    opacity: 0.7
    color: (mouseArea.pressed || selected) ? Theme.theme[appWindow.colorscheme].COLOR_MAPBUTTON_CLICKED : Theme.theme[appWindow.colorscheme].COLOR_MAPBUTTON

    property alias source : image.source
    property alias mouseArea : mouseArea
    property alias image : image

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
        onClicked: button.clicked()
    }
}

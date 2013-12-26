import QtQuick 2.1
import Sailfish.Silica 1.0

ListItem {
    id: delegateItem
    width: ListView.view.width
    contentHeight: Theme.itemSizeMedium

    Image {
        id: icon
        source: index == 0?'qrc:/images/gps-icon-inverted.png':'qrc:/images/favorite-mark-inverse.png'
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        height: 40
        width: height
    }

    Label {
        id: locName
        color: Theme.primaryColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: icon.right
        anchors.right: parent.right
        text: modelData
        font.pixelSize: Theme.fontSizeMedium
    }
}

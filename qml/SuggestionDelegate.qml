import QtQuick 2.1
import Sailfish.Silica 1.0

ListItem {
    id: suggestionDelegate
    width: ListView.view.width
    contentHeight: Theme.itemSizeMedium

    Label {
        id: locName
        elide: Text.ElideRight
        color: Theme.primaryColor
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: locType.left
        text: name + " " + housenumber
        font.pixelSize: Theme.fontSizeMedium
    }

    Label {
        id: locType
        width: 100
        elide: Text.ElideRight
        color: Theme.secondaryColor
        horizontalAlignment: Text.AlignRight
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        text: city
        font.pixelSize: Theme.fontSizeSmall
    }
}

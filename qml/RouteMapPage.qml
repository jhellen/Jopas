import QtQuick 2.1
import Sailfish.Silica 1.0
import "reittiopas.js" as Reittiopas
import "UIConstants.js" as UIConstants

Page {
    backNavigation: false
    anchors.fill: parent

    MapElement {
        id: map

        anchors {
            top: parent.top
            left: parent.left
            bottom: tools.top
            right: parent.right
        }

        Component.onCompleted: {
            initialize()
            first_station()
        }
    }

    Row {
        id: tools

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        height: back.height

        IconButton {
            id: back
            icon.source: "image://theme/icon-m-back"
            onClicked: pageStack.pop()
        }

        IconButton {
            icon.source: "image://theme/icon-m-previous"
            onClicked: map.previous_station()
            enabled: !appWindow.followMode
        }

        IconButton {
            icon.source: "image://theme/icon-m-next"
            onClicked: map.next_station()
            enabled: !appWindow.followMode
        }

    }
}


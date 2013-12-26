import QtQuick 2.1
import Sailfish.Silica 1.0

Dialog {
    anchors.fill: parent

    Column {
        width: parent.width

        DialogHeader {
            title: qsTr("Close")
            acceptText: title
        }

        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            text: "Jopas v0.1"
        }

        Spacing {}
        Spacing {}

        Label {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
            text: "(c) Jukka Nousiainen 2011-2012\n\n" + qsTr("This application is free sofware licenced under the GNU Public License version 3") //  TODO: Fix copyright notices
        }
    }
}

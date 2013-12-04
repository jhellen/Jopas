import QtQuick 2.1
import Sailfish.Silica 1.0
import "storage.js" as Storage

Dialog {
    Column {
        anchors.fill: parent

        DialogHeader {
            acceptText: qsTr("Close")
        }

        ComboBox {
            id: region
            label: qsTr("Choose region")
            menu: ContextMenu {
                MenuItem { text: "Helsinki" }
                MenuItem { text: "Tampere" }
            }
        }

        TextSwitch {
            width: parent.width
            text: qsTr("Use location services")
        }

        Label {
            x: Theme.paddingLarge
            width: parent.width - Theme.paddingLarge * 2
            text: qsTr("allow this application to use the phone location services to enhance the routing experience?\n\nThe setting can be later changed from the application preferences.")
            wrapMode: Text.WordWrap
        }
    }

    onAccepted: {
        Storage.setSetting('api', region.currentIndex == 0 ? "helsinki" : "tampere")
        Storage.setSetting('gps', 'true')
    }

    onRejected: {
        Storage.setSetting('api', region.currentIndex == 0 ? "helsinki" : "tampere")
        Storage.setSetting('gps', 'false')
    }
}

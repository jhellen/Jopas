import QtQuick 2.1
import Sailfish.Silica 1.0
import "favorites.js" as Favorites

Dialog {
    id: add_dialog
    property string coord: ''
    property alias name: editTextField.text
    property variant favoritesModel

    canAccept: add_dialog.coord != '' && name.text != ''

    onAccepted: {
        if(add_dialog.name != '') {
            if(("OK" == Favorites.addFavorite(add_dialog.name, coord))) {
                favoritesModel.clear()
                Favorites.getFavorites(favoritesModel)
            }
        }
    }

    Column {
        anchors.fill: parent

        DialogHeader {
            acceptText: qsTr("Add favorite")
        }

        LocationEntry {
            id: entry
            anchors.bottomMargin: Theme.paddingSizeSmall
            font.pixelSize: Theme.fontSizeMedium
            label.anchors.horizontalCenter: entry.horizontalCenter
            type: qsTr("Search for location")
            disable_favorites: true
            onLocationDone: {
                add_dialog.name = name
                add_dialog.coord = coord
            }
        }

        Spacing {}

        Label {
            text: qsTr("Enter name for the favorite")
            font.pixelSize: Theme.fontSizeMedium
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Qt.AlignCenter
            font.bold: true
            color: Theme.primaryColor
        }

        Spacing {}

        TextField {
            id: editTextField
            width: parent.width

            Image {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/clear.png"
                visible: (editTextField.activeFocus)

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        editTextField.text = ''
                    }
                }
            }

            Keys.onReturnPressed: {
                editTextField.platformCloseSoftwareInputPanel()
                parent.focus = true
            }
        }
    }
}

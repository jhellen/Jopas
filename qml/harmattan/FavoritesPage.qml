/*
 * This file is part of the Meegopas, more information at www.gitorious.org/meegopas
 *
 * Author: Jukka Nousiainen <nousiaisenjukka@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * See full license at http://www.gnu.org/licenses/gpl-3.0.html
 */

import QtQuick 2.1
import Sailfish.Silica 1.0
import "UIConstants.js" as UIConstants
import "reittiopas.js" as Reittiopas
import "favorites.js" as Favorites
import "theme.js" as Theme

Page {
    id: favorites_page

//    FavoriteSheet { id: sheet }

    Component.onCompleted: {
        favoritesModel.clear()
        Favorites.initialize()
        Favorites.getFavorites(favoritesModel)
    }

    ListModel {
        id: favoritesModel
    }
/*
    Dialog {
        id: edit_dialog
        property alias name : editTextField.text
        property string coord
        property string old_name : ""
        title: Text {
                text: qsTr("Edit favorite name")
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignCenter
                elide: Text.ElideNone
                font.pixelSize: UIConstants.FONT_XLARGE * appWindow.scalingFactor
                font.bold: true
                font.family: UIConstants.FONT_FAMILY
                color: Theme.theme[appWindow.colorscheme].COLOR_FOREGROUND
            }

        content: TextField {
            id: editTextField
            width: parent.width
            text: edit_dialog.name

            Image {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/clear.png"
                visible: (editTextField.activeFocus)
                opacity: 0.8
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
        buttons: Column {
            spacing: UIConstants.DEFAULT_MARGIN
            anchors.horizontalCenter: parent.horizontalCenter
            width: button_save.width

            Spacing {}

            Button {
                id: button_save
                text: qsTr("Save")
                font.pixelSize: UIConstants.FONT_DEFAULT  * appWindow.scalingFactor
                width: UIConstants.BUTTON_WIDTH * appWindow.scalingFactor
                height: UIConstants.BUTTON_HEIGHT * appWindow.scalingFactor
                onClicked: {
                    if("OK" == Favorites.updateFavorite(edit_dialog.name, favoritesModel.get(list.currentIndex).coord, favoritesModel)) {

*/                        /* update shortcuts, if exists *//*
                        if(Shortcut.checkIfExists(edit_dialog.old_name)) {
                            Shortcut.removeShortcut(edit_dialog.old_name)
                            Shortcut.toggleShortcut(edit_dialog.name,favoritesModel.get(list.currentIndex).coord)
                        }

                        if(Shortcut.checkIfCyclingExists(edit_dialog.old_name)) {
                            Shortcut.removeCyclingShortcut(edit_dialog.old_name)
                            Shortcut.toggleCyclingShortcut(edit_dialog.name,favoritesModel.get(list.currentIndex).coord)
                        }

                        favoritesModel.clear()
                        Favorites.getFavorites(favoritesModel)

                        appWindow.banner.success = true
                        appWindow.banner.text = qsTr("Favorite name successfully modified")
                        appWindow.banner.show()
                    } else {
                        appWindow.banner.success = false
                        appWindow.banner.text = qsTr("Favorite name modification failed")
                        appWindow.banner.show()
                    }

                    edit_dialog.close()
                }
            }
            Button {
                id: button_cancel
                text: qsTr("Cancel")
                font.pixelSize: UIConstants.FONT_DEFAULT  * appWindow.scalingFactor
                width: UIConstants.BUTTON_WIDTH * appWindow.scalingFactor
                height: UIConstants.BUTTON_HEIGHT * appWindow.scalingFactor
                onClicked: edit_dialog.close()
            }
        }
    }
*/
/*
    Dialog {
        id: delete_dialog
        property string name
        title: Text {
            text: qsTr("Delete favorite?")
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Qt.AlignCenter
            elide: Text.ElideNone
            font.pixelSize: UIConstants.FONT_XLARGE * appWindow.scalingFactor
            font.bold: true
            font.family: UIConstants.FONT_FAMILY
            color: Theme.theme[appWindow.colorscheme].COLOR_FOREGROUND
        }

        content: Text {
            text: delete_dialog.name
            anchors.centerIn: parent
            anchors.bottomMargin: UIConstants.DEFAULT_MARGIN
            color: UIConstants.COLOR_INVERTED_FOREGROUND
            font.pixelSize: UIConstants.FONT_DEFAULT * appWindow.scalingFactor
            elide: Text.ElideRight
            lineHeightMode: Text.FixedHeight
            lineHeight: font.pixelSize * 1.2
        }
        buttons: Column {
            spacing: UIConstants.DEFAULT_MARGIN
            anchors.horizontalCenter: parent.horizontalCenter
            width: button_save.width

            Spacing {}

            Button {
                id: delete_ok
                text: qsTr("Delete")
                font.pixelSize: UIConstants.FONT_DEFAULT  * appWindow.scalingFactor
                width: UIConstants.BUTTON_WIDTH * appWindow.scalingFactor
                height: UIConstants.BUTTON_HEIGHT * appWindow.scalingFactor
                onClicked: {
                    Favorites.deleteFavorite(favoritesModel.get(list.currentIndex).coord, favoritesModel)
                    appWindow.banner.success = true
                    appWindow.banner.text = qsTr("Favorite removed")
                    appWindow.banner.show()
                    Shortcut.removeShortcut(delete_dialog.name)
                    Shortcut.removeCyclingShortcut(delete_dialog.name)
                    delete_dialog.close()
                }
            }
            Button {
                id: delete_cancel
                text: qsTr("Cancel")
                font.pixelSize: UIConstants.FONT_DEFAULT * appWindow.scalingFactor
                width: UIConstants.BUTTON_WIDTH * appWindow.scalingFactor
                height: UIConstants.BUTTON_HEIGHT * appWindow.scalingFactor
                onClicked: delete_dialog.close()
            }
        }
    }
*/

    Dialog {
        id: add_dialog
        property string coord : ''
        property alias name : editTextField.text

        canAccept: add_dialog.coord != '' && name.text != ''

        onAccepted: {
            if(add_dialog.name != '') {
                if(("OK" == Favorites.addFavorite(add_dialog.name, coord))) {
                    favoritesModel.clear()
                    Favorites.getFavorites(favoritesModel)
                    add_dialog.name = ''

                    appWindow.banner.success = true
                    appWindow.banner.text = qsTr("Location added to favorites")
                    appWindow.banner.show()
                } else {
                    appWindow.banner.success = false
                    appWindow.banner.text = qsTr("Location already in the favorites")
                    appWindow.banner.show()
                }
            }
            else {
                appWindow.banner.success = false
                appWindow.banner.text = qsTr("Name cannot be empty")
                appWindow.banner.show()
            }
        }

        Column {
            anchors.fill: parent

            DialogHeader {
                acceptText: qsTr("Add favorite")
            }

            LocationEntry {
                id: entry
                anchors.bottomMargin: UIConstants.DEFAULT_MARGIN
                font.pixelSize: UIConstants.FONT_XLARGE * appWindow.scalingFactor
                font.bold: true
                font.family: UIConstants.FONT_FAMILY
                lineHeightMode: Text.FixedHeight
                lineHeight: font.pixelSize * 1.5
                label.anchors.horizontalCenter: entry.horizontalCenter
                type: qsTr("Search for location")
                disable_favorites: true
                onLocationDone: {
                    add_dialog.name = name
                    add_dialog.coord = coord
                }
            }

            Spacing {}

            Text {
                text: qsTr("Enter name for the favorite")
                font.pixelSize: UIConstants.FONT_XLARGE
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Qt.AlignCenter
                elide: Text.ElideNone
                font.bold: true
                font.family: UIConstants.FONT_FAMILY
                color: Theme.theme[appWindow.colorscheme].COLOR_FOREGROUND
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
                    opacity: 0.8
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

/*
    Dialog {
        id: shortcut_dialog
        property string name
        property string coord
        signal shortcutsChanged()

        title: Text {
            text: qsTr("Add to application menu?")
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Qt.AlignCenter
            elide: Text.ElideNone
            font.pixelSize: UIConstants.FONT_XLARGE * appWindow.scalingFactor
            font.bold: true
            font.family: UIConstants.FONT_FAMILY
            color: Theme.theme[appWindow.colorscheme].COLOR_FOREGROUND
        }

        content:
            Column {
                spacing: UIConstants.DEFAULT_MARGIN
                Spacing {}
                Row {
                    CheckBox {
                        id: shortcut_route_checkbox
                        Connections {
                            target: shortcut_dialog
                            onNameChanged: shortcut_route_checkbox.checked = Shortcut.checkIfExists(shortcut_dialog.name)
                        }

                        text: qsTr("Route search")
                        onClicked: {
                            Shortcut.toggleShortcut(shortcut_dialog.name, shortcut_dialog.coord)
                            shortcut_dialog.shortcutsChanged()
                            if(checked) {
                                appWindow.banner.success = true
                                appWindow.banner.text = qsTr("Favorite added to application menu")
                                appWindow.banner.show()
                            } else {
                                appWindow.banner.success = false
                                appWindow.banner.text = qsTr("Favorite removed from application menu")
                                appWindow.banner.show()
                            }
                        }
                    }
                }
                Row {
                    CheckBox {
                        id: shortcut_cycling_checkbox
                        Connections {
                            target: shortcut_dialog
                            onNameChanged: shortcut_cycling_checkbox.checked = Shortcut.checkIfCyclingExists(shortcut_dialog.name)
                        }
                        text: qsTr("Cycling")
                        onClicked: {
                            Shortcut.toggleCyclingShortcut(shortcut_dialog.name, shortcut_dialog.coord)
                            shortcut_dialog.shortcutsChanged()
                            if(checked) {
                                appWindow.banner.success = true
                                appWindow.banner.text = qsTr("Favorite added to application menu")
                                appWindow.banner.show()
                            } else {
                                appWindow.banner.success = false
                                appWindow.banner.text = qsTr("Favorite removed from application menu")
                                appWindow.banner.show()
                            }
                        }
                    }
                }
            }
        buttons: Column {
            spacing: UIConstants.DEFAULT_MARGIN
            anchors.horizontalCenter: parent.horizontalCenter
            width: button_save.width

            Spacing {}

            Button {
                id: shortcut_close
                text: qsTr("Close")
                font.pixelSize: UIConstants.FONT_DEFAULT  * appWindow.scalingFactor
                width: UIConstants.BUTTON_WIDTH * appWindow.scalingFactor
                height: UIConstants.BUTTON_HEIGHT * appWindow.scalingFactor
                onClicked: {
                    shortcut_dialog.close()
                }
            }
        }
    }
*/
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: content_column.height

        Component.onCompleted: {
            Favorites.initialize()
        }

        PullDownMenu {
            MenuItem { text: qsTr("Add favorite"); onClicked: add_dialog.open() }
        }

        Column {
            id: content_column
            width: parent.width
            spacing: UIConstants.DEFAULT_MARGIN * appWindow.scalingFactor
            PageHeader {
                title: qsTr("Manage favorites")
            }

            Component {
                id: favoritesManageDelegate
                Item {
                    width: parent.width
                    height: UIConstants.LIST_ITEM_HEIGHT_SMALL * appWindow.scalingFactor

                    Text {
                        text: modelData
                        anchors.left: parent.left
                        anchors.right: shortcut_button.left
                        anchors.verticalCenter: parent.verticalCenter
                        color: Theme.theme[appWindow.colorscheme].COLOR_FOREGROUND
                        font.pixelSize: UIConstants.FONT_XLARGE * appWindow.scalingFactor
                        elide: Text.ElideRight
                        lineHeightMode: Text.FixedHeight
                        lineHeight: font.pixelSize * 1.2
                    }
                    MyButton {
                        id: shortcut_button
                        property bool toggled : false

                        Connections {
                            target: shortcut_dialog
                            onShortcutsChanged: shortcut_button.toggled = (Shortcut.checkIfExists(modelData) || Shortcut.checkIfCyclingExists(modelData))
                        }

                        imageSize: 40
                        Component.onCompleted: {
                            toggled = (Shortcut.checkIfExists(modelData) || Shortcut.checkIfCyclingExists(modelData))
                        }
                        anchors.right: edit_button.left
                        source: toggled?
                                    Theme.theme[appWindow.colorscheme].BUTTONS_INVERTED?'qrc:/images/home-mark-inverse.png':'qrc:/images/home-mark.png' :
                                    Theme.theme[appWindow.colorscheme].BUTTONS_INVERTED?'qrc:/images/home-unmark-inverse.png':'qrc:/images/home-unmark.png'
                        mouseArea.onClicked: {
                            shortcut_dialog.name = modelData
                            shortcut_dialog.coord = coord
                            shortcut_dialog.open()
                        }
                    }

                    MyButton {
                        id: edit_button
                        source: Theme.theme[appWindow.colorscheme].BUTTONS_INVERTED?'image://theme/icon-m-toolbar-edit-white':'image://theme/icon-m-toolbar-edit'
                        anchors.right: remove_button.left
                        mouseArea.onClicked: {
                            list.currentIndex = index
                            edit_dialog.name = modelData
                            edit_dialog.old_name = modelData
                            edit_dialog.coord = coord
                            edit_dialog.open()
                        }
                    }
                    MyButton {
                        id: remove_button
                        source: Theme.theme[appWindow.colorscheme].BUTTONS_INVERTED?'image://theme/icon-m-toolbar-delete-white':'image://theme/icon-m-toolbar-delete'
                        anchors.right: parent.right
                        mouseArea.onClicked: {
                            list.currentIndex = index
                            delete_dialog.name = modelData
                            delete_dialog.open()
                        }
                    }
                }
            }

            ListView {
                id: list
                width: parent.width
                height: favoritesModel.count * UIConstants.LIST_ITEM_HEIGHT_SMALL + UIConstants.DEFAULT_MARGIN * 3
                model: favoritesModel
                delegate: favoritesManageDelegate

                ViewPlaceholder {
                    enabled: list.count == 0
                    text: qsTr("No saved favorites")
                }


            }
        }
    }
}

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

Page {
    id: favorites_page

    Component.onCompleted: {
        Favorites.initialize()
        Favorites.getFavorites(favoritesModel)
    }

    ListModel {
        id: favoritesModel
    }

/*
    Dialog {
// TODO:
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

    SilicaListView {
        id: list
        anchors.fill: parent
        property Item contextMenu
        model: favoritesModel
        delegate: favoritesManageDelegate

        header: PageHeader {
            title: qsTr("Manage favorites")
        }

        PullDownMenu {
            MenuItem { text: qsTr("Add favorite"); onClicked: pageStack.push(Qt.resolvedUrl("AddFavoriteDialog.qml"), {favoritesModel: favoritesModel}) }
        }

        ViewPlaceholder {
            enabled: list.count == 0
            text: qsTr("No saved favorites")
        }

        Component {
            id: contextMenuComponent

            ContextMenu {
                id: menu
                property Item currentItem
                MenuItem {
                    text: qsTr("Edit")
                    onClicked: menu.currentItem.edit()
                }

                MenuItem {
                    text: qsTr("Remove")
                    onClicked: menu.currentItem.remove()
                }
            }
        }
    }

    Component {
        id: favoritesManageDelegate

        BackgroundItem {
            id: rootItem
            width: parent.width
            height: menuOpen ? Theme.itemSizeSmall + list.contextMenu.height : Theme.itemSizeSmall
            property bool menuOpen: list.contextMenu != null && list.contextMenu.parent === rootItem
            function edit() {
                pageStack.push(Qt.resolvedUrl("EditFavoriteDialog.qml"), {favoritesModel: favoritesModel, name: modelData, old_name: modelData, coord: coord})
            }

            function remove() {
                remorse.execute(rootItem, "Deleting", function() {
                        Favorites.deleteFavorite(coord, favoritesModel)
                        Shortcut.removeShortcut(modelData)
                        Shortcut.removeCyclingShortcut(modelData)
                })

            }

            onPressAndHold: {
                if (!list.contextMenu) {
                    list.contextMenu = contextMenuComponent.createObject(list)
                }

                list.contextMenu.currentItem = rootItem
                list.contextMenu.show(rootItem)
            }

            Label {
                id: label
                height: Theme.itemSizeSmall
                text: modelData
                anchors.left: parent.left
                width: parent.width
                color: Theme.primaryColor
                verticalAlignment: Text.AlignVCenter
            }

            RemorseItem { id: remorse }

/*
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
*/
        }
    }
}

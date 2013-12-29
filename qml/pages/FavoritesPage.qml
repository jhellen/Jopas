/**********************************************************************
*
* This file is part of the Jopas, forked from Meegopas.
* More information:
*
*   https://github.com/rasjani/Jopas
*   https://github.com/junousia/Meegopas
*
* Author: Jani Mikkonen <jani.mikkonen@gmail.com>
* Original author: Jukka Nousiainen <nousiaisenjukka@gmail.com>
* Other contributors:
*   Jonni Rainisto <jonni.rainisto@gmail.com>
*   Mohammed Samee <msameer@foolab.org>r
*   Clovis Scotti <scotti@ieee.org>
*   Benoit HERVIER <khertan@khertan.net>
*
* All assets contained within this project are copyrighted by their
* respectful authors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* See full license at http://www.gnu.org/licenses/gpl-3.0.html
*
**********************************************************************/

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
        }
    }
}

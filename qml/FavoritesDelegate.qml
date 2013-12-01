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

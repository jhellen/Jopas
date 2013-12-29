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
import QtPositioning 5.0

ListItem {
    id: stop_item
    signal near
    contentHeight: Theme.itemSizeMedium
    property bool highlight: false

    onClicked: {
        // show map if currently hidden
        appWindow.mapVisible = true

        // follow mode disables panning to location
        if(!appWindow.followMode)
            map.map_loader.item.flickable_map.panToLatLong(model.latitude,model.longitude)
    }

    Location {
        id: coordinate

        coordinate {
            latitude: model.latitude
            longitude: model.longitude
        }
    }

    onStateChanged: {
        if (state == "near")
            stop_item.near()
    }

    state: (coordinate.coordinate.distanceTo(stop_page.position.position.coordinate) && coordinate.coordinate.distanceTo(stop_page.position.position.coordinate) < 150)? "near": "far"

    states: [
        State {
            name: "far"
        },
        State {
            name: "near"
        }
    ]

    Label {
        id: diff
        anchors.top: parent.top
        anchors.left: parent.left
        horizontalAlignment: Qt.AlignLeft
        text: "+" + time_diff + " min"
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.secondaryColor
    }

    Label {
        id: time
        anchors.top: diff.bottom
        anchors.left: parent.left
        horizontalAlignment: Qt.AlignLeft
        text: (index === 0)? Qt.formatTime(depTime, "hh:mm") : Qt.formatTime(arrTime, "hh:mm")
        font.pixelSize: Theme.fontSizeMedium
        color: stop_item.highlight ? Theme.highlightColor : Theme.primaryColor
    }

    Label {
        id: station_code
        anchors.right: parent.right
        anchors.top: parent.top
        horizontalAlignment: Qt.AlignRight
        text: shortCode ? "(" + shortCode + ")" : ""
        font.pixelSize: Theme.fontSizeSmall
        color: Theme.secondaryColor
    }

    Label {
        text: name
        horizontalAlignment: Qt.AlignRight
        anchors.right: parent.right
        anchors.top: station_code.bottom
        font.pixelSize: Theme.fontSizeMedium
        color: stop_item.highlight ? Theme.highlightColor : Theme.primaryColor
    }
}

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

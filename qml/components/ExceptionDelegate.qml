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
import "UIConstants.js" as UIConstants
import "reittiopas.js" as Reittiopas
import "helper.js" as Helper
import "theme.js" as Theme
// TODO:
Component {
    id: disruptionDelegate
    Item {
        id: delegate_item
        width: parent.width
        height: column.height + UIConstants.DEFAULT_MARGIN

        Column {
            id: column
            anchors.right: parent.right
            anchors.left: parent.left

            Text {
                text: Qt.formatDateTime(Helper.parse_disruption_time(time), "dd.MM.yyyy - hh:mm")
                anchors.left: parent.left
                horizontalAlignment: Qt.AlignLeft
                font.pixelSize: UIConstants.FONT_LARGE * appWindow.scalingFactor
                color: Theme.theme[appWindow.colorscheme].COLOR_FOREGROUND
                lineHeightMode: Text.FixedHeight
                lineHeight: font.pixelSize * 1.2
            }
            Text {
                text: info_fi
                horizontalAlignment: Text.AlignLeft
                width: parent.width
                wrapMode: Text.WordWrap
                font.pixelSize: UIConstants.FONT_DEFAULT * appWindow.scalingFactor
                color: Theme.theme[appWindow.colorscheme].COLOR_SECONDARY_FOREGROUND
                lineHeightMode: Text.FixedHeight
                lineHeight: font.pixelSize * 1.2
            }
        }
    }
}

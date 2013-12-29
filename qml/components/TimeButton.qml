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

BackgroundItem {
    id: timeContainer
    height: timeButton.height
    width: timeButton.width
    property date storedDate

    signal timeChanged(variant newTime)

    function updateTime() {
        storedDate = new Date()
        timeChanged(storedDate)
    }

    Label {
        id: timeButton
        font.pixelSize: Theme.fontSizeExtraLarge
        color: Theme.secondaryColor
        text: Qt.formatTime(storedDate, "hh:mm")
    }

    onClicked: {
        var dialog = pageStack.push("Sailfish.Silica.TimePickerDialog",
            {hour: storedDate.getHours(), minute: storedDate.getMinutes()})
        dialog.accepted.connect(function() {
            timeContainer.storedDate = dialog.time
            timeContainer.timeChanged(timeContainer.storedDate)
        })
    }
}

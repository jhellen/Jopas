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

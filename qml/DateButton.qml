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
    id: dateContainer
    width: dateButton.width
    height: dateButton.height
    anchors.horizontalCenter: parent.horizontalCenter
    property date storedDate
    signal dateChanged(variant newDate)

    onClicked: {
        var dialog = pageStack.push("Sailfish.Silica.DatePickerDialog", {date: storedDate})
        dialog.accepted.connect(function() {
            dateContainer.storedDate = dialog.date
            dateContainer.dateChanged(dateContainer.storedDate)
        })
    }

    function updateDate() {
        storedDate = new Date()
        dateChanged(storedDate)
    }

    Label {
        id: dateButton
        font.pixelSize: Theme.fontSizeLarge
        color: Theme.secondaryColor
        text: Qt.formatDate(storedDate, "dd. MMMM yyyy")
    }
}



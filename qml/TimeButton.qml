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

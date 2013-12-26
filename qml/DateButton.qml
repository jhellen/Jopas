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



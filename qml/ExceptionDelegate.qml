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

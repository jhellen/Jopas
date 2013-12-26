import QtQuick 2.1
import Sailfish.Silica 1.0

Dialog {
    property alias titleText: header.acceptText
    property alias model: view.model
    property alias delegate: view.delegate

    anchors.fill: parent

    Column {
        width: parent.width

        DialogHeader {
            id: header
            acceptText: qsTr("Add favorite")
        }

        SilicaListView {
            width: parent.width
            // TODO:
            height: 600
            id: view
        }

    }
// TODO:
property int selectedIndex
}

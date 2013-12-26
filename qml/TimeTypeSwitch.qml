import QtQuick 2.1
import Sailfish.Silica 1.0

TextSwitch {
    width: Screen.width/2 // TOODO: we break without that :/
    text: checked ? qsTr("arrival") : qsTr("departure")
}

import QtQuick 2.1
import Sailfish.Silica 1.0

TextField {
    property alias regExpValidator : regExpValidator
    validator: regExpValidator
    inputMethodHints: Qt.ImhNoPredictiveText
// TODO:
//    platformStyle: TextFieldStyle {
//        paddingLeft: 45
//    }
    RegExpValidator {
        id: regExpValidator
        regExp: /^.{3,}$/
    }
}

import QtQuick 2.1
import "helper.js" as Helper
import "UIConstants.js" as UIConstants
import "theme.js" as Theme

Item {
    id: locationSwitch
    state: "normal"
    anchors.right: parent.right
    anchors.top: from.bottom
    width: 50
    height: 50

    property variant from
    property variant to

    Rectangle {
        anchors.fill: parent
        color: Theme.theme[appWindow.colorscheme].COLOR_BACKGROUND_CLICKED
        z: -1
        visible: locationSwitchMouseArea.pressed
    }
    Image {
        anchors.centerIn: parent
        source: !Theme.theme[appWindow.colorscheme].BUTTONS_INVERTED?'qrc:/images/switch.png':'qrc:/images/switch-inverse.png'
        smooth: true
        height: 50
        width: height
    }
    MouseArea {
        id: locationSwitchMouseArea
        anchors.fill: parent

        onClicked: {
            Helper.switch_locations(from,to)
            locationSwitch.state = locationSwitch.state == "normal" ? "rotated" : "normal"
        }
    }
    states: [
        State {
            name: "rotated"
            PropertyChanges { target: locationSwitch; rotation: 180 }
        },
        State {
            name: "normal"
            PropertyChanges { target: locationSwitch; rotation: 0 }
        }
    ]
    transitions: Transition {
        RotationAnimation { duration: 500; direction: RotationAnimation.Clockwise; easing.type: Easing.InOutCubic }
    }
}


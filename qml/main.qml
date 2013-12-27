import QtQuick 2.1
import Sailfish.Silica 1.0
import "storage.js" as Storage

ApplicationWindow {
    id: appWindow
    cover: CoverBackground {
        CoverPlaceholder {
            text: "Jopas"
            // icon.source: "Jopas.png"
        }
    }


    InfoBanner {
        id: infoBanner
    }

    allowedOrientations: Orientation.All

    Component.onCompleted: {
        Storage.initialize()

        var allowGps = Storage.getSetting("gps")
        var apiValue = Storage.getSetting("api")
        if (allowGps === "Unknown" || apiValue === "Unknown") {
            var dialog = pageStack.push(Qt.resolvedUrl("StartupDialog.qml"))
            dialog.onAccepted.connect(function() {
                pageStack.replace(Qt.resolvedUrl("MainPage.qml"))
            })
            dialog.onRejected.connect(function() {
                pageStack.replace(Qt.resolvedUrl("MainPage.qml"))
            })
        }
        else {
            pageStack.push(Qt.resolvedUrl("MainPage.qml"))
        }
    }

    signal followModeEnabled

    property alias banner : banner
    property variant scalingFactor : 1
    property bool positioningActive : (Qt.application.active && gpsEnabled)
    property bool followMode : false
    property bool mapVisible : false
    property string colorscheme : "default"
    property bool gpsEnabled : false

    onFollowModeChanged: {
        if(followMode)
            followModeEnabled()
    }

    Label {
        id: banner
    }
/*
// TODO:
    InfoBanner {
        id: banner
        property bool success : false
        y: 40
        iconSource: success ? 'qrc:/images/banner_green.png':'qrc:/images/banner_red.png'
    }
*/
}

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
import "storage.js" as Storage

ApplicationWindow {
    id: appWindow

    allowedOrientations: Orientation.All

    Component.onCompleted: {
        Storage.initialize()

        var allowGps = Storage.getSetting("gps")
        var apiValue = Storage.getSetting("api")
        if (allowGps === "Unknown" || apiValue === "Unknown") {
            var dialog = pageStack.push(Qt.resolvedUrl("StartupDialog.qml"))
            dialog.onAccepted.connect(function() {
                pageStack.push(Qt.resolvedUrl("MainPage.qml"))
            })
            dialog.onRejected.connect(function() {
                pageStack.push(Qt.resolvedUrl("MainPage.qml"))
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

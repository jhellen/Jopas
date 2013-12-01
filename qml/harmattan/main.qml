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
    initialPage: Component { MainPage {} }

    signal followModeEnabled

    property alias about : aboutLoader.item
    property alias menu : menuLoader.item
    property alias banner : banner
    property variant scalingFactor : 1
    property bool positioningActive : (Qt.application.active && gpsEnabled)
    property bool followMode : false
    property bool mapVisible : false
    property bool showStationCode : true
    property string colorscheme : "default"
    property bool gpsEnabled : false
    property string region

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
    Loader {
        id: menuLoader
        anchors.fill: parent
//        sourceComponent: menuComponent
    }
    Loader {
        id: aboutLoader
        anchors.fill: parent
//        sourceComponent: aboutComponent
    }

}

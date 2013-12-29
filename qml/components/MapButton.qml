/**********************************************************************
*
* This file is part of the Jopas, forked from Meegopas.
* More information:
*
*   https://github.com/rasjani/Jopas
*   https://github.com/junousia/Meegopas
*
* Author: Jani Mikkonen <jani.mikkonen@gmail.com>
* Original author: Jukka Nousiainen <nousiaisenjukka@gmail.com>
* Other contributors:
*   Jonni Rainisto <jonni.rainisto@gmail.com>
*   Mohammed Samee <msameer@foolab.org>r
*   Clovis Scotti <scotti@ieee.org>
*   Benoit HERVIER <khertan@khertan.net>
*
* All assets contained within this project are copyrighted by their
* respectful authors.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* See full license at http://www.gnu.org/licenses/gpl-3.0.html
*
**********************************************************************/

import QtQuick 2.1
import "UIConstants.js" as UIConstants
import "theme.js" as Theme

Rectangle {
    id: button

    property int imageSize: 50
    property bool selected: false

    signal clicked

    width: 50
    height: 50
    radius: 10
    opacity: 0.7
    color: (mouseArea.pressed || selected) ? Theme.theme[appWindow.colorscheme].COLOR_MAPBUTTON_CLICKED : Theme.theme[appWindow.colorscheme].COLOR_MAPBUTTON

    property alias source : image.source
    property alias mouseArea : mouseArea
    property alias image : image

    Image {
        id: image
        anchors.centerIn: parent
        smooth: true
        height: imageSize
        width: imageSize
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: button.clicked()
    }
}

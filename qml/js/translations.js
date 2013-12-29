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

var translation = {}
translation['Tarmac'] = qsTr("Tarmac")
translation['Default'] = qsTr("Default")
translation['Gravel'] = qsTr("Gravel")
translation['Shortest'] = qsTr("Shortest")

translation['Satellite'] = qsTr("Satellite")
translation['Street'] = qsTr("Street")
translation['Terrain'] = qsTr("Terrain")
translation['Hybrid'] = qsTr("Hybrid")
translation['Transit'] = qsTr("Transit")

function translate(name) {
    return translation[name]
}

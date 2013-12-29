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
import Sailfish.Silica 1.0
import QtPositioning 5.0
import QtQuick.XmlListModel 2.0
import "UIConstants.js" as UIConstants
import "reittiopas.js" as Reittiopas
import "storage.js" as Storage
import "favorites.js" as Favorites
import "theme.js" as Theme

Column {
    property alias type : label.text
    property alias font : label.font
    property alias label : labelContainer
    property alias lineHeightMode : label.lineHeightMode
    property alias lineHeight : label.lineHeight
    property alias textfield : textfield.text

    property variant current_name : ''
    property variant current_coord : ''

    Location {
        id: previousCoord

        coordinate {
            latitude: 0
            longitude: 0
        }
    }

    property variant destination_name : ''
    property variant destination_coord : ''

    property bool isFrom : false

    property bool destination_valid : (suggestionModel.count > 0)
    property alias selected_favorite : favoriteQuery.selectedIndex
    property bool disable_favorites : false

    height: textfield.height + labelContainer.height
    width: parent.width

    signal locationDone(string name, string coord)
    signal currentLocationDone(string name, string coord)
    signal locationError()

    state: (destination_coord || current_coord) ? "validated" : destination_valid ? "sufficient" : "error"

    states: [
        State {
            name: "error"
            PropertyChanges { target: statusIndicator; color: "red" }
        },
        State {
            name: "sufficient"
            PropertyChanges { target: statusIndicator; color: "yellow" }
        },
        State {
            name: "validated"
            PropertyChanges { target: statusIndicator; color: "green" }
        }
    ]
    transitions: [
        Transition {
            ColorAnimation { duration: 100 }
        }
    ]

    Component.onCompleted: {
        Favorites.initialize()
    }

    function clear() {
        suggestionModel.source = ""
        textfield.text = ''
        destination_coord = ''
        query.selectedIndex = -1
        locationDone("","")
    }

    function updateLocation(name, housenumber, coord) {
        suggestionModel.source = ""
        var address = name

        if(housenumber && address.slice(address.length - housenumber.length) != housenumber)
            address += " " + housenumber

        destination_name = address
        destination_coord = coord
        textfield.text = address

        locationDone(address, coord)
    }

    function updateCurrentLocation(name, housenumber, coord) {
        currentLocationModel.source = ""
        var address = name

        if(housenumber && address.slice(address.length - housenumber.length) != housenumber)
            address += " " + housenumber

        current_name = address
        current_coord = coord

        textfield.placeholderText = address
        currentLocationDone(address, coord)
    }

    Timer {
        id: gpsTimer
        running: isFrom
        onTriggered: getCurrentCoord()
        triggeredOnStart: true
        interval: 200
        repeat: true
    }

    function positionValid(position) {
        if(position.latitudeValid && position.longitudeValid)
            return true
        else
            return false
    }

    function getCurrentCoord() {
        /* wait until position is accurate enough */
        if(positionValid(positionSource.position)) {
            gpsTimer.stop()
            previousCoord.coordinate.latitude = positionSource.position.coordinate.latitude
            previousCoord.coordinate.longitude = positionSource.position.coordinate.longitude
            currentLocationModel.source = Reittiopas.get_reverse_geocode(previousCoord.coordinate.latitude.toString(),
                                                                         previousCoord.coordinate.longitude.toString(),
                                                                         Storage.getSetting('api'))
        } else {
            /* poll again in 200ms */
            gpsTimer.start()
        }
    }

    PositionSource {
        id: positionSource
        updateInterval: 500
        active: appWindow.positioningActive
        onPositionChanged: {
            /* if we have moved >250 meters from the previous place, update current location */
            if(previousCoord.coordinate.latitude != 0 && previousCoord.coordinate.longitude != 0 &&
                    position.coordinate.distanceTo(previousCoord) > 250) {
                getCurrentCoord()
            }
        }
    }

    XmlListModel {
        id: currentLocationModel
        query: "/response/node"
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "city"; query: "city/string()" }
        XmlRole { name: "coord"; query: "coords/string()" }
        XmlRole { name: "shortCode"; query: "shortCode/string()" }
        XmlRole { name: "housenumber"; query: "details/houseNumber/string()" }

        onStatusChanged: {
            if(status == XmlListModel.Ready && source != "") {
                /* if only result, take it into use */
                if(currentLocationModel.count > 0) {
                    updateCurrentLocation(currentLocationModel.get(0).name.split(',', 1).toString(),
                                   currentLocationModel.get(0).housenumber,
                                   currentLocationModel.get(0).coord)
                }
            }
        }
    }

    XmlListModel {
        id: suggestionModel
        query: "/response/node"
        XmlRole { name: "name"; query: "name/string()" }
        XmlRole { name: "city"; query: "city/string()" }
        XmlRole { name: "coord"; query: "coords/string()" }
        XmlRole { name: "shortCode"; query: "shortCode/string()" }
        XmlRole { name: "housenumber"; query: "details/houseNumber/string()" }

        onStatusChanged: {
            if(status == XmlListModel.Ready && source != "") {
                /* if only result, take it into use */
                if(suggestionModel.count == 1) {
                    updateLocation(suggestionModel.get(0).name.split(',', 1).toString(),
                                   suggestionModel.get(0).housenumber,
                                   suggestionModel.get(0).coord)
                } else if (suggestionModel.count == 0) {
                    infoBanner.displayError( qsTr("No results") )
                } else {
                    /* just update the first result to main page */
                    locationDone(suggestionModel.get(0).name.split(',', 1).toString(),suggestionModel.get(0).coord)
                }
            } else if (status == XmlListModel.Error) {
                selected_favorite = -1
                suggestionModel.source = ""
                locationDone("", 0, "")
                locationError()
                infoBanner.displayError( qsTr("Could not find location") )
            }
        }
    }

    ListModel {
        id: favoritesModel
    }

    MySelectionDialog {
        id: query
        model: suggestionModel
        delegate: SuggestionDelegate {
            onClicked: {
                query.selectedIndex = index
                query.accept()
            }
        }

        titleText: qsTr("Choose location")
        onAccepted: {
            updateLocation(suggestionModel.get(selectedIndex).name,
                            suggestionModel.get(selectedIndex).housenumber,
                            suggestionModel.get(selectedIndex).coord)
        }
        onRejected: {}
    }

    MySelectionDialog {
        id: favoriteQuery
        model: favoritesModel
        titleText: qsTr("Choose location")
        delegate: FavoritesDelegate {
            onClicked: {
                favoriteQuery.selectedIndex = index
                favoriteQuery.accept()
            }
        }

        onAccepted: {
            /* if positionsource used */
            if(selectedIndex == 0) {
                if(positionSource.position.latitudeValid && positionSource.position.longitudeValid) {
                    suggestionModel.source = Reittiopas.get_reverse_geocode(positionSource.position.coordinate.latitude.toString(),
                                                                            positionSource.position.coordinate.longitude.toString(),
                                                                            Storage.getSetting('api'))
                }
                else {
                    favoriteQuery.selectedIndex = -1
                    infoBanner.displayError( qsTr("Positioning service disabled from application settings") )
                }
            } else {
                updateLocation(favoritesModel.get(selectedIndex).modelData,
                               0,
                               favoritesModel.get(selectedIndex).coord)
            }
        }
    }

    Timer {
        id: suggestionTimer
        interval: 1200
        repeat: false
        triggeredOnStart: false
        onTriggered: {
            if(textfield.acceptableInput) {
                suggestionModel.source = Reittiopas.get_geocode(textfield.text, Storage.getSetting('api'))
            }
        }
    }

    Item {
        id: labelContainer
        anchors.rightMargin: 5
        height: label.height
        width: label.width + count.width
        Rectangle {
            height: parent.height
            width: label.width + count.width
            color: Theme.theme[appWindow.colorscheme].COLOR_BACKGROUND_CLICKED
            z: -1
            visible: labelMouseArea.pressed
        }
        Text {
            id: label
            font.pixelSize: UIConstants.FONT_XXLARGE * appWindow.scalingFactor
            color: Theme.theme[appWindow.colorscheme].COLOR_FOREGROUND
            lineHeightMode: Text.FixedHeight
            lineHeight: font.pixelSize * 1.1
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
        }
        Bubble {
            id: count
            count: suggestionModel.count
            visible: (suggestionModel.count > 1)
            anchors.left: label.right
            anchors.leftMargin: 2
            anchors.verticalCenter: label.verticalCenter
        }

        MouseArea {
            id: labelMouseArea
            anchors.fill: parent
            enabled: (suggestionModel.count > 1)
            onClicked: {
                if(suggestionModel.count > 1) {
                    query.open()
                    textfield.platformCloseSoftwareInputPanel()
                }
            }
        }
    }

    Item {
        width: parent.width
        height: textfield.height
        MyTextfield {
            id: textfield
            anchors.left: parent.left
            anchors.right: disable_favorites ? parent.right : favoritePicker.left
            placeholderText: qsTr("Type a location")

            onTextChanged: {
                if(text != destination_name) {
                    suggestionModel.source = ""
                    selected_favorite = -1
                    destination_coord = ""
                    destination_name = ""
                    locationDone("","")

                    if(acceptableInput)
                        suggestionTimer.restart()
                    else
                        suggestionTimer.stop()
                }
            }
            Rectangle {
                id: statusIndicator
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: UIConstants.DEFAULT_MARGIN
                smooth: true
                radius: 10
                height: 20
                width: 20
                opacity: 0.6
            }
            Image {
                id: clearLocation
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                source: "qrc:/images/clear.png"
                visible: ((textfield.activeFocus) && !busyIndicator.running)
                MouseArea {
                    id: locationInputMouseArea
                    anchors.fill: parent
                    onClicked: {
                        clear()
                    }
                }
            }

            BusyIndicator {
                id: busyIndicator
                running: suggestionModel.status == XmlListModel.Loading
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 15
                size: BusyIndicatorSize.Small
                MouseArea {
                    id: spinnerMouseArea
                    anchors.fill: parent
                    onClicked: {
                        suggestionModel.source = ""
                    }
                }
            }
            Keys.onReturnPressed: {
                textfield.platformCloseSoftwareInputPanel()
                parent.focus = true
            }
        }

        MyButton {
            id: favoritePicker
            enabled: !disable_favorites
            visible: !disable_favorites
            source: selected_favorite == -1?
                        !Theme.theme[appWindow.colorscheme].BUTTONS_INVERTED?'qrc:/images/favorite-unmark.png':'qrc:/images/favorite-unmark-inverse.png' :
                        !Theme.theme[appWindow.colorscheme].BUTTONS_INVERTED?'qrc:/images/favorite-mark.png':'qrc:/images/favorite-mark-inverse.png'
            anchors.right: parent.right
            mouseArea.onClicked: {
                favoritesModel.clear()
                Favorites.getFavorites(favoritesModel)
                favoritesModel.insert(0, {modelData: qsTr("Current location"),coord:"0,0"})
                favoriteQuery.open()
            }
            mouseArea.onPressAndHold: {
                if(destination_coord && favoriteQuery.selectedIndex <= 0) {
                    if(("OK" == Favorites.addFavorite(textfield.text, destination_coord))) {
                        favoritesModel.clear()
                        Favorites.getFavorites(favoritesModel)
                        favoriteQuery.selectedIndex = favoritesModel.count
                        infoBanner.displayError( qsTr("Location added to favorites") )
                    } else {
                        infoBanner.displayError(qsTr("Location already in the favorites"))
                    }

                }
            }
        }
    }
}

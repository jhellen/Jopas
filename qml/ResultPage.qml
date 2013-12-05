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
import "reittiopas.js" as Reittiopas
import "storage.js" as Storage

Page {
    property variant search_parameters

    Component.onCompleted: startSearch()

    function startSearch() {
        routeModel.clear()
        Reittiopas.new_route_instance(search_parameters, routeModel, Storage.getSetting('api'))
    }

    ListModel {
        id: routeModel
        property bool done : false
    }

    Component {
        id: footer

        ListItem {
            height: Theme.itemSizeExtraSmall
            visible: !busyIndicator.running

            onClicked: {
                /* workaround to modify qml array is to make a copy of it,
                   modify the copy and assign the copy back to the original */
                var new_parameters = search_parameters
                new_parameters.time.setMinutes(new_parameters.time.getMinutes() + 15)
                search_parameters = new_parameters

                startSearch()
            }

            Label {
                text: qsTr("Next")
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.secondaryColor
            }
        }
    }


    SilicaListView {
        id: list
        anchors.fill: parent
        model: routeModel
        footer: footer
        delegate: ResultDelegate {}
        interactive: !busyIndicator.running
        header: Column {
            width: parent.width
            PageHeader {
                title: search_parameters.timetype == "departure" ?
                             qsTr("Departure ") + Qt.formatDateTime(search_parameters.time,"dd.MM hh:mm") :
                             qsTr("Arrival ") + Qt.formatDateTime(search_parameters.time,"dd.MM hh:mm")
            }

            Label {
                width: parent.width
                text: search_parameters.from_name + " - " + search_parameters.to_name
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignRight
            }

            ListItem {
                height: Theme.itemSizeExtraSmall
                visible: !busyIndicator.running

                onClicked: {
                    /* workaround to modify qml array is to make a copy of it,
                       modify the copy and assign the copy back to the original */
                    var new_parameters = search_parameters
                    new_parameters.time.setMinutes(new_parameters.time.getMinutes() - 15)
                    search_parameters = new_parameters

                    startSearch()
                }

                Label {
                    text: qsTr("Previous")
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    color: Theme.secondaryColor
                }
            }
        }

        ViewPlaceholder {
            anchors.centerIn: parent
            visible: (!busyIndicator.running && routeModel.count == 0)
            text: qsTr("No results")
        }
    }

    BusyIndicator {
        id: busyIndicator
        running: !routeModel.done
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }
}

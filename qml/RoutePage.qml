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
import "UIConstants.js" as UIConstants
import "reittiopas.js" as Reittiopas
import "theme.js" as Theme

Page {
    property int route_index
    property string from_name
    property string to_name
    property string header
    property string subheader

    onStatusChanged: {
        if(status == Component.Ready && !routeModel.count) {
            var route = Reittiopas.get_route_instance()
            route.dump_legs(route_index, routeModel)
            from_name = route.from_name
            to_name = route.to_name
        }
    }

    ListModel {
        id: routeModel
        property bool done : false
    }

    Component {
        id: delegate
        Loader {
            width: parent.width
            source: type == "station" ? "qrc:/qml/RouteStationDelegate.qml" : "qrc:/qml/RouteDelegate.qml"
        }
    }

    SilicaListView {
        id: routeList
        anchors.fill: parent
        model: routeModel
        delegate: delegate
        interactive: !busyIndicator.visible
        header: Header {
            text: header
            subtext: subheader
        }

        ViewPlaceholder {
            enabled: (!busyIndicator.visible && routeModel.count == 0)
            text: qsTr("No results")
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Map")
                onClicked: { pageStack.push(Qt.resolvedUrl("RouteMapPage.qml")) }
            }
        }
    }

    BusyIndicator {
        id: busyIndicator
        visible: !(routeModel.done)
        running: true
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
    }
}

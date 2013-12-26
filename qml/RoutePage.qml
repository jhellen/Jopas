import QtQuick 2.1
import Sailfish.Silica 1.0
import "reittiopas.js" as Reittiopas

Page {
    property int route_index
    property string from_name
    property string to_name
    property string header
    property string duration
    property string walking

    Component.onCompleted: {
        var route = Reittiopas.get_route_instance()
        route.dump_legs(route_index, routeModel)
        from_name = route.from_name
        to_name = route.to_name
    }

    ListModel {
        id: routeModel
        property bool done: false
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
        header: Column {
            width: parent.width
            PageHeader {
                title: qsTr("%1 minutes").arg(duration)
            }

            Label {
                width: parent.width
                text: qsTr("Walking %1 km").arg(walking)
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignRight
                wrapMode: Text.WordWrap
            }

            Label {
                width: parent.width
                text: header
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignRight
                wrapMode: Text.WordWrap
            }
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

import QtQuick 2.1
import QtQuick.XmlListModel 2.0
import Sailfish.Silica 1.0

Page {
    anchors.fill: parent

    Component.onCompleted: {
        exceptionModel.reload()
    }

    XmlListModel {
        id: exceptionModel
        source: "http://www.poikkeusinfo.fi/xml/v2"
        query: "/DISRUPTIONS/DISRUPTION"
        XmlRole { name: "time"; query: "VALIDITY/@from/string()" }
        XmlRole { name: "info_fi"; query: "INFO/TEXT[1]/string()" }
        XmlRole { name: "info_sv"; query: "INFO/TEXT[2]/string()" }
        XmlRole { name: "info_en"; query: "INFO/TEXT[3]/string()" }
    }

    SilicaListView {
        id: list
        anchors.fill: parent
        model: exceptionModel
        delegate: ExceptionDelegate {}

        header: PageHeader {
            title: qsTr("Traffic exception info")
        }

        PullDownMenu {
            MenuItem { text: qsTr("Update"); onClicked: exceptionModel.reload() }
        }

        ViewPlaceholder {
            anchors.centerIn: parent
            enabled: (!busyIndicator.running && exceptionModel.count == 0)
            text: qsTr("No current traffic exceptions")
        }
    }

    BusyIndicator {
        id: busyIndicator
        running: exceptionModel.status != XmlListModel.Ready
        anchors.centerIn: parent
        size: BusyIndicatorSize.Large
    }
}

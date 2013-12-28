TARGET=harbour-jopas
include(version.pri)
include(common.pri)
QT            += qml quick 
CONFIG        += link_pkgconfig
CONFIG        += sailfishapp
PKGCONFIG     += qdeclarative5-boostable



QML_IMPORT_PATH = qml

OTHER_FILES += \
    qml/* \
    harbour-jopas.desktop \
    rpm/harbour-jopas.yaml

#RESOURCES += \
#    harmattan.qrc

SOURCES += src/main.cpp

INCLUDEPATH += \
    src \
    include

include(version.pri)
include(common.pri)
configure($${PWD}/qml/AboutDialog.qml.in)

target.path = /usr/bin/
icon.path = /usr/share/icons/hicolor/86x86/apps/
icon.files = harbour-jopas.png
desktop.path = /usr/share/applications
desktop.files = harbour-jopas.desktop

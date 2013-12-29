TARGET=harbour-jopas
include(version.pri)
include(common.pri)
QT            += qml quick 
CONFIG        += link_pkgconfig
CONFIG        += sailfishapp
PKGCONFIG     += qdeclarative5-boostable



QML_IMPORT_PATH = qml

OTHER_FILES += \
    qml/js/*.js \
    qml/pages/*.qml \
    qml/components/*.qml \
    qml/pages/AboutDialog.qml.in \
    qml/main.qml \
    harbour-jopas.desktop \
    rpm/harbour-jopas.yaml \
    rpm/harbour-jopas.spec

RESOURCES += \
    jopas.qrc

SOURCES += src/main.cpp

INCLUDEPATH += \
    src 


include(version.pri)
include(common.pri)
configure($${PWD}/qml/pages/AboutDialog.qml.in)

icon.files = harbour-jopas.png
desktop.files = harbour-jopas.desktop

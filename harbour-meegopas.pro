TARGET=harbour-meegopas
# Additional import path used to resolve QML modules in Creator code model
QML_IMPORT_PATH = qml
# qml files to be visible in the project
OTHER_FILES += qml/*

QT += qml quick 

CONFIG += link_pkgconfig
CONFIG += sailfishapp
PKGCONFIG += qdeclarative5-boostable

target.path = /usr/bin/

icon.path = /usr/share/icons/hicolor/86x86/apps/
icon.files = harbour-meegopas.png
desktop.path = /usr/share/applications
desktop.files = harbour-meegopas.desktop

RESOURCES += \
    harmattan.qrc

SOURCES += src/main.cpp

INCLUDEPATH += \
    src \
    include

OTHER_FILES += \
    harbour-meegopas.desktop \
    rpm/meegopas.spec

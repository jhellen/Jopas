TARGET = harbour-meegopas

# Additional import path used to resolve QML modules in Creator code model
QML_IMPORT_PATH = qml

# qml files to be visible in the project
OTHER_FILES += qml/*

QT += qml quick dbus

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += link_pkgconfig
PKGCONFIG += qdeclarative5-boostable

target.path = /usr/bin/

# D-Bus service
dbusservice.path = /usr/share/dbus-1/services
dbusservice.files = com.juknousi.meegopas.service
icon.path = /usr/share/icons/hicolor/86x86/apps/
icon.files = harbour-meegopas.png
icons.path = /usr/share/harbour-meegopas
icons.files = MeegopasCycling80.png MeegopasRoute80.png
desktop.path = /usr/share/applications
desktop.files = harbour-meegopas.desktop
INSTALLS += dbusservice icon icons desktop target

RESOURCES += \
    harmattan.qrc

SOURCES += \
    src/shortcut.cpp \
    src/route.cpp \
    src/meegopasadaptor.cpp


HEADERS += \
    include/shortcut.h \
    include/route.h \
    include/meegopasadaptor.h

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += src/main.cpp

INCLUDEPATH += \
    src \
    include

OTHER_FILES += \
    com.juknousi.meegopas.service \
    com.juknousi.meegopas.xml \
    harbour-meegopas.desktop \
    rpm/meegopas.spec

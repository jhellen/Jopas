# Additional import path used to resolve QML modules in Creator code model
QML_IMPORT_PATH = qml

# qml files to be visible in the project
OTHER_FILES += qml/*

QT += qml quick dbus

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += link_pkgconfig
PKGCONFIG += qdeclarative5-boostable

# D-Bus service
dbusservice.path = /usr/share/dbus-1/services
dbusservice.files = com.juknousi.meegopas.service
icons.path = /usr/share/icons/hicolor/80x80/apps/
icons.files = MeegopasCycling80.png MeegopasRoute80.png
INSTALLS += dbusservice icons

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
    Meegopas.desktop












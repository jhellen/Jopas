#include <QGuiApplication>
#include <QtDebug>
#include <QtDBus/QtDBus>
#include "qplatformdefs.h"
#include "shortcut.h"
#include "meegopasadaptor.h"
#include <MDeclarativeCache>
#include <QQuickView>
#include <QFont>
#include <QQmlContext>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(MDeclarativeCache::qApplication(argc, argv));
    QScopedPointer<QQuickView> viewer(MDeclarativeCache::qQuickView());

    QFont newFont;
    newFont.setFamily("Nokia Pure Text Light");
    newFont.setWeight(QFont::Light);
    app.data()->setFont(newFont);

    QQmlContext *ctxt = viewer->rootContext();

    Shortcut sc;
    ctxt->setContextProperty("Shortcut", &sc);

    ctxt->setContextProperty("QmlApplicationViewer", &(*viewer));
    viewer->setSource(QUrl("qrc:/qml/main.qml"));

    /* register dbus interface */
    QDBusConnection bus = QDBusConnection::sessionBus();
    Route route;
    MeegopasAdaptor dbusAdaptor(&route);

    if(bus.registerService("com.juknousi.meegopas") == QDBusConnectionInterface::ServiceNotRegistered)
        qDebug() << "Registering DBus service failed";

    if(bus.registerObject("/com/juknousi/meegopas", &route) == false)
        qDebug() << "Registering DBus adaptor object failed";

    ctxt->setContextProperty("Route", &route);

    viewer->showFullScreen();
    return app->exec();
}

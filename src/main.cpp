#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>

int main(int argc, char *argv[])
{
     QGuiApplication *app = SailfishApp::application(argc, argv);
     QQuickView *view = SailfishApp::createView();
     view->setSource(SailfishApp::pathTo("qml/main.qml"));
     view->showFullScreen();
     return app->exec();
}

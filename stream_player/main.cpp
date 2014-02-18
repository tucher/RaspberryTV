#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"
#include "ctcpserver.h"
#include <QQmlEngine>
#include <QtQml>
int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QtQuick2ApplicationViewer viewer;

    qmlRegisterType<CTcpServer>("ru.joof.TcpServer", 1, 0, "TcpServer");
    viewer.setSource( QUrl("qrc:/qml/stream_player/main.qml"));
    viewer.showExpanded();
    return app.exec();
}

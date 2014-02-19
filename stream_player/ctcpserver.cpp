#include "ctcpserver.h"
#include <QTcpSocket>
#include <QFile>
#include <QJsonDocument>
#include <QUrl>
#include <QProcess>
#include <QTimer>
QByteArray CTcpServer::parseHTML(QByteArray rawData, QVariantMap & postParams)
{
    //qDebug() << rawData;

    QString string = QString::fromUtf8(rawData);
    if(string.indexOf("GET") == 0)
    {
        QFile indexHTML("index.html");
        QByteArray data;
        if(indexHTML.open(QIODevice::ReadOnly))
            data = indexHTML.readAll();

        data.prepend("HTTP/1.0 200 Ok\r\nContent-Type: text/html; charset=\"utf-8\"\r\n\r\n");
        //qDebug() << data;
        return  data;
    }
    else if(string.indexOf("POST") == 0)
    {
        int i = string.indexOf("Content-Length: ") + 16;
        QString sContL = string.mid(i, string.indexOf("\n", string.indexOf("Content-Length: ")) - i - 1);
        bool ok = false;
        int contentLength = sContL.toInt(&ok);
        if(ok)
        {
            QString content = string.right(contentLength);

            QVariantMap params;
            QJsonDocument json = QJsonDocument::fromJson(content.toUtf8());
            if(!json.isNull())
            {
                postParams = json.toVariant().toMap();
            }
            else
            {
                QStringList pList = content.split("&");
                foreach(QString p, pList)
                {
                    QStringList t = p.split("=");
                    if(t.count() == 2)
                    {
                        params.insert(t[0], QUrl::fromPercentEncoding(t[1].toUtf8()));
                    }
                }
                postParams = params;
            }

        }
        QFile indexHTML("index.html");
        QByteArray data;
        if(indexHTML.open(QIODevice::ReadOnly))
            data = indexHTML.readAll();

        data.prepend("HTTP/1.0 200 Ok\r\nContent-Type: text/html; charset=\"utf-8\"\r\n\r\n");
        //qDebug() << data;
        return  data;
    }
    else
        return "HTTP/1.0 400";
}

CTcpServer::CTcpServer(QObject *parent) :
    QTcpServer(parent)
{
    connect(this, SIGNAL(newConnection()), SLOT(handleConnection()));
    QFile pFile(":/protocol.json");
    pFile.open(QIODevice::ReadOnly);
    m_protocol = QString::fromUtf8(pFile.readAll());

    QTimer::singleShot(4000, this, SLOT(refreshTVRainLink()));
}

void CTcpServer::setPort(int port)
{
    if(listen(QHostAddress::Any, port))
    {
        qDebug() << "Listening" << port;
        emit portChanged(port);
    }
    else
    {
        qDebug() << "Failed to listen" << port;
    }
}

bool CTcpServer::connected()
{
    foreach(QTcpSocket * s, m_socketList){
        if(s && s->state() == QAbstractSocket::ConnectedState)
            return true;
    }

    return false;
}

QString CTcpServer::protocol()
{
    return m_protocol;
}

void CTcpServer::refreshTVRainLink()
{
    QProcess pythonProc;
    pythonProc.start("python", QStringList() << "get_tvrain_link.py");
    pythonProc.waitForFinished(10000);
    QString tvrainLink = QString::fromUtf8(pythonProc.readAllStandardOutput());
    tvrainLink.remove(tvrainLink.length()-1,1);
    if(tvrainLink.indexOf("rtmp") == 0)
        emit dataReceived(QString("{\"cmd\": \"setUrl\", \"url\": \"%1\"}").arg(tvrainLink));
    qDebug() << "From python: " << tvrainLink;
}

void CTcpServer::handleConnection()
{

    while(hasPendingConnections())
    {
        QTcpSocket * s = nextPendingConnection();
        if(s)
        {
            connect(s, SIGNAL(readyRead()), SLOT(handleIncomingData()));
            connect(s, SIGNAL(disconnected()), s, SLOT(deleteLater()));
            connect(s, SIGNAL(disconnected()), SLOT(handleDisconnected()));
            connect(s, SIGNAL(stateChanged(QAbstractSocket::SocketState)), SLOT(socketStateChangedSlot()));
            emit connectedChanged(true);
        }
    }
}

void CTcpServer::handleIncomingData()
{
    QTcpSocket * s = qobject_cast<QTcpSocket*>(sender());
    if(!s)
        return;
    QByteArray rawData = s->readAll();
    QVariantMap postParams;
    QByteArray response = parseHTML(rawData, postParams);
    qDebug( ) << postParams;
    if(!postParams.isEmpty())
    {
        emit dataReceived(QJsonDocument::fromVariant(postParams).toJson());
    }
    s->write(response);
    s->disconnectFromHost();
}

void CTcpServer::handleDisconnected()
{
    m_socketList.removeAll(qobject_cast<QTcpSocket*>(sender()));
    emit connectedChanged(connected());
}

void CTcpServer::sendData(QString data)
{
    foreach(QTcpSocket *s, m_socketList)
        if(s)
            s->write(data.toUtf8());
    //    else
    //        emit error("not connected");
}

void CTcpServer::socketStateChangedSlot()
{
    //emit connectedChanged(m_socket && m_socket->state() == QAbstractSocket::ConnectedState);
}

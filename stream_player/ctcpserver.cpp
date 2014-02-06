#include "ctcpserver.h"
#include <QTcpSocket>
CTcpServer::CTcpServer(QObject *parent) :
    QTcpServer(parent)
{
    connect(this, SIGNAL(newConnection()), SLOT(handleConnection()));
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
    if(m_socket && m_socket->state() == QAbstractSocket::ConnectedState)
        return true;
    else
        return false;
}

void CTcpServer::handleConnection()
{
    m_socket = nextPendingConnection();
    if(m_socket)
    {
        connect(m_socket, SIGNAL(readyRead()), SLOT(handleIncomingData()));
        connect(m_socket, SIGNAL(disconnected()), m_socket, SLOT(deleteLater()));
        connect(m_socket, SIGNAL(disconnected()), SLOT(handleDisconnected()));
        connect(m_socket, SIGNAL(stateChanged(QAbstractSocket::SocketState)), SLOT(socketStateChangedSlot()));
        emit connectedChanged(true);
    }
}

void CTcpServer::handleIncomingData()
{
    emit dataReceived(QString::fromUtf8(m_socket->readAll()));
}

void CTcpServer::handleDisconnected()
{
    m_socket = 0;
    emit connectedChanged(false);
}

void CTcpServer::sendData(QString data)
{
    if(m_socket)
        m_socket->write(data.toUtf8());
    else
        emit error("not connected");
}

void CTcpServer::socketStateChangedSlot()
{
    //emit connectedChanged(m_socket && m_socket->state() == QAbstractSocket::ConnectedState);
}

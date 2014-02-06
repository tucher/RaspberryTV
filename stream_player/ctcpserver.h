#ifndef CTCPSERVER_H
#define CTCPSERVER_H

#include <QTcpServer>
#include <QTcpSocket>
class CTcpServer : public QTcpServer
{
    Q_OBJECT
    Q_PROPERTY(int port READ serverPort WRITE setPort NOTIFY portChanged)
    Q_PROPERTY(bool connected READ connected NOTIFY connectedChanged)
    QTcpSocket * m_socket;
public:
    explicit CTcpServer(QObject *parent = 0);
    void setPort(int port);
    bool connected();
signals:
    void dataReceived(QString data);
    void error(QString error);
    void portChanged(int port);
    void connectedChanged(bool state);
public slots:
    void handleConnection();
    void handleIncomingData();
    void handleDisconnected();
    void sendData(QString data);
    void socketStateChangedSlot();
};

#endif // CTCPSERVER_H

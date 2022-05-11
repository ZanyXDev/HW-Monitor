#pragma once
#include <QObject>
#include <QSysInfo>
#include <QString>
#include <QtGlobal>
#include <QtQml/qqml.h>
#include <QTimer>

#ifdef Q_OS_ANDROID
#include <QtAndroidExtras/QtAndroid>
#include <QtAndroidExtras/QAndroidJniObject>
#include <QtAndroidExtras/QAndroidJniEnvironment>
#endif

#ifdef Q_OS_LINUX
#include <sys/sysinfo.h>
#include <unistd.h>
#include <sys/time.h>
#include <math.h>
#endif

class Monitor : public QObject {
    Q_OBJECT
    //Q_PROPERTY(int moves READ moves WRITE setMoves NOTIFY movesChanged);
    Q_PROPERTY(QString uptime READ getUptime CONSTANT NOTIFY uptimeChanged);
    Q_PROPERTY(QString hostname READ getHostname CONSTANT);
    //Q_PROPERTY(int tiles READ tiles CONSTANT)
public:
    explicit Monitor(QObject *parent = nullptr);

    QString getUptime() const;
    QString getHostname() const;

public slots:

    Q_INVOKABLE void updateSystemInfo();
signals:
    void uptimeChanged();
private:
    QString m_uptime;
    QString m_hostname;

};

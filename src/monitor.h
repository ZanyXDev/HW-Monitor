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
    Q_PROPERTY(QString uptime READ getUptime NOTIFY uptimeChanged);
    Q_PROPERTY(QString memoryUsage READ getMemoryUsage NOTIFY memoryUsageChanged);
    Q_PROPERTY(QString hostname READ getHostname CONSTANT);
    //Q_PROPERTY(int tiles READ tiles CONSTANT)
public:
    explicit Monitor(QObject *parent = nullptr);

    const QString &getUptime() const;
    const QString &getHostname() const;
    const QString &getMemoryUsage() const;

public slots:
    Q_INVOKABLE void updateSystemInfo();

signals:
    void uptimeChanged();
    void memoryUsageChanged();

private:
    QString m_uptime;
    QString m_hostname;
    QString m_memoryUsage;

    quint64 m_PCStartSeconds; /* Seconds since boot */
    quint64 m_totalram;	  /* Total usable main memory size */
    quint64 m_freeram;    /* Available memory size */
    quint64 m_sharedram;  /* Amount of shared memory */
    quint64 m_totalswap;  /* Total swap space size */
    quint64 m_freeswap;   /* swap space still available */
    double  m_memoryUsagePercent;

    void updateUpTime();
    void updateMemory();
   /**
    * float tb = 1099511627776;
    * float gb = 1073741824;
    * float mb = 1048576;
    *float kb = 1024;
    */
};

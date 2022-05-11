#include "monitor.h"

Monitor::Monitor(QObject *parent)
    : QObject(parent)
    , m_uptime(QString(""))
    , m_hostname(QString(""))
{
    updateSystemInfo();
}

QString Monitor::getUptime() const
{
    return m_uptime;
}

QString Monitor::getHostname() const
{
    return m_hostname;
}

void Monitor::updateSystemInfo()
{
#ifdef Q_OS_ANDROID

#elif defined Q_OS_LINUX
    qDebug() << "tic";
    struct sysinfo s_info;
    long m_nPCStartSeconds = 0;

    if ( 0 == sysinfo(&s_info)){
        m_nPCStartSeconds = s_info.uptime;
        int days = round(m_nPCStartSeconds / (60 * 60 * 24) );
        int hours = round((m_nPCStartSeconds - days*60*60*24) / (60 * 60));
        int mins = round((m_nPCStartSeconds - days*60*60*24 - hours*60*60) / 60);
        int sec = round(m_nPCStartSeconds - days*60*60*24 - hours*60*60 - mins*60);

        m_uptime   = QString("%1d %2h:%3m:%4s")
                .arg(days, 2, 10, QChar('0'))
                .arg(hours,2, 10, QChar('0'))
                .arg(mins,2, 10, QChar('0'))
                .arg(sec,2, 10, QChar('0'));
        m_hostname = QSysInfo::machineHostName();
        emit uptimeChanged();
    }

#endif
}



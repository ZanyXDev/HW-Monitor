#include "monitor.h"

Monitor::Monitor(QObject *parent)
    : QObject(parent)
    , m_uptime(QString(""))
    , m_hostname(QString(""))
    , m_currentProcess(QString(""))
    , m_PCStartSeconds(0)
    , m_totalram(0)
    , m_freeram (0)
    , m_sharedram(0)
    , m_totalswap(0)
    , m_freeswap (0)
    , m_procs (0)
    , m_memoryUsage (0.0)
{
#ifdef Q_OS_ANDROID
    //https://github.com/mzlogin/CleanExpert/blob/master/app/src/main/java/org/mazhuang/cleanexpert/util/MemStat.java
    //https://github.com/jaredrummler/AndroidDeviceNames

#elif defined Q_OS_LINUX
    m_hostname = QSysInfo::machineHostName();
#endif
    updateSystemInfo();
}

const QString &Monitor::getUptime() const
{
    return m_uptime;
}

const QString &Monitor::getHostname() const
{
    return m_hostname;
}
double Monitor::getMemoryUsage() const
{
    return m_memoryUsage;
}

const QString &Monitor::getcurrentProcess() const
{
    return m_currentProcess;
}

// ------------------------------- SLOTS -------------------------------------
void Monitor::updateSystemInfo()
{
#ifdef Q_OS_ANDROID

#elif defined Q_OS_LINUX
    struct sysinfo s_info;

    if ( 0 == sysinfo(&s_info)){

        m_PCStartSeconds = s_info.uptime;
        m_totalram  = s_info.totalram;
        m_freeram   = s_info.freeram;
        m_sharedram = s_info.sharedram;
        m_totalswap = s_info.totalswap;
        m_freeswap  = s_info.freeswap;

        m_procs     = s_info.procs;

        updateUpTime( );
        updateMemory( );
    }

#endif
}

void Monitor::updateUpTime()
{
    int secondsInDay = 60 * 60 * 24;
    int days  = round(   m_PCStartSeconds / (secondsInDay) );
    int hours = round( (m_PCStartSeconds - days * secondsInDay) / ( 60 * 60 ) );
    int mins  = round( (m_PCStartSeconds - days * secondsInDay - hours * 60 * 60 ) / 60);
    int sec   = round(  m_PCStartSeconds - days * secondsInDay - hours * 60 * 60 - mins * 60);

    m_uptime   = tr("%1d %2h:%3m:%4s")
            .arg(days, 2, 10, QChar('0'))
            .arg(hours,2, 10, QChar('0'))
            .arg(mins, 2, 10, QChar('0'))
            .arg(sec,  2, 10, QChar('0'));
    emit uptimeChanged();
}

void Monitor::updateMemory()
{
    // m_memoryUsage= 100 - qRound((qreal)m_freeram / (qreal)m_totalram * 100.0f);
    m_memoryUsage++;
    emit memoryUsageChanged();
}

void Monitor::updateProcess()
{
    m_currentProcess = tr("%1").arg( m_procs );
    emit currentProcessChanged();
}

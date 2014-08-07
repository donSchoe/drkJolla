/*
 * Copyright (C) 2014 Alexander Schoedon <schoedon@uni-potsdam.de>
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include <QStandardPaths>
#include "tickerhandler.h"

namespace {
    static const int     VERSION_MAJOR   = 1;
    static const int     VERSION_MINOR   = 4;
    static const QString VERSION_STRING  = "1";
    static const QString RELEASE_DATE    = "07/August/2014";
}

TickerHandler::TickerHandler(QObject *parent)
  :   QObject(parent)
  ,   m_bitfinex(this)
  ,   m_mintpal(this)
  ,   m_cryptsy(this)
  ,   m_poloniex(this)
  ,   m_settings(QString(QStandardPaths::ConfigLocation), QSettings::NativeFormat, this)
{
    setDefaults();

    if (!isOfflineMode())
        update();
}

void TickerHandler::setDefaults()
{
    if (m_settings.allKeys().contains("update/interval", Qt::CaseInsensitive))
    {
        m_settings.beginGroup("update");
        setUpdateInterval(m_settings.value("interval", 5).toInt());
        m_settings.endGroup();
    }
    else
    {
        setUpdateInterval();
    }

    if (m_settings.allKeys().contains("update/offline", Qt::CaseInsensitive))
    {
        m_settings.beginGroup("update");
        setOfflineMode(m_settings.value("offline", false).toBool());
        m_settings.endGroup();
    }
    else
    {
        setOfflineMode();
    }

    if (m_settings.allKeys().contains("coins/btc", Qt::CaseInsensitive))
    {
        m_settings.beginGroup("coins");
        setBtcEnabled(m_settings.value("btc", true).toBool());
        m_settings.endGroup();
    }
    else
    {
        setBtcEnabled();
    }

    if (m_settings.allKeys().contains("coins/drk", Qt::CaseInsensitive))
    {
        m_settings.beginGroup("coins");
        setDrkEnabled(m_settings.value("drk", true).toBool());
        m_settings.endGroup();
    }
    else
    {
        setDrkEnabled();
    }

    if (m_settings.allKeys().contains("coins/cloak", Qt::CaseInsensitive))
    {
        m_settings.beginGroup("coins");
        setCloakEnabled(m_settings.value("cloak", true).toBool());
        m_settings.endGroup();
    }
    else
    {
        setCloakEnabled();
    }

    if (m_settings.allKeys().contains("coins/xmr", Qt::CaseInsensitive))
    {
        m_settings.beginGroup("coins");
        setXmrEnabled(m_settings.value("xmr", true).toBool());
        m_settings.endGroup();
    }
    else
    {
        setXmrEnabled();
    }

    if (m_settings.allKeys().contains("coins/xc", Qt::CaseInsensitive))
    {
        m_settings.beginGroup("coins");
        setXcEnabled(m_settings.value("xc", true).toBool());
        m_settings.endGroup();
    }
    else
    {
        setXcEnabled();
    }

    if (m_settings.allKeys().contains("coins/cach", Qt::CaseInsensitive))
    {
        m_settings.beginGroup("coins");
        setCachEnabled(m_settings.value("cach", true).toBool());
        m_settings.endGroup();
    }
    else
    {
        setCachEnabled();
    }
}

void TickerHandler::update()
{
    if (!isOfflineMode())
    {
        m_bitfinex.fetch();
        m_mintpal.fetch();
        m_cryptsy.fetch();
        m_poloniex.fetch();
    }
}

void TickerHandler::setUpdateInterval(int interval)
{
    if (interval < 1)
    {
        interval = 1;
    }
    else if (interval > 99)
    {
        interval = 99;
    }
    m_settings.beginGroup("update");
    m_settings.setValue("interval", interval);
    m_settings.endGroup();
    m_settings.sync();
    sync();
    m_settings.beginGroup("update");
    m_settings.endGroup();
    m_updateInterval = interval;
}

void TickerHandler::setOfflineMode(bool enabled)
{
    m_settings.beginGroup("update");
    m_settings.setValue("offline", enabled);
    m_settings.endGroup();
    m_settings.sync();
    sync();
    m_settings.beginGroup("update");
    m_settings.endGroup();
    m_offlineMode = enabled;
}

void TickerHandler::setBtcEnabled(bool enabled)
{
    m_settings.beginGroup("coins");
    m_settings.setValue("btc", enabled);
    m_settings.endGroup();
    m_settings.sync();
    sync();
    m_settings.beginGroup("coins");
    m_settings.endGroup();
    m_btcEnabled = enabled;
}

void TickerHandler::setDrkEnabled(bool enabled)
{
    m_settings.beginGroup("coins");
    m_settings.setValue("drk", enabled);
    m_settings.endGroup();
    m_settings.sync();
    sync();
    m_settings.beginGroup("coins");
    m_settings.endGroup();
    m_drkEnabled = enabled;
}

void TickerHandler::setCloakEnabled(bool enabled)
{
    m_settings.beginGroup("coins");
    m_settings.setValue("cloak", enabled);
    m_settings.endGroup();
    m_settings.sync();
    sync();
    m_settings.beginGroup("coins");
    m_settings.endGroup();
    m_cloakEnabled = enabled;
}

void TickerHandler::setXmrEnabled(bool enabled)
{
    m_settings.beginGroup("coins");
    m_settings.setValue("xmr", enabled);
    m_settings.endGroup();
    m_settings.sync();
    sync();
    m_settings.beginGroup("coins");
    m_settings.endGroup();
    m_xmrEnabled = enabled;
}

void TickerHandler::setXcEnabled(bool enabled)
{
    m_settings.beginGroup("coins");
    m_settings.setValue("xc", enabled);
    m_settings.endGroup();
    m_settings.sync();
    sync();
    m_settings.beginGroup("coins");
    m_settings.endGroup();
    m_xcEnabled = enabled;
}

void TickerHandler::setCachEnabled(bool enabled)
{
    m_settings.beginGroup("coins");
    m_settings.setValue("cach", enabled);
    m_settings.endGroup();
    m_settings.sync();
    sync();
    m_settings.beginGroup("coins");
    m_settings.endGroup();
    m_cachEnabled = enabled;
}

int TickerHandler::updateInterval()
{
    return m_updateInterval;
}

bool TickerHandler::isOfflineMode()
{
    return m_offlineMode;
}

bool TickerHandler::isBtcEnabled()
{
    return m_btcEnabled;
}

bool TickerHandler::isDrkEnabled()
{
    return m_drkEnabled;
}

bool TickerHandler::isCloakEnabled()
{
    return m_cloakEnabled;
}

bool TickerHandler::isXmrEnabled()
{
    return m_xmrEnabled;
}

bool TickerHandler::isXcEnabled()
{
    return m_xcEnabled;
}

bool TickerHandler::isCachEnabled()
{
    return m_cachEnabled;
}

QString TickerHandler::bitfinexBtcUsd()
{
    QString ticker("BTC disabled.");
    if (isBtcEnabled()) {
        if (m_bitfinex.getBtcUsd() > 0.0f)
        {
            ticker = QString("USD ").append(QString::number(m_bitfinex.getBtcUsd(), 'f', 2));
        }
        else
        {
            ticker = QString("USD ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::bitfinexDrkUsd()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_bitfinex.getDrkUsd() > 0.0f)
        {
            ticker = QString("USD ").append(QString::number(m_bitfinex.getDrkUsd(), 'f', 2));
        }
        else
        {
            ticker = QString("USD ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::bitfinexDrkBtc()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_bitfinex.getDrkBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_bitfinex.getDrkBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::mintpalDrkBtc()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_mintpal.getDrkBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_mintpal.getDrkBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::mintpalDrkLtc()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_mintpal.getDrkLtc() > 0.0f)
        {
            ticker = QString("LTC ").append(QString::number(m_mintpal.getDrkLtc(), 'f', 5));
        }
        else
        {
            ticker = QString("LTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::mintpalCloakBtc()
{
    QString ticker("CLOAK disabled.");
    if (isCloakEnabled()) {
        if (m_mintpal.getCloakBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_mintpal.getCloakBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::mintpalXmrBtc()
{
    QString ticker("XMR disabled.");
    if (isXmrEnabled()) {
        if (m_mintpal.getXmrBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_mintpal.getXmrBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::mintpalXcBtc()
{
    QString ticker("XC disabled.");
    if (isXcEnabled()) {
        if (m_mintpal.getXcBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_mintpal.getXcBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyBtcUsd()
{
    QString ticker("BTC disabled.");
    if (isBtcEnabled()) {
        if (m_cryptsy.getBtcUsd() > 0.0f)
        {
            ticker = QString("USD ").append(QString::number(m_cryptsy.getBtcUsd(), 'f', 2));
        }
        else
        {
            ticker = QString("USD ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyDrkUsd()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_cryptsy.getDrkUsd() > 0.0f)
        {
            ticker = QString("USD ").append(QString::number(m_cryptsy.getDrkUsd(), 'f', 3));
        }
        else
        {
            ticker = QString("USD ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyDrkBtc()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_cryptsy.getDrkBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_cryptsy.getDrkBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyDrkLtc()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_cryptsy.getDrkLtc() > 0.0f)
        {
            ticker = QString("LTC ").append(QString::number(m_cryptsy.getDrkLtc(), 'f', 5));
        }
        else
        {
            ticker = QString("LTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyCloakBtc()
{
    QString ticker("CLOAK disabled.");
    if (isCloakEnabled()) {
        if (m_cryptsy.getCloakBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_cryptsy.getCloakBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyCloakLtc()
{
    QString ticker("CLOAK disabled.");
    if (isCloakEnabled()) {
        if (m_cryptsy.getCloakLtc() > 0.0f)
        {
            ticker = QString("LTC ").append(QString::number(m_cryptsy.getCloakLtc(), 'f', 5));
        }
        else
        {
            ticker = QString("LTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyXcBtc()
{
    QString ticker("XC disabled.");
    if (isXcEnabled()) {
        if (m_cryptsy.getXcBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_cryptsy.getXcBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyXcLtc()
{
    QString ticker("XC disabled.");
    if (isXcEnabled()) {
        if (m_cryptsy.getXcLtc() > 0.0f)
        {
            ticker = QString("LTC ").append(QString::number(m_cryptsy.getXcLtc(), 'f', 5));
        }
        else
        {
            ticker = QString("LTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::cryptsyCachBtc()
{
    QString ticker("CACH disabled.");
    if (isCachEnabled()) {
        if (m_cryptsy.getCachBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_cryptsy.getCachBtc(), 'f', 7));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::poloniexDrkBtc()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_poloniex.getDrkBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_poloniex.getDrkBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::poloniexDrkXmr()
{
    QString ticker("DRK disabled.");
    if (isDrkEnabled()) {
        if (m_poloniex.getDrkXmr() > 0.0f)
        {
            ticker = QString("XMR ").append(QString::number(m_poloniex.getDrkXmr(), 'f', 3));
        }
        else
        {
            ticker = QString("XMR ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::poloniexXcBtc()
{
    QString ticker("XC disabled.");
    if (isXcEnabled()) {
        if (m_poloniex.getXcBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_poloniex.getXcBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::poloniexXmrBtc()
{
    QString ticker("XMR disabled.");
    if (isXmrEnabled()) {
        if (m_poloniex.getXmrBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_poloniex.getXmrBtc(), 'f', 5));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::poloniexCachBtc()
{
    QString ticker("CACH disabled.");
    if (isCachEnabled()) {
        if (m_poloniex.getCachBtc() > 0.0f)
        {
            ticker = QString("BTC ").append(QString::number(m_poloniex.getCachBtc(), 'f', 7));
        }
        else
        {
            ticker = QString("BTC ---");
        }
        if (isOfflineMode()) {
            ticker = ticker.append(" (cached)");
        }
    }
    return ticker;
}

QString TickerHandler::version(bool shrt)
{
    if (shrt)
    {
        return QString::number(VERSION_MAJOR).append(".").append(QString::number(VERSION_MINOR));
    }
    else
    {
        return QString::number(VERSION_MAJOR).append(".").append(QString::number(VERSION_MINOR)).append("-").append(VERSION_STRING);
    }
}

QString TickerHandler::versionDate()
{
    return RELEASE_DATE;
}

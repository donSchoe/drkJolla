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

#include "tickerhandler.h"

namespace {
    static const int     VERSION_MAJOR   = 0;
    static const int     VERSION_MINOR   = 4;
    static const QString VERSION_STRING  = "1";
    static const QString RELEASE_DATE    = "02/July/2014";
}

TickerHandler::TickerHandler(QObject *parent)
  :   QObject(parent)
  ,   m_bitfinex(this)
  ,   m_mintpal(this)
{
    update();
}

QString TickerHandler::bitfinexBtcUsd()
{
    if (m_bitfinex.getBtcUsd() > 0.0f)
    {
        return QString("USD ").append(QString::number(m_bitfinex.getBtcUsd(), 'f', 2));
    }
    else
    {
        return QString("USD ---");
    }
}

QString TickerHandler::bitfinexDrkUsd()
{
    if (m_bitfinex.getDrkUsd() > 0.0f)
    {
        return QString("USD ").append(QString::number(m_bitfinex.getDrkUsd(), 'f', 3));
    }
    else
    {
        return QString("USD ---");
    }
}

QString TickerHandler::bitfinexDrkBtc()
{
    if (m_bitfinex.getDrkBtc() > 0.0f)
    {
        return QString("BTC ").append(QString::number(m_bitfinex.getDrkBtc(), 'f', 5));
    }
    else
    {
        return QString("BTC ---");
    }
}

QString TickerHandler::mintpalDrkBtc()
{
    if (m_mintpal.getDrkBtc() > 0.0f)
    {
        return QString("BTC ").append(QString::number(m_mintpal.getDrkBtc(), 'f', 5));
    }
    else
    {
        return QString("BTC ---");
    }
}

QString TickerHandler::cryptsyDrkUsd()
{
    if (m_cryptsy.getDrkUsd() > 0.0f)
    {
        return QString("USD ").append(QString::number(m_cryptsy.getDrkUsd(), 'f', 3));
    }
    else
    {
        return QString("USD ---");
    }
}

QString TickerHandler::cryptsyDrkBtc()
{
    if (m_cryptsy.getDrkBtc() > 0.0f)
    {
        return QString("BTC ").append(QString::number(m_cryptsy.getDrkBtc(), 'f', 5));
    }
    else
    {
        return QString("BTC ---");
    }
}

QString TickerHandler::cryptsyDrkLtc()
{
    if (m_cryptsy.getDrkLtc() > 0.0f)
    {
        return QString("LTC ").append(QString::number(m_cryptsy.getDrkLtc(), 'f', 3));
    }
    else
    {
        return QString("LTC ---");
    }
}

QString TickerHandler::cryptsyCachBtc()
{
    if (m_cryptsy.getCachBtc() > 0.0f)
    {
        return QString("BTC ").append(QString::number(m_cryptsy.getCachBtc(), 'f', 7));
    }
    else
    {
        return QString("BTC ---");
    }
}

QString TickerHandler::poloniexDrkBtc()
{
    if (m_poloniex.getDrkBtc() > 0.0f)
    {
        return QString("BTC ").append(QString::number(m_poloniex.getDrkBtc(), 'f', 5));
    }
    else
    {
        return QString("BTC ---");
    }
}

QString TickerHandler::poloniexCachBtc()
{
    if (m_poloniex.getCachBtc() > 0.0f)
    {
        return QString("BTC ").append(QString::number(m_poloniex.getCachBtc(), 'f', 7));
    }
    else
    {
        return QString("BTC ---");
    }
}

void TickerHandler::update()
{
    m_bitfinex.fetch();
    m_mintpal.fetch();
    m_cryptsy.fetch();
    m_poloniex.fetch();
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

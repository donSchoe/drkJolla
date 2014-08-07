
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

#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QUrl>

#include "poloniex.h"

namespace {
    static const QString TICKER = "https://poloniex.com/public?command=returnTicker";
}

PoloniEx::PoloniEx(QObject *parent)
    :   QObject(parent)
    ,   m_pairDrkBtc(-1.0f)
    ,   m_pairDrkXmr(-1.0f)
    ,   m_pairXcBtc(-1.0f)
    ,   m_pairXmrBtc(-1.0f)
    ,   m_pairCachBtc(-1.0f)
    ,   m_tickerManager(this)
{
    connect(&m_tickerManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onTickerResult(QNetworkReply*)));
    fetch();
}

PoloniEx::~PoloniEx()
{
}

double PoloniEx::getDrkBtc()
{
    return m_pairDrkBtc;
}

double PoloniEx::getDrkXmr()
{
    return m_pairDrkXmr;
}

double PoloniEx::getXcBtc()
{
    return m_pairXcBtc;
}

double PoloniEx::getXmrBtc()
{
    return m_pairXmrBtc;
}

double PoloniEx::getCachBtc()
{
    return m_pairCachBtc;
}

void PoloniEx::fetch()
{
    QNetworkRequest request;
    request.setUrl(QUrl(TICKER));
    m_tickerManager.get(request);
}

void PoloniEx::onTickerResult(QNetworkReply* reply)
{
    if (reply->error() != QNetworkReply::NoError)
    {
        m_pairDrkBtc = 0.0f;
        m_pairDrkXmr = 0.0f;
        m_pairXcBtc = 0.0f;
        m_pairXmrBtc = 0.0f;
        m_pairCachBtc = 0.0f;
    }
    else
    {
        QString data = QString(reply->readAll());
        QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());
        QJsonObject jsonObject = jsonResponse.object();

        QJsonObject jsonDrkBtcObject = jsonObject["BTC_DRK"].toObject();
        double tmpDrkBtc = QString(jsonDrkBtcObject["highestBid"].toString()).remove('"').toDouble();
        QJsonObject jsonDrkXmrObject = jsonObject["XMR_DRK"].toObject();
        double tmpDrkXmr = QString(jsonDrkXmrObject["highestBid"].toString()).remove('"').toDouble();
        QJsonObject jsonXcBtcObject = jsonObject["BTC_XC"].toObject();
        double tmpXcBtc = QString(jsonXcBtcObject["highestBid"].toString()).remove('"').toDouble();
        QJsonObject jsonXmrBtcObject = jsonObject["BTC_XMR"].toObject();
        double tmpXmrBtc = QString(jsonXmrBtcObject["highestBid"].toString()).remove('"').toDouble();
        QJsonObject jsonCachBtcObject = jsonObject["BTC_CACH"].toObject();
        double tmpCachBtc = QString(jsonCachBtcObject["highestBid"].toString()).remove('"').toDouble();

        if (tmpDrkBtc > 0.0f)
        {
            m_pairDrkBtc = tmpDrkBtc;
        }
        else
        {
            m_pairDrkBtc = 0.0f;
        }

        if (tmpDrkXmr > 0.0f)
        {
            m_pairDrkXmr = tmpDrkXmr;
        }
        else
        {
            m_pairDrkXmr = 0.0f;
        }

        if (tmpXcBtc > 0.0f)
        {
            m_pairXcBtc = tmpXcBtc;
        }
        else
        {
            m_pairXcBtc = 0.0f;
        }

        if (tmpXmrBtc > 0.0f)
        {
            m_pairXmrBtc = tmpXmrBtc;
        }
        else
        {
            m_pairXmrBtc = 0.0f;
        }

        if (tmpCachBtc > 0.0f)
        {
            m_pairCachBtc = tmpCachBtc;
        }
        else
        {
            m_pairCachBtc = 0.0f;
        }
    }
}

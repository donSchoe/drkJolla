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

#include "bitfinex.h"

namespace {
    static const QString BTC_DRK = "https://api.bitfinex.com/v1/pubticker/btcusd";
    static const QString DRK_USD = "https://api.bitfinex.com/v1/pubticker/drkusd";
    static const QString DRK_BTC = "https://api.bitfinex.com/v1/pubticker/drkbtc";
}

BitFinex::BitFinex(QObject *parent)
    :   QObject(parent)
    ,   m_pairBtcUsd(-1.0f)
    ,   m_pairDrkUsd(-1.0f)
    ,   m_pairDrkBtc(-1.0f)
    ,   m_btcUsdManager(this)
    ,   m_drkUsdManager(this)
    ,   m_drkBtcManager(this)
{
    connect(&m_btcUsdManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onBtcUsdResult(QNetworkReply*)));
    connect(&m_drkUsdManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkUsdResult(QNetworkReply*)));
    connect(&m_drkBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkBtcResult(QNetworkReply*)));
    fetch();
}

BitFinex::~BitFinex() { }


double BitFinex::getBtcUsd()
{
    return m_pairBtcUsd;
}

double BitFinex::getDrkUsd()
{
    return m_pairDrkUsd;
}

double BitFinex::getDrkBtc()
{
    return m_pairDrkBtc;
}

void BitFinex::fetch()
{
    QNetworkRequest request;
    request.setUrl(QUrl(BTC_DRK));
    QNetworkReply* replyBtcUsd = m_btcUsdManager.get(request);
    request.setUrl(QUrl(DRK_USD));
    QNetworkReply* replyDrkUsd = m_drkUsdManager.get(request);
    request.setUrl(QUrl(DRK_BTC));
    QNetworkReply* replyDrkBtc = m_drkBtcManager.get(request);
}


void BitFinex::onBtcUsdResult(QNetworkReply* reply)
{
    m_pairBtcUsd = updatePair(reply);
}


void BitFinex::onDrkUsdResult(QNetworkReply* reply)
{
    m_pairDrkUsd = updatePair(reply);
}


void BitFinex::onDrkBtcResult(QNetworkReply* reply)
{
    m_pairDrkBtc = updatePair(reply);
}

double BitFinex::updatePair(QNetworkReply* reply)
{
    double pair = -1.0f;
    if (reply->error() != QNetworkReply::NoError)
    {
        pair = 0.0f;
    }
    else
    {
        QString data = QString(reply->readAll());
        QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());
        QJsonObject jsonObject = jsonResponse.object();
        double tmp = QString(jsonObject["bid"].toString()).remove('"').toDouble();
        if (tmp > 0.0f)
        {
            pair = tmp;
        }
        else
        {
            pair = 0.0f;
        }
    }
    return pair;
}

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

#include <QStringList>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QUrl>

#include "cryptsy.h"

namespace {
    static const QString BTC_USD = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=2";
    static const QString DRK_USD = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=213";
    static const QString DRK_BTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=155";
    static const QString DRK_LTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=214";
    static const QString ANC_BTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=66";
    static const QString ANC_LTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=121";
    static const QString BTCD_BTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=256";
    static const QString CLOAK_BTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=227";
    static const QString CLOAK_LTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=228";
    static const QString XC_BTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=210";
    static const QString XC_LTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=216";
    static const QString CACH_BTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=154";
}

Cryptsy::Cryptsy(QObject *parent)
    :   QObject(parent)
    ,   m_pairBtcUsd(-1.0f)
    ,   m_pairDrkUsd(-1.0f)
    ,   m_pairDrkBtc(-1.0f)
    ,   m_pairDrkLtc(-1.0f)
    ,   m_pairAncBtc(-1.0f)
    ,   m_pairAncLtc(-1.0f)
    ,   m_pairBtcdBtc(-1.0f)
    ,   m_pairCloakBtc(-1.0f)
    ,   m_pairCloakLtc(-1.0f)
    ,   m_pairXcBtc(-1.0f)
    ,   m_pairXcLtc(-1.0f)
    ,   m_pairCachBtc(-1.0f)
    ,   m_btcUsdManager(this)
    ,   m_drkUsdManager(this)
    ,   m_drkBtcManager(this)
    ,   m_drkLtcManager(this)
    ,   m_ancBtcManager(this)
    ,   m_ancLtcManager(this)
    ,   m_btcdBtcManager(this)
    ,   m_cloakBtcManager(this)
    ,   m_cloakLtcManager(this)
    ,   m_xcBtcManager(this)
    ,   m_xcLtcManager(this)
    ,   m_cachBtcManager(this)
{
    connect(&m_btcUsdManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onBtcUsdResult(QNetworkReply*)));
    connect(&m_drkUsdManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkUsdResult(QNetworkReply*)));
    connect(&m_drkBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkBtcResult(QNetworkReply*)));
    connect(&m_drkLtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkLtcResult(QNetworkReply*)));
    connect(&m_ancBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onAncBtcResult(QNetworkReply*)));
    connect(&m_ancLtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onAncLtcResult(QNetworkReply*)));
    connect(&m_btcdBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onBtcdBtcResult(QNetworkReply*)));
    connect(&m_cloakBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onCloakBtcResult(QNetworkReply*)));
    connect(&m_cloakLtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onCloakLtcResult(QNetworkReply*)));
    connect(&m_xcBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onXcBtcResult(QNetworkReply*)));
    connect(&m_xcLtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onXcLtcResult(QNetworkReply*)));
    connect(&m_cachBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onCachBtcResult(QNetworkReply*)));

    fetch();
}

Cryptsy::~Cryptsy()
{
}

double Cryptsy::getBtcUsd()
{
    return m_pairBtcUsd;
}

double Cryptsy::getDrkUsd()
{
    return m_pairDrkUsd;
}

double Cryptsy::getDrkBtc()
{
    return m_pairDrkBtc;
}

double Cryptsy::getDrkLtc()
{
    return m_pairDrkLtc;
}

double Cryptsy::getAncBtc()
{
    return m_pairAncBtc;
}

double Cryptsy::getAncLtc()
{
    return m_pairAncLtc;
}

double Cryptsy::getBtcdBtc()
{
    return m_pairBtcdBtc;
}

double Cryptsy::getCloakBtc()
{
    return m_pairCloakBtc;
}

double Cryptsy::getCloakLtc()
{
    return m_pairCloakLtc;
}

double Cryptsy::getXcBtc()
{
    return m_pairXcBtc;
}

double Cryptsy::getXcLtc()
{
    return m_pairXcLtc;
}

double Cryptsy::getCachBtc()
{
    return m_pairCachBtc;
}

void Cryptsy::fetch()
{
    QNetworkRequest request;
    request.setUrl(QUrl(BTC_USD));
    m_btcUsdManager.get(request);
    request.setUrl(QUrl(DRK_USD));
    m_drkUsdManager.get(request);
    request.setUrl(QUrl(DRK_BTC));
    m_drkBtcManager.get(request);
    request.setUrl(QUrl(DRK_LTC));
    m_drkLtcManager.get(request);
    request.setUrl(QUrl(ANC_BTC));
    m_ancBtcManager.get(request);
    request.setUrl(QUrl(ANC_LTC));
    m_ancLtcManager.get(request);
    request.setUrl(QUrl(BTCD_BTC));
    m_btcdBtcManager.get(request);
    request.setUrl(QUrl(CLOAK_BTC));
    m_cloakBtcManager.get(request);
    request.setUrl(QUrl(CLOAK_LTC));
    m_cloakLtcManager.get(request);
    request.setUrl(QUrl(XC_BTC));
    m_xcBtcManager.get(request);
    request.setUrl(QUrl(XC_LTC));
    m_xcLtcManager.get(request);
    request.setUrl(QUrl(CACH_BTC));
    m_cachBtcManager.get(request);
}

void Cryptsy::onBtcUsdResult(QNetworkReply* reply)
{
    m_pairBtcUsd = updatePair(reply);
}

void Cryptsy::onDrkUsdResult(QNetworkReply* reply)
{
    m_pairDrkUsd = updatePair(reply);
}

void Cryptsy::onDrkBtcResult(QNetworkReply* reply)
{
    m_pairDrkBtc = updatePair(reply);
}

void Cryptsy::onDrkLtcResult(QNetworkReply* reply)
{
    m_pairDrkLtc = updatePair(reply);
}

void Cryptsy::onAncBtcResult(QNetworkReply* reply)
{
    m_pairAncBtc = updatePair(reply);
}

void Cryptsy::onAncLtcResult(QNetworkReply* reply)
{
    m_pairAncLtc = updatePair(reply);
}

void Cryptsy::onBtcdBtcResult(QNetworkReply* reply)
{
    m_pairBtcdBtc = updatePair(reply);
}

void Cryptsy::onCloakBtcResult(QNetworkReply* reply)
{
    m_pairCloakBtc = updatePair(reply);
}

void Cryptsy::onCloakLtcResult(QNetworkReply* reply)
{
    m_pairCloakLtc = updatePair(reply);
}

void Cryptsy::onXcBtcResult(QNetworkReply* reply)
{
    m_pairXcBtc = updatePair(reply);
}

void Cryptsy::onXcLtcResult(QNetworkReply* reply)
{
    m_pairXcLtc = updatePair(reply);
}

void Cryptsy::onCachBtcResult(QNetworkReply* reply)
{
    m_pairCachBtc = updatePair(reply);
}

double Cryptsy::updatePair(QNetworkReply* reply)
{
    double pair = -1.0f;
    if (reply->error() != QNetworkReply::NoError)
    {
        pair = 0.0f;
    }
    else
    {
        QString data = QString(reply->readAll());

        // @TODO cryptsy json seems to be invalid, this was my best try:
        QStringList dataList = data.split("\["); // buyorders
        dataList = dataList.last().split("\]"); // trim invalid json
        dataList = dataList.first().split("\,"); // highest bid
        dataList = dataList.first().split("\:"); // value only

        double tmp = dataList.last().remove('"').toDouble();

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


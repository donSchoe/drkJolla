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

#include "mintpal.h"

namespace {
    static const QString DRK_BTC = "https://api.mintpal.com/v2/market/stats/DRK/BTC";
    static const QString DRK_LTC = "https://api.mintpal.com/v2/market/stats/DRK/LTC";
    static const QString CLOAK_BTC = "https://api.mintpal.com/v2/market/stats/CLOAK/BTC";
    static const QString XMR_BTC = "https://api.mintpal.com/v2/market/stats/XMR/BTC";
    static const QString XC_BTC = "https://api.mintpal.com/v2/market/stats/XC/BTC";
}

MintPal::MintPal(QObject *parent)
    :   QObject(parent)
    ,   m_pairDrkBtc(-1.0f)
    ,   m_pairDrkLtc(-1.0f)
    ,   m_pairCloakBtc(-1.0f)
    ,   m_pairXmrBtc(-1.0f)
    ,   m_pairXcBtc(-1.0f)
    ,   m_drkBtcManager(this)
    ,   m_drkLtcManager(this)
    ,   m_cloakBtcManager(this)
    ,   m_xmrBtcManager(this)
    ,   m_xcBtcManager(this)
{
    connect(&m_drkBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkBtcResult(QNetworkReply*)));
    connect(&m_drkLtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkLtcResult(QNetworkReply*)));
    connect(&m_cloakBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onCloakBtcResult(QNetworkReply*)));
    connect(&m_xmrBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onXmrBtcResult(QNetworkReply*)));
    connect(&m_xcBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onXcBtcResult(QNetworkReply*)));
    fetch();
}

MintPal::~MintPal()
{
}

double MintPal::getDrkBtc()
{
    return m_pairDrkBtc;
}

double MintPal::getDrkLtc()
{
    return m_pairDrkLtc;
}

double MintPal::getCloakBtc()
{
    return m_pairCloakBtc;
}

double MintPal::getXmrBtc()
{
    return m_pairXmrBtc;
}

double MintPal::getXcBtc()
{
    return m_pairXcBtc;
}

void MintPal::fetch()
{
    QNetworkRequest request;
    request.setUrl(QUrl(DRK_BTC));
    m_drkBtcManager.get(request);
    request.setUrl(QUrl(DRK_LTC));
    m_drkLtcManager.get(request);
    request.setUrl(QUrl(CLOAK_BTC));
    m_cloakBtcManager.get(request);
    request.setUrl(QUrl(XMR_BTC));
    m_xmrBtcManager.get(request);
    request.setUrl(QUrl(XC_BTC));
    m_xcBtcManager.get(request);
}

void MintPal::onDrkBtcResult(QNetworkReply* reply)
{
    m_pairDrkBtc = updatePair(reply);
}

void MintPal::onDrkLtcResult(QNetworkReply* reply)
{
    m_pairDrkLtc = updatePair(reply);
}

void MintPal::onCloakBtcResult(QNetworkReply* reply)
{
    m_pairCloakBtc = updatePair(reply);
}

void MintPal::onXmrBtcResult(QNetworkReply* reply)
{
    m_pairXmrBtc = updatePair(reply);
}

void MintPal::onXcBtcResult(QNetworkReply* reply)
{
    m_pairXcBtc = updatePair(reply);
}

double MintPal::updatePair(QNetworkReply* reply)
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
        if (jsonObject["status"].toString() == "success")
        {
            jsonObject = jsonObject["data"].toObject();
            double tmp = QString(jsonObject["top_bid"].toString()).remove('"').toDouble();
            if (tmp > 0.0f)
            {
                pair = tmp;
            }
            else
            {
                pair = 0.0f;
            }
        }
        else
        {
            pair = 0.0f;
        }
    }
    return pair;
}


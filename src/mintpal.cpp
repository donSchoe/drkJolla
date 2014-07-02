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
}

MintPal::MintPal(QObject *parent)
    :   QObject(parent)
    ,   m_pairDrkBtc(-1.0f)
    ,   m_drkBtcManager(this)
{
    connect(&m_drkBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkBtcResult(QNetworkReply*)));
    fetch();
}

MintPal::~MintPal() { }

double MintPal::getDrkBtc()
{
    return m_pairDrkBtc;
}

void MintPal::fetch()
{
    QNetworkRequest request;
    request.setUrl(QUrl(DRK_BTC));
    QNetworkReply* replyDrkBtc = m_drkBtcManager.get(request);
}

void MintPal::onDrkBtcResult(QNetworkReply* reply)
{
    m_pairDrkBtc = updatePair(reply);
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


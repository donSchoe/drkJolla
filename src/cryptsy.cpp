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

#include <QDebug>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonValue>
#include <QUrl>

#include "cryptsy.h"

namespace {
    static const QString DRK_USD = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=213";
    static const QString DRK_BTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=155";
    static const QString DRK_LTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=214";
    static const QString CACH_BTC = "http://pubapi.cryptsy.com/api.php?method=singleorderdata&marketid=154";
}

Cryptsy::Cryptsy(QObject *parent)
    :   QObject(parent)
    ,   m_pairDrkUsd(-1.0f)
    ,   m_pairDrkBtc(-1.0f)
    ,   m_pairDrkLtc(-1.0f)
    ,   m_pairCachBtc(-1.0f)
    ,   m_drkUsdManager(this)
    ,   m_drkBtcManager(this)
    ,   m_drkLtcManager(this)
    ,   m_cachBtcManager(this)
{
    connect(&m_drkUsdManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkUsdResult(QNetworkReply*)));
    connect(&m_drkBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkBtcResult(QNetworkReply*)));
    connect(&m_drkLtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onDrkLtcResult(QNetworkReply*)));
    connect(&m_cachBtcManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onCachBtcResult(QNetworkReply*)));

    fetch();
}

Cryptsy::~Cryptsy() { }

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

double Cryptsy::getCachBtc()
{
    return m_pairCachBtc;
}

void Cryptsy::fetch()
{
    QNetworkRequest request;
    request.setUrl(QUrl(DRK_USD));
    QNetworkReply* replyDrkUsd = m_drkUsdManager.get(request);
    request.setUrl(QUrl(DRK_BTC));
    QNetworkReply* replyDrkBtc = m_drkBtcManager.get(request);
    request.setUrl(QUrl(DRK_LTC));
    QNetworkReply* replyDrkLtc = m_drkLtcManager.get(request);
    request.setUrl(QUrl(CACH_BTC));
    QNetworkReply* replyCachBtc = m_cachBtcManager.get(request);
}

void Cryptsy::onDrkUsdResult(QNetworkReply* reply)
{
    m_pairDrkUsd = updatePair(reply, QString("DRK"));
}

void Cryptsy::onDrkBtcResult(QNetworkReply* reply)
{
    m_pairDrkBtc = updatePair(reply, QString("DRK"));
}

void Cryptsy::onDrkLtcResult(QNetworkReply* reply)
{
    m_pairDrkLtc = updatePair(reply, QString("DRK"));
}

void Cryptsy::onCachBtcResult(QNetworkReply* reply)
{
    m_pairCachBtc = updatePair(reply, QString("CACH"));
}

double Cryptsy::updatePair(QNetworkReply* reply, QString market)
{
    double pair = -1.0f;

//    // @TODO this does totally not work
//    if (reply->error() != QNetworkReply::NoError)
//    {
//        pair = 0.0f;
//    }
//    else
//    {
//        QString data = QString(reply->readAll());
//        //qDebug() << "data" << data;
//        QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());
//        //qDebug() << "raw" << jsonResponse.toVariant();//.toJsonArray();
//        QJsonObject jsonObject = jsonResponse.object();
//        //qDebug() << "crypt" << jsonObject["success"].toString();
//        //qDebug() << "success" << jsonObject["success"].toString();
//        if (jsonObject["success"] != 1)
//        {
//            pair = 0.0f;
//        }
//        else
//        {
//            //qDebug() << "return" << jsonObject["return"].toString();
//            jsonObject = jsonObject["return"].toObject();
//            //qDebug() << market << jsonObject[market].toString();
//            jsonObject = jsonObject[market].toObject();
//            //qDebug() << "buyorders" << jsonObject["buyorders"].toString();
//            jsonObject = jsonObject["buyorders"].toObject();
//            //qDebug() << "0" << jsonObject[0].toString();
//            jsonObject = jsonObject[0].toObject();
//            double tmp = QString(jsonObject["price"].toString()).remove('"').toDouble();
//            //qDebug() << "price" << QString::number(tmp);
//            if (tmp > 0.0f)
//            {
//                pair = tmp;
//            }
//            else
//            {
//                pair = 0.0f;
//            }
//        }
//    }

    qDebug() << "Cryptsy disabled!!!";
    return pair;
}


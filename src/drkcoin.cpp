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

#include "drkcoin.h"


namespace {
    static const int     VERSION_MAJOR   = 0;
    static const int     VERSION_MINOR   = 2;
    static const QString VERSION_STRING  = "1";
    static const QString RELEASE_DATE    = "26/June/2014";
    static const QString BITFINEX_TICKER = "https://api.bitfinex.com/v1/pubticker/drkusd";
    static const QString MINTPAL_TICKER = "https://api.mintpal.com/v2/market/stats/DRK/BTC";
    static const QString BITFINEXBTC_TICKER = "https://api.bitfinex.com/v1/pubticker/btcusd";
}


DRKCoin::DRKCoin(QObject *parent) :
    QObject(parent)
{
    m_bitfinexUSD = 0.0f;
    m_mintpalBTC = 0.0f;
    m_bitfinexBTC = 0.0f;

    connect(&m_bitfinexManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onBitfinexResult(QNetworkReply*)));
    connect(&m_mintpalManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onMintpalResult(QNetworkReply*)));
    connect(&m_bitfinexBTCManager, SIGNAL(finished(QNetworkReply*)), this, SLOT(onBitfinexBTCResult(QNetworkReply*)));

    update();
}

QString DRKCoin::bitfinexUSD()
{
    if (m_bitfinexUSD > 0.0f)
    {
        return QString("USD ").append(QString::number(m_bitfinexUSD, 'f', 3));
    }
    else
    {
        return QString("USD ---");
    }
}

QString DRKCoin::mintpalBTC()
{
    if (m_mintpalBTC > 0.0f)
    {
        return QString("BTC ").append(QString::number(m_mintpalBTC, 'f', 5));
    }
    else
    {
        return QString("BTC ---");
    }
}

QString DRKCoin::bitfinexBTC()
{
    if (m_bitfinexBTC > 0.0f)
    {
        return QString("USD ").append(QString::number(m_bitfinexBTC, 'f', 2));
    }
    else
    {
        return QString("USD ---");
    }
}

void DRKCoin::update()
{
    fetchTickers();
}

QString DRKCoin::version(bool shrt)
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

QString DRKCoin::versionDate()
{
    return RELEASE_DATE;
}

void DRKCoin::fetchTickers()
{
    QNetworkRequest request;
    request.setUrl(QUrl(BITFINEX_TICKER));
    QNetworkReply* bitfinexReply = m_bitfinexManager.get(request);
    request.setUrl(QUrl(MINTPAL_TICKER));
    QNetworkReply* mintpalReply = m_mintpalManager.get(request);
    request.setUrl(QUrl(BITFINEXBTC_TICKER));
    QNetworkReply* bitfinexBTCReply = m_bitfinexBTCManager.get(request);
}

void DRKCoin::onBitfinexResult(QNetworkReply *reply)
{
    if (reply->error() != QNetworkReply::NoError)
    {
        m_bitfinexUSD = 0.0f;
    }
    else
    {
        QString data = QString(reply->readAll());
        QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());
        QJsonObject jsonObject = jsonResponse.object();
        double tmp = QString(jsonObject["bid"].toString()).remove('"').toDouble();
        if (tmp > 0.0f)
        {
            m_bitfinexUSD = tmp;
        }
        else
        {
            m_bitfinexUSD = 0.0f;
        }
    }
    qDebug() << "Bitfinex" << m_bitfinexUSD;
}

void DRKCoin::onMintpalResult(QNetworkReply *reply)
{
    if (reply->error() != QNetworkReply::NoError)
    {
        m_mintpalBTC = 0.0f;
    }
    else
    {
        QString data = QString(reply->readAll());
        QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());
        QJsonObject jsonObject = jsonResponse.object();
        if (jsonObject["status"].toString() != "success")
        {
            m_mintpalBTC = 0.0f;
        }
        else
        {
            jsonObject = jsonObject["data"].toObject();
            double tmp = QString(jsonObject["top_bid"].toString()).remove('"').toDouble();
            if (tmp > 0.0f)
            {
                m_mintpalBTC = tmp;
            }
            else
            {
                m_mintpalBTC = 0.0f;
            }
        }
    }
    qDebug() << "Mintpal" << m_mintpalBTC;
}

void DRKCoin::onBitfinexBTCResult(QNetworkReply *reply)
{
    if (reply->error() != QNetworkReply::NoError)
    {
        m_bitfinexBTC = 0.0f;
    }
    else
    {
        QString data = QString(reply->readAll());
        QJsonDocument jsonResponse = QJsonDocument::fromJson(data.toUtf8());
        QJsonObject jsonObject = jsonResponse.object();
        double tmp = QString(jsonObject["bid"].toString()).remove('"').toDouble();
        if (tmp > 0.0f)
        {
            m_bitfinexBTC = tmp;
        }
        else
        {
            m_bitfinexBTC = 0.0f;
        }
    }
    qDebug() << "Bitfinex" << m_bitfinexBTC;
}

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

#include <QObject>
#include <QNetworkAccessManager>

class DRKCoin : public QObject
{
    Q_OBJECT

public:
    explicit DRKCoin(QObject *parent = 0);

public slots:
    void update();

    QString bitfinexUSD();
    QString mintpalBTC();
    QString bitfinexBTC();

    QString version(bool shrt = false);
    QString versionDate();

protected:
    void fetchTickers();

protected slots:
    void onBitfinexResult(QNetworkReply* reply);
    void onMintpalResult(QNetworkReply* reply);
    void onBitfinexBTCResult(QNetworkReply* reply);

private:
    double m_bitfinexUSD;
    double m_mintpalBTC;
    double m_bitfinexBTC;

    QNetworkAccessManager m_bitfinexManager;
    QNetworkAccessManager m_mintpalManager;
    QNetworkAccessManager m_bitfinexBTCManager;

};

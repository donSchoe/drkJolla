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

class BitFinex : public QObject
{
    Q_OBJECT

public:
    explicit BitFinex(QObject *parent = 0);
    ~BitFinex();

    double getBtcUsd();
    double getDrkUsd();
    double getDrkBtc();

    void fetch();

public slots:
    void onBtcUsdResult(QNetworkReply* reply);
    void onDrkUsdResult(QNetworkReply* reply);
    void onDrkBtcResult(QNetworkReply* reply);

protected:
    double updatePair(QNetworkReply* reply);

private:
    double m_pairBtcUsd;
    double m_pairDrkUsd;
    double m_pairDrkBtc;

    QNetworkAccessManager m_btcUsdManager;
    QNetworkAccessManager m_drkUsdManager;
    QNetworkAccessManager m_drkBtcManager;

};

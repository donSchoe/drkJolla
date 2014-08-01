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

class Cryptsy : public QObject
{
    Q_OBJECT

public:
    explicit Cryptsy(QObject *parent = 0);
    ~Cryptsy();

    double getBtcUsd();
    double getDrkUsd();
    double getDrkBtc();
    double getDrkLtc();
    double getCloakBtc();
    double getCloakLtc();
    double getXcBtc();
    double getXcLtc();
    double getCachBtc();

    void fetch();

public slots:
    void onBtcUsdResult(QNetworkReply* reply);
    void onDrkUsdResult(QNetworkReply* reply);
    void onDrkBtcResult(QNetworkReply* reply);
    void onDrkLtcResult(QNetworkReply* reply);
    void onCloakBtcResult(QNetworkReply* reply);
    void onCloakLtcResult(QNetworkReply* reply);
    void onXcBtcResult(QNetworkReply* reply);
    void onXcLtcResult(QNetworkReply* reply);
    void onCachBtcResult(QNetworkReply* reply);

protected:
    double updatePair(QNetworkReply* reply);

private:
    double m_pairBtcUsd;
    double m_pairDrkUsd;
    double m_pairDrkBtc;
    double m_pairDrkLtc;
    double m_pairCloakBtc;
    double m_pairCloakLtc;
    double m_pairXcBtc;
    double m_pairXcLtc;
    double m_pairCachBtc;

    QNetworkAccessManager m_btcUsdManager;
    QNetworkAccessManager m_drkUsdManager;
    QNetworkAccessManager m_drkBtcManager;
    QNetworkAccessManager m_drkLtcManager;
    QNetworkAccessManager m_cloakBtcManager;
    QNetworkAccessManager m_cloakLtcManager;
    QNetworkAccessManager m_xcBtcManager;
    QNetworkAccessManager m_xcLtcManager;
    QNetworkAccessManager m_cachBtcManager;

};

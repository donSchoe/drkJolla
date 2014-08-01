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

class MintPal : public QObject
{
    Q_OBJECT

public:
    explicit MintPal(QObject *parent = 0);
    ~MintPal();

    double getDrkBtc();
    double getDrkLtc();
    double getCloakBtc();
    double getXmrBtc();
    double getXcBtc();
    void fetch();

public slots:
    void onDrkBtcResult(QNetworkReply* reply);
    void onDrkLtcResult(QNetworkReply* reply);
    void onCloakBtcResult(QNetworkReply* reply);
    void onXmrBtcResult(QNetworkReply* reply);
    void onXcBtcResult(QNetworkReply* reply);

protected:
    double updatePair(QNetworkReply* reply);

private:
    double m_pairDrkBtc;
    double m_pairDrkLtc;
    double m_pairCloakBtc;
    double m_pairXmrBtc;
    double m_pairXcBtc;

    QNetworkAccessManager m_drkBtcManager;
    QNetworkAccessManager m_drkLtcManager;
    QNetworkAccessManager m_cloakBtcManager;
    QNetworkAccessManager m_xmrBtcManager;
    QNetworkAccessManager m_xcBtcManager;

};

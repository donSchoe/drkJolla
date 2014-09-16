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
#include <QSettings>

#include "bitfinex.h"
#include "mintpal.h"
#include "cryptsy.h"
#include "poloniex.h"

class TickerHandler : public QObject
{
    Q_OBJECT

public:
    explicit TickerHandler(QObject *parent = 0);
    ~TickerHandler();

public slots:
    void setDefaults();
    void update(bool forced = false);

    void setUpdateInterval(int interval = 5);
    void setOfflineMode(bool enabled = false);
    void setBtcEnabled(bool enabled = false);
    void setDrkEnabled(bool enabled = true);
    void setAncEnabled(bool enabled = true);
    void setBtcdEnabled(bool enabled = true);
    void setCloakEnabled(bool enabled = false);
    void setXmrEnabled(bool enabled = true);
    void setXcEnabled(bool enabled = true);
    void setCachEnabled(bool enabled = false);

    int updateInterval();
    bool isOfflineMode();
    bool isBtcEnabled();
    bool isDrkEnabled();
    bool isAncEnabled();
    bool isBtcdEnabled();
    bool isCloakEnabled();
    bool isXmrEnabled();
    bool isXcEnabled();
    bool isCachEnabled();

    QString bitfinexBtcUsd();
    QString bitfinexDrkUsd();
    QString bitfinexDrkBtc();
    QString mintpalDrkBtc();
    QString mintpalDrkLtc();
    QString mintpalCloakBtc();
    QString mintpalXmrBtc();
    QString mintpalXcBtc();
    QString cryptsyBtcUsd();
    QString cryptsyDrkUsd();
    QString cryptsyDrkBtc();
    QString cryptsyDrkLtc();
    QString cryptsyAncBtc();
    QString cryptsyAncLtc();
    QString cryptsyBtcdBtc();
    QString cryptsyCloakBtc();
    QString cryptsyCloakLtc();
    QString cryptsyXcBtc();
    QString cryptsyXcLtc();
    QString cryptsyCachBtc();
    QString poloniexBtcUsd();
    QString poloniexXmrUsd();
    QString poloniexDrkBtc();
    QString poloniexDrkXmr();
    QString poloniexBtcdBtc();
    QString poloniexBtcdXmr();
    QString poloniexXcBtc();
    QString poloniexXmrBtc();
    QString poloniexCachBtc();

    QString version(bool shrt = false);
    QString versionDate();

private:
    int m_updateInterval;
    uint m_updated;
    bool m_offlineMode;
    bool m_btcEnabled;
    bool m_drkEnabled;
    bool m_ancEnabled;
    bool m_btcdEnabled;
    bool m_cloakEnabled;
    bool m_xmrEnabled;
    bool m_xcEnabled;
    bool m_cachEnabled;

    BitFinex m_bitfinex;
    MintPal m_mintpal;
    Cryptsy m_cryptsy;
    PoloniEx m_poloniex;

    QSettings m_settings;
};

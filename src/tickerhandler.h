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

#include "bitfinex.h"
#include "mintpal.h"
#include "cryptsy.h"
#include "poloniex.h"

class TickerHandler : public QObject
{
    Q_OBJECT

public:
    explicit TickerHandler(QObject *parent = 0);

public slots:
    void update();

    QString bitfinexBtcUsd();
    QString bitfinexDrkUsd();
    QString bitfinexDrkBtc();
    QString mintpalDrkBtc();
    QString cryptsyDrkUsd();
    QString cryptsyDrkBtc();
    QString cryptsyDrkLtc();
    QString cryptsyCachBtc();
    QString poloniexDrkBtc();
    QString poloniexCachBtc();

    QString version(bool shrt = false);
    QString versionDate();

private:
    BitFinex m_bitfinex;
    MintPal m_mintpal;
    Cryptsy m_cryptsy;
    PoloniEx m_poloniex;
};

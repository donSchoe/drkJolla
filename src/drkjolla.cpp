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

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include "sailfishapp.h"
#include "drkcoin.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<DRKCoin>("harbour.currencies.DRKCoin", 0, 2, "DRKCoin");

    return SailfishApp::main(argc, argv);
}

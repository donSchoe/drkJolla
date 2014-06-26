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

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: coverPage
    property int coverCycle: 0
    property int coverUpdate: 5
    function refresh() {
        coverBitfinexPrice.text = drkApp.drkCoin.bitfinexUSD()
        coverMintpalPrice.text = drkApp.drkCoin.mintpalBTC()
        if (coverCycle > (60 * coverUpdate)) {
            drkApp.drkCoin.update()
            coverCycle = 0
        }
        else {
            coverCycle = coverCycle + 1
        }
    }
    Timer {
        id: coverTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: coverPage.refresh()
    }
    Column {
        id: coverColumn
        anchors.centerIn: parent
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        width: parent.width - 2 * Theme.paddingLarge
        spacing: Theme.paddingMedium
        Label {
            id: coverHeading
            text: qsTr("Darkcoin")
            width: parent.width
            color: Theme.secondaryHighlightColor
            horizontalAlignment: Text.AlignRight
            font.pixelSize: Theme.fontSizeLarge
        }
        Label {
            id: coverBitfinex
            text: qsTr("Bitfinex")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverBitfinexPrice
            text: qsTr(drkApp.drkCoin.bitfinexUSD())
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeMedium
        }
        Label {
            id: coverMintpal
            text: qsTr("Mintpal")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverMintpalPrice
            text: qsTr(drkApp.drkCoin.mintpalBTC())
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeMedium
        }
        Label {
            id: coverBalance
            text: qsTr("<br /><br />")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
    }
    CoverActionList {
        id: coverActionList
        CoverAction {
            id: coverAction
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: {
                drkApp.drkCoin.update()
                coverCycle = 0
                coverPage.refresh()
            }
        }
    }
}



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

Page {
    id: firstPage
    property int firstCycle: 0
    property int firstUpdate: 5
    function refresh() {
        firstBitfinexPrice.text = drkApp.drkCoin.bitfinexUSD()
        firstMintpalPrice.text = drkApp.drkCoin.mintpalBTC()
        firstBitfinexPriceBTC.text = qsTr(drkApp.drkCoin.bitfinexBTC())
        if (firstCycle > (60 * firstUpdate)) {
            drkApp.drkCoin.update()
            firstCycle = 0
        }
        else {
            firstCycle = firstCycle + 1
        }
    }
    Timer {
        id: firstTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: firstPage.refresh()
    }
    SilicaFlickable {
        id: firstView
        anchors.fill: parent
        contentHeight: firstColumn.height
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("about.qml"))
            }
        }
        Column {
            id: firstColumn
            anchors.centerIn: parent
            x: Theme.paddingLarge
            y: Theme.paddingMedium
            width: parent.width - 2 * Theme.paddingLarge
            spacing: Theme.paddingMedium
            PageHeader {
                title: qsTr("drkJolla 0." + drkApp.drkCoin.version(true))
            }
            Label {
                id: firstHeading
                text: qsTr("Darkcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAbout
                x: Theme.paddingMedium
                text: qsTr("Tickers are updated every 5 minutes if internet connection is available.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: firstBitfinex
                text: qsTr("Bitfinex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstBitfinexPrice
                text: qsTr(drkApp.drkCoin.bitfinexUSD())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstMintpal
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstMintpalPrice
                text: qsTr(drkApp.drkCoin.mintpalBTC())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstHeadingBTC
                text: qsTr("<br />Bitcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutBTC
                x: Theme.paddingMedium
                text: qsTr("Tickers are updated every 5 minutes if internet connection is available.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: firstBitfinexBTC
                text: qsTr("Bitfinex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstBitfinexPriceBTC
                text: qsTr(drkApp.drkCoin.bitfinexBTC())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
        }
    }
}

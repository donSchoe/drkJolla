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
        firstBitfinexBtcUsd.text = drkApp.drkTicker.bitfinexBtcUsd()
        firstCryptsyBtcUsd.text = drkApp.drkTicker.cryptsyBtcUsd()
        firstBitfinexDrkUsd.text = drkApp.drkTicker.bitfinexDrkUsd()
        firstBitfinexDrkBtc.text = drkApp.drkTicker.bitfinexDrkBtc()
        firstCryptsyDrkUsd.text = drkApp.drkTicker.cryptsyDrkUsd()
        firstCryptsyDrkBtc.text = drkApp.drkTicker.cryptsyDrkBtc()
        firstCryptsyDrkLtc.text = drkApp.drkTicker.cryptsyDrkLtc()
        firstMintpalDrkBtc.text = drkApp.drkTicker.mintpalDrkBtc()
        firstMintpalDrkLtc.text = drkApp.drkTicker.mintpalDrkLtc()
        firstPoloniexDrkBtc.text = drkApp.drkTicker.poloniexDrkBtc()
        firstPoloniexDrkXmr.text = drkApp.drkTicker.poloniexDrkXmr()
        firstCryptsyCloakBtc.text = drkApp.drkTicker.cryptsyCloakBtc()
        firstCryptsyCloakLtc.text = drkApp.drkTicker.cryptsyCloakLtc()
        firstMintpalCloakBtc.text = drkApp.drkTicker.mintpalCloakBtc()
        firstMintpalXmrBtc.text = drkApp.drkTicker.mintpalXmrBtc()
        firstPoloniexXmrBtc.text = drkApp.drkTicker.poloniexXmrBtc()
        firstCryptsyXcBtc.text = drkApp.drkTicker.cryptsyXcBtc()
        firstCryptsyXcLtc.text = drkApp.drkTicker.cryptsyXcLtc()
        firstMintpalXcBtc.text = drkApp.drkTicker.mintpalXcBtc()
        firstPoloniexXcBtc.text = drkApp.drkTicker.poloniexXcBtc()
        firstCryptsyCachBtc.text = drkApp.drkTicker.cryptsyCachBtc()
        firstPoloniexCachBtc.text = drkApp.drkTicker.poloniexCachBtc()
        if (firstCycle > (60 * firstUpdate)) {
            drkApp.drkTicker.update()
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
                title: qsTr("drkJolla 0." + drkApp.drkTicker.version(true))
            }
            Label {
                id: firstHeadingBtc
                text: qsTr("Bitcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutBtc
                x: Theme.paddingMedium
                text: qsTr("Bitcoin is an innovative payment network and a new kind of money.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: firstBitfinexBtc
                text: qsTr("Bitfinex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstBitfinexBtcUsd
                text: qsTr(drkApp.drkTicker.bitfinexBtcUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstCryptsyBtc
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstCryptsyBtcUsd
                text: qsTr(drkApp.drkTicker.cryptsyBtcUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstHeadingDrk
                text: qsTr("<br />Darkcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutDrk
                x: Theme.paddingMedium
                text: qsTr("Darkcoin is a digital crypto-currency build for a maximum of privacy.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: firstBitfinexDrk
                text: qsTr("Bitfinex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstBitfinexDrkUsd
                text: qsTr(drkApp.drkTicker.bitfinexDrkUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstBitfinexDrkBtc
                text: qsTr(drkApp.drkTicker.bitfinexDrkBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstCryptsyDrk
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstCryptsyDrkUsd
                text: qsTr(drkApp.drkTicker.cryptsyDrkUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstCryptsyDrkBtc
                text: qsTr(drkApp.drkTicker.cryptsyDrkBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstCryptsyDrkLtc
                text: qsTr(drkApp.drkTicker.cryptsyDrkLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstMintpalDrk
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstMintpalDrkBtc
                text: qsTr(drkApp.drkTicker.mintpalDrkBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstMintpalDrkLtc
                text: qsTr(drkApp.drkTicker.mintpalDrkLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstPoloniexDrk
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstPoloniexDrkBtc
                text: qsTr(drkApp.drkTicker.poloniexDrkBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstPoloniexDrkXmr
                text: qsTr(drkApp.drkTicker.poloniexDrkXmr())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstHeadingCloak
                text: qsTr("<br />Cloakcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutCloak
                x: Theme.paddingMedium
                text: qsTr("Cloakcoin is a digital crypto-currency.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: firstCryptsyCloak
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstCryptsyCloakBtc
                text: qsTr(drkApp.drkTicker.cryptsyCloakBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstCryptsyCloakLtc
                text: qsTr(drkApp.drkTicker.cryptsyCloakLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstMintpalCloak
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstMintpalCloakBtc
                text: qsTr(drkApp.drkTicker.mintpalCloakBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstHeadingXmr
                text: qsTr("<br />Monero")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutXmr
                x: Theme.paddingMedium
                text: qsTr("Monero is a digital crypto-currency.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: firstMintpalMonero
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstMintpalXmrBtc
                text: qsTr(drkApp.drkTicker.mintpalXmrBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstPoloniexXmr
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstPoloniexXmrBtc
                text: qsTr(drkApp.drkTicker.poloniexXmrBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstHeadingXc
                text: qsTr("<br />XCurrency")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutXc
                x: Theme.paddingMedium
                text: qsTr("XCurrency is a digital crypto-currency.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: firstCryptsyXc
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstCryptsyXcBtc
                text: qsTr(drkApp.drkTicker.cryptsyXcBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstCryptsyXcLtc
                text: qsTr(drkApp.drkTicker.cryptsyXcLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstMintpalXc
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstMintpalXcBtc
                text: qsTr(drkApp.drkTicker.mintpalCloakBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstPoloniexXc
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstPoloniexXcBtc
                text: qsTr(drkApp.drkTicker.poloniexXcBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstHeadingCach
                text: qsTr("<br />Cachecoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutCach
                x: Theme.paddingMedium
                text: qsTr("Cachecoin is crypto-project that aims to improve the altcoin ecosystem.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: firstCryptsyCach
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstCryptsyCachBtc
                text: qsTr(drkApp.drkTicker.cryptsyCachBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstPoloniexCach
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
            }
            Label {
                id: firstPoloniexCachBtc
                text: qsTr(drkApp.drkTicker.poloniexCachBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
            }
            Label {
                id: firstFooter
                x: Theme.paddingMedium
                text: qsTr("<br />Tickers are updated every 5 minutes if internet connection is available.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            VerticalScrollDecorator {
                id: firstScroll
                flickable: firstView
            }
        }
    }
}

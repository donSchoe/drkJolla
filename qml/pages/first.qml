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
    property int updateInterval: drkApp.drkTicker.updateInterval()
    property bool active: status !== PageStatus.Inactive
    property bool offlineMode: drkApp.drkTicker.isOfflineMode()
    property bool btcEnabled: drkApp.drkTicker.isBtcEnabled()
    property bool drkEnabled: drkApp.drkTicker.isDrkEnabled()
    property bool cloakEnabled: drkApp.drkTicker.isCloakEnabled()
    property bool xmrEnabled: drkApp.drkTicker.isXmrEnabled()
    property bool xcEnabled: drkApp.drkTicker.isXcEnabled()
    property bool cachEnabled: drkApp.drkTicker.isCachEnabled()
    function refresh() {
        updateInterval = drkApp.drkTicker.updateInterval()
        offlineMode = drkApp.drkTicker.isOfflineMode()
        btcEnabled = drkApp.drkTicker.isBtcEnabled()
        drkEnabled = drkApp.drkTicker.isDrkEnabled()
        cloakEnabled = drkApp.drkTicker.isCloakEnabled()
        xmrEnabled = drkApp.drkTicker.isXmrEnabled()
        xcEnabled = drkApp.drkTicker.isXcEnabled()
        cachEnabled = drkApp.drkTicker.isCachEnabled()
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
        if (firstCycle > (60 * updateInterval)) {
            if (!offlineMode && active) {
                drkApp.drkTicker.update()
            }
            firstCycle = 0
        }
        else {
            firstCycle = firstCycle + 1
        }
    }
    Timer {
        id: firstTimer
        interval: 1000
        running: active
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
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("settings.qml"))
            }
            MenuItem {
                text: offlineMode ? qsTr("Go Online") : qsTr("Refresh")
                onClicked: {
                    if (offlineMode) {
                        drkApp.drkTicker.setOfflineMode(false)
                    }
                    else {
                        firstPage.refresh()
                    }
                }
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
                title: qsTr("drkJolla")
            }
            Label {
                id: firstHeadingBtc
                text: qsTr("Bitcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: btcEnabled
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
                visible: btcEnabled
            }
            Label {
                id: firstBitfinexBtc
                text: qsTr("Bitfinex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: btcEnabled
            }
            Label {
                id: firstBitfinexBtcUsd
                text: qsTr(drkApp.drkTicker.bitfinexBtcUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: btcEnabled
            }
            Label {
                id: firstCryptsyBtc
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: btcEnabled
            }
            Label {
                id: firstCryptsyBtcUsd
                text: qsTr(drkApp.drkTicker.cryptsyBtcUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: btcEnabled
            }
            Label {
                id: firstHeadingDrk
                text: qsTr("<br />Darkcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: drkEnabled
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
                visible: drkEnabled
            }
            Label {
                id: firstBitfinexDrk
                text: qsTr("Bitfinex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: drkEnabled
            }
            Label {
                id: firstBitfinexDrkUsd
                text: qsTr(drkApp.drkTicker.bitfinexDrkUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstBitfinexDrkBtc
                text: qsTr(drkApp.drkTicker.bitfinexDrkBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstCryptsyDrk
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: drkEnabled
            }
            Label {
                id: firstCryptsyDrkUsd
                text: qsTr(drkApp.drkTicker.cryptsyDrkUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstCryptsyDrkBtc
                text: qsTr(drkApp.drkTicker.cryptsyDrkBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstCryptsyDrkLtc
                text: qsTr(drkApp.drkTicker.cryptsyDrkLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstMintpalDrk
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: drkEnabled
            }
            Label {
                id: firstMintpalDrkBtc
                text: qsTr(drkApp.drkTicker.mintpalDrkBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstMintpalDrkLtc
                text: qsTr(drkApp.drkTicker.mintpalDrkLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstPoloniexDrk
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: drkEnabled
            }
            Label {
                id: firstPoloniexDrkBtc
                text: qsTr(drkApp.drkTicker.poloniexDrkBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstPoloniexDrkXmr
                text: qsTr(drkApp.drkTicker.poloniexDrkXmr())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: drkEnabled
            }
            Label {
                id: firstHeadingCloak
                text: qsTr("<br />Cloakcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: cloakEnabled
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
                visible: cloakEnabled
            }
            Label {
                id: firstCryptsyCloak
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: cloakEnabled
            }
            Label {
                id: firstCryptsyCloakBtc
                text: qsTr(drkApp.drkTicker.cryptsyCloakBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: cloakEnabled
            }
            Label {
                id: firstCryptsyCloakLtc
                text: qsTr(drkApp.drkTicker.cryptsyCloakLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: cloakEnabled
            }
            Label {
                id: firstMintpalCloak
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: cloakEnabled
            }
            Label {
                id: firstMintpalCloakBtc
                text: qsTr(drkApp.drkTicker.mintpalCloakBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: cloakEnabled
            }
            Label {
                id: firstHeadingXmr
                text: qsTr("<br />Monero")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: xmrEnabled
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
                visible: xmrEnabled
            }
            Label {
                id: firstMintpalMonero
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: xmrEnabled
            }
            Label {
                id: firstMintpalXmrBtc
                text: qsTr(drkApp.drkTicker.mintpalXmrBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: xmrEnabled
            }
            Label {
                id: firstPoloniexXmr
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: xmrEnabled
            }
            Label {
                id: firstPoloniexXmrBtc
                text: qsTr(drkApp.drkTicker.poloniexXmrBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: xmrEnabled
            }
            Label {
                id: firstHeadingXc
                text: qsTr("<br />XCurrency")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: xcEnabled
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
                visible: xcEnabled
            }
            Label {
                id: firstCryptsyXc
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: xcEnabled
            }
            Label {
                id: firstCryptsyXcBtc
                text: qsTr(drkApp.drkTicker.cryptsyXcBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: xcEnabled
            }
            Label {
                id: firstCryptsyXcLtc
                text: qsTr(drkApp.drkTicker.cryptsyXcLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: xcEnabled
            }
            Label {
                id: firstMintpalXc
                text: qsTr("Mintpal")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: xcEnabled
            }
            Label {
                id: firstMintpalXcBtc
                text: qsTr(drkApp.drkTicker.mintpalCloakBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: xcEnabled
            }
            Label {
                id: firstPoloniexXc
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: xcEnabled
            }
            Label {
                id: firstPoloniexXcBtc
                text: qsTr(drkApp.drkTicker.poloniexXcBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: xcEnabled
            }
            Label {
                id: firstHeadingCach
                text: qsTr("<br />Cachecoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: cachEnabled
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
                visible: cachEnabled
            }
            Label {
                id: firstCryptsyCach
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: cachEnabled
            }
            Label {
                id: firstCryptsyCachBtc
                text: qsTr(drkApp.drkTicker.cryptsyCachBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: cachEnabled
            }
            Label {
                id: firstPoloniexCach
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: cachEnabled
            }
            Label {
                id: firstPoloniexCachBtc
                text: qsTr(drkApp.drkTicker.poloniexCachBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: cachEnabled
            }
            Label {
                id: firstWarning
                text: qsTr("<br />Heads up!")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryHighlightColor
                visible: (!btcEnabled && !drkEnabled && !cloakEnabled && !xmrEnabled && !xcEnabled && !cachEnabled) || offlineMode
            }
            Label {
                id: firstWarningTickers
                x: Theme.paddingMedium
                text: qsTr("<br />You have no tickers enabled. Please review your settings and select at least one coin.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                visible: (!btcEnabled && !drkEnabled && !cloakEnabled && !xmrEnabled && !xcEnabled && !cachEnabled)
            }
            Label {
                id: firstWarningOffline
                x: Theme.paddingMedium
                text: qsTr("<br />You have the offline mode enabled. Tickers will not be refreshed unless the offline mode is disabled in settings.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                visible: offlineMode
            }
            Label {
                id: firstFooter
                x: Theme.paddingMedium
                text: qsTr("<br />Tickers are updated every " + updateInterval + " minutes if internet connection is available. You can adjust the update interval in settings.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                visible: (btcEnabled || drkEnabled || cloakEnabled || xmrEnabled || xcEnabled || cachEnabled) && !offlineMode
            }
            VerticalScrollDecorator {
                id: firstScroll
                flickable: firstView
            }
        }
    }
}

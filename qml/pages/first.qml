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
    property int updateInterval: drkApp.drkTicker.updateInterval()
    property bool active: status === PageStatus.Active
    property bool offlineMode: drkApp.drkTicker.isOfflineMode()
    property bool btcEnabled: drkApp.drkTicker.isBtcEnabled()
    property bool drkEnabled: drkApp.drkTicker.isDrkEnabled()
    property bool ancEnabled: drkApp.drkTicker.isAncEnabled()
    property bool btcdEnabled: drkApp.drkTicker.isBtcdEnabled()
    property bool cloakEnabled: drkApp.drkTicker.isCloakEnabled()
    property bool xmrEnabled: drkApp.drkTicker.isXmrEnabled()
    property bool xcEnabled: drkApp.drkTicker.isXcEnabled()
    function refresh() {
        if (active && Qt.application.active) {
            updateInterval = drkApp.drkTicker.updateInterval()
            offlineMode = drkApp.drkTicker.isOfflineMode()
            btcEnabled = drkApp.drkTicker.isBtcEnabled()
            drkEnabled = drkApp.drkTicker.isDrkEnabled()
            ancEnabled = drkApp.drkTicker.isAncEnabled()
            btcdEnabled = drkApp.drkTicker.isBtcdEnabled()
            cloakEnabled = drkApp.drkTicker.isCloakEnabled()
            xmrEnabled = drkApp.drkTicker.isXmrEnabled()
            xcEnabled = drkApp.drkTicker.isXcEnabled()
            firstBitfinexBtcUsd.text = drkApp.drkTicker.bitfinexBtcUsd()
            firstCryptsyBtcUsd.text = drkApp.drkTicker.cryptsyBtcUsd()
            firstPoloniexBtcUsd.text = drkApp.drkTicker.poloniexBtcUsd()
            firstBitfinexDrkUsd.text = drkApp.drkTicker.bitfinexDrkUsd()
            firstBitfinexDrkBtc.text = drkApp.drkTicker.bitfinexDrkBtc()
            firstCryptsyDrkUsd.text = drkApp.drkTicker.cryptsyDrkUsd()
            firstCryptsyDrkBtc.text = drkApp.drkTicker.cryptsyDrkBtc()
            firstCryptsyDrkLtc.text = drkApp.drkTicker.cryptsyDrkLtc()
            firstPoloniexDrkBtc.text = drkApp.drkTicker.poloniexDrkBtc()
            firstPoloniexDrkXmr.text = drkApp.drkTicker.poloniexDrkXmr()
            firstPoloniexBtcdBtc.text = drkApp.drkTicker.poloniexBtcdBtc()
            firstPoloniexBtcdXmr.text = drkApp.drkTicker.poloniexBtcdXmr()
            firstCryptsyAncBtc.text = drkApp.drkTicker.cryptsyAncBtc()
            firstCryptsyAncLtc.text = drkApp.drkTicker.cryptsyAncLtc()
            firstCryptsyBtcdBtc.text = drkApp.drkTicker.cryptsyBtcdBtc()
            firstCryptsyCloakBtc.text = drkApp.drkTicker.cryptsyCloakBtc()
            firstCryptsyCloakLtc.text = drkApp.drkTicker.cryptsyCloakLtc()
            firstPoloniexXmrUsd.text = drkApp.drkTicker.poloniexXmrUsd()
            firstPoloniexXmrBtc.text = drkApp.drkTicker.poloniexXmrBtc()
            firstCryptsyXcBtc.text = drkApp.drkTicker.cryptsyXcBtc()
            firstCryptsyXcLtc.text = drkApp.drkTicker.cryptsyXcLtc()
            firstPoloniexXcBtc.text = drkApp.drkTicker.poloniexXcBtc()
            if (!offlineMode && active) {
                drkApp.drkTicker.update()
            }
        }
    }
    Timer {
        id: firstTimer
        interval: 1000
        running: active && Qt.application.active
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
                        drkApp.drkTicker.update(true)
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
                id: firstPoloniexBtc
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: btcEnabled
            }
            Label {
                id: firstPoloniexBtcUsd
                text: qsTr(drkApp.drkTicker.poloniexBtcUsd())
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
                text: qsTr("Darkcoin is the first digital crypto-currency build for a maximum of privacy.<br />")
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
                id: firstHeadingAnc
                text: qsTr("<br />Anoncoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: ancEnabled
            }
            Label {
                id: firstAboutAnc
                x: Theme.paddingMedium
                text: qsTr("Anoncoin was created with the goal of being a truly anonymous cryptocurrency.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                visible: ancEnabled
            }
            Label {
                id: firstCryptsyAnc
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: ancEnabled
            }
            Label {
                id: firstCryptsyAncBtc
                text: qsTr(drkApp.drkTicker.cryptsyAncBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: ancEnabled
            }
            Label {
                id: firstCryptsyAncLtc
                text: qsTr(drkApp.drkTicker.cryptsyAncLtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: ancEnabled
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
                text: qsTr("Monero is a new privacy-centric coin which aims to be a fungible and untraceable digital medium of exchange.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
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
                id: firstPoloniexXmrUsd
                text: qsTr(drkApp.drkTicker.poloniexXmrUsd())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
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
                id: firstHeadingBtcd
                text: qsTr("<br />BitcoinDark")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
                visible: btcdEnabled
            }
            Label {
                id: firstAboutBtcd
                x: Theme.paddingMedium
                text: qsTr("BitcoinDark is a community driven project which aims to fulfill the original ideals of crypto-currency: Decentralization, Openness, and Anonymity.<br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                visible: btcdEnabled
            }
            Label {
                id: firstCryptsyBtcd
                text: qsTr("Cryptsy")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: btcdEnabled
            }
            Label {
                id: firstCryptsyBtcdBtc
                text: qsTr(drkApp.drkTicker.cryptsyBtcdBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: btcdEnabled
            }
            Label {
                id: firstPoloniexBtcd
                text: qsTr("Poloniex")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                visible: btcdEnabled
            }
            Label {
                id: firstPoloniexBtcdBtc
                text: qsTr(drkApp.drkTicker.poloniexBtcdBtc())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: btcdEnabled
            }
            Label {
                id: firstPoloniexBtcdXmr
                text: qsTr(drkApp.drkTicker.poloniexBtcdXmr())
                width: parent.width
                color: Theme.highlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeLarge
                x: 3 * Theme.paddingLarge
                visible: btcdEnabled
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
                text: qsTr("XCurrency is a platform for private transactions, communication and services.<br />")
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
                text: qsTr("Cloakcoin is a crypto-currency that will feature decentralized p2p-anonymization features via Proof-of-Stake protocol extensions.<br />")
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
                id: firstWarning
                text: qsTr("<br />Heads up!")
                width: parent.width
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryHighlightColor
                visible: (!btcEnabled && !drkEnabled && !cloakEnabled && !xmrEnabled && !xcEnabled) || offlineMode
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
                visible: (!btcEnabled && !drkEnabled && !cloakEnabled && !xmrEnabled && !xcEnabled)
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
                visible: (btcEnabled || drkEnabled || cloakEnabled || xmrEnabled || xcEnabled) && !offlineMode
            }
            VerticalScrollDecorator {
                id: firstScroll
                flickable: firstView
            }
        }
    }
}

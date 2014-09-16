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
    property bool coverActive: status === Cover.Active
    property bool coverDrkEnabled: true
    property bool offlineMode: drkApp.drkTicker.isOfflineMode()
    property bool btcEnabled: drkApp.drkTicker.isBtcEnabled()
    property bool drkEnabled: drkApp.drkTicker.isDrkEnabled()
    property bool ancEnabled: drkApp.drkTicker.isAncEnabled()
    property bool xmrEnabled: drkApp.drkTicker.isXmrEnabled()
    property bool xcEnabled: drkApp.drkTicker.isXcEnabled()
    property bool btcdEnabled: drkApp.drkTicker.isBtcdEnabled()
    function refresh() {
        if (coverActive) {
            offlineMode = drkApp.drkTicker.isOfflineMode()
            btcEnabled = drkApp.drkTicker.isBtcEnabled()
            drkEnabled = drkApp.drkTicker.isDrkEnabled()
            ancEnabled = drkApp.drkTicker.isAncEnabled()
            xmrEnabled = drkApp.drkTicker.isXmrEnabled()
            xcEnabled = drkApp.drkTicker.isXcEnabled()
            btcdEnabled = drkApp.drkTicker.isBtcdEnabled()
            coverBtcUsd.text = drkApp.drkTicker.bitfinexBtcUsd()
            coverDrkBtc.text = drkApp.drkTicker.mintpalDrkBtc()
            coverAncBtc.text = drkApp.drkTicker.cryptsyAncBtc()
            coverXmrBtc.text = drkApp.drkTicker.mintpalXmrBtc()
            coverXcBtc.text = drkApp.drkTicker.mintpalXcBtc()
            coverBtcdBtc.text = drkApp.drkTicker.cryptsyBtcdBtc()
            if (!offlineMode && coverActive) {
                drkApp.drkTicker.update()
            }
        }
    }
    Timer {
        id: coverTimer
        interval: 1000
        running: coverActive
        repeat: true
        onTriggered: coverPage.refresh()
    }
    Column {
        id: coverColumn
        anchors.centerIn: parent
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        width: parent.width - 2 * Theme.paddingLarge
        spacing: Theme.paddingSmall
        Label {
            id: coverBtc
            text: qsTr("Bitcoin")
            visible: btcEnabled
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverBtcUsd
            text: qsTr(drkApp.drkTicker.bitfinexBtcUsd())
            visible: btcEnabled
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverDrk
            text: qsTr("Darkcoin")
            visible: drkEnabled
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverDrkBtc
            text: qsTr(drkApp.drkTicker.mintpalDrkBtc())
            visible: drkEnabled
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverAnc
            text: qsTr("Anoncoin")
            visible: ancEnabled
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverAncBtc
            text: qsTr(drkApp.drkTicker.cryptsyAncBtc())
            visible: ancEnabled
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverBtcd
            text: qsTr("BitcoinDark")
            visible: btcdEnabled
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverBtcdBtc
            text: qsTr(drkApp.drkTicker.cryptsyBtcdBtc())
            visible: btcdEnabled
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverXmr
            text: qsTr("Monero")
            visible: xmrEnabled
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverXmrBtc
            text: qsTr(drkApp.drkTicker.mintpalXmrBtc())
            visible: xmrEnabled
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverXc
            text: qsTr("XCurrency")
            visible: xcEnabled
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverXcBtc
            text: qsTr(drkApp.drkTicker.mintpalXcBtc())
            visible: xcEnabled
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverWarningOffline
            x: Theme.paddingMedium
            text: qsTr("<br />You have no tickers enabled. Please review your settings and select at least one coin.<br />")
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeTiny
            horizontalAlignment: Text.AlignHLeft
            wrapMode: Text.WordWrap
            elide: Text.ElideMiddle
            width: parent.width * 0.9
            visible: (!btcEnabled && !drkEnabled && !ancEnabled && !xmrEnabled && !xcEnabled && !btcdEnabled)
        }
        Label {
            id: coverFooter
            x: Theme.paddingMedium
            text: qsTr("<br /><br />")
            color: Theme.secondaryColor
            font.pixelSize: Theme.fontSizeTiny
            horizontalAlignment: Text.AlignHLeft
            wrapMode: Text.WordWrap
            elide: Text.ElideMiddle
            width: parent.width * 0.9
            visible: !(btcEnabled && drkEnabled && ancEnabled && xmrEnabled && xcEnabled && btcdEnabled)
        }
    }
    CoverActionList {
        id: coverActionList
        CoverAction {
            id: coverAction
            iconSource: (btcEnabled && drkEnabled && ancEnabled && xmrEnabled && xcEnabled && btcdEnabled) ? false : "image://theme/icon-cover-refresh"
            onTriggered: {
                if (!offlineMode) {
                    drkApp.drkTicker.update()
                    coverPage.refresh()
                }
            }
        }
    }
}



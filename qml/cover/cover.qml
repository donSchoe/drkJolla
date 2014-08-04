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
    property int updateInterval: drkApp.drkTicker.updateInterval()
    property bool coverActive: status !== Cover.Inactive
    property bool coverDrkEnabled: true
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
        coverDrkBtc.text = drkApp.drkTicker.mintpalDrkBtc()
        coverCloakBtc.text = drkApp.drkTicker.mintpalCloakBtc()
        coverXmrBtc.text = drkApp.drkTicker.mintpalXmrBtc()
        coverXcBtc.text = drkApp.drkTicker.mintpalXcBtc()
        coverCachBtc.text = drkApp.drkTicker.cryptsyCachBtc()
        if (coverCycle > (60 * updateInterval)) {
            if (!offlineMode && coverActive) {
                drkApp.drkTicker.update()
            }
            coverCycle = 0
        }
        else {
            coverCycle = coverCycle + 1
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
            id: coverCloak
            text: qsTr("Cloakcoin")
            visible: cloakEnabled
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverCloakBtc
            text: qsTr(drkApp.drkTicker.mintpalCloakBtc())
            visible: cloakEnabled
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
            id: coverCach
            text: qsTr("Cachecoin")
            visible: cachEnabled
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverCachBtc
            text: qsTr(drkApp.drkTicker.cryptsyCachBtc())
            visible: cachEnabled
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeTiny
        }
    }
//    CoverActionList {
//        id: coverActionList
//        CoverAction {
//            id: coverAction
//            iconSource: coverDrkEnabled ? "image://theme/icon-cover-next" : "image://theme/icon-cover-previous"
//            onTriggered: {
//                coverDrkEnabled = !coverDrkEnabled
//                drkApp.drkTicker.update()
//                coverCycle = 0
//                coverPage.refresh()
//            }
//        }
//    }
}



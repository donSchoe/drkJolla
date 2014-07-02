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
    property bool coverDrkEnabled: true
    function refresh() {
        if (coverDrkEnabled) {
            coverBitfinexDrkUsd.text = drkApp.drkTicker.bitfinexDrkUsd()
            coverCryptsyDrkBtc.text = drkApp.drkTicker.cryptsyDrkBtc()
            coverMintpalDrkBtc.text = drkApp.drkTicker.mintpalDrkBtc()
        }
        else {
            coverCryptsyCachBtc.text = drkApp.drkTicker.cryptsyCachBtc()
            coverPoloniexCachBtc.text = drkApp.drkTicker.poloniexCachBtc()
        }
        if (coverCycle > (60 * coverUpdate)) {
            drkApp.drkTicker.update()
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
        id: coverColumnDrk
        visible: coverDrkEnabled
        anchors.centerIn: parent
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        width: parent.width - 2 * Theme.paddingLarge
        spacing: Theme.paddingSmall
        Label {
            id: coverHeadingDrk
            text: qsTr("Darkcoin")
            width: parent.width
            color: Theme.secondaryHighlightColor
            horizontalAlignment: Text.AlignRight
            font.pixelSize: Theme.fontSizeLarge
        }
        Label {
            id: coverBitfinexDrk
            text: qsTr("Bitfinex")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverBitfinexDrkUsd
            text: qsTr(drkApp.drkTicker.bitfinexDrkUsd())
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeSmall
        }
        Label {
            id: coverCryptsyDrk
            text: qsTr("Cryptsy")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverCryptsyDrkBtc
            text: qsTr(drkApp.drkTicker.cryptsyDrkBtc())
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeSmall
        }
        Label {
            id: coverMintpalDrk
            text: qsTr("Mintpal")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverMintpalDrkBtc
            text: qsTr(drkApp.drkTicker.mintpalDrkBtc())
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeSmall
        }
        Label {
            id: coverFooterDrk
            text: qsTr("<br /><br />")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
    }
    Column {
        id: coverColumnCach
        visible: !coverDrkEnabled
        anchors.centerIn: parent
        x: Theme.paddingLarge
        y: Theme.paddingLarge
        width: parent.width - 2 * Theme.paddingLarge
        spacing: Theme.paddingSmall
        Label {
            id: coverHeadingCach
            text: qsTr("Cachecoin")
            width: parent.width
            color: Theme.secondaryHighlightColor
            horizontalAlignment: Text.AlignRight
            font.pixelSize: Theme.fontSizeLarge
        }
        Label {
            id: coverCryptsyCach
            text: qsTr("Cryptsy")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverCryptsyCachBtc
            text: qsTr(drkApp.drkTicker.cryptsyCachBtc())
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeSmall
        }
        Label {
            id: coverPoloniexCach
            text: qsTr("Poloniex")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeTiny
        }
        Label {
            id: coverPoloniexCachBtc
            text: qsTr(drkApp.drkTicker.poloniexCachBtc())
            width: parent.width
            color: Theme.highlightColor
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeSmall
        }
        Label {
            id: coverFooter
            text: qsTr("<br /><br />")
            width: parent.width
            horizontalAlignment: Text.AlignLeft
            font.pixelSize: Theme.fontSizeSmall
        }
    }
    CoverActionList {
        id: coverActionList
        CoverAction {
            id: coverAction
            iconSource: coverDrkEnabled ? "image://theme/icon-cover-next" : "image://theme/icon-cover-previous"
            onTriggered: {
                coverDrkEnabled = !coverDrkEnabled
                drkApp.drkTicker.update()
                coverCycle = 0
                coverPage.refresh()
            }
        }
    }
}



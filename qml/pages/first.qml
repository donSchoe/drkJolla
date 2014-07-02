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
        firstBitfinexDrkUsd.text = drkApp.drkTicker.bitfinexDrkUsd()
        firstBitfinexDrkBtc.text = drkApp.drkTicker.bitfinexDrkBtc()
        firstMintpalDrkBtc.text = drkApp.drkTicker.mintpalDrkBtc()
        firstBitfinexBtcUsd.text = qsTr(drkApp.drkTicker.bitfinexBtcUsd())
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
                id: firstHeadingDrk
                text: qsTr("Darkcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutDrk
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
                id: firstHeadingBtc
                text: qsTr("<br />Bitcoin")
                width: parent.width
                color: Theme.secondaryHighlightColor
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: Theme.fontSizeExtraLarge
            }
            Label {
                id: firstAboutBtc
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
            VerticalScrollDecorator {
                id: firstScroll
                flickable: firstView
            }
        }
    }
}

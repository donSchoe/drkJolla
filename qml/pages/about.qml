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
    id: aboutPage
    SilicaFlickable {
        id: aboutView
        anchors.fill: parent
        contentHeight: aboutColumn.height
        Column {
            id: aboutColumn
            anchors.centerIn: parent
            x: Theme.paddingLarge
            y: Theme.paddingMedium
            width: parent.width - 2 * Theme.paddingLarge
            spacing: Theme.paddingMedium
            PageHeader {
                title: qsTr("About")
            }
            Label {
                id: aboutLabel
                x: Theme.paddingMedium
                text: qsTr("Version 0." + drkApp.drkTicker.version(true))
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: aboutVersion
                x: Theme.paddingMedium
                text: qsTr("<strong>drkJolla</strong> v0." + drkApp.drkTicker.version() + " released as of " + drkApp.drkTicker.versionDate() + ".<br /><br />")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: aboutCopy
                x: Theme.paddingMedium
                text: qsTr("<html>Copyright &copy; 2014 by A. Schoedon</html>")
                color: Theme.highlightColor
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: aboutLicense
                x: Theme.paddingMedium
                text: qsTr("<html><style type='text/css'>a:link { color: " + Theme.secondaryHighlightColor + "; }</style>
<strong>drkJolla</strong> is free software licensed under the GPLv3 available at <a href='https://github.com/donSchoe/drkjolla'>github.com/donSchoe/drkjolla</a>.
This program is distributed in the hope that it will be useful, but without any warranty.
See the GNU General Public License for more details.
Cryptocoin prices are fetched from the <a href='http://bitfinex.com'>bitfinex.com</a>, <a href='http://cryptsy.com'>cryptsy.com</a> and <a href='http://poloniex.com'>poloniex.com</a> APIs.<br /><br />
<strong>Darkcoin</strong> is the first digital crypto-currency build for a maximum of privacy.
<strong>Anoncoin</strong> was created with the goal of being a truly anonymous cryptocurrency.
<strong>BitcoinDark</strong> is a community driven project which aims to fulfill the original ideals of crypto-currency: Decentralization, Openness, and Anonymity.
<strong>Monero</strong> is a new privacy-centric coin which aims to be a fungible and untraceable digital medium of exchange.
<strong>XCurrency</strong> is a platform for private transactions, communication and services.
<strong>Cloakcoin</strong> is a crypto-currency that will feature decentralized p2p-anonymization features via Proof-of-Stake protocol extensions.
The software is free, released under the MIT license, &copy; 2009-2013 by the Bitcoin developers, &copy; 2011-2012 by the Peercoin developers, &copy; 2011-2013 by the Litecoin developers, &copy; 2013-2014 by the Darkcoin developers, &copy; 2013-2014 by the Anoncoin developers, &copy; 2013-2014 by the Bytecoin and Bitmonero teams, &copy; 2014 by the BitcoinDark developers, &copy; 2014 by the XCurrency developers and &copy, &copy; 2014 by the Cloakcoin developers available at <a href='http://darkcoin.io'>darkcoin.io</a>, <a href='https://anoncoin.net'>anoncoin.net</a>, <a href='http://www.monero.cc'>monero.cc</a>, <a href='http://http://bitcoindark.pw'>bitcoindark.pw</a>, <a href='http://www.xc-official.com'>xc-official.com</a> and <a href='http://www.cloakcoin.com'>cloakcoin.com</a> - Bitcoin is available at <a href='http://bitcoin.org'>bitcoin.org</a>, Litecoin at <a href='http://litecoin.org'>litecoin.org</a>, Peercoin at <a href='http://peercoin.net'>peercoin.net</a> and Bytecoin at <a href='http://bytecoin.org'>bytecoin.org</a>.<br /><br /></html>")
                color: Theme.secondaryColor
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                onLinkActivated: Qt.openUrlExternally(link)
            }
            Label {
                id: aboutDonate
                x: Theme.paddingMedium
                text: qsTr("Buy me a coffee")
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeMedium
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: aboutCoinAddress
                x: Theme.paddingMedium
                text: qsTr("<html><style type='text/css'>a:link { color: " + Theme.secondaryHighlightColor + "; }</style>
Bitcoin: <a href='bitcoin://1BumJSsvHJUG6xHYz3K4tX6mBFDtc1hmh1'>1BumJSsvHJUG6xHYz3K4tX6mBFDtc1hmh1</a><br />
Darkcoin: <a href='darkcoin://XwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg'>XwnLY9Tf7Zsef8gMGL2fhWA9ZmMjt4KPwg</a><br /><br />")
                color: Theme.secondaryColor
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                onLinkActivated: Qt.openUrlExternally(link)
            }
            VerticalScrollDecorator {
                id: aboutScroll
                flickable: aboutView
            }
        }
    }
}

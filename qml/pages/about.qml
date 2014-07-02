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
                title: qsTr("About drkJolla 0." + drkApp.drkTicker.version(true))
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
                text: qsTr("<html><style type='text/css'>a:link { color: " + Theme.secondaryHighlightColor + "; }</style><strong>drkJolla</strong> is free software licensed under the GPLv3 available at <a href='https://github.com/donSchoe/drkjolla'>github.com/donSchoe/drkjolla</a>. This program is distributed in the hope that it will be useful, but without any warranty. See the GNU General Public License for more details. Darkcoin prices are fetched from the <a href='http://bitfinex.com'>bitfinex.com</a> and <a href='http://mintpal.com'>mintpal.com</a> APIs.<br /><br /><strong>Darkcoin</strong> is a digital crypto-currency build for a maximum of privacy. The software is free, released under the MIT license, &copy; 2009-2013 by the Bitcoin developers and &copy; 2013-2014 by the Darkcoin project developers available at <a href='http://darkcoin.io'>darkcoin.io</a>. Bitcoin is available at <a href='http://bitcoin.org'>bitcoin.org</a>.<br /><br /></html>")
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
                text: qsTr("Bitcoin: 1Bzc7PatbRzXz6EAmvSuBuoWED96qy3zgc<br />Darkcoin: XsWp6DXrEiEtBpyU5YMctXf15BYNHhufrG<br /><br />")
                color: Theme.secondaryColor
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }
}

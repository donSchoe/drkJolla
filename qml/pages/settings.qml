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

Dialog {
    id: settingsPage
    SilicaFlickable {
        id: settingsView
        anchors.fill: parent
        contentHeight: settingsColumn.height
        Column {
            id: settingsColumn
            anchors.centerIn: parent
            x: Theme.paddingLarge
            y: Theme.paddingMedium
            width: parent.width - 2 * Theme.paddingLarge
            spacing: Theme.paddingMedium
            PageHeader {
                title: qsTr("Settings")
            }
            Label {
                id: settingsCoins
                x: Theme.paddingMedium
                text: qsTr("Select Coins")
                color: Theme.highlightColor
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: settingsCoinsText
                x: Theme.paddingMedium
                text: qsTr("Select the coins which you want to monitor.")
                color: Theme.secondaryColor
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
                onLinkActivated: Qt.openUrlExternally(link)
            }
            TextSwitch {
                id: settingsCoinsBtc
                text: qsTr("Bitcoin")
                checked: drkApp.drkTicker.isBtcEnabled()
                description: "Enables the BTC tickers."
            }
            TextSwitch {
                id: settingsCoinsDrk
                text: qsTr("Darkcoin")
                checked: drkApp.drkTicker.isDrkEnabled()
                description: "Enables the DRK tickers."
            }
            TextSwitch {
                id: settingsCoinsAnc
                text: qsTr("Anoncoin")
                checked: drkApp.drkTicker.isAncEnabled()
                description: "Enables the ANC tickers."
            }
            TextSwitch {
                id: settingsCoinsBtcd
                text: qsTr("BitcoinDark")
                checked: drkApp.drkTicker.isBtcdEnabled()
                description: "Enables the BTCD tickers."
            }
            TextSwitch {
                id: settingsCoinsXmr
                text: qsTr("Monero")
                checked: drkApp.drkTicker.isXmrEnabled()
                description: "Enables the XMR tickers."
            }
            TextSwitch {
                id: settingsCoinsXc
                text: qsTr("XCurrency")
                checked: drkApp.drkTicker.isXcEnabled()
                description: "Enables the XC tickers."
            }
            TextSwitch {
                id: settingsCoinsCloak
                text: qsTr("Cloakcoin")
                checked: drkApp.drkTicker.isCloakEnabled()
                description: "Enables the CLOAK tickers."
            }
            Label {
                id: settingsUpdate
                x: Theme.paddingMedium
                text: qsTr("Update Interval")
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: settingsUpdateText
                x: Theme.paddingMedium
                text: qsTr("Adjust the ticker update interval in minutes.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            TextField {
                id: settingsUpdateTextField
                width: parent.width * 0.9
                horizontalAlignment: Text.AlignHCenter
                text: drkApp.drkTicker.updateInterval();
                label: qsTr("Update interval in minutes.")
                validator: RegExpValidator { regExp: /^[0-9]{1,2}$/ }
                color: errorHighlight? "red" : Theme.primaryColor
                inputMethodHints: Qt.ImhDigitsOnly | Qt.ImhNoPredictiveText
            }
            Label {
                id: settingsMode
                x: Theme.paddingMedium
                text: qsTr("Offline Mode")
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeLarge
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            Label {
                id: settingsModeText
                x: Theme.paddingMedium
                text: qsTr("Toggle offline mode. During offline mode no tickers are refreshed. This saves bandwith and battery.")
                color: Theme.secondaryColor
                font.pixelSize: Theme.fontSizeTiny
                horizontalAlignment: Text.AlignHLeft
                wrapMode: Text.WordWrap
                elide: Text.ElideMiddle
                width: parent.width * 0.9
            }
            TextSwitch {
                id: settingsModeSwitch
                text: qsTr("Offline Mode")
                checked: drkApp.drkTicker.isOfflineMode()
                description: "Enables the offline mode."
            }
            VerticalScrollDecorator {
                id: settingsScroll
                flickable: settingsView
            }
        }
    }
    onDone: {
          if (result === DialogResult.Accepted) {
              drkApp.drkTicker.setBtcEnabled(settingsCoinsBtc.checked);
              drkApp.drkTicker.setDrkEnabled(settingsCoinsDrk.checked);
              drkApp.drkTicker.setAncEnabled(settingsCoinsAnc.checked);
              drkApp.drkTicker.setBtcdEnabled(settingsCoinsBtcd.checked);
              drkApp.drkTicker.setCloakEnabled(settingsCoinsCloak.checked);
              drkApp.drkTicker.setXmrEnabled(settingsCoinsXmr.checked);
              drkApp.drkTicker.setXcEnabled(settingsCoinsXc.checked);
              drkApp.drkTicker.setUpdateInterval(settingsUpdateTextField.text);
              drkApp.drkTicker.setOfflineMode(settingsModeSwitch.checked);
          }
    }
}

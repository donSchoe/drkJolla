# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-drkjolla

CONFIG += sailfishapp

HEADERS += \
    src/tickerhandler.h \
    src/bitfinex.h \
    src/cryptsy.h \
    src/mintpal.h \
    src/poloniex.h

SOURCES += src/drkjolla.cpp \
    src/tickerhandler.cpp \
    src/bitfinex.cpp \
    src/cryptsy.cpp \
    src/mintpal.cpp \
    src/poloniex.cpp

OTHER_FILES += qml/drkjolla.qml \
    qml/pages/first.qml \
    qml/pages/about.qml \
    qml/cover/cover.qml \
    rpm/drkjolla.changes \
    rpm/drkjolla.spec \
    rpm/drkjolla.yaml \
    drkjolla.desktop \
    drkjolla.png

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
TARGET = drkjolla

CONFIG += sailfishapp

SOURCES += src/drkjolla.cpp \
    src/tickerhandler.cpp \
    src/bitfinex.cpp \
    src/mintpal.cpp \
    src/cryptsy.cpp

OTHER_FILES += qml/drkjolla.qml \
    qml/cover/cover.qml \
    rpm/drkjolla.changes.in \
    rpm/drkjolla.spec \
    rpm/drkjolla.yaml \
    translations/*.ts \
    drkjolla.desktop \
    qml/pages/about.qml \
    qml/pages/first.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/drkjolla-de.ts

HEADERS += \
    src/tickerhandler.h \
    src/bitfinex.h \
    src/mintpal.h \
    src/cryptsy.h

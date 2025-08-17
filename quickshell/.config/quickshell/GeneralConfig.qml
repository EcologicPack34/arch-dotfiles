pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    // an expression can be broken across multiple lines using {}
    property color mainBackgroundColor: "#710b3358"
    property color secondaryBackgroundColor: "#54348afa"

    property color buttonColor1: "#5332af"
    property color buttonColor2: "#8f03c7"

    property color highlight1: "#1eabeeff"

    property color mainTextColor: "#ffffff"
    property color textColor2: "#cbffac"


    property string mainTextFont: "Pixelify Sans"
    property int fontSize1: 14 * uiScale
    property int fontSize2: 20 * uiScale


    property real uiScale: 1
}
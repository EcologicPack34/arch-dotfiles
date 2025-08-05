import QtQuick
import Quickshell
import Quickshell.Io

PopupWindow{
    id: popup;

    default property alias contentChildren: content.data

    property bool open: false;
    property int popAnimDuration: 300

    property int pWitdth: 50
    property int pHeight: 100


    property color pColor: "white"


    anchor.rect.x: 0

    width: pWitdth
    implicitHeight: pHeight
    visible: false
    color: "transparent"

    Rectangle{
        id: content
        width: pWitdth
        height: pHeight
        x:0
        y: -pHeight

        property real yanim: -pHeight


        color: pColor

        PropertyAnimation{
            id: anim
            target:content
            property: "y"
            from: yanim
            to: open ? 0 : -content.height

            duration: popAnimDuration

            easing.type: Easing.OutQuad

        }
        Timer{
            id: animTimer
            interval: anim.duration
            repeat : false
            onTriggered: {
                if (!open){
                    popup.visible = false
                }
            }
        }

        Connections {
            target: popup
            onOpenChanged: {
                if (open){
                    popup.visible = true
                    content.yanim = -content.height
                    anim.duration = popAnimDuration * (-content.y)/pHeight
                    animTimer.interval = anim.duration
                    anim.stop()
                    animTimer.stop()
                    anim.start()
                    animTimer.start()
                }
                else{
                    content.yanim = 0
                    anim.duration = popAnimDuration * (pHeight + content.y)/pHeight
                    animTimer.interval = anim.duration
                    anim.stop()
                    animTimer.stop()
                    anim.start()
                    animTimer.start()
                }
            }
        }
    }


}
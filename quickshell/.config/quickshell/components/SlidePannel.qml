import QtQuick
import Quickshell
import Quickshell.Io

PopupWindow{
    id: popup;

    default property alias contentChildren: content.data

    property bool open: false;
    property int slideAnimDuration: 300

    property int pWitdth: 50
    property int pHeight: 100


    property color pColor: "white"
    property int pRadius: 0

    implicitWidth: pWitdth
    implicitHeight: pHeight
    visible: false
    color: "transparent"

    property bool topSlide: false
    property bool leftSlide: false
    property bool downSlide: false
    property bool rightSlide: false

    property var slideAnimType: Easing.OutQuad

    Rectangle{
        id: content
        width: pWitdth
        height: pHeight
        x:0
        y:0

        property real yPos: 0
        property real xPos: 0

        Component.onCompleted:{
            if(topSlide){
                content.x = 0
                content.y = -pHeight
            }else if(leftSlide){
                content.x = -pWitdth
                content.y = 0
            }else if(downSlide){
                content.x = 0
                content.y = pHeight
            }else if(rightSlide){
                content.x = pWitdth
                content.y = 0
            }else{
                content.x = 0
                content.y = 0
            }
        }

        color: pColor
        radius: pRadius

        PropertyAnimation{
            id: animY
            target:content
            property: "y"
            from: content.yPos
            to: content.yPos

            duration: slideAnimDuration

            easing.type: slideAnimType
        }
        PropertyAnimation{
            id: animX
            target:content
            property: "x"
            from: content.xPos
            to: content.xPos

            duration: slideAnimDuration

            easing.type: slideAnimType
        }

        Timer{
            id: animTimer
            interval: 2
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
                    
                    if(topSlide){
                        content.yPos = content.y;
                        animY.duration = slideAnimDuration * (-content.y)/pHeight

                        animY.from = content.y
                        animY.to = 0

                        animY.stop()
                        animY.start()
                    }else if(leftSlide){
                        content.xPos = content.x;
                        animX.duration = slideAnimDuration * (-content.x)/pWitdth
                        
                        animX.from = content.x
                        animX.to = 0

                        animX.stop()
                        animX.start()
                    }else if(downSlide){
                        content.yPos = content.y;
                        animY.duration = slideAnimDuration * (content.y)/pHeight
                        
                        animY.from = content.y
                        animY.to = 0

                        animY.stop()
                        animY.start()
                    }else if(rightSlide){
                        content.xPos = content.x;
                        animX.duration = slideAnimDuration * (content.x)/pWitdth
                        
                        animX.from = content.x
                        animX.to = 0

                        animX.stop()
                        animX.start()
                    }else{
                        content.x = 0
                        content.y = 0
                    }
                }
                else{
                    if(topSlide){
                        content.yPos = content.y;
                        animY.duration = slideAnimDuration * (pHeight + content.y)/pHeight

                        animY.from = content.y
                        animY.to = -pHeight

                        animTimer.interval = animY.duration

                        animTimer.stop()
                        animTimer.start()

                        animY.stop()
                        animY.start()
                    }else if(leftSlide){
                        content.xPos = content.x;
                        animX.duration = slideAnimDuration * (pWitdth + content.x)/pWitdth
                        
                        animX.from = content.x
                        animX.to = -pWitdth

                        animTimer.interval = animX.duration

                        animTimer.stop()
                        animTimer.start()

                        animX.stop()
                        animX.start()
                    }else if(downSlide){
                        content.yPos = content.y;
                        animY.duration = slideAnimDuration * (pHeight - content.y)/pHeight
                        
                        animY.from = content.y
                        animY.to = pHeight

                        animTimer.interval = animY.duration

                        animTimer.stop()
                        animTimer.start()

                        animY.stop()
                        animY.start()
                    }else if(rightSlide){
                        content.xPos = content.x;
                        animX.duration = slideAnimDuration * (pWitdth - content.x)/pWitdth

                        animTimer.interval = animX.duration

                        animX.from = content.x
                        animX.to = pWitdth

                        animTimer.stop()
                        animTimer.start()

                        animX.stop()
                        animX.start()
                    }else{
                        content.x = 0
                        content.y = 0
                        popup.visible = false
                    }
                }
            }
        }
    }


}
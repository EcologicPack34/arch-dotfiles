import QtQuick
import Quickshell
import Quickshell.Io

Rectangle{

    id: root
    
    property string label: ""
    
    signal clicked()
    signal hoverEnter()
    signal hoverExit()

    property int bWidth : 10
    property int bHeight: 10

    property color hoverColor : "white"
    property color defaultColor: "black"

    property int expandPercentW: 50
    property int expandPercentH: 50

    property real expandDuration: 500


    width: bWidth
    height: bHeight
    color: defaultColor

    transform: Scale{
        id: scaleTransform
        origin.x: root.width / 2
        origin.y: root.height / 2
        xScale: 1
        yScale: 1
    }

    onDefaultColorChanged:{
        color = defaultColor
    }

    MouseArea{
        id: mouseArea

        anchors.fill: parent
        
        hoverEnabled: true

        onEntered:{
            root.color = hoverColor;

            root.hoverEnter()

            widthAnim.stop()
            widthAnim.from = scaleTransform.xScale
            widthAnim.to = 1 + expandPercentW/100
            widthAnim.start()

            heightAnim.stop()
            heightAnim.from = scaleTransform.yScale
            heightAnim.to = 1 + expandPercentH/100
            heightAnim.start()
        }
        onExited:{
            root.color = defaultColor;

            root.hoverExit()

            widthAnim.stop()
            widthAnim.from = scaleTransform.xScale
            widthAnim.to = 1
            widthAnim.start()

            heightAnim.stop()
            heightAnim.from = scaleTransform.yScale
            heightAnim.to = 1
            heightAnim.start()
        }

        onClicked:{
            root.clicked()
        }
    }

    Text{
        id: bText
        text: ""
    }

    PropertyAnimation{
        id: widthAnim
        
        target: scaleTransform
        property: "xScale"
        
        from: 0
        to: 0

        duration: expandDuration

        easing.type: Easing.OutCubic
    }
    PropertyAnimation{
        id: heightAnim
        
        target: scaleTransform
        property: "yScale"
        
        from: 0
        to: 0

        duration: expandDuration

        easing.type: Easing.OutCubic
    }


}
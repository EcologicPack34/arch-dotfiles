import QtQuick
import QtQuick.Shapes

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

import "../../Services"
import "../../components"
import "../widgets"
import "../.."

Scope{
    id: bar

    readonly property int barHeight: 30 * GeneralConfig.uiScale
    readonly property int barWidth: 600 * GeneralConfig.uiScale

    readonly property int barRadius: 10 * GeneralConfig.uiScale

    Variants{
        model: Quickshell.screens;
        PanelWindow{
            id: barRoot;
            screen: modelData
            
            color: "transparent"
            

            anchors{
                top: true;
            }

            implicitHeight : (barHeight)
            implicitWidth: barWidth
            exclusiveZone: barHeight

            margins {
                top: 0;
                left: 2;
                right : 2
            }
            //bar fill
            Shape {
                id: barFill
                anchors.fill: parent

                ShapePath {
                    strokeWidth: 0
                    fillColor: "#710b3358"

                    
                    pathElements: [
                        PathMove { x: 0; y: 0 },                        // Start at top-left corner (sharp)
                        PathLine { x: width; y: 0 },                    // top-right corner (sharp)
                        PathLine { x: width; y: height - barRadius },          // down right edge, minus bottom corner radius
                        PathQuad { x: width - barRadius; y: height; controlX: width; controlY: height },  // bottom-right rounded corner
                        PathLine { x: barRadius; y: height },                   // line to bottom-left corner, offset by radius
                        PathQuad { x: 0; y: height - barRadius; controlX: 0; controlY: height },         // bottom-left rounded corner
                        PathLine { x: 0; y: 0 }                         // back to start
                    ]
                }
            }
            //workspaces
            Row{
                id: workspacesRow

                anchors.centerIn: parent
                spacing: 8 * GeneralConfig.uiScale;

                Repeater{
                    model: Hyprland.workspaces

                    delegate: CustomButton{
                        bWidth: 20 * GeneralConfig.uiScale
                        bHeight: 20 * GeneralConfig.uiScale
                
                        radius: 5 * GeneralConfig.uiScale

                        expandPercentH: 30
                        expandPercentW: 30
                        expandDuration: 200

                        defaultColor: modelData.active ? "#9f0077ff" : "#a10c414b"
                        hoverColor: "#293994"

                        onClicked:{
                            if(modelData.id > 0)
                                Hyprland.dispatch("workspace " + modelData.id)
                            else{
                                Hyprland.dispatch("togglespecialworkspace magic")
                            }
                        }

                        Text{
                            text: modelData.id > 0 ? modelData.id : ""
                            
                            anchors.centerIn: parent
                            verticalAlignment: Text.AlignVCenter

                            color: modelData.active ? "#ffffff" : "#cccccc"
                            font.pixelSize: GeneralConfig.fontSize1
                            font.family: GeneralConfig.mainTextFont
                        }
                        Text{
                            visible: Hyprland.workspaces.length === 0
                            text: "No Workspaces"
                            color: "#ffffff"
                            font.pixelSize: GeneralConfig.fontSize1
                            font.family: GeneralConfig.mainTextFont
                        }
                    }
                }
            }

            //time display
            CustomButton{
                id: timeDisplay
                
                y: 5
                bWidth: 60 * GeneralConfig.uiScale
                bHeight: 20 * GeneralConfig.uiScale
                
                expandPercentH: 10
                expandPercentW: 10
                expandDuration: 100

                defaultColor: "transparent"
                hoverColor: "#1eabeeff"

                radius: 5 * GeneralConfig.uiScale

                anchors.verticalCenter: parent.verticalCenter
                anchors{
                        right: parent.right
                        rightMargin: 16 * GeneralConfig.uiScale
                }

                onClicked:{
                    timeCalendar.open = !timeCalendar.open
                }

                Text{
                    id: timeText

                    anchors.centerIn: parent
                    verticalAlignment: Text.AlignVCenter

                    width: 50 * GeneralConfig.uiScale

                    text: Time.time
                    font.family: GeneralConfig.mainTextFont
                    color: GeneralConfig.mainTextColor
                    font.pixelSize: GeneralConfig.fontSize1
                }
            }
            SlidePannel{
                id: timeCalendar
                
                pWitdth: 200 * GeneralConfig.uiScale
                pHeight: 200 * GeneralConfig.uiScale
                
                slideAnimDuration: 300
                slideAnimType: Easing.OutQuad

                anchor.rect.y: barHeight
                anchor.rect.x: timeDisplay.x - 125 * GeneralConfig.uiScale
                anchor.window: barRoot

                topSlide: true

                pColor: "transparent"

                Calendar{
                    width: timeCalendar.pWitdth
                    height: timeCalendar.pHeight

                    color: GeneralConfig.secondaryBackgroundColor
                    radius: 10 * GeneralConfig.uiScale

                    titleColor: "#ffffff"
                    tileColor: "#63ffffff"
                    tileTextColor: "#000000"
                    currentDayColor: "#b75356ff"
                }
            }
            
            //PowerMenu Trigger
            CustomButton{
                id: powerButton
                bWidth: 20 * GeneralConfig.uiScale
                bHeight: 20 * GeneralConfig.uiScale
                
                radius: 20 * GeneralConfig.uiScale

                expandPercentH: 30
                expandPercentW: 30
                expandDuration: 200

                defaultColor: "#5332af"
                hoverColor: "#8f03c7"

                anchors{
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 15
                }

                onClicked: {
                    powerPannel.open = !powerPannel.open
                }

                Text{
                    id: icon

                    color: "#cbffac"

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "󰣇"//arch icon
                    font.pointSize: GeneralConfig.fontSize1
                                
                    y:-2
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            //PowerMenu
            SlidePannel{
                id: powerPannel
                anchor.rect.y: barHeight
                anchor.window: barRoot
                pHeight: (30 * 3 + 40) * GeneralConfig.uiScale
                pWitdth: 50 * GeneralConfig.uiScale
                pRadius: 10 * GeneralConfig.uiScale
                pColor: GeneralConfig.secondaryBackgroundColor
                
                topSlide: true

                Column{
                    id: buttonColumn
                    anchors.fill: parent
                    spacing: 10 * GeneralConfig.uiScale
                    padding: 10 * GeneralConfig.uiScale

                    Repeater{
                        model: [
                            { label: "Power Off",
                              icon: "⏻" },
                            { label: "Reboot",
                                icon: ""},
                            { label: "Suspend",
                                icon: "" },
                        ]

                        delegate: CustomButton{
                            label: modelData.label

                            bWidth: 30 * GeneralConfig.uiScale
                            bHeight: 30 * GeneralConfig.uiScale
                            radius: 30 * GeneralConfig.uiScale

                            defaultColor: "#2fe0b4"
                            hoverColor: "#db2f63"
                            
                            expandDuration: 200
                            expandPercentH: 20
                            expandPercentW: 20

                            anchors.horizontalCenter: parent.horizontalCenter

                            onClicked: {
                                switch (index){
                                    case 0: SystemProcess.doPoweroff();break;
                                    case 1: SystemProcess.doReboot();break;
                                    case 2: SystemProcess.doSuspend();break;
                                }
                            }
                            Text{
                                anchors.centerIn: parent
                                text: modelData.icon
                                font.pointSize: 20
                                font.pixelSize: GeneralConfig.fontSize2

                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }


            }
            
            //volume
            CustomButton{
                id: volumeButton
                bWidth: 20 * GeneralConfig.uiScale
                
                bHeight: 20 * GeneralConfig.uiScale
                
                radius: 20 

                expandPercentH: 30
                expandPercentW: 30
                expandDuration: 200

                defaultColor: "#5332af"
                hoverColor: "#8f03c7"

                anchors{
                    right: timeDisplay.left
                    verticalCenter: parent.verticalCenter
                    rightMargin: 10
                }

                onClicked: {
                    volumePannel.open = !volumePannel.open
                }

                Text{
                    id: volumeIcon

                    color: "#cbffac"

                    anchors.horizontalCenter: parent.horizontalCenter
                    text: ""//arch icon
                    font.pointSize: GeneralConfig.fontSize1
                                
                    y:(parent.height - paintedHeight) / 2
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            SlidePannel{
                id: volumePannel
                anchor.rect.y: barHeight
                anchor.rect.x: volumeButton.x - 15
                anchor.window: barRoot
                pHeight: 220
                pWitdth: 280
                pColor: "#86474747"

                topSlide: true
            }


        }
    }

}

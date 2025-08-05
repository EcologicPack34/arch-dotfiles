import QtQuick
import QtQuick.Shapes

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

import "../../Services"
import "../widgets"

Scope{
    id: bar

    readonly property int barHeight: 30
    readonly property int barWidth: 600

    readonly property int barRadius: 10

    Variants{
        model: Quickshell.screens;
        PanelWindow{
            id: barRoot;
            screen: modelData
            
            color: "transparent"
            

            anchors{
                top: true;
            }

            implicitHeight : barHeight
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
                spacing: 8;

                Repeater{
                    model: Hyprland.workspaces

                    delegate: CustomButton{
                        bWidth: 20
                        bHeight: 20
                
                        radius: 5

                        expandPercentH: 35
                        expandPercentW: 35
                        expandDuration: 200

                        defaultColor: modelData.active ? "#9f0077ff" : "#a10c414b"
                        hoverColor: "#293994"

                        onClicked: Hyprland.dispatch("workspace " + modelData.id)

                        Text{
                            text: modelData.id
                            
                            anchors.horizontalCenter: parent.horizontalCenter
                            y: -1

                            color: modelData.active ? "#ffffff" : "#cccccc"
                            font.pixelSize: 12
                            font.family: "OpenDyslexic Nerd Font"
                        }
                        Text{
                            visible: Hyprland.workspaces.length === 0
                            text: "No Workspaces"
                            color: "#ffffff"
                            font.pixelSize: 12
                        }
                    }
                }
            }

            //time display
            Text{
                id: timeDisplay
                anchors{
                    right: parent.right
                    rightMargin: 16
                }
                y: 5
                width: 50

                text: Time.time
                font.family: "OpenDyslexic Nerd Font"
                color: "#ffffff"
            }
            
            //PowerMenu Trigger
            CustomButton{
                id: powerButton
                bWidth: 20
                bHeight: 20
                
                radius: 20

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
                    font.pointSize: 15
                                
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
                pHeight: 30 * 3 + 40
                pWitdth: 50
                pRadius: 10
                pColor: "#54348afa"
                
                Column{
                    id: buttonColumn
                    anchors.fill: parent
                    spacing: 10
                    padding: 10

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

                            bWidth: 30
                            bHeight: 30
                            radius: 30

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
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: modelData.icon
                                font.pointSize: 20
                                
                                y:-1
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }
                }


            }
            

            CustomButton{
                id: volumeButton
                bWidth: 20
                
                bHeight: 20
                
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
                    font.pointSize: 15
                                
                    y:-2
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }
            SlidePannel{
                id: volumePannel
                anchor.rect.y: barHeight
                anchor.rect.x: volumeButton.x - 15
                anchor.window: barRoot
                pHeight: 30 * 3 + 40
                pWitdth: 50
                pColor: "#86474747"
            }


        }
    }

}

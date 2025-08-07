import QtQuick
import QtQuick.Controls

import "../../components"

Rectangle {
    id: root
    width: 300
    height: 300
    color: "#f0f0f0"

    property color titleColor: "white"
    property color tileTextColor: "black"
    property color tileColor: "white"
    property color currentDayColor: "transparent"

    property int currentYear: new Date().getFullYear()
    property int currentMonth: new Date().getMonth()  // 0 = January
    property int currentDay: new Date().getDate()

    Column {
        anchors.centerIn: parent
        spacing: root.height/32

        // Month and Year Label
        Text {
            text: Qt.formatDate(new Date(currentYear, currentMonth), "MMMM yyyy")
            font.pixelSize: 20
            font.family: "OpenDyslexic Nerd Font"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            color: titleColor
        }

        // Day Names Row
        Row {
            spacing: 5
            Repeater {
                model: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat","Sun"]
                delegate: Text {
                    text: modelData
                    font.pixelSize: 14
                    width: root.width / 9
                    horizontalAlignment: Text.AlignHCenter
                    color: titleColor
                }
            }
        }

        // Calendar Grid
        Grid {
            id: calendarGrid
            columns: 7
            spacing: 5

            property int daysInMonth: new Date(currentYear, currentMonth + 1, 0).getDate()
            property int startDay: new Date(currentYear, currentMonth, 0).getDay()

            Repeater {
                model: calendarGrid.daysInMonth + calendarGrid.startDay

                delegate: CustomButton{
                    bWidth: root.width / 9
                    bHeight: (root.height - root.height/4) / 7
                    
                    defaultColor: index < calendarGrid.startDay ? "transparent" : ( index === (currentDay + calendarGrid.startDay) ? currentDayColor :tileColor)
                    hoverColor: index < calendarGrid.startDay ? "transparent" : ( index === (currentDay + calendarGrid.startDay) ? currentDayColor :tileColor)
                    border.color: "lightgray"
                    radius: 5

                    bEnabled: index >= calendarGrid.startDay
                    
                    Text {
                        anchors.centerIn: parent
                        text: index < calendarGrid.startDay ? "" : index - calendarGrid.startDay + 1
                        font.pixelSize: 12
                        font.family: "OpenDyslexic Nerd Font"
                        color: tileTextColor
                    }
                }

                // delegate: Rectangle {
                //     width: root.width / 9; height: (root.height - root.height/4) / 7
                    
                //     color: index < calendarGrid.startDay ? "transparent" : ( index === (currentDay + calendarGrid.startDay) ? currentDayColor :tileColor)
                    
                //     border.color: "lightgray"

                //     radius: 5

                //     Text {
                //         anchors.centerIn: parent
                //         text: index < calendarGrid.startDay ? "" : index - calendarGrid.startDay + 1
                //         font.pixelSize: 12
                //         font.family: "OpenDyslexic Nerd Font"
                //         color: tileTextColor
                //     }
                // }
            }
        }
    }
}
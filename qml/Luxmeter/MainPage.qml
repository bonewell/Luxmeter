import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.sensors 1.2

Page {
    id: meter
    //tools: commonTools

    LightSensor {
        id: lightSensor
        active: true

        onReadingChanged: {
            light.text = reading.lux;
        }
    }

    Rectangle {
        id: background
        radius: 20
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#c8c8c8"
            }

            GradientStop {
                position: 1
                color: "#646464"
            }
        }
        border.width: 20
        border.color: "#969696"
        z: -1
        anchors.fill: parent
    }

    Rectangle {
        id: display
        height: 160
        radius: 5
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#646464"
            }

            GradientStop {
                position: 1
                color: "#323232"
            }
        }
        border.color: "#333333"
        border.width: 5
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: sensor.bottom
        anchors.topMargin: 20

        Text {
            id: light
            color: "#c00000"
            text: "0"
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            anchors.fill: parent
            font.family: "Impact"
            font.pixelSize: 130
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignTop
            z: 1
            style: Text.Normal
            font.bold: true
    }

    Text {
        id: hold
        x: 286
        color: "#c00000"
        text: qsTr("HOLD")
        font.pixelSize: 16
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.family: "Arial Black"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignRight
    }
    }

    Rectangle {
        id: sensor
        width: 160
        height: 160
        radius: 20
        anchors.horizontalCenter: parent.horizontalCenter
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#ffffff"
            }

            GradientStop {
                position: 1
                color: "#c8c8c8"
            }
        }
        anchors.top: parent.top
        anchors.topMargin: 30
        border.width: 15
        border.color: "#555555"
    }

    Rectangle {
        id: logo
        x: 0
        y: 220
        width: 160
        height: 50
        radius: 3
        border.width: 3
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#c8c8c8"
            }

            GradientStop {
                position: 1
                color: "#646464"
            }
        }
        border.color: "#646464"
        anchors.rightMargin: 80
        anchors.leftMargin: 80
        anchors.topMargin: 15
        anchors.top: display.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        Text {
            id: lux
            color: "#646464"
            text: "LUX"
            anchors.fill: parent
            font.family: "Arial"
            styleColor: "#323232"
            style: Text.Outline
            font.bold: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 50
    }
    }

}

import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.sensors 1.2
import Torch 1.2

Page {
    id: meter
    smooth: true
    orientationLock: PageOrientation.LockPortrait

    Torch {
        id: torch
        automated: false
        bound: 200

        onAutomatedChanged: {
            iautotorch.visible = automated;
            if (automated)
                bound = light.text;
            else
                stop();
        }
    }

    LightSensor {
        id: lightSensor
        active: true

        onReadingChanged: {
            if (!ihold.visible)
                light.text = reading.lux;
            if (!torch.automated) return;
            if (reading.lux < torch.bound)
                torch.start();
            else
                torch.stop();
        }
    }

    Rectangle {
        id: background
        radius: 20
        smooth: true
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
        smooth: true
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
            smooth: true
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
        id: ihold
        x: 286
        color: "#c00000"
        text: "HOLD"
        visible: false
        smooth: true
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.family: "Arial Black"
        font.bold: true
        verticalAlignment: Text.AlignBottom
        horizontalAlignment: Text.AlignRight
    }

    Text {
        id: iautotorch
        x: 278
        y: 9
        color: "#c00000"
        text: "AT"
        smooth: true
        font.pixelSize: 20
        anchors.top: parent.top
        anchors.topMargin: 5
        visible: false
        anchors.rightMargin: 10
        font.family: "Arial Black"
        font.bold: true
        anchors.right: ihold.left
        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignBottom
    }
    }

    Rectangle {
        id: sensor
        width: 160
        height: 160
        radius: 20
        smooth: true
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
        width: 120
        height: 50
        radius: 3
        smooth: true
        anchors.horizontalCenter: parent.horizontalCenter
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
        anchors.topMargin: 15
        anchors.top: display.bottom

        Text {
            id: lux
            color: "#646464"
            text: "LUX"
            smooth: true
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

    Rectangle {
        id: hold
        x: 20
        y: 458
        height: 70
        radius: 20
        smooth: true
        gradient: generalButton
        border.width: 3
        border.color: "#787878"
        anchors.top: line.bottom
        anchors.topMargin: 10
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.left: parent.left
        anchors.right: parent.right

        Text {
            id: thold
            color: "#323232"
            text: "HOLD"
            font.pixelSize: 30
            smooth: true
            styleColor: "#8c8c8c"
            style: Text.Raised
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.NoWrap
            anchors.fill: parent
        }

        MouseArea {
            id: mhold
            anchors.fill: parent

            onClicked: {
                ihold.visible = !ihold.visible;
                hold.gradient = generalButton;
            }
            onPressed: {
                hold.gradient = pressedButton;
            }
        }
    }

    Rectangle {
        id: line
        height: 3
        color: "#969696"
        radius: 1
        smooth: true
        anchors.top: logo.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 50
    }

    Rectangle {
        id: autotorch
        x: 29
        y: 457
        height: 70
        radius: 20
        smooth: true
        anchors.top: hold.bottom
        border.color: "#787878"
        anchors.topMargin: 20
        Text {
            id: tautotorch
            color: "#323232"
            text: "AUTO TORCH"
            smooth: true
            font.pixelSize: 30
            anchors.fill: parent
            style: Text.Raised
            wrapMode: Text.NoWrap
            styleColor: "#8c8c8c"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            id: mautotorch
            anchors.fill: parent

            onClicked: {
                torch.automated = !torch.automated;
                autotorch.gradient = generalButton;
            }
            onPressed: {
                autotorch.gradient = pressedButton;
            }
        }
        anchors.rightMargin: 20
        border.width: 3
        anchors.right: parent.right
        anchors.leftMargin: 20
        gradient: generalButton
        anchors.left: parent.left
    }
    Gradient {
        id: generalButton
        GradientStop {
            position: 0
            color: "#cfcfcf"
        }

        GradientStop {
            position: 1
            color: "#404040"
        }
    }
    Gradient {
        id: pressedButton
        GradientStop {
            position: 0
            color: "#c8c8c8"
        }

        GradientStop {
            position: 1
            color: "#646464"
        }
    }
}

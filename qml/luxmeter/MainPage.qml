import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.sensors 1.2
import Torch 1.2
import Memory 1.1

Page {
    id: meter
    width: 480
    height: 854
    smooth: true
    orientationLock: PageOrientation.LockPortrait

    FontLoader {
        id: dsDigital
        source: "DS-Digital-Italic.ttf"
    }

    Torch {
        id: torch
        automated: false
        bound: 200

        onAutomatedChanged: {
            iautotorch.visible = automated;
            if (automated)
                bound = memory.cur;
            else
                stop();
        }
    }

    Memory {
        id: memory
        type: Memory.LX
        cur: NaN

        onTypeChanged: {
            switch (memory.type) {
            case Memory.LX: {
                ilx.visible = true;
                ifc.visible = false;
            } break;
            case Memory.FC: {
                ilx.visible = false;
                ifc.visible = true;
            } break;
            }
        }

        onCurChanged: {
            ilight.text = hold ? visible : cur;

            if (!torch.automated) return;
            if (cur < torch.bound)
                torch.start();
            else
                torch.stop();
        }

        onMinChanged: {
            iminvalue.text = min;
        }

        onMaxChanged: {
            imaxvalue.text = max;
        }

        onHoldChanged: {
            ihold.visible = hold;
            ilight.text = visible;
        }
    }

    LightSensor {
        id: luxmeter
        active: true

        onReadingChanged: {
            memory.cur = reading.lux;
        }
    }

    Rectangle {
        id: background
        x: 0
        y: 0
        color: "#5a5a5a"
        radius: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        smooth: true
        z: -1
        anchors.fill: parent
    }

    Rectangle {
        id: display
        x: 25
        y: 263
        width: 431
        height: 203
        color: "#00000000"
        radius: 0
        border.width: 2
        border.color: "#000000"
        z: 1
        smooth: true
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.top: sensor.bottom
        anchors.topMargin: 20

        Text {
            id: ilight
            x: 6
            y: 22
            color: "#1e1e1e"
            text: "130100"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            smooth: true
            anchors.rightMargin: 14
            anchors.bottomMargin: 0
            font.family: "DS-Digital"
            font.pixelSize: 130
            horizontalAlignment: Text.AlignRight
            z: 1
    }

    Text {
        id: ihold
        y: 15
        color: "#1e1e1e"
        text: "HOLD"
        wrapMode: Text.NoWrap
        anchors.left: parent.left
        anchors.leftMargin: 11
        styleColor: "#323232"
        visible: false
        smooth: true
        font.pixelSize: 35
        anchors.top: parent.top
        anchors.topMargin: 15
        font.family: "DS-Digital"
        horizontalAlignment: Text.AlignRight
    }

    Text {
        id: iautotorch
        x: 11
        y: 51
        color: "#1e1e1e"
        text: "AT"
        anchors.left: parent.left
        anchors.leftMargin: 11
        smooth: true
        font.pixelSize: 35
        anchors.top: ihold.bottom
        anchors.topMargin: 0
        visible: false
        font.family: "DS-Digital"
        horizontalAlignment: Text.AlignRight
    }

    Text {
        id: imax
        x: 365
        color: "#1e1e1e"
        text: qsTr("MAX")
        anchors.top: parent.top
        anchors.topMargin: 15
        anchors.right: parent.right
        anchors.rightMargin: 14
        font.family: "DS-Digital"
        smooth: true
        font.pixelSize: 35
    }

    Text {
        id: imin
        x: 372
        y: 51
        color: "#1e1e1e"
        text: qsTr("MIN")
        anchors.top: imax.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 14
        font.family: "DS-Digital"
        smooth: true
        font.pixelSize: 35
    }

    Text {
        id: ilx
        y: 148
        color: "#1e1e1e"
        text: qsTr("LX")
        smooth: true
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 19
        anchors.left: parent.left
        anchors.leftMargin: 11
        font.family: "DS-Digital"
        font.pixelSize: 35
    }

    Text {
        id: ifc
        x: 11
        y: 112
        color: "#1e1e1e"
        text: qsTr("FC")
        smooth: true
        visible: false
        anchors.bottom: ilx.top
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 11
        font.family: "DS-Digital"
        font.pixelSize: 35
    }

    Text {
        id: imaxvalue
        x: 251
        color: "#1e1e1e"
        text: qsTr("135000")
        smooth: true
        anchors.right: imax.left
        anchors.rightMargin: 19
        anchors.top: parent.top
        anchors.topMargin: 15
        horizontalAlignment: Text.AlignRight
        font.family: "DS-Digital"
        font.pixelSize: 35
    }

    Text {
        id: iminvalue
        x: 318
        y: 51
        color: "#1e1e1e"
        text: qsTr("10")
        smooth: true
        anchors.top: imaxvalue.bottom
        anchors.topMargin: 0
        anchors.right: imin.left
        anchors.rightMargin: 27
        font.family: "DS-Digital"
        horizontalAlignment: Text.AlignRight
        font.pixelSize: 35
    }

    Image {
        id: screen
        width: 431
        height: 203
        smooth: true
        z: -1
        source: "screen.png"
    }
    }

    Rectangle {
        id: keyHold
        height: 90
        radius: 10
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.right: parent.right
        anchors.rightMargin: 25
        smooth: true
        gradient: generalButton
        border.width: 2
        border.color: "#1e1e1e"
        anchors.top: keyLxfc.bottom
        anchors.topMargin: 20

        Text {
            id: thold
            color: "#1e1e1e"
            text: "HOLD"
            style: Text.Sunken
            font.family: "Monospace"
            z: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 40
            smooth: true
            styleColor: "#969696"
            wrapMode: Text.NoWrap
        }

        MouseArea {
            id: mhold
            hoverEnabled: false
            enabled: true
            anchors.fill: parent

            onClicked: {
                memory.hold = !memory.hold;
                keyHold.gradient = generalButton;
            }
            onPressed: {
                keyHold.gradient = pressedButton;
            }
        }
    }

    Rectangle {
        id: keyAutotorch
        x: 20
        y: 634
        height: 90
        radius: 10
        smooth: true
        anchors.top: keyHold.bottom
        border.color: "#1e1e1e"
        anchors.topMargin: 20
        Text {
            id: tautotorch
            color: "#1e1e1e"
            text: "AUTO TORCH"
            font.family: "Monospace"
            z: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            smooth: true
            font.pixelSize: 40
            style: Text.Sunken
            wrapMode: Text.NoWrap
            styleColor: "#969696"
        }

        MouseArea {
            id: mautotorch
            anchors.fill: parent

            onClicked: {
                torch.automated = !torch.automated;
                keyAutotorch.gradient = generalButton;
            }
            onPressed: {
                keyAutotorch.gradient = pressedButton;
            }
        }
        anchors.rightMargin: 25
        border.width: 2
        anchors.right: parent.right
        anchors.leftMargin: 25
        gradient: generalButton
        anchors.left: parent.left
    }

    Image {
        id: sensor
        x: 251
        width: 205
        height: 205
        smooth: true
        rotation: 50
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 25
        source: "sensor.png"
    }

    Image {
        id: lux
        width: 189
        height: 101
        smooth: true
        anchors.top: parent.top
        anchors.topMargin: 75
        anchors.left: parent.left
        anchors.leftMargin: 25
        source: "lux.png"
    }

    Rectangle {
        id: topline
        y: 55
        height: 3
        radius: 0
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#000000"
            }

            GradientStop {
                position: 1
                color: "#ffffff"
            }
        }
        smooth: true
        anchors.bottom: lux.top
        anchors.bottomMargin: 24
        anchors.right: parent.right
        anchors.rightMargin: 210
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    Rectangle {
        id: bottomline
        height: 3
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#000000"
            }

            GradientStop {
                position: 1
                color: "#ffffff"
            }
        }
        smooth: true
        anchors.top: lux.bottom
        anchors.topMargin: 23
        anchors.right: parent.right
        anchors.rightMargin: 210
        anchors.left: parent.left
        anchors.leftMargin: 20
    }

    Gradient {
        id: generalButton

        GradientStop {
            position: 1
            color: "#cfcfcf"
        }

        GradientStop {
            position: 0.8
            color: "#404040"
        }

        GradientStop {
            position: 0
            color: "#101010"
        }

        GradientStop {
            position: 0.2
            color: "#404040"
        }
    }

    Gradient {
        id: pressedButton

        GradientStop {
            position: 0.9
            color: "#808080"
        }

        GradientStop {
            position: 0.8
            color: "#404040"
        }

        GradientStop {
            position: 0
            color: "#000000"
        }

        GradientStop {
            position: 1
            color: "#000000"
        }

        GradientStop {
            position: 0.2
            color: "#404040"
        }
    }

    Rectangle {
        id: keyLxfc
        width: 200
        height: 90
        color: "#ffffff"
        radius: 10
        smooth: true
        border.width: 2
        border.color: "#000000"
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.top: display.bottom
        anchors.topMargin: 20
        gradient: generalButton

        MouseArea {
            id: mlxfc
            anchors.fill: parent

            onClicked: {
                switch (memory.type) {
                case Memory.LX: memory.type = Memory.FC; break;
                case Memory.FC: memory.type = Memory.LX; break;
                }
                keyLxfc.gradient = generalButton;
            }
            onPressed: {
                keyLxfc.gradient = pressedButton;
            }
        }

        Text {
            id: tlxfc
            x: 40
            y: 21
            color: "#1e1e1e"
            text: qsTr("LX/FC")
            smooth: true
            anchors.verticalCenterOffset: 0
            anchors.horizontalCenterOffset: 0
            style: Text.Sunken
            styleColor: "#969696"
            font.family: "Monospace"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 40
        }
    }

    Rectangle {
        id: keyReset
        y: 570
        height: 90
        color: "#ffffff"
        radius: 10
        smooth: true
        border.width: 2
        border.color: "#000000"
        anchors.right: parent.right
        anchors.rightMargin: 25
        anchors.left: keyLxfc.right
        anchors.leftMargin: 25
        anchors.top: display.bottom
        anchors.topMargin: 20
        gradient: generalButton

        MouseArea {
            id: mreset
            anchors.fill: parent

            onClicked: {
                memory.reset();
                torch.automated = false;
                keyReset.gradient = generalButton;
            }
            onPressed: {
                keyReset.gradient = pressedButton;
            }
        }

        Text {
            id: treset
            x: 125
            y: 53
            color: "#1e1e1e"
            text: qsTr("RESET")
            smooth: true
            styleColor: "#969696"
            style: Text.Sunken
            font.family: "Monospace"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 40
        }
    }


}

import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.sensors 1.2

Page {
    tools: commonTools

    Label {
        id: light
        anchors.centerIn: parent
        text: qsTr("Hello world!")
        visible: true
    }

    LightSensor {
        id: lightSensor
        active: true

        onReadingChanged: {
            light.text = reading.lux;
        }
    }
}

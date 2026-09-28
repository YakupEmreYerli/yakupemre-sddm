// yakupemre-sddm: three round glass power buttons, labels on hover.
import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

RowLayout {
    spacing: root.font.pointSize * 1.6
    property ComboBox exposedSession

    Repeater {
        model: [
            ["sys-shutdown", config.TranslateShutdown || textConstants.shutdown],
            ["sys-reboot", config.TranslateReboot || textConstants.reboot],
            ["sys-suspend", config.TranslateSuspend || textConstants.suspend]
        ]

        RoundButton {
            id: btn
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.topMargin: root.font.pointSize * 4
            implicitWidth: root.font.pointSize * 4
            implicitHeight: implicitWidth
            display: AbstractButton.IconOnly
            icon.source: Qt.resolvedUrl("../Assets/" + modelData[0] + ".svg")
            icon.width: root.font.pointSize * 2.1
            icon.height: root.font.pointSize * 2.1
            icon.color: "#e6ecfa"
            hoverEnabled: true
            ToolTip.visible: hovered
            ToolTip.delay: 300
            ToolTip.text: modelData[1]

            background: Rectangle {
                radius: width / 2
                color: btn.down ? Qt.rgba(1, 1, 1, 0.22) : btn.hovered || btn.activeFocus ? Qt.rgba(1, 1, 1, 0.16) : Qt.rgba(1, 1, 1, 0.07)
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, btn.hovered ? 0.35 : 0.14)
                Behavior on color { ColorAnimation { duration: 150 } }
            }

            Keys.onReturnPressed: clicked()
            onClicked: index == 0 ? sddm.powerOff() : index == 1 ? sddm.reboot() : sddm.suspend()
        }
    }
}

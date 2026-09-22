import QtQuick
import QtQuick.Layouts

import qs.config
import qs.modules.components

Item {
    id: root

    signal networkRequested
    signal bluetoothRequested

    implicitWidth: 400
    implicitHeight: contentColumn.implicitHeight

    ColumnLayout {
        id: contentColumn
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: Config.spacingM

        RowLayout {
            spacing: Config.spacingM

            Network {
                onActivated: root.networkRequested()
            }
            Bluetooth {
                onActivated: root.bluetoothRequested()
            }
        }

        // TODO: test on a laptop
        Brightness {}
        Volume {}
    }
}

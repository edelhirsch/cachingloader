import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Caching loader vs. normal loader")

    Rectangle {
        id: normalLoaderButton
        anchors.left: root.left
        anchors.top: root.top
        width: root.width / 2
        height: root.height / 2
        Text {
            text: "keep clicking to benchmark normal loader"
            anchors.centerIn: parent
        }
    }

    MouseArea {
        anchors.fill: normalLoaderButton
        onClicked: {
            console.time("loading object with normal loader");
            if(normalLoader.source == "" || normalLoader.source == "qrc:/BigFile2.qml") {
                normalLoader.source = "qrc:/BigFile1.qml";
            } else {
                normalLoader.source = "qrc:/BigFile2.qml";
            }
            console.timeEnd("loading object with normal loader");
        }
    }

    Loader {
        id: normalLoader
        anchors.left: root.left
        anchors.top: normalLoaderButton.bottom
        width: root.width / 2
        height: root.height / 2
    }


    Rectangle {
        id: cachingLoaderButton
        anchors.left: normalLoaderButton.right
        anchors.top: root.top
        width: root.width / 2
        height: root.height / 2
        Text {
            text: "keep clicking to benchmark caching loader"
            anchors.centerIn: parent
        }
    }

    MouseArea {
        anchors.fill: cachingLoaderButton
        onClicked: {
            console.time("loading object with caching loader");
            if(cachingLoader.source == "" || cachingLoader.source == "qrc:/BigFile2.qml") {
                cachingLoader.source = "qrc:/BigFile1.qml";
            } else {
                cachingLoader.source = "qrc:/BigFile2.qml";
            }
            console.timeEnd("loading object with caching loader");
        }
    }

    CachingLoader {
        id: cachingLoader
        anchors.left: normalLoader.right
        anchors.top: normalLoaderButton.bottom
        width: root.width / 2
        height: root.height / 2
    }


    Shortcut {
        sequence: "Ctrl+q"
        onActivated: Qt.quit()
    }
}

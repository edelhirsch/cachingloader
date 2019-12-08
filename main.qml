import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    visible: true
    width: 960
    height: 480
    title: qsTr("Caching loader vs. normal loader")

    // normal Loader
    Rectangle {
        id: normalLoaderButton
        anchors.left: root.left
        anchors.top: root.top
        width: root.width / 3
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
        width: root.width / 3
        height: root.height / 2
    }


    // normal Loader with sourceComponent
    Rectangle {
        id: normalComponentLoaderButton
        anchors.left: normalLoaderButton.right
        anchors.top: root.top
        width: root.width / 3
        height: root.height / 2
        Text {
            text: "keep clicking to benchmark\nnormal loader with Component"
            anchors.centerIn: parent
        }
    }

    MouseArea {
        anchors.fill: normalComponentLoaderButton
        onClicked: {
            console.time("loading object with normal Component loader");
            if(normalComponentLoader.sourceComponent == undefined || normalComponentLoader.sourceComponent === bigComponent2) {
                normalComponentLoader.sourceComponent = bigComponent1;
            } else {
                normalComponentLoader.sourceComponent = bigComponent2;
            }
            console.timeEnd("loading object with normal Component loader");
        }
    }

    Loader {
        id: normalComponentLoader
        anchors.left: normalLoader.right
        anchors.top: normalComponentLoaderButton.bottom
        width: root.width / 3
        height: root.height / 2
    }

    Component {
        id: bigComponent1

        Rectangle {
            width: parent.width
            height: parent.height

            Image {
                anchors.centerIn: parent
                source: "deer1.jpg"
                width: parent.width
                height: parent.height
            }
        }
    }

    Component {
        id: bigComponent2

        Rectangle {
            width: parent.width
            height: parent.height

            Image {
                anchors.centerIn: parent
                source: "deer2.jpg"
                width: parent.width
                height: parent.height
            }
        }
    }


    // caching Loader
    Rectangle {
        id: cachingLoaderButton
        anchors.left: normalComponentLoaderButton.right
        anchors.top: root.top
        width: root.width / 3
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
        anchors.left: normalComponentLoader.right
        anchors.top: cachingLoaderButton.bottom
        width: root.width / 3
        height: root.height / 2
    }


    Shortcut {
        sequence: "Ctrl+q"
        onActivated: Qt.quit()
    }
}

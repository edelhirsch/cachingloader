import QtQuick 2.0

Item {
    id: root
    property var cachedPages: []
    property string source: ""
    property string oldSource: ""

    onSourceChanged: {
        if(oldSource !== "") {
            cachedPages[oldSource].visible = false;
            cachedPages[oldSource].enabled = false;
        }

        if(source in cachedPages) {
            console.log(source + " found in cache, reusing it");
            var cachedPage = cachedPages[source];
            cachedPage.enabled = true;
            cachedPage.visible = true;
        } else {
            console.log(source + " not found in cache, creating it");
            var component = Qt.createComponent(source);
            var page = component.createObject(root, {});
            component.destroy();
            cachedPages[source] = page;
        }

        oldSource = source;
    }

    Component.onDestruction: {
        for(var page in cachedPages) {
            cachedPages[page].destroy();
        }
    }
}

/******************************************************************************
 * Caching Loader - Copyright (C) 2019 Edelhirsch Software GmbH
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 *****************************************************************************/

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

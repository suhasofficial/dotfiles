/*
    SPDX-FileCopyrightText: 2025 adolfo <adolfo@librepixels.com>

    SPDX-License-Identifier: GPL-3.0-or-later
*/

import QtQuick
import QtQuick.Controls
import Qt.labs.platform
import org.kde.plasma.plasmoid
import Qt5Compat.GraphicalEffects
import Qt.labs.folderlistmodel 2.15
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: root
    twinFormLayouts: parentLayout
    QtObject {
        id: files
        property url pathFolder
        property bool defaultFolder
        property var images

    }

    FolderListModel {
        id: imagesModel
        folder: files.defaultFolder ? Qt.resolvedUrl("BigSur") : files.pathFolder
        showDirs: true
        nameFilters: ["*.jpg", "*.png", "*.jpeg", "*.webp"]

        onStatusChanged: {
            if (status === FolderListModel.Ready) {

                var nmes = ["1","2","3","4"]
                function removeImageExtensions(filename) {
                    return filename.replace(/\.(jpg|jpeg|png|webp)$/i, '');
                }
                for (var j = 0; j < count; j++) {
                    var onlyName = removeImageExtensions(imagesModel.get(j, "fileName"))
                    console.log(onlyName)
                    if (onlyName === "1" || onlyName === "2" || onlyName === "3" || onlyName === "4") {
                        nmes[parseInt(onlyName) - 1] = imagesModel.get(j, "filePath")
                    }
                }
                if (folderMode.checked) {
                    files.images = nmes
                }

            }
        }
    }

    FolderDialog  {
        id: folderDialog
        onAccepted: {
            files.pathFolder = folder
        }
    }
    FileDialog {
        id: one
        nameFilters: ["*.jpg", "*.png", "*.jpeg", "*.webp"]
        onAccepted: {
            files.images[0] = file
            imageOne.Source = file
            files.pathFolder = undefined
        }
    }
    FileDialog {
        id: two
        nameFilters: ["*.jpg", "*.png", "*.jpeg", "*.webp"]
        onAccepted: {
            files.images[1] = file
            imageTwo.Source = file
            files.pathFolder = undefined
        }
    }
    FileDialog {
        id: three
        nameFilters: ["*.jpg", "*.png", "*.jpeg", "*.webp"]
        onAccepted: {
            files.images[2] = file
            imageThree.Source = file
            files.pathFolder = undefined
        }
    }
    FileDialog {
        id: four
        nameFilters: ["*.jpg", "*.png", "*.jpeg", "*.webp"]
        onAccepted: {
            files.images[3] = file
            imageFour.Source = file
            files.pathFolder = undefined
        }
    }

    property alias cfg_FolderMode: folderMode.checked
    property alias cfg_urlFolder: files.pathFolder
    property alias cfg_dafaultFolder: files.defaultFolder
    property alias cfg_model: files.images


    Switch {
        id: folderMode
        Kirigami.FormData.label: i18n("Enable Folder Mode:")
    }
    Button {
        text: i18n("Select Folder:")
        enabled: folderMode.checked
        Kirigami.FormData.label: file.pathFolder
        onClicked: {
            folderDialog.open()
            files.defaultFolder = false
        }
    }
    Rectangle {
        id: mask
        anchors.fill: parent
        radius: 16
        visible: false
    }
    Image {
        id: imageOne
        source: files.images[0]
        sourceSize.width: 128
        sourceSize.height: 128
        Kirigami.FormData.label: i18n("Dawn/Dusk")
        fillMode: Image.PreserveAspectFit
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
        MouseArea {
            anchors.fill: parent
            enabled: !folderMode.checked
            onClicked: {
               one.open()
            }
        }

    }
    Image {
        id: imageTwo
        source: files.images[1]
        sourceSize.width: 128
        sourceSize.height: 128
        Kirigami.FormData.label: i18n("Day")
        fillMode: Image.PreserveAspectFit
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
        MouseArea {
            anchors.fill: parent
            enabled: !folderMode.checked
            onClicked: {
               two.open()
            }
        }

    }
    Image {
        id: imageThree
        source: files.images[2]
        sourceSize.width: 128
        sourceSize.height: 128
        Kirigami.FormData.label: i18n("Twilight")
        fillMode: Image.PreserveAspectFit
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
        MouseArea {
            anchors.fill: parent
            enabled: !folderMode.checked
            onClicked: {
                three.open()
            }
        }

    }
    Image {
        id: imageFour
        source: files.images[3]
        sourceSize.width: 128
        sourceSize.height: 128
        Kirigami.FormData.label: i18n("Night")
        fillMode: Image.PreserveAspectFit
        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: mask
        }
        MouseArea {
            anchors.fill: parent
            enabled: !folderMode.checked

            onClicked: {
                four.open()
            }
        }
    }
}

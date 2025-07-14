/*****************************************************************************
 *   Copyright (C) 2022 by Friedrich Schriewer <friedrich.schriewer@gmx.net> *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 ****************************************************************************/
import QtQuick 2.15
import QtQuick.Layouts 1.12
import Qt5Compat.GraphicalEffects
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.coreaddons 1.0 as KCoreAddons

import org.kde.plasma.plasma5support 2.0 as P5Support
import org.kde.kirigami as Kirigami

Item {
  id: main
  property bool searching: (searchBar.text != "")
  signal  newTextQuery(string text)

  readonly property color textColor: Kirigami.Theme.textColor
  readonly property string textFont: plasmoid.configuration.useSystemFontSettings ? Kirigami.Theme.defaultFont : "SF Pro Text"
  readonly property real textSize: plasmoid.configuration.useSystemFontSettings ? Kirigami.Theme.defaultFont.pointSize : 11
  readonly property color bgColor: Kirigami.Theme.backgroundColor
  readonly property color highlightColor: Kirigami.Theme.highlightColor
  readonly property color highlightedTextColor: Kirigami.Theme.highlightedTextColor
  readonly property bool isTop: plasmoid.location == PlasmaCore.Types.TopEdge & plasmoid.configuration.launcherPosition != 2 & !plasmoid.configuration.floating

  readonly property color glowColor1: plasmoid.configuration.glowColor == 0 ? "#D300DC" :
                                      plasmoid.configuration.glowColor == 1 ? "#20bdff" :
                                      "#ff005d"
  readonly property color glowColor2: plasmoid.configuration.glowColor == 0 ? "#8700FF" :
                                      plasmoid.configuration.glowColor == 1 ? "#5433ff" :
                                      "#ff8b26"

  property bool showAllApps: false

  KCoreAddons.KUser {
      id: kuser
  }

  function updateStartpage(){
    appList.currentStateIndex = plasmoid.configuration.defaultPage
  }

  function reload() {
    searchBar.clear()
    searchBar.focus = true
    appList.reset()
  }
  function reset(){
    searchBar.clear()
    searchBar.focus = true
    appList.reset()
    headerLabelRow.reset()
  }

  Rectangle {
    id: backdrop
    x: 0
    y: 125 * 1
    width: main.width
    height: isTop ? main.height - y - Kirigami.Units.largeSpacing : main.height - y //- (searchBarContainer.height + 20)
    color: bgColor
    opacity: 0
  }
  //Floating Avatar
  Item {
    id: avatarParent
    x: main.width / 2
    y: - root.margins.top
    FloatingAvatar { //Anyone looking for an unpredictable number generator?
      id: floatingAvatar
      //visualParent: root
      isTop: main.isTop
      avatarWidth: 125 * 1
      visible: root.visible && !isTop ? true : root.visible && plasmoid.configuration.floating ? true : false
    }
  }
  //Power & Settings
  RowLayout {
    id: headerBar
    width: main.width
    Item {
      Layout.fillWidth: true
      UserAvatar {
        width: 80
        height: width
        visible: !floatingAvatar.visible
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: width / 2
      }
    }

    Header {
      id: powerSettings
      iconSize: 20 
      Layout.fillHeight: false
      Layout.alignment: Qt.AlignRight | Qt.AlignTop
    }

  }
  
  //Greeting
  Greeting {
    id: greeting
    visible: true//floatingAvatar.visible
    x: main.width / 2 - textWidth / 2 //This centeres the Text
    y: main.isTop ? 95 : 70 
    textSize: 20 
  }

  // Fvorites / All apps label
  ColumnLayout {

    anchors.top: backdrop.top
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    spacing: 2

    RowLayout {
      id: headerLabelRow

      function reset() {
        if(showAllApps) {
          var currentCategory = appList.getCurrentCategory();
          mainLabelGrid.text = currentCategory.name;
          sortingImage.source = currentCategory.icon;
          appList.updateShowedModel(currentCategory.index);
        } else {
          mainLabelGrid.text = "Favorite Apps";
        }
      }
        
      Image {
        id: headerLabel
        source: "icons/feather/star.svg"
        visible: !main.showAllApps
        
        Layout.preferredHeight: 15
        Layout.preferredWidth: 15
        Layout.fillHeight: false

        ColorOverlay {
          visible: headerLabel.visible
          anchors.fill: headerLabel
          source: headerLabel
          color: main.textColor
        }
      }

      Kirigami.Icon {
        id: sortingImage
        Layout.preferredHeight: 15
        Layout.preferredWidth: 15
        Layout.fillHeight: false
        visible: main.showAllApps
      }

      PlasmaComponents.Label {
        id: mainLabelGrid
        font.family: textFont
        font.pointSize: textSize
        Layout.fillWidth: true
        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          hoverEnabled: true
          enabled: showAllApps && !searching
          acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
          onClicked: {
            if (mouse.button == Qt.LeftButton) { appList.incrementCurrentStateIndex() }
            else if (mouse.button == Qt.RightButton) { appList.decrementCurrentStateIndex() }
            else if (mouse.button == Qt.MiddleButton) { appList.resetCurrentStateIndex() }
            headerLabelRow.reset();
          }
        }
      }

      // Show all app buttons
      PlasmaComponents.Button  {
        id: allAppsButton
        text: i18n(showAllApps ? "Back" : "All apps")
        flat: false
        
        topPadding: 5
        bottomPadding: topPadding
        leftPadding: 8
        rightPadding: 8

        visible: !searching

        icon.name: showAllApps ? "go-previous" : "go-next"
        icon.height: 15
        icon.width: icon.height

        font.pointSize: textSize
        font.family: textFont
        
        LayoutMirroring.enabled: true
        LayoutMirroring.childrenInherit: !showAllApps 
        Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

        MouseArea {
            hoverEnabled: true
            anchors.fill: parent
            cursorShape: containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
              showAllApps = !showAllApps;
              headerLabelRow.reset();
            }
        }

        background: Rectangle {
          id: btnBg
          color: Qt.lighter(Kirigami.Theme.backgroundColor)
          border.width: 1
          border.color: Qt.darker(Kirigami.Theme.backgroundColor, 1.14)
          radius: plasmoid.configuration.enableGlow ? height / 2 : 5

          Rectangle {
            id: bgMask
            width: parent.width
            height: parent.height
            radius: height / 2
            border.width: 1
            visible: plasmoid.configuration.enableGlow && !searching
          }
          Item {
            visible: plasmoid.configuration.enableGlow && !searching
            anchors.fill: bgMask
            layer.enabled: true
            layer.effect: OpacityMask { maskSource: bgMask }

            LinearGradient {
              anchors.fill: parent
              start: Qt.point(bgMask.width, 0)
              end: Qt.point(0, bgMask.height)
              gradient: Gradient {
                  GradientStop { position: 0.0; color: glowColor1 }
                  GradientStop { position: 1.0; color: glowColor2 }
              }
            }
          }
        }

        //All apps button shadow
        DropShadow {
            anchors.fill: btnBg
            cached: true
            horizontalOffset: 0
            verticalOffset: 0
            radius: 11.0
            samples: 16
            color: glowColor1
            source: btnBg
            visible: plasmoid.configuration.enableGlow && !searching
        }
      }
    }


    //List of Apps
    AppList {
      id: appList
      state: "visible"

      Layout.fillWidth: true
      Layout.fillHeight: true

      visible: opacity > 0
      states: [
      State {
        name: "visible"; when: (!searching)
        PropertyChanges { target: appList; opacity: 1.0 }
      },
      State {
        name: "hidden"; when: (searching)
        PropertyChanges { target: appList; opacity: 0.0}
      }]
      transitions: [
        Transition {
          to: "visible"
          PropertyAnimation {properties: 'opacity'; duration: 100; easing.type: Easing.OutQuart}
        },
        Transition {
          to: "hidden"
          PropertyAnimation {properties: 'opacity'; duration: 100; easing.type: Easing.OutQuart}
        }
      ]
    }
    RunnerList {
      id: runnerList
      model: runnerModel
      state: "hidden"
      visible: opacity > 0

      Layout.fillWidth: true
      Layout.fillHeight: true

      states: [
      State {
        name: "visible"; when: (searching)
        PropertyChanges { target: runnerList; opacity: 1.0 }
        PropertyChanges { target: runnerList; x: 20  * 1}
      },
      State {
        name: "hidden"; when: (!searching)
        PropertyChanges { target: runnerList; opacity: 0.0}
        PropertyChanges { target: runnerList; x: 40 * 1}
      }]
      transitions: [
        Transition {
          to: "visible"
          PropertyAnimation {properties: 'opacity'; duration: 100; easing.type: Easing.OutQuart}
          PropertyAnimation {properties: 'x'; from: 80 * 1; duration: 100; easing.type: Easing.OutQuart}
        },
        Transition {
          to: "hidden"
          PropertyAnimation {properties: 'opacity'; duration: 100; easing.type: Easing.OutQuart}
          PropertyAnimation {properties: 'x'; from: 20 * 1; duration: 100; easing.type: Easing.OutQuart}
        }
      ]
    }

    // Search Bar

    Rectangle {
      id: searchBarContainer

      Layout.fillWidth: true
      Layout.preferredHeight: 45
      Layout.alignment: Qt.ALignBottom | Qt.AlignHCenter

      radius: 8
      color: Qt.lighter(Kirigami.Theme.backgroundColor, 1.5) // better contrast color 

      RowLayout {
        anchors.fill: parent
        Image {
          id: searchIcon
          Layout.preferredWidth: 15
          Layout.preferredHeight: 15
          Layout.margins: 15
        
          source: 'icons/feather/search.svg'
          ColorOverlay {
            visible: true
            anchors.fill: searchIcon
            source: searchIcon
            color: main.textColor
          }
        }

        Rectangle {

          Layout.fillHeight: true
          Layout.fillWidth: true
          Layout.rightMargin: 15

          clip: true
          color: 'transparent'
          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.IBeamCursor
            hoverEnabled: true
          }
          TextInput {
            id: searchBar
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            focus: true
            color: textColor
            selectByMouse: true
            selectionColor: highlightColor
            font.family: textFont
            font.pixelSize: 13 * 1
            Text {
              anchors.fill: parent
              text: i18n("Search your computer")
              color: Kirigami.Theme.disabledTextColor
              visible: !parent.text
            }
            onTextChanged: {
                runnerModel.query = text;
                newTextQuery(text)
            }
            function clear() {
                text = "";
            }
            function backspace() {
                if (searching) {
                    text = text.slice(0, -1);
                }
                focus = true;
            }
            function appendText(newText) {
                if (!root.visible) {
                    return;
                }
                focus = true;
                text = text + newText;
            }
            Keys.onPressed: {
              if (event.key == Qt.Key_Down) {
                event.accepted = true;
                runnerList.setFocus()
              } else if (event.key == Qt.Key_Tab || event.key == Qt.Key_Up) {
                event.accepted = true;
                runnerList.setFocus()
              } else if (event.key == Qt.Key_Escape) {
                event.accepted = true;
                if (searching) {
                  clear()
                } else {
                  root.toggle()
                }
              } else if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return) {
                runnerList.setFocus()
                runnerList.triggerFirst()
              }
            }
          }
        }
      }
    }
  }

  Keys.onPressed: {
    if (event.key == Qt.Key_Backspace) {
        event.accepted = true;
        if (searching)
            searchBar.backspace();
        else
            searchBar.focus = true
    } else if (event.key == Qt.Key_Escape) {
        event.accepted = true;
        if (searching) {
            searchBar.clear()
        } else {
            root.toggle()
        }
    } else if (event.text != "" || event.key == Qt.Key_Down) {
        if (event.key != Qt.Key_Return){
          event.accepted = true;
          searchBar.appendText(event.text);
        }
    }
  }
}

/*
 *  SPDX-FileCopyrightText: 2025 zayronxio <adolfo@librepixels.com>
 *
 *  SPDX-License-Identifier: GPL-3.0-or-later
 */

import QtQuick
import org.kde.plasma.plasmoid
import Qt.labs.folderlistmodel 2.15

WallpaperItem {
    id: root
    property var images: root.configuration.model

    Image {
        id: bs
        anchors.fill: parent
        source: image2
        fillMode: Image.PreserveAspectCrop
    }
    Image {
        id: full
        anchors.fill: parent
        source: image
        fillMode: Image.PreserveAspectCrop
        opacity: 0

        Behavior on opacity {
            NumberAnimation {
                duration: 1000
            }
        }
        onOpacityChanged: {
            if (opacity === 1){
                bs.source = image
            }
        }
    }
    FolderListModel {
        id: imagesModel
        folder: Qt.resolvedUrl("BigSur")
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

                if (root.configuration.defaultFolder) {
                    root.configuration.model = nmes
                }

            }
        }
    }
    property int minutesDay: minutesOfDay(new Date())

    property url image: image4

    property url image1: images[0]
    property url image2: images[1]
    property url image3: images[2]
    property url image4: images[3]

    property int deepNight: 1230
    property int day: 360
    property int civilTwilightSunrise: 300
    property int civilTwilightSunset: 1110
    property int astronomicalTwilightSunrise: 285
    property int astronomicalTwilightSunset: 1170

    function getTimeZone(){
        const date = new Date();
        const timeZone = date.toString().match(/([A-Z]{3}[+-]\d{4})/)?.[1] || "UTC";
        return timeZone;
    }

    function minutesOfDay(dat){
        var UTCstring = dat.toUTCString(); // date RFC 1123


        let UTCsimpleString  = UTCstring.split(" ") // separates the string with the date into manageable elements
        let hoursMinutes = UTCsimpleString[3].split(":")
        // get hours and Minutes
        let hours = parseInt(hoursMinutes[0])
        let minutes = parseInt(hoursMinutes[1])
        return (hours * 60) + minutes
    }

    function minutesOfDayISO8601(dat){
        var hours = parseInt(Qt.formatDateTime(dat, "h")) * 60
        var minutes = parseInt(Qt.formatDateTime(dat, "m"))
        return hours + minutes;
    }
    function inInterval(minutes, start, end) {
        // Si el intervalo no cruza la medianoche.
        if (start <= end) {
            return minutes >= start && minutes < end;
        } else {
            // Si el intervalo cruza la medianoche.
            return minutes >= start || minutes < end;
        }
    }

    function setWallpaper(){
        const minutes = minutesOfDay(new Date());

        let newImage;

        if (inInterval(minutes, astronomicalTwilightSunrise, civilTwilightSunrise)) {
            newImage = image3;
        } else if (inInterval(minutes, civilTwilightSunrise, day)) {
            newImage = image1;
        } else if (inInterval(minutes, day, civilTwilightSunset)) {
            newImage = image2;
        } else if (inInterval(minutes, civilTwilightSunset, astronomicalTwilightSunset)) {
            newImage = image1;
        } else if (inInterval(minutes, astronomicalTwilightSunset, deepNight)) {
            newImage = image3;
        } else if (inInterval(minutes, deepNight, astronomicalTwilightSunrise)) {
            newImage = image4;
        }

        if (image !== newImage) {
            full.opacity = 0;
            image = newImage;
            full.source = image;
            full.opacity = 1;
        }
    }
    function obtenerCoordenadas() {
        let url = "http://ip-api.com/json/?fields=lat,lon";

        let req = new XMLHttpRequest();
        req.open("GET", url, true);

        req.onreadystatechange = function () {
            if (req.readyState === 4) {
                if (req.status === 200) {
                    try {
                        let datos = JSON.parse(req.responseText);
                        let latitud = datos.lat;
                        let longitud = datos.lon;
                        let full = `${latitud}, ${longitud}`;
                        let apiUrlFinal = "https://api.sunrise-sunset.org/json?lat=" + latitud + "&lng=" + longitud + "&formatted=0"
                        fetchSunData(apiUrlFinal)
                    } catch (error) {
                        console.error("Error procesando la respuesta JSON:", error);
                    }
                }
            }
        };

        req.onerror = function () {
            retry.start()
        };

        req.send();
    }

    function fetchSunData(url) {
        var xhr = new XMLHttpRequest();
        xhr.open("GET", url, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                if (response.status === "OK") {
                    deepNight = minutesOfDayISO8601(response.results.astronomical_twilight_end);
                    day = minutesOfDayISO8601(response.results.sunrise);
                    console.log("el dia es", day)
                    civilTwilightSunrise = minutesOfDayISO8601(response.results.civil_twilight_begin);
                    civilTwilightSunset = minutesOfDayISO8601(response.results.sunset);
                    astronomicalTwilightSunrise = minutesOfDayISO8601(response.results.astronomical_twilight_begin);
                    astronomicalTwilightSunset = minutesOfDayISO8601(response.results.civil_twilight_end);
                    console.log("se usaran el dato", parseInt(minutesDay))
                    setWallpaper()
                }
            }
        };
        xhr.send();
    }

    Timer {
        id: timer
        interval: 500000
        running: true
        repeat: true
        onTriggered: {
            setWallpaper()
        }
    }
    Timer {
        id: retry
        interval: 6000
        running: false
        repeat: false
        onTriggered: {
           obtenerCoordenadas()
        }
    }
    onImagesChanged: {
        setWallpaper()
    }
    Component.onCompleted: {
        obtenerCoordenadas()
        //fetchSunData()
    }
}


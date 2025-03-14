# garmin-bridge

Test diffrent methods for data retrieval off Garmin watches

______
### Option 1
**Download the .FIT Activity file**

This gives you some data from that avtivity but not the raw accelerometer and gyroscope data. 

### Option 2
**Make own app to record**


____
### Notes

- When connecting to mac (via usb) it will not show up on MACOS since mac use `MSC` not `MTP`
    - unless you use `Android File Transfer` then you can access the files

<br>
<br>

# How to use option 2

## Setting Up the App
1. Connect your Garmin watch to your computer via USB
2. Find the `bridge.prg` file in the builds folder
3. Drag the file into the `GARMIN/APPLICATIONS/` directory on your watch
4. Unplug
5. On the watch, allow the app

## Making the App Accessible
1. Reconnect the watch via USB
2. Open Garmin Express
3. In Garmin Express go to "APPS"
3. Press "Rearrange Activities" button at the bottom
4. Move AccelBridge up in the list so it appears in your favorite activities (otherwise you cant acces it on the watch)

## Using the App
1. Open the app from your activities list
2. Use the top button to start/stop recording
3. The app will save accelerometer data to a .FIT file

## Getting the Data
1. When finished recording, reconnect the watch via USB
2. Copy the .FIT file from `GARMIN/ACTIVITIES/` to your computer
3. Delete the file from your watch to avoid cluttering your real activities
4. Use `decoder.ipynb` to convert the .FIT file to CSV format

## Analyzing the Data
The CSV file will contain timestamp, x, y, and z acceleration values that you can visualize or process further.
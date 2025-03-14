import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.System;
import Toybox.Timer;

class bridgeView extends WatchUi.View {
    private var _accelEnabled = false;
    private var _timer = null;
    private var _lastAccelData = null;
    private var _recorder = null;
    private var _statusField = null;
    private const TIMER_INTERVAL = 3000; //print every 3 seconds

    function initialize(recorder) {
        View.initialize();
        _recorder = recorder;
    }

    // load resources
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        
        // get  status text field in the layout
        _statusField = View.findDrawableById("statusText");
    }

    // Called when this View is brought to the foreground
    function onShow() as Void {
        // Enable accel sensing when the view is visible
        if (!_accelEnabled) {
            enableAccelerometer();
        }
        
        // timer to print accel data 
        if (_timer == null) {
            _timer = new Timer.Timer();
            _timer.start(method(:onTimer), TIMER_INTERVAL, true);
        }
        
        updateUI();
    }

    // update the view
    function onUpdate(dc as Dc) as Void {
        updateUI();
        View.onUpdate(dc);
    }

    function onHide() as Void {
        // turn off accel when view is hidden
        disableAccelerometer();
        
        // stop the timer when the view is hidden
        if (_timer != null) {
            _timer.stop();
            _timer = null;
        }
    }

    // enable accel data collection
    function enableAccelerometer() as Void {        
        Sensor.setEnabledSensors([]); //enable default sensors
        Sensor.enableSensorEvents(method(:onSensorData));
        _accelEnabled = true;
        System.println("Accelerometer enabled");
    }

    // dissable accel data collection
    function disableAccelerometer() as Void {
        if (_accelEnabled) {
            Sensor.setEnabledSensors([]);
            Sensor.enableSensorEvents(null);
            _accelEnabled = false;
            System.println("Accelerometer disabled");
        }
    }

    // Callback function to handle sensor data
    function onSensorData(sensorInfo as Sensor.Info) as Void {
        if (sensorInfo has :accel && sensorInfo.accel != null) {
            // Store the latest accelerometer data
            // Make sure we create a proper array to avoid type issues
            var accelX = sensorInfo.accel[0];
            var accelY = sensorInfo.accel[1];
            var accelZ = sensorInfo.accel[2];
            _lastAccelData = [accelX, accelY, accelZ];
        }
    }
    
    // timer callback to print accel data
    function onTimer() as Void {
        if (_lastAccelData != null) {
            System.println("-------------------------------------");
            System.println("Accelerometer data:");
            System.println("X = " + _lastAccelData[0]);
            System.println("Y = " + _lastAccelData[1]); 
            System.println("Z = " + _lastAccelData[2]);
            System.println("-------------------------------------");
        } else {
            System.println("No accelerometer data available yet");
        }
        
        updateUI();
    }
    
    // update the UI with current status
    function updateUI() as Void {
        if (_statusField != null) {
            var statusText = "Accel: ";
            
            // add recording status
            if (_recorder != null && _recorder.isRecording()) {
                statusText += "Recording...";
            } else {
                statusText += "Not recording";
            }
            
            // add accel data
            if (_lastAccelData != null) {
                statusText += "\nX: " + _lastAccelData[0].format("%.2f");
                statusText += " Y: " + _lastAccelData[1].format("%.2f");
                statusText += " Z: " + _lastAccelData[2].format("%.2f");
            }
            
            _statusField.setText(statusText);
        }
    }
}
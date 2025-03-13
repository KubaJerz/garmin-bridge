import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.Sensor;
import Toybox.System;
import Toybox.Timer;

class bridgeView extends WatchUi.View {
    private var _accelEnabled = false;
    private var _timer = null;
    private var _lastAccelData = null;
    private const TIMER_INTERVAL = 3000; // Print every 3 seconds

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        // Enable accelerometer sensing when the view becomes visible
        if (!_accelEnabled) {
            enableAccelerometer();
        }
        
        // Set up a timer to print accelerometer data regularly
        if (_timer == null) {
            _timer = new Timer.Timer();
            _timer.start(method(:onTimer), TIMER_INTERVAL, true);
        }
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        // Disable accelerometer when view is hidden
        disableAccelerometer();
        
        // Stop the timer when the view is hidden
        if (_timer != null) {
            _timer.stop();
            _timer = null;
        }
    }

    // Enable accelerometer data collection
    function enableAccelerometer() as Void {
        // Enable all sensors to get accelerometer data
        Sensor.setEnabledSensors([]);  // First clear any existing sensors
        Sensor.enableSensorEvents(method(:onSensorData));
        _accelEnabled = true;
        System.println("Accelerometer enabled");
    }

    // Disable accelerometer data collection
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
            _lastAccelData = sensorInfo.accel;
        }
    }
    
    // Timer callback to periodically print accelerometer data
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
    }
}
import Toybox.ActivityRecording;
import Toybox.SensorLogging;
import Toybox.System;
import Toybox.Time;

class AccelRecorder {
    private var _logger = null;
    private var _session = null;
    private var _isRecording = false;
    private const PREFIX = "ACCEL_BRIDGE_";

    function initialize() {
        // make a sensor logger for the accel
        _logger = new SensorLogging.SensorLogger({
            :enableAccelerometer => true
        });
    }

    // Start a new recording session
    function startRecording() {
        if (_isRecording) {
            System.println("Already recording");
            return;
        }

        // unique name and timestamp
        var now = Time.now();
        var timeString = now.value().toString();
        var sessionName = PREFIX + timeString;

        // make new FIT recording
        _session = ActivityRecording.createSession({
            :name => sessionName,
            :sport => ActivityRecording.SPORT_GENERIC,
            :sensorLogger => _logger
        });

        // start
        if (_session != null) {
            _session.start();
            _isRecording = true;
            System.println("Recording started - saving to FIT file: " + sessionName);
        } else {
            System.println("Failed to create recording session");
        }
    }

    // stop the recording 
    function stopRecording() {
        if (!_isRecording || _session == null) {
            System.println("Not recording");
            return;
        }

        // stop the session
        _session.stop();
        _isRecording = false;
        System.println("Recording stopped");
    }

    // save current recording 
    function saveRecording() {
        if (_session == null) {
            System.println("No recording to save");
            return;
        }

        // save to FIT file
        _session.save();
        System.println("Recording saved to FIT file with prefix: " + PREFIX);
        _session = null;
    }

    function isRecording() {
        return _isRecording;
    }
}
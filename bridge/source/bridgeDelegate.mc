import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.System;

class bridgeDelegate extends WatchUi.BehaviorDelegate {
    private var _recorder = null;

    function initialize(recorder) {
        BehaviorDelegate.initialize();
        _recorder = recorder;
    }

    function onMenu() as Boolean {
        if (_recorder != null) {
            if (_recorder.isRecording()) {
                //stop & save
                _recorder.stopRecording();
                _recorder.saveRecording();
                System.println("Recording stopped and saved via menu");
            } else {
                //start & record
                _recorder.startRecording();
                System.println("Recording started via menu");
            }
            WatchUi.requestUpdate();
        }
        return true;
    }

    function onSelect() as Boolean {
        if (_recorder != null) {
            if (_recorder.isRecording()) {
                _recorder.stopRecording();
                _recorder.saveRecording();
                System.println("Recording stopped and saved via select");
            } else {
                _recorder.startRecording();
                System.println("Recording started via select");
            }
            WatchUi.requestUpdate();
        }
        return true;
    }
}
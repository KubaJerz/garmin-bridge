import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class bridgeApp extends Application.AppBase {
    private var _recorder = null;

    function initialize() {
        AppBase.initialize();
        _recorder = new AccelRecorder();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        // Start recording automatically when app starts
        if (_recorder != null) {
            _recorder.startRecording();
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
        // Make sure we stop and save any recording in progress when the app exits
        if (_recorder != null && _recorder.isRecording()) {
            _recorder.stopRecording();
            _recorder.saveRecording();
        }
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new bridgeView(_recorder), new bridgeDelegate(_recorder) ];
    }
}

function getApp() as bridgeApp {
    return Application.getApp() as bridgeApp;
}
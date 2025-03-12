import Toybox.Lang;
import Toybox.WatchUi;

class bridgeDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new bridgeMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}
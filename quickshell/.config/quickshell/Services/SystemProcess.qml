pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    
    Process{
        id: poweroff
        command: ["sh", "-c", "systemctl poweroff"]
    }
    Process{
        id: reboot
        command: ["sh", "-c", "systemctl reboot"]
    }
    Process{
        id: suspend
        command: ["sh", "-c", "systemctl suspend"]
    }

    function doPoweroff(){
        poweroff.running = true
    }
    function doReboot(){
        reboot.running = true
    }
    function doSuspend(){
        suspend.running = true
    }

}
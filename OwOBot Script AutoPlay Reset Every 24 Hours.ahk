#Requires AutoHotkey v2.0
#SingleInstance Force

global running := false
global paused := false
global cycleIndex := 1

; Run/Pause pattern (in milliseconds)
global runTimes := [3*60000, 2*60000, 3.5*60000]   ; 3, 2, 3.5 minutes
global pauseTimes := [5*60000, 4*60000, 10*60000]  ; 5, 4, 6 minutes

; ========= START =========
F8:: {
    global running, paused, cycleIndex

    running := true
    paused := false
    cycleIndex := 1

    SetTimer(OwOh, 15000)
    SetTimer(OwOb, 15000)

    StartRunCycle()
}

; ========= STOP =========
F9:: {
    global running, paused

    running := false
    paused := false

    SetTimer(OwOh, 0)
    SetTimer(OwOb, 0)
    SetTimer(StartPause, 0)
    SetTimer(EndPause, 0)
}

; ========= START RUN =========
StartRunCycle() {
    global runTimes, cycleIndex

    currentRun := runTimes[cycleIndex]

    ; After run time → start pause
    SetTimer(StartPause, -currentRun)
}

; ========= START PAUSE =========
StartPause() {
    global paused, pauseTimes, cycleIndex

    paused := true

    currentPause := pauseTimes[cycleIndex]

    ; After pause → end pause
    SetTimer(EndPause, -currentPause)
}

; ========= END PAUSE =========
EndPause() {
    global running, paused, cycleIndex, runTimes

    if !running
        return

    paused := false

    ; Move to next cycle
    cycleIndex++
    if (cycleIndex > runTimes.Length)
        cycleIndex := 1

    ; Start next run
    StartRunCycle()
}

; ========= SEND FUNCTIONS =========
OwOh() {
    global running, paused
    if !running || paused
        return
    SendInput("owoh{Enter}")
}

OwOb() {
    global running, paused
    if !running || paused
        return
    SendInput("owob{Enter}")
}
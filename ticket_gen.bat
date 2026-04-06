@echo off
title Operation One Ticket Generator by Blazzy
setlocal enabledelayedexpansion

:start
cls
echo --------------------------------------
echo    OPERATION ONE TICKET GENERATOR
echo --------------------------------------

echo.
:: Step 0: Ticket ID
set "input_id="
set /p "input_id=Step 0: Enter Ticket ID (Press Enter for 'EC'): "

if "[%input_id%]"=="[]" (
    set "ticket_id=EC"
) else (
    set "ticket_id=%input_id%"
)

echo.
:: Step 1: User ID
set "userid="
set /p "userid=Step 1: Enter Roblox User ID: "

echo.
echo Step 2: Select Platform:
echo [1] Roblox
echo [2] Discord
choice /c 12 /n /m "Selection: "
if errorlevel 2 (set "platform=Discord") else (set "platform=Roblox")

echo.
echo Step 3: Select Violation Reason:
echo [1] Cheating/Exploiting
echo [2] Griefing
echo [3] Inappropriate display/loadout/username
echo [4] Cheating servers
echo [5] Cheating by own admission
echo [6] Custom
choice /c 123456 /n /m "Selection: "

:: Logic for Reason selection - highest to lowest errorlevel
if errorlevel 6 goto custom_reason
if errorlevel 5 (
    set "base_reason=Reported and investigated for cheating by own admission."
    goto step4
)
if errorlevel 4 (
    set "base_reason=Reported and investigated for being in cheating servers."
    goto perm_skip
)
if errorlevel 3 (
    set "base_reason=Reported for inappropriate user content."
    goto step4
)
if errorlevel 2 (
    set "base_reason=Reported and investigated for griefing."
    goto step4
)
if errorlevel 1 (
    set "base_reason=Reported and investigated for cheating."
    goto perm_skip
)

:custom_reason
echo.
set /p "base_reason=Enter custom reason: "
goto step4

:perm_skip
set "duration=Permanent"
set "hr_val="
set "warning="
goto output

:step4
echo.
echo Step 4: Select Punishment Duration:
echo [1] 24 Hours
echo [2] 3 Days
echo [3] 7 Days
echo [4] Permanent
choice /c 1234 /n /m "Selection: "

if errorlevel 4 (
    set "duration=Permanent"
    set "hr_val="
    set "warning="
    goto output
)
if errorlevel 3 (
    set "duration=7 Days"
    set "hr_val=168"
    set "warning= Repeat offenses may result in permanent suspension."
    goto output
)
if errorlevel 2 (
    set "duration=3 Days"
    set "hr_val=72"
    set "warning= Repeat offenses may result in permanent suspension."
    goto output
)
if errorlevel 1 (
    set "duration=24 Hours"
    set "hr_val=24"
    set "warning= Repeat offenses may result in permanent suspension."
    goto output
)

:output
:: Using quotes here prevents the script from crashing if special characters exist
set "final_phrase=%base_reason%%warning% ID: %ticket_id%"

cls
echo --- GENERATED TICKET CONTENT ---
echo --------------------------------
echo Ticket Reference: %ticket_id%
echo Target User ID:   %userid%
echo Platform:          %platform%
echo Details:           %final_phrase%
echo Punishment Length: %duration%
echo Evidence: 
echo --------------------------------

if "%platform%"=="Roblox" (
    echo Generated Admin Command:
    if "%duration%"=="Permanent" (
        echo ban/%userid%/%final_phrase%
    ) else (
        echo ban/%userid%/%final_phrase%/%hr_val%
    )
    echo --------------------------------
)

echo.
echo Ticket generated successfully.
echo.
echo Would you like to make another ticket?
echo [Y] Yes / [N] No
choice /c YN /n /m "Selection: "

if errorlevel 2 goto end
if errorlevel 1 goto start

:end
exit

/*
    WINDOWS MANAGER PROJECT FOR GAMEMAKER 8.2
    PACKAGE VERSION 0.1
    COPYRIGHT 2023
    NAME:   winMan_interaction
    CALLER: Window manager
    PURPOSE:Does window logic. Allows for user interactions.
    REQUIRE:None.
*/
var exitProg;

// Are we clicking on an active window?
if (stackTop != noone && mouse_check_button_pressed(mb_any)) {
    var winX, winY, winSX, winSY;
    winX = ds_list_find_value(stackTop, 5);
    winY = ds_list_find_value(stackTop, 6);
    winSX = ds_list_find_value(stackTop, 9);
    winSY = ds_list_find_value(stackTop, 10);
    if (mouse_x >= winX && mouse_x <= winX+winSX)
        if (mouse_y >= winY && mouse_y <= winY+winSY) {
            // So, now we have to check a few things.
            if (mouse_check_button_pressed(mb_middle)) // Force move
                moveActive = true;

            if (!moveActive) { // Now we investigate where the mouse actually lands.
                // Calculate where the interior of the window is, based on its actual size and the style.
                var winIX, winIY, winISX, winISY, actStyle;
                actStyle = ds_list_find_value(stackTop, 2);
                winISX = ds_list_find_value(stackTop, 5);
                winISY = ds_list_find_value(stackTop, 6);
                winIX = winX;
                winIY = winY;


            }

            if (clearIO)
                mouse_clear(mb_any);
            exitProg = true; // Either way, exit this program, we don't need to run anything else.
        }
}


if (moveActive) {
    moveActive = false;
}

// We do need to set the previous mouse though.
pmouse_x = mouse_x;
pmouse_y = mouse_y;

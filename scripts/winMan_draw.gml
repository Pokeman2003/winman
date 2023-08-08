/*
    WINDOWS MANAGER PROJECT FOR GAMEMAKER 8.2
    PACKAGE VERSION 1.0
    COPYRIGHT 2023
    NAME:   winMan_draw
    CALLER: Window manager
    PURPOSE:Draws the windows onto the screen. Fairly simple routine that can't be fucked up.
    REQUIRE:None.
*/

if (!ds_priority_empty(windowList)) {
    var activeList; // Actively processed list.
    activeList = ds_priority_create();
    ds_priority_copy(activeList, windowList)
    draw_set_font(windowFont);
    while (!ds_priority_empty(activeList)) {
        var winPosX, winPosY, winWidth, winHeight winStyle, winTitle, winScheme, winFrame, cList;
        cList = ds_priority_delete_min(activeList);
        winPosX = ds_list_find_value(cList, 5);
        winPosY = ds_list_find_value(cList, 6);
        winWidth = ds_list_find_value(cList, 7);
        winHeight = ds_list_find_value(cList, 8);
        winStyle = ds_list_find_value(cList, 2);
        winTitle = ds_list_find_value(cList, 4);
        winScheme = ds_list_find_value(cList, 0);
        winFrame = ds_list_find_value(cList, 3);
        
        // Draw the border.
        if (winStyle & 1) {
            var borderL, borderR, borderU, borderD;
            borderU = ds_list_find_value(winScheme, 5);
            borderD = ds_list_find_value(winScheme, 6);
            borderL = ds_list_find_value(winScheme, 7);
            borderR = ds_list_find_value(winScheme, 8);
            // horizontal
            draw_set_color(borderU);
            draw_rectangle(winPosX-2, winPosY-2, winPosX+winWidth+2, winPosY, false);
            draw_set_color(borderD);
            draw_rectangle(winPosX-2, winPosY+winHeight, winPosX+winWidth+2, winPosY+winHeight+2, false);
            // vertical
            draw_set_color(borderL);
            draw_rectangle(winPosX-2, winPosY-2, winPosX, winPosY+winHeight+2, false);
            draw_set_color(borderR);
            draw_rectangle(winPosX+winWidth+2, winPosY-2, winPosX+winWidth, winPosY+winHeight+2, false);
        }
        
        // Draw the titlebar.
        if (winStyle & 2) {
            var boxS, boxE, boxB, textH, textW, textCS, textC;
            // Calculate text cutoff and height.
            textH = string_height(winTitle);
            textW = string_width(winTitle);
            textCS = string_width(".");
            textC = winWidth-6;
            
            boxS = ds_list_find_value(winScheme, 2);
            boxE = ds_list_find_value(winScheme, 3);
            boxB = ds_list_find_value(winScheme, 4);
            
            draw_set_color(boxB);
            draw_rectangle(winPosX-2, winPosY-(textH*2), winPosX+winWidth+2, winPosY, true)
            draw_rectangle_color(winPosX-1, winPosY-(textH*2)+1, winPosX+winWidth+1, winPosY-1, boxS, boxE, boxE, boxS, false);
            
            if (winStyle & 8) { // Exit button.
                textC -= 2+(winHeight);
            }
            
            /* if (textW > textC) {
                while (textW > textC) {
                    winTitle = string_copy(winTitle, 0, string_length(winTitle)-4) + "...";
                    if (winTitle == "...")
                        winTitle = "";
                    textW = string_width(winTitle);
                }
            }*/
            
            draw_text(winPosX+3, winPosY-textH*1.5, winTitle);
        }
    }
}

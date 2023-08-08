/*
    WINDOWS MANAGER PROJECT FOR GAMEMAKER 8.2
    PACKAGE VERSION 0.1
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
        
        var surfaceColor;
        surfaceColor = ds_list_find_value(winScheme, 1);
        
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
            var boxS, boxE, boxB, textH, textW, textCS, textC, textCO;
            // Calculate text cutoff and height.
            textH = string_height(winTitle);
            textW = string_width(winTitle);
            textCS = string_width(".");
            textC = winWidth-textCS;
            
            boxS = ds_list_find_value(winScheme, 2);
            boxE = ds_list_find_value(winScheme, 3);
            boxB = ds_list_find_value(winScheme, 4);
            textCO = ds_list_find_value(winScheme, 0);

            draw_set_color(boxB);
            draw_rectangle(winPosX-2, winPosY-(textH*2), winPosX+winWidth+2, winPosY, true)
            draw_rectangle_color(winPosX-1, winPosY-(textH*2)+1, winPosX+winWidth+1, winPosY-1, boxS, boxE, boxE, boxS, false);
            
            // Buttons
            var addedButton;
            if (winStyle & 8) { // Exit button.
                // Calculate
                var calcIX, calcIY, calcOX, calcOY;
                calcIX = winPosX+textC-(textH*2)+2;
                calcIY = winPosY-(textH*2)+2;
                calcOX = winPosX+textC;
                calcOY = winPosY-2
                
                // Draw
                draw_set_color(surfaceColor);
                draw_rectangle(calcIX, calcIY, calcOX, calcOY, false);
                draw_set_color(boxB);
                draw_rectangle(winPosX+textC, winPosY-(textH*2)+2, winPosX+textC-(textH*2)+2, winPosY-2, true);
                
                draw_line_width(calcIX+3, calcIY+3, calcOX-3, calcOY-3, 3);
                draw_line_width(calcIX+3, calcOY-3, calcOX-3, calcIY+3, 3);
                
                // Move text
                textC -= 2+(textH*2);
            }
            
            if (textW > textC) { // Adjust text.
                while (textW > abs(textC)) {
                    winTitle = string_copy(winTitle, 0, string_length(winTitle)-4) + "...";
                    if (winTitle == "...")
                        winTitle = "";
                    textW = string_width(winTitle);
                    show_debug_message(string(textW) + " > " + string(textC) + " " + winTitle);
                }
            }
            
            draw_set_color(textCO);
            draw_text(winPosX+3, winPosY-textH*1.5, winTitle);
        }
        
        draw_rectangle(winPosX, winPosY, winPosX+winWidth, winPosY+winHeight, false);
        draw_surface_part_ext(winFrame, 0, 0, winWidth, winHeight, winPosX, winPosY, 1, 1, surfaceColor, 1);
    }
}

/*
    WINDOWS MANAGER PROJECT FOR GAMEMAKER 8.2
    PACKAGE VERSION 0.1
    COPYRIGHT 2023
    NAME:   winMan_register
    CALLER: Window Object
    PURPOSE:Creates a window and adds it to the stack. Returns a list ID to use with winMan_Alter, or noone on failure.
    REQUIRE:Title, style, [colorScheme, X, Y, surface, size width, size height.]
*/

/*
    Style Guide
    1 - Title Bar
    2 - Bordered
    4 - Exit Button
    8 - [RESERVED FOR LATER USE]
    16 - [RESERVED FOR LATER USE]
    32 - Override active
    64 - [RESERVED FOR LATER USE]
    128 - [RESERVED FOR LATER USE]
*/

var title, style, posX, posY, surfaceID, sizeX, sizeY, colorScheme, windowID;

title = string(argument0);
style = real(argument1);
// Optional parameters
posX = noone;
posY = noone;
surfaceID = noone;
sizeX = noone;
sizeY = noone;
colorScheme = noone;

// Acquire these parameters.
if (argument_count > 2)
    posX = argument[2];
if (argument_count > 3)
    posY = argument[3];
if (argument_count > 4)
    surfaceID = argument[4];
if (argument_count > 5)
    sizeX = argument[5];
if (argument_count > 6)
    sizeY = argument[6];
if (argument_count > 7)
    colorScheme = argument[7];

// Determine if the window manager exists.
if (!instance_exists(global.winManager))
    return noone; // It doesn't exist.

// Time to create.
var calcWidth, calcHeight, elementList;
calcHeight = 0;
calcWidth = 0;
draw_set_font((global.winManager).windowFont);

if (posX == noone)
    if ((global.winManager).stackTop != noone)
        posX = ds_list_find_value((global.winManager).stackTop, 2) + 60;
    else
        posX = 60;
if (posY == noone)
    if ((global.winManager).stackTop != noone)
        posY = ds_list_find_value((global.winManager).stackTop, 3) + 60;
    else
        posY = 60;

if (sizeX == noone)
    sizeX = 240;
if (sizeY == noone)
    sizeY = 240;

if (!surface_exists(surfaceID))
    surfaceID = surface_create(sizeX, sizeY);

if (colorScheme == noone)
    colorScheme = (global.winManager).windowNormalScheme;

if (style | 1)
    calcHeight += string_height(title)*2;

if (style | 2) {
    calcHeight += 4;
    calcWidth += 4;
}

calcHeight += sizeX;
calcWidth += sizeY;
elementList = ds_list_create();
// Assemble it
windowID = ds_list_create();
// General
ds_list_add(windowID, colorScheme); // Color schema
ds_list_add(windowID, elementList); // The element list.
ds_list_add(windowID, style);       // Style.
ds_list_add(windowID, surfaceID);   // Drawn surface.
ds_list_add(windowID, title);
// Position
ds_list_add(windowID, posX); 
ds_list_add(windowID, posY);
// Size
ds_list_add(windowID, sizeX);
ds_list_add(windowID, sizeY);
ds_list_add(windowID, calcWidth);
ds_list_add(windowID, calcHeight);

// Finally add and return.
calcHeight = ds_priority_size((global.winManager).windowList)
ds_priority_add((global.winManager).windowList, windowID, calcHeight);

return windowID;

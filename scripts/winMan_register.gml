/*
    WINDOWS MANAGER PROJECT FOR GAMEMAKER 8.2
    PACKAGE VERSION 1.0
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
    8 - Minimize
    16 - Maximize button
    32 - Force to top of stack
*/

var title, style, posX, posY, surfaceID, sizeX, sizeY, colorScheme, windowID;

title = argument0;
style = argument1;
// Optional parameters
posX = noone;
posY = noone;
surfaceID = noone;
sizeX = noone;
sizeY = noone;
colorScheme = noone;

// Acquire these parameters.
if (argument_count > 1)
    posX = argument[2];
if (argument_count > 2)
    posY = argument[3];
if (argument_count > 3)
    surfaceID = argument[4];
if (argument_count > 4)
    sizeX = argument[5];
if (argument_count > 5)
    sizeY = argument[6];
if (argument_count > 6)
    colorScheme = argument[7];

// Determine if the window manager exists.
if (!instance_exists(global.winManager))
    return noone; // It doesn't exist.
var instance;
instance = ds_list_create();
global.winManager.windowList = 0;

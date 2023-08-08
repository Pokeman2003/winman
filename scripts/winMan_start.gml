/*
    WINDOWS MANAGER PROJECT FOR GAMEMAKER 8.2
    PACKAGE VERSION 0.1
    COPYRIGHT 2023
    NAME:   winMan_start
    CALLER: Window manager
    PURPOSE:Initializes the window manager object.
    REQUIRE:None.
*/

// Manager settings can be found at the end of the script.
// DO NOT ALTER THE REST OF THE SCRIPT!
if (instance_number(self.object_index) != 1) { // Don't bother setting up if we already exist elsewhere.
    instance_destroy();
    break;
}

windowList = ds_priority_create();
stackTop = noone;
colorSchema = ds_list_create();
global.winManager = self.id;
activeElement = noone;

// SETTINGS!
allDeactivate = true;       // Whether or not clicking on an empty space deactivates the currently active window
clearIO = true;             // If interaction with windows(selected window, text box) will clear the IO.
windowFont = winMan_title;  // What font to use in the title bar.

// Add color schemes here.
col_normal = ds_list_create();
col_reverse = ds_list_create();
col_inactive = ds_list_create();

windowInactiveScheme = col_inactive; // Color scheme for when a window goes inactive.
windowNormalScheme = col_normal;    // Default color scheme for when a window is created.

/* Each color scheme has 9 mandatory values.
    Value #     : Name
    Value 1     : Font Color
    Value 2     : Surface Color
    Value 3     : Gradient Start
    Value 4     : Gradient End
    Value 5     : Title Surrounding
    Value 6     : Exterior Upper
    Value 7     : Exterior Lower
    Value 8     : Exterior Left
    Value 9     : Exterior Right
    Following that, you have additional values that can be set. Additional values can be skipped by simply using the value noone.
    Value #     : Name                      : Default Behavior
    Value 10    : Element Exterior Upper    : Exterior Upper
    Value 11    : Element Exterior Lower    : Exterior Lower
    Value 12    : Element Exterior Left     : Exterior Left
    Value 13    : Element Exterior Right    : Exterior Right
    Value 14    : Button Interior           : Surface Color
*/

// Normal color scheme. Templated.
ds_list_add(col_normal, c_white);   // Font Color
ds_list_add(col_normal, c_white);   // Surface Color (white deactivates any effects)
ds_list_add(col_normal, c_blue);    // Gradient Start
ds_list_add(col_normal, c_teal);    // Gradient End
ds_list_add(col_normal, c_black);   // Title Surrounding
ds_list_add(col_normal, c_white);   // Exterior Upper
ds_list_add(col_normal, c_gray);    // Exterior Lower
ds_list_add(col_normal, c_black);   // Exterior Left
ds_list_add(col_normal, c_gray);    // Exterior Right
/* Unused, but kept for template purposes.
ds_list_add(col_normal, noone);    // Element Exterior Upper
ds_list_add(col_normal, noone);    // Element Exterior Lower
ds_list_add(col_normal, noone);    // Element Exterior Left
ds_list_add(col_normal, noone);    // Element Exterior Right
ds_list_add(col_normal, noone);    // Button Interior
*/

// Inverse color scheme.
ds_list_add(col_reverse, c_black);   // Font Color
ds_list_add(col_reverse, c_white);   // Surface Color (white deactivates any effects)
ds_list_add(col_reverse, c_teal);    // Gradient Start
ds_list_add(col_reverse, c_blue);    // Gradient End
ds_list_add(col_reverse, c_white);   // Title Surrounding
ds_list_add(col_reverse, c_gray);   // Exterior Upper
ds_list_add(col_reverse, c_black);    // Exterior Lower
ds_list_add(col_reverse, c_gray);    // Exterior Left
ds_list_add(col_reverse, c_black);    // Exterior Right

// Inactive
ds_list_add(col_inactive, c_dkgray);   // Font Color
ds_list_add(col_inactive, c_dkgray);   // Surface Color (white deactivates any effects)
ds_list_add(col_inactive, c_gray);    // Gradient Start
ds_list_add(col_inactive, c_white);    // Gradient End
ds_list_add(col_inactive, c_gray);   // Title Surrounding
ds_list_add(col_inactive, c_white);   // Exterior Upper
ds_list_add(col_inactive, c_silver);    // Exterior Lower
ds_list_add(col_inactive, c_black);    // Exterior Left
ds_list_add(col_inactive, c_silver);    // Exterior Right

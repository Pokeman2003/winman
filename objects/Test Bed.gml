#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
windowOpen = noone;
#define Mouse_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=541
applies_to=self
invert=0
arg0=buttonInv
arg1=0
arg2=1
*/
#define Mouse_56
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if (windowOpen == noone && sprite_index == buttonInv) {
    windowOpen = winMan_register("winMan Demo : Version " + string(VERSION), 255);
}
sprite_index = buttonDef;

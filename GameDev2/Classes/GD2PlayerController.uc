class GD2PlayerController extends UTPlayerController;
var SoundCue attackh;
var SoundCue attackm;
var SoundCue heartb;
var SoundCue heartf;
var SoundCue level;
//Function to output debug messages
simulated private function DebugPrint(int sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}
event Possess(Pawn inPawn, bool bVehicleTransition)
{
    super.Possess(inPawn, bVehicleTransition);
    SetTimer(5.51,true,'play');
    SetTimer(2.48,true,'playf');
    PlaySound(level);
    SetTimer(43,true,'levelp');
}
function levelp()
{
PlaySound(level);
}
function play()
{
if(GD2PlayerPawn(Pawn).Health > 300)
PlaySound(heartb);
}
function playf()
{
if(GD2PlayerPawn(Pawn).Health <= 300&& GD2PlayerPawn(Pawn).Health > 0)
PlaySound(heartf);
}
function GetTriggerUseList(float interactDistanceToCheck, float crosshairDist, float minDot, bool bUsuableOnly, out array<trigger> out_useList)
{
    //local int Idx;
    local vector cameraLoc;
    local rotator cameraRot;
    local trigger checkTrigger;
    //local SeqEvent_Used UseSeq;
 
    if (Pawn != None)
    {
        // grab camera location/rotation for checking crosshairDist
        GetPlayerViewPoint(cameraLoc, cameraRot); 
        // search of nearby actors that have use events 
        foreach Pawn.CollidingActors(class'trigger',checkTrigger,interactDistanceToCheck) 
        { 
            //8<------ 
            //Code from the parent function. I've snipped it, but you have to put it in 
            //or you'll basically break Use events in Kismet.
            //8<------
 
            //If it's a usable actor and it hasn't already been added to the list, let's add it. 
            if (ua(checkTrigger) != None && (out_useList.Length == 0 || out_useList[out_useList.Length-1] != checkTrigger))
            {
                out_useList[out_useList.Length] = checkTrigger;
            }
        }
    }
}
//combat function that exectues when z is pressed
exec function attackb()
{
local monster ai;
local float dot1;
local vector v;
local GD2PlayerPawn p;
local actor Player_location_actor;
local int Distance;
Player_location_actor = GetALocalPlayerController().Pawn;
p  = GD2PlayerPawn(Player_Location_Actor);
v = Vector(p.Rotation);
GD2PlayerPawn(Pawn).blockbb = false;
/*if(p.health <=0)
{
p.destroy();
}*/
ForEach AllActors(class'monster',ai)
{
Distance = VSize(Player_location_actor.Location - ai.Location);
dot1 =v dot (Player_location_actor.Location - ai.Location);
//DebugPrint(dot1);
if(Distance<0)
    Distance*=-1;
if(Distance>175&&Distance<275&&dot1 < 0)
{
PlaySound(attackh);
ai.monster_health-=10;
ai.dead();
}
}
PlaySound(attackm);
}
//block function that executes when c is pressed
exec function blockb()
{
local float dot1;
local vector v;
local GD2PlayerPawn p;
local monster ai;
local actor Player_location_actor;
local int Distance;
/*if(p.health <=0)
{
p.destroy();
}*/
Player_location_actor = GetALocalPlayerController().Pawn;
p  = GD2PlayerPawn(Player_Location_Actor);
v = Vector(p.Rotation);
ForEach AllActors(class'monster',ai)
{
Distance = VSize(Player_location_actor.Location - ai.Location);
dot1 =v dot (Player_location_actor.Location - ai.Location);
if(Distance<0)
    Distance*=-1;
if(Distance<700 && Distance<175 &&dot1 < 0)
{
GD2PlayerPawn(Pawn).blockbb = true;
}
else
GD2PlayerPawn(Pawn).blockbb = false;
}
}

defaultproperties
{
   CameraClass=class'GameDev2.GD2PlayerCamera'
   bCollideActors=true
   attackh =  SoundCue'Sounds.attack_hit_cue'
   attackm =  SoundCue'Sounds.attack_miss_cue'
   heartb =  SoundCue'Sounds.heart_beatc'
   heartf =  SoundCue'Sounds.heart_beat_fastc'
   level = SoundCue'Sounds.windc'
   // bBehindView=false
   // bForceBehindView=false
}
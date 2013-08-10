class GameDev2 extends FrameworkGame;
/*
Game Class for Landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialized variables
var SoundCue level;
var LF_Main_Menu main;
var bool bLoaded;

///////////////////////////////////////////////
//event after player is loaded into game
event PostLogin( PlayerController NewPlayer )
{
 //local GD2Hud hud;
	local string url;
 	local actor Player_Location_Actor;
    local GD2PlayerPawn LF_pawn;
	local LF_save_info save_info;
	local vector vec;
 super.PostLogin( NewPlayer );
 //`log(GetURLMap());
 //`log(GetAddressURL());
 //`log(GetLocalURL());
 //hud = GD2Hud();
 //hud.CheckViewPortAspectRatio();
 Player_Location_Actor = GetALocalPlayerController().Pawn;
 LF_pawn = GD2PlayerPawn(Player_Location_Actor);
 PlaySound(level);
 SetTimer(43,true,'levelp');
 url = WorldInfo.GetLocalURL();
 `log(url);
 if(Instr(url,"?load",,true)!=-1)
 {
	save_info = class'LF_save_info'.static.load_options();
	if(save_info == none)
	{
		save_info = new class'LF_save_info';
	}
	LF_Pawn.mission1 = save_info.mission_1;
	LF_Pawn.mission2a = save_info.mission_2;
	LF_Pawn.mission3 = save_info.mission_3;
	LF_Pawn.mission4 = save_info.mission_4;
	LF_Pawn.mission5 = save_info.mission_5;
	LF_Pawn.flashlightc = save_info.flashlight_state;
	vec.x = save_info.loc_x;
	vec.y = save_info.loc_y;
	vec.z = save_info.loc_z;
	`log(vec.z@vec.y@vec.z);
	LF_Pawn.SetLocation(vec);
 	`log(LF_Pawn.mission1);
 }
 //main = new class'LF_Main_Menu';
 //main.Init();
 }
 function levelp()
{
PlaySound(level);
}
///////////////////////////////////////////////


static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
return Default.class;
}
event PostBeginPlay()
{
	super.PostBeginPlay();

}
defaultproperties
{
   PlayerControllerClass=class'GameDev2.GD2PlayerController'
   DefaultPawnClass=class'GameDev2.GD2PlayerPawn'
   HUDType=class'GameDev2.GD2Hud'
   level = SoundCue'Sounds.windc'
   bDelayedStart=false
}


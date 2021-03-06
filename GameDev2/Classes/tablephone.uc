class tablephone extends trigger;
/*
Interactable table used for dialog excahnge in landfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var int search;
var bool IsInInteractionRange;
var bool firsttime;
var bool play;
var bool play_sequence;
var SoundCue duc;
var SoundCue linesdead;
var SoundCue hello;
var SoundCue us;
var SoundCue island;
var SoundCue relax;
var SoundCue dial;
var SoundCue staticc;
var(Rendertext) Font lf;


//Debug Function
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}


//When touched it is interactable
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {
        
        PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        IsInInteractionRange = true;
        //idle();
        //DebugPrint("here");
    }
}


//Can no longer interact when the line is dead
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
       
    }
}

//Renders prompts based on the state of the trigger
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local Font previous_font;
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
	
    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
	
    if(search == 0 && a.mission2a == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press E to Investigate");
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    //a.mission2b = true;
    }
	
    else if(search == 1 && a.mission2b == true)
    {
    previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press E to Repair");
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
	
    if(search == 2)
    {
	previous_font = Canvas.Font;
    Canvas.Font = lf;
    Canvas.SetPos(400,300);
    Canvas.SetDrawColor(255,50,15,255);
    Canvas.DrawText("Press E to Interact");
    Canvas.Font = previous_font; 
    previous_font = Canvas.Font;
    }
    
}


//When used, depending on the trigger state, a certain dialog sequence will play
function bool UsedBy(Pawn User)
{
    local bool used;
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
	
    //DebugPrint("f");
    used = super.UsedBy(User);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
	
    if (IsInInteractionRange&&search!=2&&a.mission2a==true)
    {
        //DebugPrint("F");
     
        search = 1;
        if(play== false)
        {
        PlaySound(linesdead);
        play = true;
        a.mission2b = true;
        }
		
        if(a.duct == 1 && a.wire == 1 && a.strip == 1&& play_sequence == false)
        {
        PlaySound(duc);
        PlaySound(dial);
		
        search = 2;
        a.GroundSpeed = 0;
        play_sequence = true;
		
        PlaySound(hello);
        PlaySound(us);
        PlaySound(island);
        PlaySound(relax);
        a.wait();
        }
		
		if(search == 2)
		{
		PlaySound(staticc);
        }
		
        return true;
    }
    return used;
} 

DefaultProperties
{
    Begin Object Name=Sprite
        HiddenGame=true HiddenEditor=true
    End Object
	
    Begin Object Name=CollisionCylinder
       CollisionHeight =40.000000
       CollisionRadius=20.00000
    End Object
    CylinderComponent=CollisionCylinder
	
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'table_comp_phone.table_comp_phone'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    linesdead = SoundCue'Sounds.shitthelineisdeadc'
    duc = SoundCue'Sounds.duct_tapec'
    hello = SoundCue'Sounds.hello_hello_crapc'
    us = SoundCue'Sounds.uss103c'
    island = SoundCue'Sounds.imonanisladnc'
    relax = SoundCue'Sounds.relaxlocationc'
    dial = SoundCue'Sounds.dialc'
	staticc = SoundCue'Sounds.staticc'
	
    bBlockActors=true
    bCollideActors=true
    bHidden=false
    bStatic = true
    bPostRenderIfNotVisible=true
    search = 0
    firsttime = true
    play = false
    play_sequence = false
	
    lf = Font'EngineFonts.lffont'
}

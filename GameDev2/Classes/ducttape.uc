class ducttape extends trigger;
/*
Interactable duct tape needed for mission2
of Lanfall
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var int search;
var bool IsInInteractionRange;
var bool firsttime;
var bool play;
var bool playa;
var SoundCue clicky;
var(Rendertext) Font lf;


//Debug Print
simulated private function DebugPrint(string sMessage)
{
	GetALocalPlayerController().ClientMessage(sMessage);
}

// When touching the trigger it becomes interactable
event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
 
    if (Pawn(Other) != none)
    {

        PlayerController(Pawn(Other).Controller).myHUD.AddPostRenderedActor(self);
        IsInInteractionRange = true;
        //DebugPrint("here");
    }
}

// An un touch makes the trigger no longer interactable
event UnTouch(Actor Other)
{
    super.UnTouch(Other);
 
    if (Pawn(Other) != none)
    {
        PlayerController(Pawn(Other).Controller).myHUD.RemovePostRenderedActor(self);
        IsInInteractionRange = false;
        /*if(search == 1)
        {
           search = 2;
        }*/
    }
}

// Prompts user to interact with duct tape when touching it
simulated event PostRenderFor(PlayerController PC, Canvas Canvas, Vector CameraPosition, Vector CameraDir)
{
    local Font previous_font;
    //local actor Player_Location_Actor;
    //local GD2PlayerPawn a;
    super.PostRenderFor(PC, Canvas, CameraPosition, CameraDir);
    //Player_Location_Actor = GetALocalPlayerController().Pawn;
    //a = GD2PlayerPawn(Player_Location_Actor);
		if(search == 0)// && a.mission2b == true)
		{
		previous_font = Canvas.Font;
		Canvas.Font = lf;
		Canvas.SetPos(400,300);
		Canvas.SetDrawColor(255,50,15,255);
		Canvas.DrawText("Press E to Pick Up"); //Prompt is a string variable defined in our new actor's class.
		Canvas.Font = previous_font; 
		previous_font = Canvas.Font;
		//a.mission2b = true;
		}
		else if(search == 1)
		{
		self.Destroy();
		}

}
// Plays a sound and destroys the duct tape when initialized
function bool UsedBy(Pawn User)
{
    local bool used;
    local actor Player_Location_Actor;
    local GD2PlayerPawn LF_Pawn;
    //DebugPrint("f");
    used = super.UsedBy(User);
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    LF_Pawn = GD2PlayerPawn(Player_Location_Actor);
    if (IsInInteractionRange&&search!=1)//&&a.mission2b==true)
    {
        //DebugPrint("F");
        //If it matters, you might want to double check here that the user is a player-controlled pawn.
        search = 1;
        if(play== false)
        {
        PlaySound(clicky);
        play = true;
        LF_Pawn.duct+=1;
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
       StaticMesh=StaticMesh'duct_tape.duct_tape'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    clicky = SoundCue'Sounds.clickc'
	
	search = 0
		
    bBlockActors=true
    bCollideActors=true
    bHidden=false
    bNoDelete = false
    bStatic = false
    bPostRenderIfNotVisible=true
    firsttime = true
    play = false
    playa = false
	
    lf = Font'EngineFonts.lffont'
}

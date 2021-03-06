class rotatinglights extends actor
placeable;
/*
Rotates the lights on the carosel
DangerZone Games: James Ross (rossj511@gmail.com)
Date : 04/24/2013
All code (c)2012 DangerZone Games inc. all rights reserved
*/

//initialize variables
var int RotatingSpeed;
var int SpeedFade;


//Changes yaw every frame to allow a spin
event Tick( float DeltaTime ) 
{
    local Rotator final_rot;
	
    super.Tick(DeltaTime);
	
    final_rot = Rotation;
	RotatingSpeed = FMax(RotatingSpeed - SpeedFade* DeltaTime,0);
	final_rot.Yaw = final_rot.Yaw + RotatingSpeed*DeltaTime;
	SetRotation(final_rot);
}
defaultproperties
{
    //may need .mesh when textured
    Begin Object Class=StaticMeshComponent Name=MyMesh
       StaticMesh=StaticMesh'LF_Buildings.carouselLights'
    End Object
    CollisionComponent=MyMesh 
    Components.Add(MyMesh)
	
    RotatingSpeed = 12000
    SpeedFade = 1
	
	bHidden = false
}
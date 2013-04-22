class testweapon extends UDKWeapon;
var bool check;
var AnimNodePlayCustomAnim Attack;
//var AnimNodePlayCustomAnim Idle;
var AnimNodePlayCustomAnim Block;
simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
    super.PostInitAnimTree(SkelComp);

    if (SkelComp == Mesh)
    {                                                                   //custom animation names
        Attack = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('FP_attack_node'));     //('Fp_attack'));
        Block = AnimNodePlayCustomAnim(SkelComp.FindAnimNode('FP_block_node'));     //('Fp_block'));
        //Idle = AnimNodePlayCustomAnim(SkelComp.FindAnimNode(');      //('FP_idle'));
    }
}
simulated event SetPosition(UDKPawn Holder)
{
    local vector FinalLocation;
    local vector X,Y,Z;
    local GD2PlayerController k;
    local actor Player_Location_Actor;
    local GD2PlayerPawn a;
    Player_Location_Actor = GetALocalPlayerController().Pawn;
    a = GD2PlayerPawn(Player_Location_Actor);
    k= GD2PlayerController(a.controller);
    //local rotator c;
    Holder.GetAxes(Holder.Controller.Rotation,X,Y,Z);
    FinalLocation= Holder.GetPawnViewLocation(); //this is in world space.
    FinalLocation= FinalLocation-Y*9-Z*20; // Rough position adjustment
    //FinalLocation= FinalLocation- Y * -12 - Z * -32;
    SetHidden(False);
    SetLocation(FinalLocation);
    SetBase(Holder);
    SetRotation(Holder.Controller.Rotation);
    if(k.checka == true)
    {
    Attack.playcustomanim('FP_attack',1.0 );
    }
    if(k.checkb == true)
    {
    Block.playcustomanim('FP_block',1.0 );
    }
    //Attack.playcustomanim('FP_attack',1.0 );
    //c.yaw = c.yaw - 15000;
    //SetRotation(c);
}

DefaultProperties
{
    /*Begin Object Class=StaticMeshComponent Name=GunMesh
        StaticMesh=StaticMesh'FP_arms_test.FParms_test2'
        Rotation=(Yaw=-15000)
        HiddenGame=FALSE
        HiddenEditor=FALSE
        CastShadow = False
    end object*/
    Begin object class=AnimNodeSequence name=armanim 
    End object
    Begin Object class=SkeletalMeshComponent Name=MySkeletalMeshComponent
    SkeletalMesh=SkeletalMesh'FP_arms_pckg.FP_animations_mesh'
    AnimtreeTemplate= AnimTree'FP_arms_pckg.FP_arms_animtree'
    AnimSets(0)=AnimSet'FP_arms_pckg.FP_arms_animset'
    Translation=(Z=0.0)
    End Object
    Mesh=MySkeletalMeshComponent
    //bCastShadows = false
    Components.Add(MySkeletalMeshComponent)
    check = false
   //SpawnRotation=(yaw=6000)
}
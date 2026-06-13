using Godot;
using System;

public partial class G : Node
{
    public static G M { get; private set; }
    public Node Main { get; set; }
    public GodotObject Generic { get; set; }
    public SceneTree Tree { get; private set; }
    public Node Dialogic { get; private set; }
    
    public bool IsTalking = false;
    public bool IsMenus = false;
    public bool Stopped => IsTalking || IsMenus;
    public override void _Ready()
    {
        M = this;
        Generic = (GodotObject)GD.Load<GDScript>("res://GenericScenes/generic.gd").New();
        Tree = (SceneTree)Engine.GetMainLoop();
        Dialogic = GetNode("/root/Dialogic");
        
        Dialogic.Connect("timeline_started", Callable.From(OnTimelineStarted)); 
        Dialogic.Connect("timeline_ended", Callable.From(OnTimelineEnded));
    }

    private void OnTimelineStarted()
    {
        IsTalking = true;
    }
    private void OnTimelineEnded()
    {
        IsTalking = false;
    }
}
public static class Dialogic
{
    public static void Start(GodotObject timelineName)
    {
        G.M.Dialogic.Call("start", timelineName);
    }

    public static void Pause()
    {
        G.M.Dialogic.Call("pause");
    }

    public static void Resume()
    {
        G.M.Dialogic.Call("resume");
    }
    public static void PlayRawText(string dialogue)
    {
        if (string.IsNullOrWhiteSpace(dialogue))
        {
            return;
        }

        GodotObject tm = (GodotObject)G.M.Generic.Call("PlayRawText", dialogue);
        Start(tm);
    }
}
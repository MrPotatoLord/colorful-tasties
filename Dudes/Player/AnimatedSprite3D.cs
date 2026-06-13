using Godot;
namespace Player;

public partial class AnimatedSprite3D : Godot.AnimatedSprite3D
{
    public void Walk(Vector2 dir)
    {
        if(dir.IsZeroApprox())
        {
            Play("default");
            FlipH = false;
        }
        else
        {
            Play("walk_forw");
        }
    }
}
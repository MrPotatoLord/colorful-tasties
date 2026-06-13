using Godot;
using System;
namespace Player;
public partial class Player : CharacterBody3D
{
    private RayCast3D _rayCast;
    private AnimatedSprite3D _animatedSprite;
    
    private float _speed = 5.0F;
    private float _rayLength;
    private float _rayPos;
    public override void _Ready()
    {
        _animatedSprite = GetNode<AnimatedSprite3D>("AnimatedSprite3D");
        _rayCast = GetNode<RayCast3D>("RayCast3D");
        _rayLength = _rayCast.TargetPosition.Length();
        _rayPos = _rayCast.Position.Length();
    }

    public override void _PhysicsProcess(double delta)
    {
        float deltaTime = (float)delta;
        Vector3 velocity = Velocity;
        if(!IsOnFloor())
        {
            velocity += GetGravity() * deltaTime;
        }
        Velocity = velocity;

        if (!G.M.Stopped)
        {
            Move(Input.GetVector("ui_left", "ui_right", "ui_up", "ui_down"), deltaTime);
        }

        
        MoveAndSlide();
    }

    private void Move(Vector2 inputDir, float deltaTime)
    {
        _animatedSprite.Walk(inputDir); 
        Vector3 direction = (Transform.Basis * new Vector3(inputDir.X, 0, inputDir.Y)).Normalized();
        Vector3 velocity = Velocity;
        
        if (direction != Vector3.Zero)
        {
            _rayCast.TargetPosition = direction * _rayLength;
            _rayCast.Position = -direction * _rayPos;

            velocity.X = direction.X * _speed;
            velocity.Z = direction.Z * _speed;
        }
        else
        {
            velocity.X = Mathf.MoveToward(velocity.X, 0, _speed);
            velocity.Z = Mathf.MoveToward(velocity.Z, 0, _speed);
        }

        Velocity = velocity; 
    }
    public override void _Input(InputEvent @event)
    {
        if (@event.IsActionPressed("interact") && !G.M.Stopped)
        {
            if (_rayCast.GetCollider() is IInteractable interactableTarget)
            { 
                interactableTarget.Interact(this); 
            }
        }
    }
}
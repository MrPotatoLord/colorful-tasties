using Godot;
using System;

public partial class Turtle : StaticBody3D, IDialog
{
	[Export(PropertyHint.MultilineText)]
	public string Dialog { get; set; }
	public override void _Ready()
	{
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}
}

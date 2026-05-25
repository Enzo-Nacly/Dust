using Godot;
using System;

public virtual partial class Interactable : Node
{
	public abstract void Interagir()

	public override void _Ready()
	{
		collision_shape = GetNode<CollisionShape2D>("CollisionShape2D");
	}
}

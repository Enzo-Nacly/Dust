using Godot;
using System;



// estava dando dois erros:
// 1 - Método Abstrato não pode existir se a classe não for abstrata;
// 2 - o modificador virtual não pode existir pro item, a gente não sabe o porque desse segundo.
public abstract partial class Interactable : Node
{
	private CollisionShape2D collision_shape;

	public abstract void Interagir();

	public override void _Ready()
	{
		collision_shape = GetNode<CollisionShape2D>("CollisionShape2D");
	}
}

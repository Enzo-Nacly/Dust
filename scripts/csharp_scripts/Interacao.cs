using Godot;
using System;

public partial class Interacao : Node2D
{
	private Node2D _entidade;

	public void Setup(Node2D entidade)
	{
		this._entidade = entidade;
	}

	public override void _Process(double delta)
	{
		if (Input.IsActionJustPressed("interact"))
		{
			GD.Print("Interação funcionando no frame corrente!");
		}
	}
}

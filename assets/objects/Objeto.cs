using Godot;
using System;

public partial class Objeto : StaticBody2D
{
	private Planet planet;
	private RotationComponent rotationComponent;
	public override void _Ready()
	{
		rotationComponent = GetNode<RotationComponent>("Rotation_Component");
		rotationComponent.Setup(this);

		planet = GetTree().GetNodesInGroup("planets")[0] as Planet;
	}

	public override void _Process(double delta)
	{
		Vector2 forcaGravitacional = planet.PegarGravidadeEm(GlobalPosition);

        if (forcaGravitacional != Vector2.Zero)
        {
            Vector2 vetorCentro = forcaGravitacional.Normalized();
            rotationComponent.AtualizarRotacao(vetorCentro);
		}
	}
}

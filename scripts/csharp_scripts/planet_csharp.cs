using Godot;
using System;
using System.ComponentModel;

public partial class planet_csharp : StaticBody2D
{
	[Export] public PlanetStatus planetStatus;

	private GravityComponet gravityComponent;
	private CollisionShape2D collision_shape;

	public override void _Ready()
	{
		gravityComponent = GetNode<GravityComponet>("Gravity_Component");
		collision_shape = GetNode<CollisionShape2D>("CollisionShape2D");

		gravityComponent.setup(this, planetStatus.raio);
		if(collision_shape.Shape is CircleShape2D)
		{
			CircleShape2D shape = (CircleShape2D)(collision_shape.Shape);
			shape.Radius = planetStatus.raio;		
		}	
	}

	public Godot.Vector2 pegarGravidadeEm(Godot.Vector2 posicaoParticula)
	{
		return gravityComponent.pegarGravidadeEm(posicaoParticula);
	}

    public override void _Draw()
    {
        Vector2 posicaoCentro = Vector2.Zero;
		DrawCircle(posicaoCentro, planetStatus.raio, planetStatus.cor);
    }

}

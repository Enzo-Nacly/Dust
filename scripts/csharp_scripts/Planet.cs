using Godot;
using System;
using System.ComponentModel;

//public partial class Planet : StaticBody2D
//{
	//[Export] public PlanetStatus planetStatus;
//
	//private GravityComponent gravityComponent;
	//private CollisionShape2D collision_shape;
//
	//public override void _Ready()
	//{
		//gravityComponent = GetNode<GravityComponent>("Gravity_Component");
		//collision_shape = GetNode<CollisionShape2D>("CollisionShape2D");
//
		//gravityComponent.Setup(this, planetStatus.raio);
		//if(collision_shape.Shape is CircleShape2D)
		//{
			//CircleShape2D shape = (CircleShape2D)(collision_shape.Shape);
			//shape.Radius = planetStatus.raio;		
		//}	
	//}
//
	//public Godot.Vector2 PegarGravidadeEm(Godot.Vector2 posicaoParticula)
	//{
		//return gravityComponent.PegarGravidadeEm(posicaoParticula);
	//}
//
	//public override void _Draw()
	//{
		//Vector2 posicaoCentro = Vector2.Zero;
		//DrawCircle(posicaoCentro, planetStatus.raio, planetStatus.cor);
	//}
//
//}
public partial class Planet : StaticBody2D
{
	[Export] public PlanetStatus planetStatus;
	
	private GravityComponent gravityComponent;
	private CollisionShape2D collisionShape;
	private Sprite2D sprite;

	public override void _Ready()
	{
		gravityComponent = GetNode<GravityComponent>("Gravity_Component");
		collisionShape = GetNode<CollisionShape2D>("CollisionShape2D");
		sprite = GetNode<Sprite2D>("Sprite2D"); 

		gravityComponent.Setup(this, planetStatus.raio);

		if (collisionShape.Shape is CircleShape2D circleShape)
		{
			circleShape.Radius = planetStatus.raio;
		}

		AjustarTamanhoDoSprite();
	}

	private void AjustarTamanhoDoSprite()
	{
		if (sprite.Texture == null) return;


		float tamanhoOriginalDaImagem = sprite.Texture.GetSize().X;

		float diametroDesejado = planetStatus.raio * 2;

		float novaEscala = diametroDesejado / tamanhoOriginalDaImagem;


		sprite.Scale = new Vector2(novaEscala, novaEscala);
		
	}

	public Godot.Vector2 PegarGravidadeEm(Godot.Vector2 posicaoParticula)
	{
		return gravityComponent.PegarGravidadeEm(posicaoParticula);
	}
}

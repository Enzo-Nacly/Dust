using System;
using Godot;

public partial class MovementComponent : Node2D  
{
	[Export] float proporcaoVelocidade = 5.0f;

	const float MULTIPLICADOR_VELOCIDADE = 100.0f;
	const float VELOCIDADE_ANGULAR = 1.0f/30.0f;
	const float ATRITO = 500.0f;
	const float ACELERACAO = 500.0f;

	CharacterBody2D entidade;

	public void Setup(CharacterBody2D entidade)
	{
		this.entidade = entidade;
	}
	


	public void Mover(float delta)
	{
		

		
		float direcao = Input.GetAxis("ui_left", "ui_right");

		if(entidade.MotionMode == CharacterBody2D.MotionModeEnum.Floating)
		{
			entidade.Rotate(VELOCIDADE_ANGULAR * direcao);
			return;
		}

		if(direcao != 0.0f)
			AplicarAceleracao(delta, direcao);

		else if (entidade.IsOnFloor())
		{
			float moduloVelocidadeLateral = entidade.Velocity.Dot(entidade.Transform.X);
			if(moduloVelocidadeLateral != 0.0f)
				AplicarAtrito(delta);
		}
	}


	private void AplicarAceleracao(float delta, float direcao)
	{
		float moduloVelocidadeLateral = entidade.Velocity.Dot(entidade.Transform.X);
		Godot.Vector2 velocidadeLateral = entidade.Transform.X * moduloVelocidadeLateral;

		float moduloVelocidade = direcao * proporcaoVelocidade * MULTIPLICADOR_VELOCIDADE;
		float moduloVelocidadeLateralAcelerada = Mathf.MoveToward(moduloVelocidadeLateral, moduloVelocidade, ACELERACAO * delta);
		Godot.Vector2 velocidadeLateralAcelerada = entidade.Transform.X * moduloVelocidadeLateralAcelerada;

		entidade.Velocity -= velocidadeLateral;
		entidade.Velocity += velocidadeLateralAcelerada;
	}


	private void AplicarAtrito(float delta)
	{
		float moduloVelocidadeLateral = entidade.Velocity.Dot(entidade.Transform.X);
		Godot.Vector2 velocidadeLateral = entidade.Transform.X * moduloVelocidadeLateral;

		float moduloVelocidadeLateralAtritada =  Mathf.MoveToward(moduloVelocidadeLateral, 0.0f, ATRITO * delta);
		Godot.Vector2 velocidadeLateralAtritada = entidade.Transform.X * moduloVelocidadeLateralAtritada;

		entidade.Velocity -= velocidadeLateral;
		entidade.Velocity += velocidadeLateralAtritada;
	}
}

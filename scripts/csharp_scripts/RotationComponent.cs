using System;
using Godot;

public partial class RotationComponent : Node2D
{
	private static readonly float AJUSTE_ORIENTACAO_SPRITE = Mathf.Pi / 2.0f;

	Node2D entidade;

	public void Setup(Node2D entidade)
	{
		this.entidade = entidade;
	}


	public void AtualizarRotacao(Godot.Vector2 vetorCentro)
	{
		entidade.Rotation = vetorCentro.Angle() - AJUSTE_ORIENTACAO_SPRITE;
	}
}

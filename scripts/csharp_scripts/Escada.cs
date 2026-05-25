using Godot;
using System;

public partial class Escada : Node2D
{
	private Area2D andarEmbaixo;
	private Area2D andarCima;
    private CollisionShape2D collisionCima;

    public override void _Ready()
    {
        andarEmbaixo = GetNode<Area2D>("andar_embaixo");
		andarCima = GetNode<Area2D>("andar_cima");

        collisionCima = GetNode<CollisionShape2D>("andar_cima/CollisionShape2D");

        andarEmbaixo.BodyEntered += OnBodyEnteredEmbaixo;
    }


    private void OnBodyEnteredEmbaixo(Node2D body)
    {
        if(body is Player)
        {
            GD.Print("entrou, embaixo");
            body.GlobalPosition = collisionCima.GlobalPosition;
        }
    }

    private void OnBodyEnteredCima(Node2D body)
    {
        
    }
}

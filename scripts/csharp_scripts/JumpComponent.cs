using Godot;

public partial class JumpComponent : Node2D
{
    [Export] public float forcaPulo = 400.0f;

    private CharacterBody2D entidade;

    public void Setup(Node2D entidade)
    {
        this.entidade = entidade as CharacterBody2D;
    }

    public void Pular(Vector2 vetorCentro)
    {
        bool quisPular = Input.IsActionJustPressed("ui_accept");
        bool estaNoChao = entidade.IsOnFloor();

        if (quisPular && estaNoChao)
        {
            entidade.Velocity -= vetorCentro * forcaPulo;
        }
    }
}
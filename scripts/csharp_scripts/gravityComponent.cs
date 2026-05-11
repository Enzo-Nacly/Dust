using Godot;
using System;

public partial class GravityComponent : Node2D
{
    [Export] private bool desenharCirculoInfluencia = true;

    const float MULTIPLICADOR_RAIO = 3.0f;

    Node2D entidade;
    private int forcaGravidade;
    private float raioInfluencia;

    public void Setup(Node2D entidade, int raio)
    {
        this.entidade = entidade;
        raioInfluencia = MULTIPLICADOR_RAIO * raio;
        forcaGravidade = CalcularForcaGravidade(raio);
    }

    private float LogBase(float numero, float baseLog)
    {
        return (float)(Math.Log(numero)/Math.Log(baseLog));
    }

    private int CalcularForcaGravidade(float raio)
    {
        const float BASE_LOG = 2.5f;
        float forcaG = (float)(LogBase(raio, BASE_LOG) * Math.Pow(10, 2));
        return (int)(forcaG);
    }

    public Godot.Vector2 PegarGravidadeEm(Godot.Vector2 posicaoParticula)
    {
        Godot.Vector2 vetorCentro = entidade.GlobalPosition - posicaoParticula;
        float distancia = vetorCentro.Length();
        if(distancia > raioInfluencia)
            return Godot.Vector2.Zero;

        Godot.Vector2 forcaGravitacional = vetorCentro.Normalized() * forcaGravidade;
        return forcaGravitacional;
    }

    public override void _Draw()
    {
        if (desenharCirculoInfluencia)
        {
            Godot.Vector2 centroCirculo = Godot.Vector2.Zero;
            int segmentosArco = (int)((raioInfluencia/MULTIPLICADOR_RAIO)/4);
            float grossuraArco = 2.0f;
            DrawArc(centroCirculo, raioInfluencia, 0, Mathf.Tau, segmentosArco, Colors.Red, grossuraArco);
        }
    }
}
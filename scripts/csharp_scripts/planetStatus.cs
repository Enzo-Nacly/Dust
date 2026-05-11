using Godot;

[GlobalClass]
public partial class PlanetStatus : Resource
{
    [Export] public int raio = 200;
    [Export] public Color cor = Colors.Red;
}
using Godot;

public partial class Player : CharacterBody2D
{
	private MovementComponent movementComponent;
	private RotationComponent rotationComponent;
	private JumpComponent jumpComponent;
	private Planet planet;

	public override void _Ready()
	{
		movementComponent = GetNode<MovementComponent>("Components/Movement_Component");
		rotationComponent = GetNode<RotationComponent>("Components/Rotation_Component");
		jumpComponent = GetNode<JumpComponent>("Components/Jump_Component");

		// get_tree().get_nodes_in_group("planets")[0]
		planet = GetTree().GetNodesInGroup("planets")[0] as Planet;

		movementComponent.Setup(this);
		rotationComponent.Setup(this);
		jumpComponent.Setup(this);
		
	}

	public override void _PhysicsProcess(double delta)
	{

			movementComponent.Mover((float)delta);

			Vector2 forcaGravitacional = planet.PegarGravidadeEm(GlobalPosition);

			if (forcaGravitacional != Vector2.Zero)
			{
				Vector2 vetorCentro = forcaGravitacional.Normalized();
				rotationComponent.AtualizarRotacao(vetorCentro);

				UpDirection = -vetorCentro;
				MotionMode = MotionModeEnum.Grounded;
				jumpComponent.Pular(vetorCentro);

				Velocity += forcaGravitacional * (float)delta;
			}
			else
			{
				MotionMode = MotionModeEnum.Floating;
			}
			
			MoveAndSlide();
		}
	}

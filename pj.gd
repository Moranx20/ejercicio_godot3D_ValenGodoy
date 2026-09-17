extends CharacterBody3D

const MAX_JUMP = 2 

@onready var camara: Camera3D = $Camera3D

var JUMP = 13
var speed: int = 1000
var direccion: Vector3
var sensibilidad: float = 0.01
var jump_count = 0


func _ready():
	add_to_group("player")

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	
	if Input.is_action_just_pressed("Up") and jump_count < MAX_JUMP:
		velocity.y = JUMP
		jump_count +=1
	
	run(delta)
	
	if is_on_floor():
		jump_count = 0
	
	move_and_slide()
	print("¿Está en el suelo?: ", is_on_floor())


func _input(event):
	moverCamara(event)

func run(delta):
	direccion = transform.basis * Vector3(Input.get_axis("Right","Left"), 0, Input.get_axis("Back","Frontal")).normalized()
	velocity.x = direccion.x * speed * delta
	velocity.z = direccion.z * speed * delta



func moverCamara(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensibilidad)

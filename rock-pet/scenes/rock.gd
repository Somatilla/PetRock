extends Area2D

var happinessGoDown = 0
var bored = false
var happiness = 50
var hunger = 100
@onready var bubble = $"text"

func _process(delta: float) -> void:
	hunger -= 5 * delta / 5
	happiness = happiness - happinessGoDown * delta
	happiness = clamp(happiness,0,100)
	hunger = clamp(hunger, 0, 100)

	$UI/FoodBar.value = hunger
	$UI/HappinessBar.value = happiness
	
	if hunger > 90:
		print("im full")
		bubble.text = "I'm full!"
		happinessGoDown - 0.3
		
	elif bored:
		bubble.text = "I'm bored :/ "
		
	elif hunger > 20 and hunger < 90:
		bubble.text = ""

	elif hunger < 20:
		bubble.text = "I'm hungry!"
		happinessGoDown = happinessGoDown + 0.2
		happinessGoDown = clamp(happinessGoDown,0,100)
		
	if happiness > 70 :
		$RockSprite.texture = load("res://images/happyrock.png")
	elif happiness > 40 :
		$RockSprite.texture = load("res://images/justarock.png")
	else:
		$RockSprite.texture =load("res://images/sadrock.png")
	
func _on_food_pressed() -> void:
	hunger += 10
	hunger = clamp(hunger, 0, 100)
	$BoringTimer.start(600.0)

	print(hunger)

	if hunger >= 100:
		print("im full")
	if bored :
		happinessGoDown = happinessGoDown + 0.1
		happinessGoDown = clamp(happinessGoDown,0,100)

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		happiness = happiness + 3
		happiness = clamp(happiness,0,100)
		print(happiness)
		happinessGoDown = happinessGoDown - 0.1
		happinessGoDown = clamp(happinessGoDown,0,100)
		bored = false


func _on_boring_timer_timeout() -> void:
	bored = true
	print("im bored")

extends Control

var lives_pos = Vector2.ZERO
var lives_index = 30
onready var Indicator = load("res://UI/indicator.tscn")

func _ready():
	lives_pos.x = 20
	lives_pos.y = Global.VP.y-20
	update_score()
	update_time()
	update_lives()

func update_score():
	$Score.text = "Score: " + str(Global.score)
	
func update_time():
	$Time.text = "Time Remaining: " + str(Global.time)
	
func _on_Timer_timeout():
	Global.time -= 1
	if Global.time < 0:
		var _scene = get_tree().change_scene("res://UI/End_Game.tscn")
	else: 
		update_time()
		
func update_lives():
	lives_pos = Vector2(20,Global.VP.y-20)
	for child in $Indicator_Containor.get_children():
		child.queue_free()
	for i in range(Global.lives):
		var indicator = Indicator.instance()
		indicator.position = Vector2(lives_pos.x+i*lives_index, lives_pos.y)
		add_child(indicator)
		$Indicator_Containor.add_child(indicator)

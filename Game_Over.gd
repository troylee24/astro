extends Node2D

func _ready():
	if Master.score == 150:
		$Control/GameOverLabel.text = "game win"
	Master.play("res://music/Retro_No hope.ogg",-10)
	$Control/CurrentScoreLabel.text += str(Master.score) + " secs."
	$Control/BestScoreLabel.text += str(Master.best_score) + " secs."

func _process(_delta):
	if Input.is_action_just_pressed("restart"):
		Master.stop_all()
		Master.goto_scene("res://StartMenu.tscn",true)

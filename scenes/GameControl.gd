extends Node

var Fracture = preload("res://scenes/entities/fracture.tscn")
var Bomb = preload("res://scenes/entities/bomb.tscn")
var Spark = preload("res://scenes/entities/spark.tscn")

#var score = 0 
var oxygen = 100000
var spawnedFractures = 0

var isMoving = false
var isCharging = false

var deadZones = 0
const BASE_TIMER = 300
const TIMER_PENALTY = 50
var timer = BASE_TIMER
var rng = RandomNumberGenerator.new()



var hasPlayedDestroy = [false, false, false, false, false, false]
var hasPlayedAlert = [false, false, false, false, false, false]



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.score = 0
	rng.randomize()
	for i in 20:
		$TileMap.tile_set.tile_set_modulate(i, Globals.neutralColor)
	for j in 6:
		$TileMap.tile_set.tile_set_modulate(j+1, Globals.zoneColor)
	$TileMap.tile_set.tile_set_modulate(21, Globals.YELLOW)
	get_parent().get_node("ColorRect").color = Globals.backgroundColor
	$Player.modulate = Globals.botColor


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= 1
	if Globals.spawnPowerup:
		Globals.spawnPowerup = false
		var spawnZone = rng.randi_range(1, 6)
		var newPowerup = Spark.instance()
		var tileArray = $TileMap.get_used_cells_by_id(spawnZone)
		var randomIndex = rng.randi_range(0, tileArray.size()-1)
		newPowerup.position = tileArray[randomIndex]*16
		newPowerup.position.x += 8
		newPowerup.position.y += 8
		add_child(newPowerup)
	
	if timer <= 0:
		spawnedFractures += 1
		var newFracture = ""
		if spawnedFractures % 10 == 0:
			newFracture = Bomb.instance()
		else:
			newFracture = Fracture.instance()
		var foundZone = false
		var zoneDamaged = 0
		while !foundZone:
			zoneDamaged = rng.randi_range(1, 6)
			if Globals.zoneHealth[zoneDamaged-1] > 0:
				foundZone = true
		newFracture.zone = zoneDamaged-1	
		var tileArray = $TileMap.get_used_cells_by_id(zoneDamaged)
		var randomIndex = rng.randi_range(0, tileArray.size()-1)
		newFracture.position = tileArray[randomIndex]*16
		newFracture.position.x += 8
		newFracture.position.y += 8
		
		get_parent().get_node(str("Zone", zoneDamaged)).add_child(newFracture)
		$CrashSound.play()
		timer = BASE_TIMER - (TIMER_PENALTY * deadZones) - (spawnedFractures/10) 
		
	#Globals.score += (1 * (6 - deadZones))
	#$Score.text = str("Score: ", Globals.score)
	
	for fracture in get_tree().get_nodes_in_group("fracture"):
		if fracture.isBeingRepaired:
			if Globals.power > 0:
				Globals.power -= 1
				fracture.health -= 10
			else:
				fracture.isBeingRepaired = false
		else:
			fracture.health += 1
			
	if Input.is_action_pressed("up"):
		isMoving = true	
	elif Input.is_action_pressed("down"):
		isMoving = true	
	elif Input.is_action_pressed("left"):
		isMoving = true	
	elif Input.is_action_pressed("right"):
		isMoving = true	
	else:
		isMoving = false		
			
	
	
	
	if Globals.playDestroy == true:
		$DestroySound.play()
		Globals.playDestroy = false 
	#$Power.text = str("Power: ", $Player.power/10, "%")
	
	deadZones = 0
	var isAlertNeeded = false
	for i in 6:
		var zone = get_parent().get_node(str("Zone", i+1))
		var fractureCount = zone.get_child_count()
		Globals.zoneHealth[i] -= zone.damage
		get_node(str("Zone", i+1, "Health")).text = str(Globals.zoneHealth[i]/100, "%")
		if Globals.zoneHealth[i] <= Globals.STARTING_HEALTH/4:
			get_node(str("Zone", i+1, "Health")).add_color_override("font_color", Globals.RED)
			if Globals.zoneHealth[i] <= 0:
				get_node(str("Zone", i+1, "Health")).add_color_override("font_color", Globals.backgroundColor)
				var node = get_parent().get_node(str("Zone", i+1))
				for n in node.get_children():
					node.remove_child(n)
					n.queue_free()
				deadZones += 1
				Globals.zoneHealth[i] = 0
				$TileMap.tile_set.tile_set_modulate(i+1, Globals.backgroundColor)
				if !hasPlayedDestroy[i]: 
					$DestroySound.play()
					hasPlayedDestroy[i] = true
			elif fractureCount > 0:
				isAlertNeeded = true
				
	if isAlertNeeded && !$AlertSound.playing:
		$AlertSound.play()
	elif !isAlertNeeded:
		$AlertSound.stop()
	
	if deadZones == 6:
		get_tree().change_scene("res://scenes/gameover.tscn")
	


func _on_Charger_body_entered(body):
	if body.is_in_group("player"):
		$Player.playCharge()


func _on_Charger_body_exited(body):
	if body.is_in_group("player"):
		$Player.stopCharge()

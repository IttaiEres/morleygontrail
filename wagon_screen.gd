extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Reigns.visible = false # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_rich_ready() -> void:
	$Rich/RichAnimations.play("StandRight") # Replace with function body.

func _on_hannah_ready() -> void:
	$Hannah/HannahAnimations.play("StandBreathe")

func _on_matt_ready() -> void:
	$Matt/MattAnimations.play("StandBreathe")
	
func _on_kim_ready() -> void:
	$Kim/KimAnimations.play("StandLeft")	

func _on_ittai_ready() -> void:
	$Ittai/AnimationPlayer.play("StandRight") # Replace with function body.

func _on_wagon_ready() -> void:
	$Wagon/WagonAnimation.play("RESET") # Replace with function body.
	
const HannahLines: Array[String] = [
	"It's so great to see everyone here!",
	"From Kim, to Matt, to me, Rich, and even this odd horse!",
	"But we'd better get our wagon hitched up and get going if we hope to make it to the Rogue Valley before Christmas!",
	"(Press space, then H to hitch)"
]

const HannahLines2 : Array[String] = [
	"Oh no, something definitely broke in that hitching process!",
	"If only someone could fix the wagon!"
]

const HannahLines0 : Array[String] = [
	"*Stares at Matt*",
	"(Press space, then R to repair)"
]

const HannahLines3 : Array[String] = [
	"That's the stuff Matt, just put some more elbow grease into it.",
	"A few more repair swings should do it!",
	"(Press space, then R a few times to repair some more)"
]

const HannahLines4 : Array[String] = [
	"Huzzah, great job!",
	"Now let's all giddy up into the wagon so we can get going!",
	"(Press space, then G to giddy up)"
]

const HannahLines5 : Array[String] = [
	"I know you can't see, but don't worry, it's me, Hannah, speaking.",
	"Let's get going, to Central Point, posthaste!",
	"Onwards please, odd horse!",
	"(Press space, then H to move horse with no name)"
]

const HannahLines6 : Array[String] = [
	"Oh no! It looks like a fallen tree is blocking the path.",
	"Dad, maybe you could chop it?",
	"(Press space, then C to chop--maybe a few times!)"
]

const HannahLines7 : Array[String] = [
	"Great job Dad! And we can use all that firewood when we get home!",
	"I think the only thing we still should do here before we can finally make our way home is brighten the place up a bit.",
	"Mom, what do you think? Want to plant some flowers?",
	"(Press space, then F a few times to plant flowers)"
]

const RichLines: Array[String] = [
	"INCREDIBLE!",
	"Now we are truly ready to find our way home and bask in the joy of Christmas."
]

const IttaiLines: Array[String] = [
	"Merry Christmas 2024 to my Morley Family! - With Much Love, Ittai"
]

@onready var hitch_given = false
@onready var hitched = false
@onready var repairs = 0
@onready var chops = 0
@onready var flowers = 0
@onready var christmas = 0

func _unhandled_input(event):
	if event.is_action_pressed("advance_dialog")&& !hitch_given :
		var position_1 = $Hannah.position
		position_1.y -= 50
		$Hannah/HannahAnimations.play("Talk")
		DialogManager.start_dialog(position_1, HannahLines)
		hitch_given = true
		
	if event.is_action_pressed("hitch") && !hitched:
		$Ittai/AnimationPlayer.play("StandLeft")
		var tween = create_tween()
		$Hannah/HannahAnimations.play("StandLeft")
		$Rich/RichAnimations.play("StandLeft")
		$Kim/KimAnimations.play("StandLeft")
		$Matt/MattAnimations.play("StandLeft")
		tween.set_parallel(true)
		$Ittai.z_index = 2
		$Wagon.z_index = 1
		tween.tween_property($Ittai, "position", Vector2(150, $Ittai.position.y), 2)
		tween.tween_property($Wagon, "position", Vector2(450, $Wagon.position.y), 2)
		await(tween)
		$WagonTimer.start()
		
	if event.is_action_pressed("repair") && repairs == 0:
		var tween = create_tween()
		$Matt.z_index = 0
		$Hannah.z_index = 1
		$Rich.z_index = 1
		tween.set_parallel(true)
		tween.tween_property($Matt, "position", Vector2(690, $Matt.position.y), 2)
		tween.tween_property($ActionMatt, "position", Vector2(690, $ActionMatt.position.y), 2)
		$Hannah/HannahAnimations.play("StandLeft")
		$Rich/RichAnimations.play("StandLeft")
		await tween.finished
		$ActionMatt/AnimationPlayer.play("RepairLeft")
		$Matt.visible = false
		$ActionMatt.visible = true
		var position_1 = $Hannah.position
		position_1.y -= 50
		$Hannah/HannahAnimations.play("Talk")
		DialogManager.start_dialog(position_1, HannahLines3)
		repairs +=1
	
	if event.is_action_pressed("repair") && repairs < 8 && repairs >0:
		$Hannah/HannahAnimations.play("StandLeft")
		$Repair.play()
		repairs += 1
		
	if repairs == 8:
		var tween = create_tween()
		$Wagon/WagonAnimation.play("RESET")
		var position_1 = $Hannah.position
		position_1.y -= 50
		$Hannah/HannahAnimations.play("Talk")
		$Rich/RichAnimations.play("StandRight")
		DialogManager.start_dialog(position_1, HannahLines4)
		$ActionMatt.visible = false
		$Matt.visible = true
		$Matt/MattAnimations.play("StandRight")
		tween.set_parallel(true)
		tween.tween_property($Matt, "position", Vector2(922, 506), 2)
		tween.tween_property($ActionMatt, "position", Vector2(922, 506), 2)
		await tween.finished
		$Matt/MattAnimations.play("StandBreathe")
		repairs = 9
		
	if event.is_action_pressed("giddyup"):
		var tween = create_tween()
		$Rich/RichAnimations.play("StandLeft")
		$Matt/MattAnimations.play("StandLeft")
		$Hannah/HannahAnimations.play("StandLeft")
		tween.set_parallel(true)
		tween.tween_property($Ittai, "position", Vector2($Ittai.position.x+250, $Ittai.position.y), 2)
		tween.tween_property($Wagon, "position", Vector2($Wagon.position.x+250, $Wagon.position.y), 2)
		tween.tween_property($Reigns, "position", Vector2($Reigns.position.x+250, $Reigns.position.y), 2)
		tween.tween_property($Hannah, "position", Vector2($Hannah.position.x-210, $Hannah.position.y-80), 2)
		tween.tween_property($Kim, "position", Vector2($Kim.position.x-210, $Kim.position.y-80), 2)
		tween.tween_property($Rich, "position", Vector2($Rich.position.x-210, $Rich.position.y-80), 2)
		tween.tween_property($Matt, "position", Vector2($Matt.position.x-210, $Matt.position.y-80), 2)
		await tween.finished
		var position_1 = $Hannah.position
		position_1.y -= 70
		DialogManager.start_dialog(position_1, HannahLines5)
		
	if event.is_action_pressed("hitch") && hitched:
		$Neigh.play()
		$Ittai/AnimationPlayer.play("GallopLeft")
		$Wagon/WagonAnimation.play("Stand")
		$Gallop.play()
		$GallopTimer.start()
		
	if event.is_action_pressed("chop") && chops==0:
		var tween = create_tween()
		tween.set_parallel(true)
		$Reigns.z_index = 2
		$Rich.z_index = 3
		$ActionRich.z_index = 3
		$Hannah/HannahAnimations.play("StandLeft")
		tween.tween_property($Rich, "position", Vector2(210, $ActionRich.position.y), 2)
		tween.tween_property($ActionRich, "position", Vector2(210, $ActionRich.position.y), 2)
		$Rich.visible = false
		$ActionRich.visible = true
		$ActionRich/AnimationPlayer.play("IdleLeft")
		await tween.finished
		chops += 1
		$TreeChop.play()
		$ActionRich/AnimationPlayer.play("ChopLeft")
	
	if event.is_action_pressed("chop") && chops >0 && chops <8:
		$TreeChop.play()
		chops+=1
		$ActionRich/AnimationPlayer.play("ChopLeft")
		
	if chops == 8:
		chops = 9
		var tween = create_tween()
		$Matt/MattAnimations.play("StandRight")
		$Hannah/HannahAnimations.play("Talk")
		$Rich.visible = true
		$Tree.visible = false
		$Logs.visible = true
		$ActionRich.visible = false
		$Rich/RichAnimations.play("StandRight")
		tween.set_parallel(true)
		tween.tween_property($Rich, "position", Vector2(700, $Rich.position.y), 2)
		tween.tween_property($ActionRich, "position", Vector2(700, $ActionRich.position.y), 2)
		tween.tween_property($Wagon, "position", Vector2($Wagon.position.x-300, $Wagon.position.y), 2)
		tween.tween_property($Ittai, "position", Vector2($Ittai.position.x-280, $Ittai.position.y), 2)
		tween.tween_property($Reigns, "position", Vector2($Reigns.position.x-300, $Reigns.position.y), 2)
		tween.tween_property($Matt, "position", Vector2($Matt.position.x-150, $Matt.position.y), 2)
		tween.tween_property($Kim, "position", Vector2($Kim.position.x-150, $Kim.position.y), 2)
		tween.tween_property($Hannah, "position", Vector2($Hannah.position.x-150, $Hannah.position.y), 2)
		await tween.finished
		var tween2 = create_tween()
		tween2.tween_property($Logs, "position", Vector2($Wagon.position.x, $Wagon.position.y), 4)
		var position_1 = $Hannah.position
		position_1.y -= 50
		DialogManager.start_dialog(position_1, HannahLines7)
		await DialogManager.dialog_finished
		$Hannah/HannahAnimations.play("StandRight")
		$Matt/MattAnimations.play("StandRight")
		$Kim/KimAnimations.play("StandRight")
		
	if event.is_action_pressed("flower") && flowers < 8:
		flowers += 1
		$Water.play()
		$Kim/KimAnimations.play("PaintRight")
	
	if flowers == 8:
		flowers = 9
		$Water.stop()
		$Kim/KimAnimations.play("StandLeft")
		$Matt/MattAnimations.play("StandLeft")
		$Hannah/HannahAnimations.play("StandLeft")
		$Sprout.play()
		await get_tree().create_timer(0.05).timeout
		$Sprout.play()
		await get_tree().create_timer(0.05).timeout
		$Sprout.play()
		await get_tree().create_timer(0.05).timeout
		$Sprout.play()
		await get_tree().create_timer(0.05).timeout
		$Sprout.play()
		await get_tree().create_timer(0.05).timeout
		$Sprout.play()
		await get_tree().create_timer(0.05).timeout
		$Sprout.play()
		await get_tree().create_timer(0.05).timeout
		$Sprout.play()
		$Flowers.visible = true
		var position_1 = $Rich.position
		position_1.y -= 50
		$Rich/RichAnimations.play("Meditating")
		DialogManager.start_dialog(position_1, RichLines)
		await DialogManager.dialog_finished
		await get_tree().create_timer(0.3).timeout
		christmas = 1
	
	if christmas == 1:
		christmas = 2
		var tween = create_tween()
		$Wagon.z_index = 100
		$Rich/RichAnimations.play("StandLeft")
		tween.set_parallel(true)
		tween.tween_property($Rich, "position", Vector2($Wagon.position.x, $Wagon.position.y), 2)
		tween.tween_property($Matt, "position", Vector2($Wagon.position.x, $Wagon.position.y), 2)
		tween.tween_property($Kim, "position", Vector2($Wagon.position.x, $Wagon.position.y), 2)
		tween.tween_property($Hannah, "position", Vector2($Wagon.position.x, $Wagon.position.y), 2)
		await tween.finished
		$Ittai/AnimationPlayer.play("GallopLeft")
		$Gallop.play()
		$Neigh.play()
		$Background3.z_index = 1000
		$Background3.modulate.a = 0
		$Background3.visible = true
		var tween2 = create_tween()
		tween2.tween_property($Background3, "modulate:a", 1, 4)
		await tween2.finished
		$Gallop.stop()
		$JingleBells.play()
		BackGroundMusic.stop()
		var tween3 = create_tween()
		tween3.set_parallel(true)
		tween3.tween_property($Ittai, "position", Vector2(800, 500), 1)
		tween3.tween_property($RichXmas, "position", Vector2(100, 550), 1)
		tween3.tween_property($KimXmas, "position", Vector2(200, 550), 1)
		tween3.tween_property($MattXmas, "position", Vector2(300, 550), 1)
		tween3.tween_property($HannahXmas, "position", Vector2(400, 550), 1)
		tween3.tween_property($Ittai, "scale", Vector2(4,4), 1)
		await tween3.finished
		$Ittai/AnimationPlayer.play("StandLeft")
		$Ittai.z_index=1001
		$HannahXmas.visible=true
		$KimXmas.visible=true 
		$MattXmas.visible=true 
		$RichXmas.visible=true 
		$HannahXmas.z_index=1001
		$MattXmas.z_index=1001
		$KimXmas.z_index=1001
		$RichXmas.z_index=1001
		$HannahXmas/AnimationPlayer.play("Xmas")
		await get_tree().create_timer(0.3).timeout
		$RichXmas/AnimationPlayer.play("Xmas")
		await get_tree().create_timer(0.3).timeout
		$KimXmas/AnimationPlayer.play("Xmas")
		await get_tree().create_timer(0.3).timeout
		$MattXmas/AnimationPlayer.play("Xmas")
		
	if christmas==2 && event.is_action_pressed("advance_dialog"):
		await get_tree().create_timer(0.25).timeout
		var position_1 = $Ittai.position
		position_1.y -= 80
		$Ittai.z_index = 1001
		DialogManager.start_dialog(position_1, IttaiLines)
		await DialogManager.dialog_finished
		$Star.play()
		christmas = 2
		
		
func _on_wagon_timer_timeout() -> void:
	$Reigns.z_index=3
	$Reigns.visible=true
	$Wagon/WagonAnimation.play("Break")
	$BreakSound.play()
	var position_1 = $Hannah.position
	position_1.y -= 50
	$Hannah/HannahAnimations.play("Talk")
	$Rich/RichAnimations.play("StandRight")
	$Matt/MattAnimations.play("StandLeft")
	$Kim/KimAnimations.play("StandLeft")
	DialogManager.start_dialog(position_1, HannahLines2)
	await DialogManager.dialog_finished
	$Hannah/HannahAnimations.play("StandRight")
	await get_tree().create_timer(0.5).timeout
	DialogManager.start_dialog(position_1, HannahLines0)
	await DialogManager.dialog_finished
	$Hannah/HannahAnimations.play("StandLeft")
	hitched = true

func _on_gallop_timer_timeout() -> void:
	$Gallop.stop() # Replace with function body.
	$TreeFall.play()
	$Background2.z_index = -1
	$BackGround.visible = false
	$Background2.visible = true
	$Ittai/AnimationPlayer.play("StandLeft")
	$Wagon/WagonAnimation.play("RESET")
	$Tree.visible = true
	var tween = create_tween()
	tween.set_parallel(true)
	$Rich.z_index = 3
	tween.tween_property($Hannah, "position", Vector2($Hannah.position.x+360, $Hannah.position.y+80), 2)
	tween.tween_property($Kim, "position", Vector2($Kim.position.x+290, $Kim.position.y+80), 2)
	tween.tween_property($Rich, "position", Vector2($Rich.position.x+310, $Rich.position.y+120), 2)
	tween.tween_property($Matt, "position", Vector2($Matt.position.x+210, $Matt.position.y+80), 2)
	await tween.finished
	$Rich/RichAnimations.play("StandBreathe")
	var position_1 = $Hannah.position
	position_1.y -= 50
	$Hannah/HannahAnimations.play("Talk")
	DialogManager.start_dialog(position_1, HannahLines6)

# GrassScatter.gd
extends Node2D

@export var area_size := Vector2i(1920, 1080)
@export var grid := 32                 # spacing (also limits max density)
@export var density := 0.28            # 0..1 chance per grid cell
@export var seed := 424242             # fixed seed => same layout every run
@export var tuft_scene: PackedScene    # assign Tuft.tscn in the Inspector

func _ready():
	var rng := RandomNumberGenerator.new()
	rng.seed = seed

	var cols := int(area_size.x / grid)
	var rows := int(area_size.y / grid)

	for y in rows:
		for x in cols:
			if rng.randf() < density:
				var t := tuft_scene.instantiate()
				# jitter inside the cell (still deterministic thanks to rng seed)
				var px := (x - (rows/2) ) * grid + rng.randf_range(-grid * 0.35, grid * 0.35)
				var py := (y - (cols/2)) * grid + rng.randf_range(-grid * 0.35, grid * 0.35)
				t.position = Vector2(px, py)

				# optional tiny variety:
				

				add_child(t)

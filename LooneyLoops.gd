extends Control

var player_words = [];
var current_story = {};
onready var PlayerText = $VBoxContainer/HBoxContainer/PlayerText;
onready var DisplayText = $VBoxContainer/DisplayText;
onready var label = $VBoxContainer/HBoxContainer/Label;

func _ready():
	pick_current_story();
	DisplayText.text = "Welcome to looney lips, lets tell a story! ";
	check_player_words_length();
	label.text = "OK";
	PlayerText.grab_focus();


func pick_current_story():
	randomize();
	var stoires = $StoryBook.get_child_count();
	var selected_story = randi() % stoires;
	print($StoryBook.get_child(selected_story).prompts);
	current_story.prompts = $StoryBook.get_child(selected_story).prompts;
	current_story.story = $StoryBook.get_child(selected_story).story;

func _on_PlayerText_text_entered(new_text):
	add_to_player_words();


func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene();
	else:
		add_to_player_words();
		PlayerText.grab_focus();


func add_to_player_words():
	player_words.append(PlayerText.text);
	DisplayText.text = "";
	PlayerText.clear();
	check_player_words_length();

func is_story_done():
	return player_words.size() == current_story.prompts.size();
	

func check_player_words_length():
	if is_story_done():
		end_game();
	else:
		prompt_player();
		
func tell_story():
	DisplayText.text = current_story.story % player_words;
	
	
func prompt_player():
	DisplayText.text += "May I have " + current_story.prompts[player_words.size()] + " please?";
	
	
func end_game():
	label.text = "Again!";
	PlayerText.queue_free();
	tell_story();
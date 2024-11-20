extends Node

signal update_user_list

var user_name : String = "Default"
var user_color : String = "Red"

var user_list : Dictionary

func create_server():
	var server := ENetMultiplayerPeer.new()
	server.create_server(9999, 32)
	get_tree().set_network_peer(server)
	enter_chat_room()
	
func enter_chat_room():
	get_tree().change_scene_to_file("res://ChatRoom/ChatRoom.tscn")

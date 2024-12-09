extends CanvasLayer

@onready var join_button: Button = $vbxLobbyContainer/btnJoin
@onready var host_button: Button = $vbxLobbyContainer/btnHost
@onready var status: Label = $hbxStatusContainer/lblStatus
@onready var colors: OptionButton = $vbxLobbyContainer/hbxIPContainer2/optColors
@onready var ip_address: TextEdit = $vbxLobbyContainer/hbxIPContainer/txtIP
@onready var user_name: TextEdit = $vbxLobbyContainer/hbxNameContainer/txtName

func _ready():
	compile_colors()
	get_tree().connect("connection_failed", connected_fail)

#Populate the options list with colours
func compile_colors():
	colors.add_item("red")
	colors.add_item("green")
	colors.add_item("blue")
	colors.add_item("yellow")
	colors.add_item("purple")
	colors.add_item("black")

#Failed to connect to IP
func connected_fail():
	print("Failed to connect")
	status.text = "couldn't connect try again, or host?"
	#Connection failed so allow user to try again
	join_button.disabled = false
	host_button.disabled = false
	

func _on_opt_colors_item_selected(index: int) -> void:
	Network.user_color = colors.text

func _on_btn_host_pressed() -> void:
	Network.create_server()
	status.text = "Hosting"
	Network.user_name = user_name.text
	#Put our username and ID in the dictionary
	Network.user_list[str(get_tree().get_network_unique_id())] = Network.user_name


func _on_btn_join_pressed() -> void:
	#Create a client that will connect to the server
	var client := ENetMultiplayerPeer.new()
	client.create_client(ip_address.text,9999)
	get_tree().set_network_peer(client)
	
	#Disable buttons whilst waiting
	join_button.disabled = true
	host_button.disabled = true
	
	#Update status and username for chatroom
	status.text = "Trying to join to " + ip_address.text
	Network.user_name = user_name.text
	pass
	

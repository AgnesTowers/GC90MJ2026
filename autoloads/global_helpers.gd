@tool
extends Node

func MakeLocal(node: Node, owner: Node) -> Node:
	node.scene_file_path = ""
	node.owner = owner
	for childNode in node.get_children():
		childNode = MakeLocal(childNode, owner)
	return node

func get_all_child_nodes(node: Node) -> Array[Node]:
	var nodes: Array[Node] = []
	for child: Node in node.get_children():
		nodes.append(child)
		if child.get_child_count() > 0:
			nodes.append_array(get_all_child_nodes(child))
	
	return nodes

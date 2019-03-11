package test {
import de.polygonal.ds.TreeNode;
import de.polygonal.ds.TreeBuilder;

import flash.display.Sprite;

/**
 * @author ssen (i@ssen.name)
 */
public class DSTreeTest2 extends Sprite {
	public function DSTreeTest2() {
var tree : TreeBuilder = new TreeBuilder(new TreeNode("root"));
var f : int;
var s : int;
f = -1;
while (++f < 3) {
	tree.appendChild("node" + f);
	tree.down();
	s = -1;
	while (++s < 3) {
		tree.appendChild("child node" + s);
	}
	tree.up();
}

tree.root();
tree.childStart();
var node : TreeNode = tree.getChildNode();
var child : TreeNode;
while (node != null) {
	trace(node.val);
	if (node.hasChildren()) {
		child = node.children;
		while (child != null) {
			trace("--", child.val);
			child = child.next;
		}
	}
	node = node.next;
}
	}
}
}

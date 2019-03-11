<?php
function getDirectoryList($path) {
	$dir = opendir($path);
	while($file = readdir($dir)) {
		if($file != "." && $file != "..") {
			$list[] = $file;
		}
	}

	closedir($dir);
	return $list;
}
?>
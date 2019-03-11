<?php
/**
 * @param string $encoding
 */
function getXMLHeader($encoding) {
	header("Content-Type: text/xml;charset='.$encoding.'");
	echo '<?xml version="1.0" encoding="'.$encoding.'"?>';
}

?>
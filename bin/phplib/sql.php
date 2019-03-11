<?php

class SQL
{
	/** initialize **/
	function SQL($connect)
	{
		$this->connect = $connect;
	}

	/** public member **/
	/**
	 * 한개의 데이터만을 찝어서 가져온다.
	 * @return String
	 * @param $table Object
	 * @param $filed Object
	 * @param $search Object
	 */
	function get_singleData($table, $field, $searchID, $searchKeyword)
	{
		$que = "SELECT $field FROM $table WHERE $searchID='$searchKeyword'";
		$data = mysql_query($que, $this->connect);
		$row = mysql_fetch_array($data);
		return $row[0];
	}

	/**
	 * 리스트를 불러오기 위한 SELECT * FROM 의 축약함수.
	 * @return SQL list
	 * @param $table Object
	 * @param $optionQuery Object
	 */
	function get_listSQL($table, $optionQuery)
	{
		$que = "SELECT * FROM $table $optionQuery";
		return mysql_query($que, $this->connect);
	}

	function set_insertData($table, $dataArray)
	{
		$keys = "";
		$values = "";

		$first = false;

		foreach ($dataArray as $fk => $fd) {
			if ($first) {
				$keys .= ",";
				$values .= ",";
			} else {
				$first = true;
			}
			$keys .= $fk;
			if (gettype($fd) == "string") {
				$values .= "'".$fd."'";
			} else {
				$values .= $fd;
			}
		}

		$que = "INSERT INTO $table (".$keys.") VALUES (".$values.")";
		mysql_query($que, $this->connect);
	}

	function set_updateData($table, $dataArray, $searchID, $searchKeyword)
	{
		$values = "";

		$first = false;

		foreach ($dataArray as $fk => $fd) {
			if ($first) {
				$values .= ",";
			} else {
				$first = true;
			}
			if (gettype($fd) == "string") {
				$values .= $fk."='".$fd."'";
			} else {
				$values .= $fk."=".$fd;
			}
		}

		if (gettype($searchKeyword) == "string") {
			$searchKeyword = "'".$searchKeyword."'";
		}

		$que = "UPDATE $table SET ".$values." WHERE $searchID=$searchKeyword";
		mysql_query($que, $this->connect);
	}
}
?>

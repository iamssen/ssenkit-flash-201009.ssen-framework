<!DOCTYPE html>
<html>
	<head>
		<title>Test Stutter HTML</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<META http-equiv="Expires" content="-1">
		<META http-equiv="Pragma" content="no-cache">
		<META http-equiv="Cache-Control" content="No-Cache">
		<style type="text/css">
			html, body {
				margin: 0;
				padding: 0;
				font-size: 100%;
				font-family: "NanumGothic", sans-serif;
			}
			
			div#wrapper {
				float: right;
				width: 100%;
				margin-left: -200px
			}
			
			div#content {
				margin-left: 200px;
				padding-left: 20px;
			}
			
			div#navigation {
				float: left;
				width: 200px
			}
		</style>
		<link type="text/css" rel="stylesheet" href="stutter/stutter.css" media="screen" />
		<link type="text/css" rel="stylesheet" href="stutter/stutter.code.css" media="screen" />
		<link type="text/css" rel="stylesheet" href="stutter/stutter.text.css" media="screen" />
		<script type="text/javascript" src="stutter/jquery-1.4.1.min.js">
		</script>
		<script type="text/javascript" src="stutter/swfobject.js">
		</script>
		<script type="text/javascript" src="stutter/prettify.js">
		</script>
		<script type="text/javascript" src="stutter/stutter.js">
		</script>
		<script type="text/javascript">
			window.onload = function() {
				var scripts = document.getElementsByTagName("script");
				var src;
				var div;
				var stutter;
				var text;
				var htmlResult;
				
				for (var i = 0; i < scripts.length; i++) {
					if (scripts[i].type == "stutter") {
						src = scripts[i].src;
						div = scripts[i].nextSibling;
						
						
						
						if (src && src.indexOf("#")) {
							div = document.getElementById(src.substr(src.indexOf("#") + 1));
						} else {
							while (div && div.nodeName.toUpperCase() != "DIV") {
								div = div.nextSibling;
							}
						}
						
						if (div) {
							stutter = new Stutter("http://ssen.name", true, true);
							if (div) {
								text = scripts[i].text;
								htmlResult = stutter.parse(text);
								div.innerHTML = htmlResult;
								// code
								prettyPrint();
							}
						}
					}
				}
			}
		</script>
	</head>
	<body>
		<div id="container">
			<div id="wrapper">
				<div id="content" class="stutter">
					<p>
						loading...
					</p>
				</div>
			</div>
			<div id="navigation">
				<p>
				</p>
			</div>
		</div>
	</body>
</html>

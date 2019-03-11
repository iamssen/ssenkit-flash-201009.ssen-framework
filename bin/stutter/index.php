<!DOCTYPE html>
<html>
    <head>
        <title>Test Stutter HTML</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <META http-equiv="Expires" content="-1">
        <META http-equiv="Pragma" content="no-cache">
        <META http-equiv="Cache-Control" content="No-Cache">
        <link type="text/css" rel="stylesheet" href="stutter.css" media="screen" />
        <link type="text/css" rel="stylesheet" href="stutter.code.css" media="screen" />
        <link type="text/css" rel="stylesheet" href="stutter.text.css" media="screen" />
        <script type="text/javascript" src="jquery-1.4.1.min.js">
        </script>
        <script type="text/javascript" src="swfobject.js">
        </script>
        <script type="text/javascript" src="prettify.js">
        </script>
        <script type="text/javascript" src="stutter.js">
        </script>
        <script type="text/javascript">
            window.onload = function(){
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
                        }
                        else {
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

                                layer = document.getElementById("xmpLayer");
                				layer.value = htmlResult;
                            }
                        }
                    }
                }
            }
        </script>
    </head>
    <body>
        <script type="stutter">
            <? include "stutter.txt"; ?>
        </script>
        <div class="stutter">
        </div>
        <br />
        <br />
        <textarea id="xmpLayer" style="width:100%; height:800px;"></textarea>
    </body>
</html>

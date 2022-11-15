<!DOCTYPE html>
<!-- 
Autor: @adrianlois 
Obtención de dirección IP pública y privada en PHP
-->
<html>
    <head>
    <meta charset="utf-8">
		<style>
			@font-face { 
				font-family: Abel;
				src: url(abel-regular.ttf); 
			}
			
			body {  
				background-image: url("wp-content/uploads/2017/02/image.jpg");
				background-position: left top;
				background-size: cover;
				background-repeat: no-repeat;
				background-attachment: fixed;
				background-color:#222222; 
				color:#e4e4e4; 
				font-family:'Abel'; 
				font-size: 19px; 
			}
			
			li { 
				list-style-type: none; 
				margin:0; 
				padding:0; 
			}
			
			ul { 
				margin:0; 
				padding:0; 
			}
			
			#clic { 
				margin-top:28%; 
			}
			
			#titulo { 
				font-size: 43px; 
			}
			
			table, tr, td, th { 
				font-weight: normal; 
			}
		</style>
    </head>
    <body>
		<div id="clic" align="center">
			<div id="titulo">¿Cuál es mi IP?</div>
			<br />
			<table border="1" bordercolor="#bbb" cellspacing="0" cellpadding="7">
				<tr>
					<th>Tipo de asignación de IP Pública</th>
					<th>
					<?php 
					$ippubnom = gethostbyaddr($_SERVER['REMOTE_ADDR']);
					$cadenatexto = strstr($ippubnom, 'dynamicip');
					if ( $cadenatexto == true ) { 
						echo "IP Dinámica"; 
					} else { 
						echo "IP Estática"; 
					  }
					?>
					</th>
				</tr>
				<tr>
					<th>IPv4 Pública</th>
					<th>
					<?php 
						$ippubnum = $_SERVER['REMOTE_ADDR'];
						echo "$ippubnum";
					?> 
					<br />
					<?php
						$ippubnum = $_SERVER['REMOTE_ADDR'];
						$ippubnumcadena = substr($ippubnum, 0, 3);
						if ($ippubnumcadena >= 0 && $ippubnumcadena <= 127 ) {
							echo "Clase A";
						} elseif ($ippubnumcadena >= 128 && $ippubnumcadena <= 191 ) {
							echo "Clase B";
						} elseif ($ippubnumcadena >= 192 && $ippubnumcadena <= 223 ) {
							echo "Clase C";
						} elseif ($ippubnumcadena >= 224 && $ippubnumcadena <= 239 ) {
							echo "Clase D";
						} elseif ($ippubnumcadena >= 240 && $ippubnumcadena <= 255 ) {
							echo "Clase E";
						} else {
							echo "Sin Clase";
						}
					?>
					</th>
				</tr>
				<tr>
					<th>IPv4 Privada</th>
					<th><ul></ul></th>
				</tr>
			</table>
		
			<?php
				date_default_timezone_set("Europe/Madrid");
				$fechaactual = date('d/m/Y - H:i');
				echo "<br>";
				echo "$fechaactual";
			?>
		
		<iframe id="iframe" sandbox="allow-same-origin" style="display: none"></iframe>
			<script>
				function getIPs(callback){
					var ip_dups = {};
					var RTCPeerConnection = window.RTCPeerConnection
						|| window.mozRTCPeerConnection
						|| window.webkitRTCPeerConnection;
					var useWebKit = !!window.webkitRTCPeerConnection;
					if(!RTCPeerConnection){
						var win = iframe.contentWindow;
						RTCPeerConnection = win.RTCPeerConnection
							|| win.mozRTCPeerConnection
							|| win.webkitRTCPeerConnection;
						useWebKit = !!win.webkitRTCPeerConnection;
					}
					var mediaConstraints = {
						optional: [{RtpDataChannels: true}]
					};
					var servers = {iceServers: [{urls: "stun:stun.services.mozilla.com"}]};
					var pc = new RTCPeerConnection(servers, mediaConstraints);
					function handleCandidate(candidate){
						var ip_regex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/
						var ip_addr = ip_regex.exec(candidate)[1];
						if(ip_dups[ip_addr] === undefined)
							callback(ip_addr);
						ip_dups[ip_addr] = true;
					}
					pc.onicecandidate = function(ice){
						if(ice.candidate)
							handleCandidate(ice.candidate.candidate);
					};
					pc.createDataChannel("");
					pc.createOffer(function(result){
						pc.setLocalDescription(result, function(){}, function(){});
					}, function(){});
					setTimeout(function(){
						var lines = pc.localDescription.sdp.split('\n');
						lines.forEach(function(line){
							if(line.indexOf('a=candidate:') === 0)
								handleCandidate(line);
						});
					}, 1000);
				}
				getIPs(function(ip){
					var li = document.createElement("li");
					li.textContent = ip;
					if (ip.match(/^(192\.168\.|169\.254\.|10\.|172\.(1[6-9]|2\d|3[01]))/))
						document.getElementsByTagName("ul")[0].appendChild(li);
				});
			</script>
		</div>
    </body>
</html>
<html>
	<head>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
		<title>
		Ajax normal ref(w3schools.com/xml/ajax_intro.asp)
		Ajax jquery ref(w3schools.com/jquery/jquery_ajax_intro.asp)
		</title>
		
		<script>
			//jquery를 이용하지 않은 일반 ajax
			function normalAjax(inputStr){
				var xRequest=new XMLHttpRequest();
				xRequest.onreadystatechange=function (){
					console.log("==============\nonreadystatechange" 
							+ "\nreadyState : " + this.readyState
							+ "\nstatus : " + this.status
							+ "\nstatusText : " + this.statusText
							+ "\nresponseText : " + this.responseText
							+ "\ngetAllResponseHeaders() : " + this.getAllResponseHeaders()
							+ "\n=============="
							);
										
					if((this.readyState==4) && (this.status==200)){
						console.log("readyState is 4 and status is 200");
						document.getElementById("update").innerHTML=this.responseText;
					}
				}	 
				
/*  			console.log("open start");
				xRequest.open("get","ajaxJspFile.jsp?q="+inputStr,true);	//url을 jsp 파일로, get방식으로 open
				xRequest.open("get","ajaxTextFile.txt",true);	//url을 txt 파일로
				xRequest.open("get","ajaxXmlFile.xml",true);	//url을 xml 파일로
				console.log("open end");
				
				console.log("send start");
				xRequest.send();	//get 방식으로 send
				console.log("send end");
			 */
				
				//post 방식 ajax 테스트
  				xRequest.open("post","ajaxJsp.jsp",true);	//url을 jsp 파일로, post방식으로 open
 				xRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
 				xRequest.send("q="+inputStr);
			 
			
			}

			//jquery load를 이용한 ajax
			function jqueryAjaxLoad(inputStr){
			        $("#update").load("ajaxTextFile.txt", function(response, status){
		            if(status == "success")
		                console.log("content load using load AJAX success!");
		        });
		    }
			
			//jquery post를 이용한 ajax
			function jqueryAjaxPost(inputStr){
					$.post("ajaxJsp.jsp","q=ajaxPost Input",
			        function(data, status){
		            if(status == "success"){
		            	document.getElementById("update").innerHTML=data+".....ajaxPost....."+status;
		            }
		        });
		    }
			
		</script>		
		
	</head>
	<body>
		
		<button type="button" onclick="normalAjax(123456789)">Change Content using normal AJAX</button>
		<br>
		<button type="button" onclick="jqueryAjaxLoad(123456789)">Change Content using Jquery AJAX Load</button>
		<br>
		<button type="button" onclick="jqueryAjaxPost(123456789)">Change Content using Jquery AJAX Post</button>
		<br>
		<div id="update">if button clicked This text will be updated</div>
		<div>
			<p>Unchanged text</p>
		</div>
	</body>
</html>




<!-- 
===============================================================================
AJAX란?
	- AJAX는 프로그래밍 언어가 아니라 웹서버의 데이터를 주고받는 기법(technique)임
		: 'A'syncronous 'J'avaScript 'A'nd 'X'ML의 약자로, javascript와 XML 문서를 이용해 비동기적(asynchronously)으로 데이터를 서버와 주고 받는 기법
		: 사실 XML대신 요즘은 json등 다른 웹 텍스트 규격과 더 많이 쓰인다.

		* 비동기적(asynchronously) 데이터 처리?
			웹페이지 전체 reload없이 웹페이지에 새로운 데이터를 업데이트 하는것 
-------------------------------------------------------------------------------			
XMLHttpRequest 객체
	- 이것은 javascript 객체중 하나인데, 웹 애플리케이션에서 AJAX 기술을 이용해 데이터를 처리할 수 있게 해준다.
	- 거의 모든 브라우저의 자바스크립트엔진은 XMLHttpRequest 객체를 지원함
						
-------------------------------------------------------------------------------
XMLHttpRequest객체의  method
		open(method, url, async)
				특정 url에 대한 request를 정의해 서버와 연결(connection)함
				method : GET 또는 POST
				url: 요청 하려는 서버의 url(*.txt, *.xml, *.jsp, *.php 같은 모든 파일이 올 수 있음 )
				async: true면 비동기, false이면 동기 인데, 그냥 무조건 true라고 생각할것(async부분을 false로 하는 것은 deprecated된 듯)

		send()			GET 방식으로 open으로 서버에 연결된 리퀘스트를 실제 서버로 보냄 
		send(string)	POST 방식으로 open으로 서버에 연결된 리퀘스트를 실제 서버로 보냄
--------------------------------------------------------------------------------			
XMLHttpRequest객체의 property 
		onreadystatechange
			- 'readyState' 상태가 바뀔때마다 매번 호출되는 함수가 정의될 property
				: 'onreadystatechange'에 정의된 함수는 readyState의 상태가 바뀔때마다 매번 호출된다.
				: readyState가 4이고, status 가 200이면 응답이 완전히 준비된다.
				(function is called every time the readyState changes. When readyState is 4 and status is 200, the response is ready)
		
		readyState
			- XMLHttpRequest객체의 상태코드를 갖고 있는 property
				0: request not initialized 
				1: server connection established
				2: request received 
				3: processing request 
				4: request finished and response is ready
		
		status
			- (일반)http 요청의 상태코드를 갖고 있는 property					
				200: "OK"
				403: "Forbidden"
				404: "Page not found"
				
		responseText
			- 스트링 포맷의 ajax호출의 response 데이터
		
		responseXML
			- xml 포맷의 ajax호출의 response 데이터
			- responseXML property를 쓰려면 ajax로 가져오는 데이터가 xml포맷이어야 함
			
		getAllResponseHeaders()
			- ajax호출 reponse의 header 데이터
		
===============================================================================
jQuery의 AJAX 메서드
	load 메서드
		$(selector).load(url [, data ] [, complete callback ] );
			-특정 url에서 비동기로 데이터를 가져온 후 선택한 selector에 넣음
				URL: 데이터 요청 URL
				data : 리퀘스트 url과 함께 전달되는 파라메터 key/value 쌍
				callback( String responseText, String textStatus, jqXHR jqXHR ) : load 메서드가 완료된 후 수행될 콜백 함수
					responseText : load 성공시 반환되는 텍스트(html 또는 text 타입)
					textStatus : load 호출에 대한 status 텍스트
					jqXHR : XMLHttpRequest 객체
-------------------------------------------------------------------------------	
	get 메서드
		$.get( url [, data ] [, success callback ])
			- 특정 url에서 'GET' 리퀘스트를 통해 비동기로 데이터를 가져옴 
				: load와는 달리 선택한 selector에 가져온 데이터를 넣는것은 안함
					-> 응답 데이터를 callback으로 처리하는 듯
				URL : 데이터 요청 URL
				data : 리퀘스트 url과 함께 전달되는 파라메터 key/value 쌍
				callback(Object data, String textStatus, jqXHR jqXHR ) : get 메서드가 '성공'하면 수행될 콜백 함수
							data : get 성공시 반환되는 데이터(PlainObject 타입)
							textStatus : get 호출에 대한 status 텍스트
							jqXHR : XMLHttpRequest 객체
-------------------------------------------------------------------------------								 		
	post 메서드
		$.post( url [, data ] [, success callback ])
			- 특정 url에서 'POST' 리퀘스트를 통해 비동기로 데이터를 가져옴 (load와는 달리 선택한 selector에 가져온 데이터를 넣는것은 안함)
				URL : 요청 하려는 서버의 url
				data : 리퀘스트에 url과 던져질 key/value 쌍
				callback(Object data, String textStatus, jqXHR jqXHR ) : post 메서드가 '성공'하면 수행될 콜백 함수
							data : get 성공시 반환되는 데이터(PlainObject 타입)
							textStatus : get 호출에 대한 status 텍스트
							jqXHR : XMLHttpRequest 객체	
							
-------------------------------------------------------------------------------		
	load 메서드 vs  get/post 메서드
		공통점
			- 모두 jquery의 기본 메서드인 $.ajax()를 래핑한것임. $.ajax()에 몇가지 기본 설정 및 특정기능이 기능이 추가된것
		
		차이점
			- get/post 메서드는 단순히 데이터를 가져오는데 끝나지만 load 메서드는 호출된 html selector에 가져온 데이터를 삽입함
				: 따라서 load 메서드로 가져오는 데이터는 html 및 text 타입이어야 함.  get/post 메서드로 가져오는 데이터는 모든 object타입 가능
			- load 메서드는 html selector에서 호출되어야 하지만, get/post 메서드는 그냥 jquery($)에서 호출됨. 즉 다음과 같은 형태로 쓰임
				$('#divWantingContent').load(...)
				$.get()
				$.post()						
-->
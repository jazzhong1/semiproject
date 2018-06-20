<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="truck.vo.TruckMenu"%>
<%@page import="truck.vo.Truck"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/views/common/header.jsp"%>
<%Truck truck=(Truck)request.getAttribute("truck");
	//리뷰~때문에//
	/* int truckPk=(int)request.getAttribute("truckPk");
	if(truckPk<0){
		truckPk=truck.getTruckPk();
	} */
%>
<%String serlvet=(String)request.getAttribute("truckChoice");%>
	
<script type="text/javascript">
$(function() {
$.ajax({
		url:"<%=request.getContextPath()%>/<%=serlvet%>",
		type : "POST",
		data:{truckPk :<%=truck.getTruckPk()%>},
		success : function(data){ 
		$("#choice-body").html(data);
		}, 
		error : function(request,status,error) { 
		alert("code:"+request.status+"\n"+ "message:"+request.responseText+"\n"+"error:"+error); 
		}
})
})
</script>
<style>
   #googlemap {
    	height : 300px;
    width: 100%;
    border: 1px solid black;
    }
</style>

 <!--지도안나오면 all css확인-->

<link rel="stylesheet"
	href="<%=request.getContextPath() %>/css/foodTruckMenu.css">

<section>
	<div class="container">

		<div class='row'>
			<div class="col-md-7 ">
				<div class="panel-group">

					<div id="truckBasic" class='row'>
						<div class='panel panel-default'>
							<div class='panel-heading'>
								<h3 class='panel-title truck-panel-header'>기본정보</h3>
							</div>
							<div class='panel-body pannel-basic'>
								<div class="row">
									<div class="col-md-4 panel-1">
										<p id='truck-title-p'><%=truck.getTruckName() %></p>
										
										
										<% if(truck.getTruckRenameImage()==null){%>
												<a href="#" data-toggle="modal" data-target=".pop-up-1">
										<img class='trcuk-img img-responsive center-block'
											src="http://proxyprivat.com/images/noimage.jpeg" alt=""
											style="width: 200px; height: 200px" ></a><br><br>
											<%	}
											else{ %>
											<a href="#" data-toggle="modal" data-target=".pop-up-1">
										<img class='trcuk-img img-responsive center-block'
											src="images/truck/<%=truck.getTruckRenameImage()%>" alt=""
											style="width: 200px; height: 200px" ></a><br><br>
											<%} %>
										
									</div>
									

									<!--모달 틀-->
									<div class="modal fade pop-up-1" tabindex="-1" role="dialog"
										aria-labelledby="myLargeModalLabel-1" aria-hidden="true" data-backdrop="false">
										<div class="modal-dialog modal-lg">
											<div class="modal-content">

												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal"
														aria-hidden="true">×</button>
													<h4 class="modal-title" id="myLargeModalLabel-1">확대
														이미지</h4>
												</div>
												<div class="modal-body">
													<img id="truckbasic-modal" src="images/truck/<%=truck.getTruckRenameImage()%>"
														class="img-responsive img-rounded center-block" alt=""
														width="500" height="500">
												</div>
											</div>
											<!-- /.modal-content -->
										</div>
										<!-- /.modal-dialog -->
									</div>
									<!-- /.modal mixer image -->
								
									
									

									<div class="col-md-8">
										<p class='truck-basic-font'>
											주소:
											<%=truck.getTrucklocation() %></p>
													<div class="ratings">
      														<div class="empty-stars"></div>
      														<div class="full-stars" style="width:<%=truck.getTruckStar()*20%>%"></div>
    												  </div>
										<br> <span class='truck-basic-font'>최소금액: <%=truck.getTruckPrice() %>원</span>
										<br>
										<br>
										<p class='truck-basic-font'>
											사업자정보 :
											<%=truck.getTruckInfoName() %></p>
										<span class='truck-basic-font'>상호명: <%=truck.getTruckName() %></span>
										<br> <span class='truck-basic-font'>사업자등록번호: <%=truck.getTruckInfoRegisterNumber() %></span>
									</div>
	
									<div class="col-xs-12" align="center">
										<div class="onoffswitch">
											<input type="checkbox" name="onoffswitch"
												class="onoffswitch-checkbox" id="myonoffswitch"
												<%=truck.getTruckStatus().equals("t")?"checked":"" %>>
											<label class="onoffswitch-label" for="myonoffswitch"
												align="left"> <span class="onoffswitch-inner"></span>
												<span class="onoffswitch-switch"></span>
											</label>
											<!--클릭이벤트제거-->
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<br> <br>

					<div class="row">
						<div class="panel panel-default">
							<div class="panel-heading">
								<div class="row">
									<ul class="nav nav-pills nav-justified">
										<li role="presentation"><a id="choiceMenu"
											class='truck-panel-header'>메뉴</a></li>
										<li role="presentation"><a id="choiceReview"
											class='truck-panel-header'>리뷰(<%=truck.getReviewCount()%>개)</a></li>
										<li role="presentation"><a id="choiceEvent"
											class='truck-panel-header'>이벤트</a></li>
									</ul>
								</div>
							</div>
							<script type="text/javascript">
                
                $("#choiceMenu").on("click", function() {
					$.ajax({
						url:"<%=request.getContextPath()%>/truckChoiceMenu",
						type : "POST",
						data:{truckPk :<%=truck.getTruckPk()%>},
						success : function(data){ 
							$("#choice-body").html(data);
						}, 
						error : function(request,status,error) { 
							alert("code:"+request.status+"\n"+ "message:"+request.responseText+"\n"+"error:"+error); 
						}
					})
				})
				
				
                $("#choiceReview").on("click", function() {
						$.ajax({
							url:"<%=request.getContextPath()%>/truckChoiceReview",
							type : "POST",
							data:{truckPk :<%=truck.getTruckPk()%>},
							success : function(data){ 
								$("#choice-body").html(data);
							}, 
							error : function(request,status,error) { 
								alert("code:"+request.status+"\n"+ "message:"+request.responseText+"\n"+"error:"+error); 
							}
						})
					})
					
					$("#choiceEvent").on("click", function() {
						$.ajax({
							url:"<%=request.getContextPath()%>/truckChoiceEvent",
							type : "POST",
							data:{truckPk :<%=truck.getTruckPk()%>},
							success : function(data){ 
								$("#choice-body").html(data);
							}, 
							error : function(request,status,error) { 
								alert("code:"+request.status+"\n"+ "message:"+request.responseText+"\n"+"error:"+error); 
							}
						})
					})
                </script>
							<div id="choice-body" class="panel-body"></div>
						</div>
					</div>
				</div>
			</div>



			<div id="truckDetail" class="col-md-4 col-md-offset-1">
<script>
// 맵에 찍어주기
$(function geocodeLatLng() {
	   		var mapOptions = {
	   			      zoom: 17
	   		};
		  	 var map = new google.maps.Map(document.getElementById('googlemap'), mapOptions);
	 //googlemap div에 구글 맵을 붙여쥼

		var geocoder = new google.maps.Geocoder;
			 var infowindow = new google.maps.InfoWindow;
 	
 		 var latitude = <%=truck.getLatitude()%>;
 		 var longitude = <%=truck.getLogitude()%>;
 		  var latlngStr = latitude + "," + longitude;
 			$('#holiday').html(<%=truck.getLatitude()%>);
 	     var latlng = {
		        lat: latitude,
		        lng: longitude
		      };	
		      geocoder.geocode({
		        'location': latlng
		      }, function(results, status) {
		        if (status === 'OK') {
		          if (results[1]) {
		            map.setZoom(18);
		            var marker = new google.maps.Marker({
		              position: latlng,
		              map: map
		            });
		            map.setCenter(new google.maps.LatLng(latitude, longitude))
		            //  results[1].formatted_address = 위도,경도로 구한 주소
		            infowindow.setContent(results[1].formatted_address);
		            infowindow.open(map, marker);
		          }
		        } else {
		          window.alert('No results found');
		          window.alert('Geocoder failed due to: ' + status);
		        } //  오류표시
   });
 });
	
	
  </script>
				<div class="row">
					<div class="panel panel-default">
						<div class="panel-heading">
							<h3 class="panel-title truck-panel-header">푸드트럭 상세 정보</h3>
						</div>
						<div class="panel-body">
							<div id="googlemap"></div>
							<br> <br>
							<p id="truck_address">
								위치 :
								<%=truck.getTrucklocation() %></p>
							<br>
								<p>
									오픈시간 : <%=request.getAttribute("openTime")%>
								</p>
								<br>
								<p>
									마감시간 : <%=request.getAttribute("closeTime")%>
								</p>
								<br>
								<p>
									휴무일 :<%=truck.getTruckHoliday()%>
								</p>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>
</section>
<script type="text/javascript">
//on/off스위치
$("#myonoffswitch").on('click', function(e) {
	e.preventDefault();
});
  
</script>

<%@ include file="/views/common/footer.jsp"%>

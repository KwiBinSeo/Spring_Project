<%@ page language="java" contentType="text/html; charset=UTF-8" session="false"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page import="com.cglab.smartplace.AllData" %> <!-- 사용자가 입력하는 모든 데이터들을 저장할 객체 import -->

<%

	// 귀빈 수정 부분
	request.setCharacterEncoding("UTF-8");

	// Session 객체에 저장 되어 있는 User_ID 및 User_PW 받기
	HttpSession session = request.getSession(false);
	String User_ID = (String) session.getAttribute("User_ID");
	String User_PW = (String) session.getAttribute("User_PW");

 	// 서버 날짜를 저장하는 부분
	GregorianCalendar calendar = new GregorianCalendar();
 	
	String[] weekDay = {"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};
	calendar.add(Calendar.DATE, 0); // 금일 날짜 가져오기
 	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
	int date = calendar.get(Calendar.DATE);
	int num = calendar.get(Calendar.DAY_OF_WEEK);
	
	String today = Integer.toString(year) + "년 " + Integer.toString(month) + "월 " + Integer.toString(date) + "일 " + weekDay[num]; // 오늘 날짜

	// DB연결 부분
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null, rs2 = null;
	String URL = "jdbc:mysql://220.69.209.170/smartplace";
	String DB_NAME = "cglab";
	String DB_PW = "clws";
	String query = "";
	int count = 0;
	int i = 0;
	String[] rsarray;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("URL, DB_Name, DB_PW");
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from occupation"; // occupation 테이블에서 모든 속성을 검색한다.
		rs = stmt.executeQuery(query); // 쿼리문 실행
		
		rs.last(); // 커서를 맨 마지막으로 이동
		count = rs.getRow();
		rs.beforeFirst(); // 커서를 원상태로 복구
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
	
	rsarray = new String[count]; // 데이터를 저장할 변수 rsarray String 객체 배열 생성
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("URL, DB_Name, DB_PW");
		stmt = conn.createStatement(); // 상태 확인
		query = "select * from occupation"; // occupation 테이블에서 모든 속성을 검색한다.
		rs = stmt.executeQuery(query); // 쿼리문 실행
		
		while(rs.next()) {
			rsarray[i] = rs.getString("occupation");
			System.out.println("데이터 값 : " + rsarray[i]);
			i++;
		}
	} catch (SQLException se) {
		se.printStackTrace();
	} catch (ClassNotFoundException cnfe) {
		cnfe.printStackTrace();
	}
	// DB 연결 부분 끝
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>건설현장관리플랫폼 | 인원현황</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"
	name="viewport">
	<!-- Bootstrap 3.3.7 -->
	<link
	href="<c:url value="/resources/css/bootstrap/css/bootstrap.min.css" />"
	rel="stylesheet">

	<!-- Font Awesome -->
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">

	<!-- Ionicons -->
	<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">


	<!-- Theme style -->
	<link href="<c:url value="/resources/css/dist/css/AdminLTE.min.css" />"
	rel="stylesheet">


	<!-- AdminLTE Skins. Choose a skin from the css/skins
	folder instead of downloading all of them to reduce the load. -->
	<link
	href="<c:url value="/resources/css/dist/css/skins/_all-skins.min.css" />"
	rel="stylesheet">
	
	<!-- Morris chart -->
	<link href="<c:url value="/resources/css/plugins/morris/morris.css" />"
	rel="stylesheet">

	<!-- jvectormap -->
	<link
	href="<c:url value="/resources/css/plugins/jvectormap/jquery-jvectormap-1.2.2.css" />"
	rel="stylesheet">

	<!-- Date Picker -->
	<link
	href="<c:url value="/resources/css/plugins/datepicker/datepicker3.css" />"
	rel="stylesheet">

	<!-- Daterange picker -->
	<link
	href="<c:url value="/resources/css/plugins/daterangepicker/daterangepicker.css" />"
	rel="stylesheet">

	<!-- bootstrap wysihtml5 - text editor -->
	<link
	href="<c:url value="/resources/css/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />"
	rel="stylesheet">

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- Google Font -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<header class="main-header">
			<!-- Logo -->
			<a href="home.jsp" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
				<span class="logo-mini"><b>관리</b>플랫폼</span> <!-- logo for regular state and mobile devices -->
				<span class="logo-lg" style="font-size: 13pt"><b><i	class="fa fa-tasks"></i>&nbsp;&nbsp;건설 현장 관리 플랫폼</b></span>
			</a>
			<!-- Header Navbar: style can be found in header.less -->
			<nav class="navbar navbar-static-top">
				<div class="navbar-custom-menu">
					<ul class="nav navbar-nav">
						<li class="dropdown user user-menu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<i class="fa fa-user" class="user-image" alt="User Image"></i> 
								<span class="hidden-xs"><%=User_ID%></span> 
								<%System.out.println("세션 아이디: " + User_ID);%>
							</a>
							<ul class="dropdown-menu">
								<!-- Menu Footer-->
								<li class="user-header"><img src="<c:url value="/resources/css/plugins/img/user.png" />" class="img-circle" alt="User Image">
									<p><%=User_ID%><small> 00현장관리자</small></p>
								</li>
								<li class="user-footer">
									<div class="pull-right">
										<a href="/test/logout" class="btn btn-default btn-flat">Sign out</a>
									</div>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</nav>
		</header>

		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<ul class="sidebar-menu" data-widget="tree">
					<li class="header">MENU</li>
					<li class="active treeview">
						<a href="#">
							<i class="fa fa-book"></i>
							<span>일일&nbsp;작업&nbsp;일보&nbsp;</span>
							<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="/smartplace/menu1by1.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;사항</a></li>
							<li><a href="/smartplace/menu1by2.jsp"><i class="fa fa-circle-o"></i>공종&nbsp;작업&nbsp;현황</a></li>
							<li class="active"><a href="/smartplace/menu1by3.jsp"><i class="fa fa-circle-o"></i>인원&nbsp;현황</a></li>
							<li><a href="/smartplace/menu1by4.jsp"><i class="fa fa-circle-o"></i>장비&nbsp;투입&nbsp;현황</a></li>
							<li><a href="/smartplace/menu1by5.jsp"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황</a></li>
							<li><a href="/smartplace/menu1by6.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;모아&nbsp;보기</a></li>
						</ul>
					</li>
					<li>
						<a href="/test/admin1">
							<i class="fa fa-book"></i>
							<span>관리자&nbsp;페이지&nbsp;</span>
							<span class="pull-right-container">
								<i class="fa fa-angle-left pull-right"></i>
							</span>
						</a>
						<ul class="treeview-menu">
							<li><a href="/test/admin1"><i class="fa fa-user-md"></i>공사&nbsp;개요</a></li>    
						</ul>
					</li>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1 class="box-title"> 인원 현황 <small>Personnel status</small></h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
					<li class="active">Personnel Status</li>
				</ol>
			</section>

			<section class="content">
				<div class="col-md-12">
					<div class="box box-danger">
						<div class="box-header with-border">
							<h3 class="box-title">인원 투입 현황</h3>
							<div class="pull-right">
								<form id="back" action="/test/menu1by2" method="POST" style="float: left">
									<input type="submit" value="BACK" class="btn btn-primary btn-block "></input>
								</form>
								<form id="next" action="/test/menu1by4" method="POST" style="float: left">
									<input type="submit" value="NEXT" class="btn btn-primary btn-block"></input>
								</form>
							</div>
						</div>

						<!-- <script type="text/javascript"> -->
							<div class="box-body">
								<!--  동적 input 생성 -->						
								<script language="javascript" type="text/javascript">     
									function ckbAll_onclick() {
										var ckbs = document.getElementsByName("ckbSelect");
										for (var i = 0; i < ckbs.length; i++)
											ckbs[i].checked = ckbAll.checked;
									}

									function btnAdd_onclick() {
									//자바스크립트로 동적 추가
							
									// var cp = tblMember.createCaption();
									//cp.innerHTML = "사원 정보";
									//새로운 행 추가
									var nr = tblMember.insertRow(-1);		
									var td1 = nr.insertCell(0);//체크박스 넣기
									var td2 = nr.insertCell(1);//텍스트박스 넣기
									var td3 = nr.insertCell(2); //텍스트박스 넣기		
									var td4 = nr.insertCell(3); //텍스트박스 넣기	
									var ckb = document.createElement("input");
									ckb.type = "text";
									ckb.name = "ckbSelect";
									td1.appendChild(document.createElement("input"));
									td2.appendChild(document.createElement("input"));
									td3.appendChild(document.createElement("input"));  
									td4.appendChild(document.createElement("input"));            
								}
								</script>

								<form id="frm" action="/test/menu1by4" method="POST">
									<div class="table-responsive">
										<script> var temp; function drop_click(selectObj){
											window.location.replace("menu1by3?temp="+selectObj.value);
											var val = selectObj.value;
											document.getElementById("jobSel").value = val;
												//alert(selectObj.value); 
												alert(val);
											};
										</script>

										<script> var temp2; function drop_click2(selectObj){

											window.location.replace("menu1by3?temp2="+selectObj.value);
										};
										</script>

										<script> var temp3; function drop_click3(selectObj){

											window.location.replace("menu1by3?temp3="+selectObj.value);
										};
										</script>
								
										<script> var temp4; function drop_click4(selectObj){

											window.location.replace("menu1by3?temp4="+selectObj.value);
										};
										</script>

										<script> var temp5; function drop_click5(selectObj){

											window.location.replace("menu1by3?temp5="+selectObj.value);
										};
										</script>
							
										<script>
										function addFunction() {
											var x = parseInt(document.getElementById("total").value);
											var y = parseInt(document.getElementById("today").value);
											var sum = x+y;
											document.getElementById("new_total").value = x+y;
										}
										</script>
										<table class="table no-margin">			
											<thead>
												<tr>
													<th width=10><center>구분</center></th>
													<th width=10><center>전일</center></th>
													<th width=10><center>금일</center></th>
													<th width=10><center>누계</center></th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><center>
														<select name="job" onChange="javascript:drop_click(this)">
															<option value="구분 선택">구분 선택</option>
															<c:forEach begin="0" end="${fn:length(rsarray)-1}" var="index">
															<option value="${index}" >
																<c:out value="${rsarray[index]}"/>
																<% String check_value = "";
																check_value = (String)pageContext.getAttribute("value");
																System.out.println("선택한 항목 : "+ check_value);
																%>
															</option>
															</c:forEach>
														</select>
													</center></td>
													<%
													//선택한 인원의 total 출력
													rs = null;
													Connection con = null;
													PreparedStatement pstmt = null;
													String sql = "";

													String url = "jdbc:mysql://220.69.209.170/smartplace";
													String user = "cglab";
													String pwd = "clws";
													int total = 0;
													int total2 = 0;
													int total3 = 0;
													int total4 = 0;
													int total5 = 0;
													String temp="";
													String  occupation_number="";//select;

											
													try{
													 //1단계 드라이버로더
													 Class.forName("com.mysql.jdbc.Driver");
													 //2단계 디비연결
													 con = DriverManager.getConnection(url, user, pwd);
													 //3단계 id에 해당하는 passwd가져오기
													 sql = "select total from occupation_db where occupation_number=?";


													 pstmt = con.prepareStatement(sql);
													 pstmt.setString(1,  occupation_number);

													 //4단계 실행 => rs
													 rs = pstmt.executeQuery();
													 //5단계 데이터가 있으면 아이디있음
													 
													 if(rs.next())
													 {
													 	temp = rs.getString("total");
													 	total = Integer.parseInt(temp);
														//System.out.println(select + "번의 total: "+total);

													}}
													catch (Exception e) {
													e.printStackTrace();
													}
													%>

													<td><input type="text" id="total" name="total" width=50 onkeyup="addFunction()" value="<%=total%>"></td>
													<td><input type="text" id="today" name="today" width=50 onkeyup="addFunction()"></td>
													<td><input type="text" id="new_total" name="new_total" width=50 ></td>
												</tr>

												<script>
													function addFunction2() {
														var x = parseInt(document.getElementById("total2").value);
														var y = parseInt(document.getElementById("today2").value);
														document.getElementById("new_total2").value = x+y;
													}
												</script>

												<tr>
													<td><center>
														<select name="job" onChange="javascript:drop_click2(this)">
															<option value="구분 선택">구분 선택</option>
															<c:forEach begin="0" end="${fn:length(rsarray)-1}" var="index">
																<option value="${index}" >
																	<c:out value="${rsarray[index]}"/>
																</option>
															</c:forEach>     
														</select>
													</center></td>
													<td><input type="text" id="total2" name="total2" width=50 onkeyup="addFunction2()" value="<%=total2%>"></td>
													<td><input type="text" id="today2" name="today2" width=50 onkeyup="addFunction2()"></td>
													<td><input type="text" id="new_total2" name="new_total2" width=50 ></td>
												</tr>

												<script>
													function addFunction3() {
														var x = parseInt(document.getElementById("total3").value);
														var y = parseInt(document.getElementById("today3").value);
														document.getElementById("new_total3").value = x+y;
													}
												</script>

												<tr>
													<td><center>
														<select name="job" onChange="javascript:drop_click3(this)">
															<option value="구분 선택">구분 선택</option>
															<c:forEach begin="0" end="${fn:length(rsarray)-1}" var="index">
															<option value="${index}" >
																<c:out value="${rsarray[index]}"/>
															</option>
														</c:forEach>     
													</select>
												</center></td>

												<td><input type="text" id="total3" name="total3" width=50 onkeyup="addFunction3()" value="<%=total3%>"></td>
												<td><input type="text" id="today3" name="today3" width=50 onkeyup="addFunction3()"></td>
												<td><input type="text" id="new_total3" name="new_total3" width=50 ></td>
											</tr>

											<script>
												function addFunction4() {
													var x = parseInt(document.getElementById("total4").value);
													var y = parseInt(document.getElementById("today4").value);
													document.getElementById("new_total4").value = x+y;
												}
											</script>

											<tr>
												<td><center>
													<select name="job" onChange="javascript:drop_click4(this)">
														<option value="구분 선택">구분 선택</option>
														<c:forEach begin="0" end="${fn:length(rsarray)-1}" var="index">
															<option value="${index}" >
																<c:out value="${rsarray[index]}"/>
															</option>
														</c:forEach>     
													</select>
												</center></td>
												<td><input type="text" id="total4" name="total4" width=50 onkeyup="addFunction()" value="<%=total4%>"></td>
												<td><input type="text" id="today4" name="today4" width=50 onkeyup="addFunction()"></td>
												<td><input type="text" id="new_total4" name="new_total4" width=50 ></td>
											</tr>

											<script>
												function addFunction5() {
													var x = parseInt(document.getElementById("total5").value);
													var y = parseInt(document.getElementById("today5").value);
													document.getElementById("new_total5").value = x+y;
												}
											</script>

											<tr>
												<td><center>
													<select name="job" onChange="javascript:drop_click5(this)">
														<option value="구분 선택">구분 선택</option>
														<c:forEach begin="0" end="${fn:length(rsarray)-1}" var="index">
															<option value="${index}" >
																<c:out value="${rsarray[index]}"/>
															</option>
															<script> 
																document.form.a.value='<?=$a?>'; 
															</script> 
														</c:forEach>     
													</select>
												</center></td>

												<td><input type="text" id="total5" name="total5" width=50 onkeyup="addFunction5()" value="<%=total5%>"></td>
												<td><input type="text" id="today5" name="today5" width=50 onkeyup="addFunction5()"></td>
												<td><input type="text" id="new_total5" name="new_total5" width=50 ></td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>
							<br><br>
							<div class="pull-right">
								<input type="button" id="btnAdd" name="btnAdd" value="추가" onclick="return btnAdd_onclick()" class="btn btn-primary btn-block bg-black color-palette"/>
							</div>
						</div>
					</div>
				</div>
			</section>	
		</div>
	</div>

	<div>
		<input type="text"  id="w-input-search" value="">
		<span>
			<button id="button-id" type="button">Search</button>
		</span>
	</div>


	<footer class="main-footer">
		<div class="pull-right hidden-xs">
			<b>Version</b> 2.4.0
		</div>
		<strong>Copyright &copy; 2017-2017 <a href="http://cglab.sch.ac.kr/" target="_blank">Maded by CGLAB in Soonchunhyang Univ</a>.</strong> All rights reserved.
	</footer>

	<!-- Add the sidebar's background. This div must be placed
		immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->
	<!-- jQuery 3.1.1 -->
	<script src="css/plugins/jQuery/jquery-3.1.1.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>

	<!-- Bootstrap 3.3.7 -->
	<script src="resources/css/bootstrap/js/bootstrap.min.js"></script>

	<!-- Morris.js charts -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<script src="<c:url value="/resources/css/plugins/morris/morris.min.js" />"></script>

	<!-- Sparkline -->
	<script src="<c:url value="/resources/css/plugins/sparkline/jquery.sparkline.min.js" />"></script>

	<!-- jvectormap -->
	<script src="<c:url value="/resources/css/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" />"></script>

	<!-- jQuery Knob Chart -->
	<script src="<c:url value="/resources/css/plugins/knob/jquery.knob.js" />"></script>

	<!-- daterangepicker -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
	<script src="<c:url value="/resources/css/plugins/daterangepicker/daterangepicker.js" />"></script>

	<!-- datepicker -->
	<script src="<c:url value="/resources/css/plugins/datepicker/bootstrap-datepicker.js" />"></script>

	<!-- Bootstrap WYSIHTML5 -->
	<script src="<c:url value="/resources/css/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" />"></script>

	<!-- Slimscroll -->
	<script src="<c:url value="/resources/css/plugins/slimScroll/jquery.slimscroll.min.js" />"></script>

	<!-- FastClick -->
	<script src="<c:url value="/resources/css/plugins/fastclick/fastclick.js" />"></script>

	<!-- AdminLTE App -->
	<script src="<c:url value="/resources/css/dist/js/adminlte.min.js" />"></script>

	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script src="<c:url value="/resources/css/dist/js/pages/dashboard.js" />"></script>

	<!-- AdminLTE for demo purposes -->
	<script src="<c:url value="/resources/css/dist/js/demo.js" />"></script>

</body>
</html>

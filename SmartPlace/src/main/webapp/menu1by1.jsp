<%@page import="java.sql.Date"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" session="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.cglab.smartplace.AllData" %> <!-- 사용자가 입력하는 모든 데이터들을 저장할 객체 import -->


<%
	// AllData 객체 만들기
	AllData AD = new AllData();
	
	//서버 날짜 date에 저장
	GregorianCalendar calendar = new GregorianCalendar();
	GregorianCalendar calendar_2 = new GregorianCalendar();

	calendar.add(Calendar.DATE, -1); // 전일 날짜 가져요기
	calendar_2.add(Calendar.DATE, 0); // 금일 날짜 가져오기

	String[] weekDay = {"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"};

	// 전일 요일 계산하는 부분
	int year_1 = calendar.get(Calendar.YEAR);
	int month_1 = calendar.get(Calendar.MONTH) + 1;
	int date_1 = calendar.get(Calendar.DATE);
	int num_1 = calendar.get(Calendar.DAY_OF_WEEK) - 1;

	// 금일 요일 계산하는 부분
	int year_2 = calendar_2.get(Calendar.YEAR);
	int month_2 = calendar_2.get(Calendar.MONTH) + 1;
	int date_2 = calendar_2.get(Calendar.DATE);
	int num_2 = calendar_2.get(Calendar.DAY_OF_WEEK) - 1;

	String yesterday = Integer.toString(year_1) + "년 " + Integer.toString(month_1) + "월 "
			+ Integer.toString(date_1) + "일 " + weekDay[num_1]; // 어제 날짜
	String today = Integer.toString(year_2) + "년 " + Integer.toString(month_2) + "월 " + Integer.toString(date_2)
			+ "일 " + weekDay[num_2]; // 오늘 날짜

	//id 받기
	HttpSession session = request.getSession(false);
	String User_ID = (String) session.getAttribute("User_ID");
	String User_PW = (String) session.getAttribute("User_PW");
%>

<%
	ResultSet rs = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	String sql = "";

	String url = "jdbc:mysql://220.69.209.170/smartplace";
	String user = "cglab";
	String pwd = "clws";
	String yest_issue = "";

	try {
		//1단계 드라이버로더
		Class.forName("com.mysql.jdbc.Driver");
		//2단계 디비연결
		con = DriverManager.getConnection(url, user, pwd);
		//3단계 id에 해당하는 passwd가져오기
		sql = "select issue from workissue where id=?";

		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, User_ID);

		//4단계 실행 => rs
		rs = pstmt.executeQuery();
		//5단계 데이터가 있으면 아이디있음

		while (rs.next() != false) {
			yest_issue = rs.getString("issue");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>건설현장관리플랫폼 | 작업사항</title>
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
<!-- AdminLTE Skins. Choose a skin from the css/skins folder instead of downloading all of them to reduce the load. -->
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

	<!-- jQuery 3.1.1 -->
	<script src="/resources/css/plugins/jQuery/jquery-3.1.1.min.js"></script>
	<!-- jQuery UI 1.11.4 -->
	<script src="https://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
	<!-- Resolve conflict in jQuery UI tooltip with Bootstrap tooltip -->
	<script>
		$.widget.bridge('uibutton', $.ui.button);
	</script>
	<!-- Bootstrap 3.3.7 -->
	<script src="resources/css/bootstrap/js/bootstrap.min.js"></script>
	<!-- Morris.js charts -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/raphael/2.1.0/raphael-min.js"></script>
	<script
		src="<c:url value="/resources/css/plugins/morris/morris.min.js" />"></script>
	<!-- Sparkline -->
	<script
		src="<c:url value="/resources/css/plugins/sparkline/jquery.sparkline.min.js" />"></script>
	<!-- jvectormap -->
	<script
		src="<c:url value="/resources/css/plugins/jvectormap/jquery-jvectormap-1.2.2.min.js" />"></script>
	<!-- jQuery Knob Chart -->
	<script
		src="<c:url value="/resources/css/plugins/knob/jquery.knob.js" />"></script>
	<!-- daterangepicker -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
	<script
		src="<c:url value="/resources/css/plugins/daterangepicker/daterangepicker.js" />"></script>
	<!-- datepicker -->
	<script
		src="<c:url value="/resources/css/plugins/datepicker/bootstrap-datepicker.js" />"></script>
	<!-- Bootstrap WYSIHTML5 -->
	<script
		src="<c:url value="/resources/css/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" />"></script>
	<!-- Slimscroll -->
	<script
		src="<c:url value="/resources/css/plugins/slimScroll/jquery.slimscroll.min.js" />"></script>
	<!-- FastClick -->
	<script
		src="<c:url value="/resources/css/plugins/fastclick/fastclick.js" />"></script>
	<!-- AdminLTE App -->
	<script src="<c:url value="/resources/css/dist/js/adminlte.min.js" />"></script>
	<!-- AdminLTE dashboard demo (This is only for demo purposes) -->
	<script
		src="<c:url value="/resources/css/dist/js/pages/dashboard.js" />"></script>
	<!-- AdminLTE for demo purposes -->
	<script src="<c:url value="/resources/css/dist/js/demo.js" />"></script>
	
</head>

<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<header class="main-header"> <!-- Logo --> <a href="home.jsp"
			class="logo"> <!-- mini logo for sidebar mini 50x50 pixels --> <span
			class="logo-mini"><b>관리</b>플랫폼</span> <!-- logo for regular state and mobile devices -->
			<span class="logo-lg" style="font-size: 13pt"><b><i
					class="fa fa-tasks"></i>&nbsp;&nbsp;건설 현장 관리 플랫폼</b></span>
		</a> <!-- Header Navbar: style can be found in header.less --> <nav
			class="navbar navbar-static-top">
		<div class="navbar-custom-menu">
			<ul class="nav navbar-nav">
				<li class="dropdown user user-menu">
				<!-- 우측 상단에 있는 회원 아이디 출력 부분 -->
				<a href="#" class="dropdown-toggle" data-toggle="dropdown"> <i class="fa fa-user" class="user-image" alt="User Image"></i> 
					<span class="hidden-xs"><%=User_ID%></span> <%System.out.println("세션 아이디: " + User_ID);%>
				</a>
					<ul class="dropdown-menu">
						<!-- Menu Footer-->
						<li class="user-header"><img
							src="<c:url value="/resources/css/plugins/img/user.png" />"
							class="img-circle" alt="User Image">
							<p><%=User_ID%><small> 00현장관리자</small></p></li>
						<li class="user-footer">
							<div class="pull-right">
								<a href="/test/logout" class="btn btn-default btn-flat">Sign
									out</a>
							</div>
						</li>
					</ul></li>
			</ul>
		</div>
		</nav> </header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar"> <!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar"> <!-- /.search form --> <!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">MENU</li>
			<li class="active treeview"><a href="/test"> <i
					class="fa fa-book"></i> <span>일일&nbsp;작업&nbsp;일보</span> <span
					class="pull-right-container"><i
						class="fa fa-angle-left pull-right"></i></span>
			</a>
				<ul class="treeview-menu">
					<li class="active"><a href="/smartplace/menu1by1.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;사항</a></li>
					<li><a href="/smartplace/menu1by2.jsp"><i class="fa fa-circle-o"></i>공종&nbsp;작업&nbsp;현황</a></li>
					<li><a href="/smartplace/menu1by3.jsp"><i class="fa fa-circle-o"></i>인원&nbsp;현황</a></li>
					<li><a href="/smartplace/menu1by4.jsp"><i class="fa fa-circle-o"></i>장비&nbsp;투입&nbsp;현황</a></li>
					<li><a href="/smartplace/menu1by5.jsp"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황</a></li>
					<li><a href="/smartplace/menu1by6.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;모아&nbsp;보기</a></li>
				</ul></li>
			<li><a href="/test/admin1"> <i class="fa fa-book"></i> <span>관리자&nbsp;페이지&nbsp;</span>
					<span class="pull-right-container"><i
						class="fa fa-angle-left pull-right"></i></span>
			</a>
				<ul class="treeview-menu">
					<li><a href="/test/admin1"><i class="fa fa-user-md"></i>공사&nbsp;개요</a></li>
				</ul></li>
		</ul>
		</section> <!-- /.sidebar --> </aside>

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">

			<!-- Content Header (Page header) -->
			<section class="content-header">
			<h1>
				작업 사항<small>Work Issues</small>
			</h1>
			<ol class="breadcrumb">
				<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
				<li class="active">Work issue</li>
			</ol>
			</section>

			<!-- 오늘의 날씨 -->
			<section class="content">
			<div class="col-md-8 col-md-offset-2">
				<div class=" box box-danger">
					<div class="box-header with-border">
						<fieldset>
							오늘의 날씨
							<div class="pull-right">
								<input type="checkbox" name="sunny" value="1"> <label
									for="coding">맑음&nbsp;&nbsp;&nbsp;&nbsp;</label> <input
									type="checkbox" name="cloudy" value="2"> <label
									for="music">구름 많음&nbsp;&nbsp;&nbsp;&nbsp;</label> <input
									type="checkbox" name="rainy" value="3"> <label
									for="music">비&nbsp;&nbsp;&nbsp;&nbsp;</label> <input
									type="checkbox" name="snowy" value="4"> <label
									for="music">눈</label>
							</div>
						</fieldset>
					</div>
				</div>
			</div>

			<div class="col-md-8 col-md-offset-2">
				<div class=" box box-danger">
					<div class="box-header with-border">
						<i class="fa fa-warning"></i>
						<h3 class="box-title">전일 작업 사항</h3>
						&nbsp;&nbsp;&nbsp; <small><%=yesterday%> </small>
					</div>
					<div class="box-body with-border">
						<div class="col-xs-6">
							<textarea class="textarea" cols="70" rows="10" placeholder="Place some text here"><%=yest_issue%>
								<%System.out.println(yest_issue);%>
							</textarea>
						</div>
					</div>
				</div>
			</div>

			<!-- menu1by1Toby2.do로 전달 //  -->
			<form action="/smartplace/menu1by1Toby2.do" method="post">
				<div class="col-md-8 col-md-offset-2">
					<div class=" box box-danger">
						<div class="box-header with-border">
							<i class="fa fa-warning"></i>
							<h3 class="box-title">금일 예정 사항</h3>
							&nbsp;&nbsp;&nbsp; <small><%=today%> </small>
							<div class="pull-right">
								<input type="submit" value="NEXT" class="btn btn-primary btn-block"></input>
							</div>
						</div>
						<div class="box-body with-border">
							<div class="col-xs-6">
								<% if(AD.today_issue.equals("") || AD.today_issue == null) { %>
								<textarea name="issue" cols="70" rows="10"
									placeholder="금일 예정 사항을 입력하세요"
									style="font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
								<%} else { %>
								<textarea name="issue" cols="70" rows="10"
									placeholder="<%=AD.today_issue%>"
									style="font-size: 14px; line-height: 18px; border: 1px solid #dddddd; padding: 10px;"></textarea>
								<% } 
								System.out.println("금일 작업사항 : " + AD.today_issue);%>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>
		</section>

		<!-- Control Sidebar -->
		<aside class="control-sidebar control-sidebar-dark"> <!-- Create the tabs -->
		<ul class="nav nav-tabs nav-justified control-sidebar-tabs">
			<li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
			<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content">
			<!-- Home tab content -->
			<div class="tab-pane" id="control-sidebar-home-tab">
				<h3 class="control-sidebar-heading">Recent Activity</h3>
				<ul class="control-sidebar-menu">
					<li>
						<a href="javascript:void(0)"> <i class="menu-icon fa fa-birthday-cake bg-red"></i>
						<div class="menu-info">
							<h4 class="control-sidebar-subheading">Langdon's Birthday</h4>
							<p>Will be 23 on April 24th</p>
						</div>
						</a>
					</li>
					<li>
						<a href="javascript:void(0)"> <i class="menu-icon fa fa-user bg-yellow"></i>
							<div class="menu-info">
								<h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>
								<p>New phone +1(800)555-1234</p>
							</div>
						</a>
					</li>
					<li>
						<a href="javascript:void(0)"> <i class="menu-icon fa fa-envelope-o bg-light-blue"></i>
						<div class="menu-info">
							<h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>
							<p>nora@example.com</p>
						</div>
						</a>
					</li>
					<li>
						<a href="javascript:void(0)"> <i class="menu-icon fa fa-file-code-o bg-green"></i>
							<div class="menu-info">
								<h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>
								<p>Execution time 5 seconds</p>
							</div>
						</a>
					</li>
				</ul>
				
				<!-- /.control-sidebar-menu -->
				<h3 class="control-sidebar-heading">Tasks Progress</h3>
				<ul class="control-sidebar-menu">
					<li>
						<a href="javascript:void(0)">
						<h4 class="control-sidebar-subheading">Custom Template Design <span class="label label-danger pull-right">70%</span></h4>
						<div class="progress progress-xxs">
							<div class="progress-bar progress-bar-danger" style="width: 70%"></div>
						</div>
						</a>
					</li>
					<li>
						<a href="javascript:void(0)">
						<h4 class="control-sidebar-subheading">Update Resume <span class="label label-success pull-right">95%</span></h4>
							<div class="progress progress-xxs">
								<div class="progress-bar progress-bar-success" style="width: 95%"></div>
							</div>
						</a>
					</li>
					<li>
						<a href="javascript:void(0)">
							<h4 class="control-sidebar-subheading"> Laravel Integration <span class="label label-warning pull-right">50%</span></h4>
							<div class="progress progress-xxs">
								<div class="progress-bar progress-bar-warning" style="width: 50%"></div>
							</div>
						</a>
					</li>
					<li>
						<a href="javascript:void(0)">
							<h4 class="control-sidebar-subheading">Back End Framework <span class="label label-primary pull-right">68%</span></h4>
							<div class="progress progress-xxs">
								<div class="progress-bar progress-bar-primary"style="width: 68%"></div>
							</div>
						</a>
					</li>
				</ul>
				<!-- /.control-sidebar-menu -->
				</div>
				<!-- /.tab-pane -->
				<!-- Stats tab content -->
				<div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
				<!-- /.tab-pane -->
				<!-- Settings tab content -->
					<div class="tab-pane" id="control-sidebar-settings-tab">
						<form method="post">
							<h3 class="control-sidebar-heading">General Settings</h3>
								<div class="form-group">
									<label class="control-sidebar-subheading"> Report panel usage
										<input type="checkbox" class="pull-right" checked>
									</label>
									<p>Some information about this general settings option</p>
								</div>
								<!-- /.form-group -->
								<div class="form-group">
									<label class="control-sidebar-subheading"> Allow mail redirect <input type="checkbox" class="pull-right" checked></label>
									<p>Other sets of options are available</p>
								</div>
								<!-- /.form-group -->

								<div class="form-group">
									<label class="control-sidebar-subheading"> Expose author name in posts <input type="checkbox" class="pull-right" checked></label>

						<p>Allow the user to show his name in blog posts</p>
					</div>
					<!-- /.form-group -->

					<h3 class="control-sidebar-heading">Chat Settings</h3>

					<div class="form-group">
						<label class="control-sidebar-subheading"> Show me as
							online <input type="checkbox" class="pull-right" checked>
						</label>
					</div>
					<!-- /.form-group -->

					<div class="form-group">
						<label class="control-sidebar-subheading"> Turn off
							notifications <input type="checkbox" class="pull-right">
						</label>
					</div>
					<!-- /.form-group -->

					<div class="form-group">
						<label class="control-sidebar-subheading"> Delete chat
							history <a href="javascript:void(0)" class="text-red pull-right"><i
								class="fa fa-trash-o"></i></a>
						</label>
					</div>
					<!-- /.form-group -->
				</form>
			</div>
			<!-- /.tab-pane -->
		</div>
		</aside>
		<!-- /.control-sidebar -->
		<!-- Add the sidebar's background. This div must be placed immediately after the control sidebar -->
		<div class="control-sidebar-bg"></div>
	</div>
	<!-- ./wrapper -->
</body>
</html>
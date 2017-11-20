<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>


<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>


 <%
 	/*
	//서버 날짜 date에 저장
    GregorianCalendar calendar = new GregorianCalendar();
	
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH)+1;
	int dat = calendar.get(Calendar.DATE);
	
	String date = Integer.toString(year) +"-"+Integer.toString(month)+"-"+Integer.toString(dat);
	
	
	//id 받기
	HttpSession session = request.getSession(false);
	String id = (String)session.getAttribute("id");
	
	*/	
 %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>건설현장관리플랫폼 | 자재투입현황</title>
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	 <!-- Bootstrap 3.3.7 -->
	<link href="<c:url value="/resources/css/bootstrap/css/bootstrap.min.css" />" rel="stylesheet">
	
	<!-- Font Awesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
	
	<!-- Ionicons -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
	
	<!-- Theme style --> 
	<link href="<c:url value="/resources/css/dist/css/AdminLTE.min.css" />" rel="stylesheet">
		
	<!-- AdminLTE Skins. Choose a skin from the css/skins
	     folder instead of downloading all of them to reduce the load. -->
	<link href="<c:url value="/resources/css/dist/css/skins/_all-skins.min.css" />" rel="stylesheet">
		
	<!-- Morris chart -->
	<link href="<c:url value="/resources/css/plugins/morris/morris.css" />" rel="stylesheet">
	
	<!-- jvectormap -->
	<link href="<c:url value="/resources/css/plugins/jvectormap/jquery-jvectormap-1.2.2.css" />" rel="stylesheet">
	
	<!-- Date Picker -->
	<link href="<c:url value="/resources/css/plugins/datepicker/datepicker3.css" />" rel="stylesheet">
	
	<!-- Daterange picker -->
	<link href="<c:url value="/resources/css/plugins/daterangepicker/daterangepicker.css" />" rel="stylesheet">
	
	<!-- bootstrap wysihtml5 - text editor -->
	<link href="<c:url value="/resources/css/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" />" rel="stylesheet">
	
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
    		<a href="home.jsp" class="logo">
      			<!-- mini logo for sidebar mini 50x50 pixels -->
      			<span class="logo-mini"><b>관리</b>플랫폼</span>
      			<!-- logo for regular state and mobile devices -->
      			<span class="logo-lg" style="font-size:13pt"><b><i class="fa fa-tasks"></i>&nbsp;&nbsp;건설 현장 관리 플랫폼</b></span>
    		</a>
    
    		<!-- Header Navbar: style can be found in header.less -->
    		<nav class="navbar navbar-static-top"> 
      			<div class="navbar-custom-menu">
        			<ul class="nav navbar-nav">
     	 				<li class="dropdown user user-menu">
            				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
              					<i class="fa fa-user" class="user-image" alt="User Image"></i>
             	 				<span class="hidden-xs"><%//=id %></span>
             	 				<%// System.out.println("세션 아이디: "+id); %>
            				</a>
            				<ul class="dropdown-menu">          
              					<!-- Menu Footer-->
              					<li class="user-header">
              						<img src="<c:url value="/resources/css/plugins/img/user.png" />" class="img-circle" alt="User Image">
              						<p> <%//=id %><small> 00현장관리자</small></p>
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
				<!-- sidebar menu: : style can be found in sidebar.less -->
      			<ul class="sidebar-menu" data-widget="tree">
        			<li class="header">MENU</li>
        			<li class="active treeview">
          				<a href="#">
            				<i class="fa fa-book"></i> <span>일일&nbsp;작업&nbsp;일보</span>
            				<span class="pull-right-container">
              					<i class="fa fa-angle-left pull-right"></i>
            				</span>
          				</a>
          				<ul class="treeview-menu">
            				<li><a href="/smartplace/menu1by1.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;사항</a></li>            
							<li><a href="/smartplace/menu1by2.jsp"><i class="fa fa-circle-o"></i>공종&nbsp;작업&nbsp;현황</a></li>  
							<li><a href="/smartplace/menu1by3.jsp"><i class="fa fa-circle-o"></i>인원&nbsp;현황</a></li>
							<li><a href="/smartplace/menu1by4.jsp"><i class="fa fa-circle-o"></i>장비&nbsp;투입&nbsp;현황</a></li>
							<li class="active"><a href="/smartplace/menu1by5.jsp"><i class="fa fa-circle-o"></i>자재&nbsp;투입&nbsp;현황</a></li>
							<li><a href="/smartplace/menu1by6.jsp"><i class="fa fa-circle-o"></i>작업&nbsp;일보&nbsp;모아&nbsp;보기</a></li>
          				</ul>
        			</li>
        			<li>
         				<a href="/smartplace/admin1.jsp">
            				<i class="fa fa-book"></i> <span>관리자&nbsp;페이지&nbsp;</span>
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
	      		<h1> 자재 투입 현황<small>Material input status</small></h1>
	      		<ol class="breadcrumb">
	        		<li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
	        		<li class="active">Material input status</li>
	      		</ol>
    		</section>

			<section class="content">
				<div class="col-md-12">
					<div class="box box-danger">
						<div class = "box-header with-border">	
							<h3 class="box-title"> 관급 자재 투입 현황</h3> 
							<div class="pull-right">
								<form id="back" action="/test/menu1by4" method="POST" style="float:left">
									<input type="submit" value="BACK" class="btn btn-primary btn-block"></input>
								</form>
								<form id="back" action="/test/menu1by4" method="POST" style="float:left">
									<input type="submit" value="NEXT" class="btn btn-primary btn-block"></input>
								</form>
							</div>
						</div>
						<div class="box-body">
							<form id="frm"   action="/test/menu1by4" method="POST" >
								<div  class="table-responsive">
									<table class="table no-margin">
										<thead>
											<tr>
												<th><center>자재명</center></th>
												<th><center>설계량</center></th>
												<th><center>기반입량</center></th>
												<th><center>반입량</center></th>
												<th><center>반입누계</center></th>
												<th><center>비고</center></th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><center>
													<select name="job" >
					     								<option value="">구분 선택</option>
													</select>
												</center></td>
												<td><center><input type="text" name="first_description"></input></td>
												<td><center><input type="text" name="fisrt_number"></input></td>
												<td><center><input type="text" name="fisrt_number"></input></td>
												<td><center><input type="text" name="first_description"></input></td>
												<td><center><input type="text" name="fisrt_number"></input></td>
											</tr>			
										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>

			<section class="content">
				<div class="col-md-12">
					<div class="box box-danger">
						<div class = "box-header with-border">
							<h3 class="box-title"> 사급 자재 투입 현황</h3> 
						</div>
						<div class="box-body">
							<form id="frm"   action="/test/menu1by4" method="POST" >
								<div class="table-responsive">
									<table class="table no-margin">
										<thead>
											<tr>
												<th><center>자재명</center></th>
												<th><center>설계량</center></th>
												<th><center>기반입량</center></th>
												<th><center>반입량</center></th>
												<th><center>반입누계</center></th>
												<th><center>비고</center></th>		
											</tr>
										</thead>
										<tbody>
											<tr>
												<td><center>
													<select name="job" >
											    		<option value="">구분 선택</option>  
													</select>
												</center></td>
												<td><center><input type="text" name="first_description"></input></td>
												<td><center><input type="text" name="fisrt_number"></input></td>
												<td><center><input type="text" name="fisrt_number"></input></td>
												<td><center><input type="text" name="first_description"></input></td>
												<td><center><input type="text" name="fisrt_number"></input></td>
											</tr>
										</tbody>
									</table>
								</div>
							</form>
						</div>
					</div>
				</div>
			</section>		
		</div>
		  
		<!-- footer 메뉴바 -->
		<footer class="main-footer">
	    	<div class="pull-right hidden-xs">
	      		<b>Version</b> 2.4.0
	    	</div>
	    	<strong>Copyright &copy; 2017-2017 <a href="http://cglab.sch.ac.kr/" target="_blank">Maded by CGLAB in Soonchunhyang Univ</a>.</strong> All rights reserved.
	  	</footer>		
	</div>
	<!-- /.content-wrapper -->

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

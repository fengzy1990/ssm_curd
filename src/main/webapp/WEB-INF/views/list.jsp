<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- web路径问题
	不易/开始的相对路径，找资源，是以当前资源的路径为基准，经常出现问题。
	以/开始的相对路径，找资源，是以服务器的路径为标准（http://xxx:9909）
 -->
<!-- 引入jQuery样式 -->
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-1.12.4-min.js"></script>
<!-- 引入样式 -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
		<h1>SSM-CURD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			 <div class="col-md-4 col-md-offset-8">
			 <button type="button" class="btn btn-primary">新增</button>
			 <button type="button" class="btn btn-danger">删除</button>
			 </div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
			<table>
				<tr>
					<th>#</th>
					<th>empName</th>
					<th>gender</th>
					<th>email</th>
					<th>deptName</th>
					<th>操作</th>
				</tr>
				<tr>
					<th>1</th>
					<th>aa</th>
					<th>a</th>
					<th>a</th>
					<th>aa</th>
					<th>
					<button type="button" class="btn btn-info"> <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑
					</button>
					<button type="button" class="btn btn-warning"><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>删除
					</button>
					</th>
				</tr>
			</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row"></div>
</body>
</html>
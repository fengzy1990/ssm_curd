<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
	src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
<!-- 引入样式 -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
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
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页信息 -->
		<div class="row">
			<div class="col-md-6">当前第 页，共 页，共 条记录</div>
			<div class="clo-md-6"></div>
		</div>
	</div>
	<script type="text/javascript">
		//页面加载完成后，发送ajax请求，得到分页数据
		$(function() {
			$.ajax({
				url : "${APP_PATH}/empsjson",
				data : "pn=1",
				type : "GET",
				success : function(result) {
					//console.log(result);
					//请求成功后，解析json,显示员工和分页信息
					build_emps_table(result);
				}
			});
		});
		function build_emps_table(result) {
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				//alert(item.empName);
				var empIdTd=$("<td></td>").append(item.empId);
				var empNameTd=$("<td></td>").append(item.empName);
				var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
				var emailTd=$("<td></td>").append(item.email);
				var deptNameTd=$("<td></td>").append(item.department.deptName);
				var editBtn=$("<button></button>").addClass("btn btn-info btn-sm")
				.append($("<span></span>")
						.addClass("glyphicon glyphicon-pencil"))
						.append(" 编辑");
				var delBtn=$("<button></button>").addClass("btn btn-warning btn-sm")
												.append($("<span></span>")
														.addClass("glyphicon glyphicon-trash"))
														.append(" 删除");
				var btnTd=$("<td></td>").append(editBtn).append(delBtn);
				$("<tr></tr>").append(empIdTd)
								.append(empNameTd)
								.append(genderTd)
								.append(emailTd)
								.append(deptNameTd)
								.append(btnTd)
								.appendTo("#emps_table tbody");
			});
		}
		function build_page_nav(result) {

		}
	</script>
</body>
</html>
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
				<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
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
			<div class="col-md-6" id="page_info_area"></div>
			<div class="clo-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecord;//用来调用增加完数据后，用记录数作为页码，这样pageinfo总会显示最后一页
		//页面加载完成后，发送ajax请求，得到分页数据
		$(function() {
			to_page(1);

		});
		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/empsjson",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//请求成功后，解析json,显示员工和分页信息
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}
		//显示每条职工数据函数
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				//alert(item.empName);
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == "M" ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-info btn-sm").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append(" 编辑");
				var delBtn = $("<button></button>").addClass(
						"btn btn-warning btn-sm").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						" 删除");
				var btnTd = $("<td></td>").append(editBtn).append(delBtn);
				$("<tr></tr>").append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#emps_table tbody");
			});
		}
		//解析分页信息
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页，共"
							+ result.extend.pageInfo.pages + "页，共"
							+ result.extend.pageInfo.total + "条记录");
			totalRecord = result.extend.pageInfo.total;
		}
		//解析分页条数据
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));
			if (!result.extend.pageInfo.hasPreviousPage) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//绑定点击事件
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));
			if (!result.extend.pageInfo.hasNextPage) {
				nextPageLi.addClass("diasbled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numPageLi = $("<li></li>")
						.append($("<a></a>").append(item));
				if (result.extend.pageInfo.pageNum == item) {
					numPageLi.addClass("active");
				}
				numPageLi.click(function() {
					to_page(item);
				});
				ul.append(numPageLi);

			});
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		//ajax请求，绑定点击事件
		$("#emp_add_modal_btn").click(function() {
			//发送ajax请求，查出部门名称
			getDepts();
			
			//弹出模态框
			$("#empAddModal").modal({
				backdrop : "static"
			});
		});
		function getDepts(){
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"get",
				success:function(result){
					//console.log(result);
					$.each(result.extend.depts,function(){
						var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo("#dept_add_select");
					});
				}
			});
		};
		
		$("#emp_save_btn").click(function(){
			//提交表单数据保存
			$.ajax({
				url : "${APP_PATH}/emp",
				type : "POST",
				data : $("#empAddModal form").serialize(),
				success : function(result){
					alert(result.msg);
					//保存成功，关闭模态框，跳转到最后一页，显示插入的数据
					$("#empAddModal").modal('hide');
					to_page(totalRecord);
				}
			});
		});
	</script>
</body>
<!-- 员工新增弹窗 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">员工添加</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
						<div class="col-sm-10">
							<input type="text" name="empName" class="form-control" id="empName_add_input"
								placeholder="empName">
						</div>
					</div>
					<div class="form-group">
						<label for="email_add_input" class="col-sm-2 control-label">email</label>
						<div class="col-sm-10">
							<input type="text" name="email" class="form-control" id="email_add_input"
								placeholder="email@fengzi.com">
						</div>
					</div>
					<div class="form-group">
						<label for="gender_add_input" class="col-sm-2 control-label">gender</label>
						<div class="col-sm-10">
							<label class="radio-inline">
 							<input type="radio" name="gender" id="gender1_add_input" checked="checked" value="M">男
							</label>
							<label class="radio-inline">
  							<input type="radio" name="gender" id="gender2_add_input" value="F">女
							</label>
						</div>
					</div>
					<div class="form-group">
						<label for="deptName_add_input" class="col-sm-2 control-label">deptName</label>
						<div class="col-sm-4">
							  <select class="form-control" name="dId" id="dept_add_select">
							  
							  </select>
						</div>
					</div>	
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
			</div>
		</div>
	</div>
</div>
</html>
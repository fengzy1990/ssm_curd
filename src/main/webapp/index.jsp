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
				<button type="button" class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
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
		var totalRecord,currentNumPage;//用来调用增加完数据后，用记录数作为页码，这样pageinfo总会显示最后一页
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
				var checkBoxId =$("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(
						item.gender == "M" ? "男" : "女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-info btn-sm update_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append(" 编辑");
				//为编辑按钮添加自定义属性，可以在更新数据时，知道是哪条数据,不能使用empIdTd，这是一个Object对象
				editBtn.attr("update-id",item.empId);
				var delBtn = $("<button></button>").addClass(
						"btn btn-warning btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						" 删除");
				//删除按钮添加自定义属性，可以在删除数据时，知道是哪条数据
				delBtn.attr("del-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(delBtn);
				$("<tr></tr>").append(checkBoxId).append(empIdTd).append(empNameTd).append(
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
			currentNumPage = result.extend.pageInfo.pageNum;
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
		$("#emp_add_modal_btn").click(
				function() {
					//每次弹出模态框，清楚弹出模态框中的数据
					$("#empAddModal form")[0].reset();
					$("#empAddModal form").find("*").removeClass(
							"has-success has-error");
					$("#empAddModal form").find(".help-block").text("");
					//$("#empName_add_input").next("span").text(" ");
					//$("#email_add_input").next("span").text(" ");
					//发送ajax请求，查出部门名称,以下两种方式都可以
					//getDepts("#dept_add_select");
					getDepts("#empAddModal select");
					//弹出模态框
					$("#empAddModal").modal({
						backdrop : "static"
					});
				});

		function getDepts(element) {
			$(element).empty();
			$.ajax({
				url : "${APP_PATH}/depts",
				type : "get",
				success : function(result) {
					//console.log(result);
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(element);
					});
				}
			});
		}
		//校验函数
		function validate_add_form() {
			//首先要拿到数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{4,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)) {
				//alert("用户名必须是2-5位中文，或4-16位英文-_组合！");
				//优化校验回显状态，美化。
				show_validate_msg("#empName_add_input", "error",
						"用户名必须是2-5位中文，或4-16位英文-_组合！");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "用户名符合规则！");
			}
			var email = $("#email_add_input").val();
			var regEmail = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
			if (!regEmail.test(email)) {
				//alert("邮箱格式不符合规则！");
				//取消使用弹窗的方式进行提醒，美化校验结果。
				show_validate_msg("#email_add_input", "error", "邮箱格式不符合规则！");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "邮箱格式符合规则！");
			}
			return true;
		}
		//校验信息显示函数
		function show_validate_msg(element, status, msg) {
			//清除元素的校验状态
			$(element).removeClass("has-success has-error");
			$(element).next("span").text(" ");
			if ("success" == status) {
				$(element).parent().addClass("has-success");
				$(element).next("span").text(msg);
			} else if ("error" == status) {
				$(element).parent().addClass("has-error");
				$(element).next("span").text(msg);
			}
		}
		//为用户名添加事件，内容改变后执行对应函数。
		setTimeout(function() {
			$("#empName_add_input").change(
					function() {
						//发送ajax请求，校验用户名是否可用
						var empName = this.value;
						$
								.ajax({
									url : "${APP_PATH}/checkuser",
									data : "empName=" + empName,
									type : "post",
									success : function(result) {
										if (result.code == 100) {
											show_validate_msg(
													"#empName_add_input",
													"success", "用户名可用!");
											$("#emp_save_btn").attr("ajax-va",
													"success");
										} else {
											show_validate_msg(
													"#empName_add_input",
													"error",
													result.extend.val_msg);
											$("#emp_save_btn").attr("ajax-va",
													"error");
										}
									}
								});
					});
		});
		//为保存按钮添加事件
		setTimeout(function() {
			$("#emp_save_btn").click(function() {
				//提交表单数据保存
				//先提交给服务器进行数据校验，这边是前端校验，即使绕过前段校验，还有后端JSR303校验
				 if (!validate_add_form()) {
					return false;
				} 
				//在执行ajax请求，首先要拿到ajax请求的校验值
				if ($(this).attr("ajax-va") == "error") {
					return false;
				}
				$.ajax({
					url : "${APP_PATH}/emp",
					type : "POST",
					data : $("#empAddModal form").serialize(),
					success : function(result) {
						if (result.code == 100) {
							//保存成功，关闭模态框，跳转到最后一页，显示插入的数据
							$("#empAddModal").modal('hide');
							to_page(totalRecord);
						} else {
							//后台显示信息
							//console.log(result);
							//那个字段错误信息就显示那个字段的，这里是后端校验，从后端拿到的校验信息
							/* EmployeeController中定义了email,empName的校验，如果出现错误errorFields中就会
							出现email，如果没有错误就是出现undefined  */
							if (undefined != result.extend.errorFields.email) {
								show_validate_msg(
										"#email_add_input",
										"error", result.extend.errorFields.email);
							}
							if (undefined != result.extend.errorFields.empName) {
								show_validate_msg(
										"#empName_add_input",
										"error", result.extend.errorFields.empName);
							}
						}
					}
				});
			});
		});
		//为编辑按钮绑定事件，但是页面首先加载完成后，发送ajax请求得到数据后才显示出编辑删除按钮，所以直接.click（）方法绑定不上。
		//JQuery有live方法，新的版本没有live方法，用on方法代替。
			$(document).on("click",".update_btn",function(){
				//alert("edit");
				//首先查出员工信息，然后查出部门信息，以下两种方式都可以
				//每次弹出更新模态框时，清除之前验证提示和验证结果状态
				$("#empUpdateModal form").find("*").removeClass(
						"has-success has-error");
				$("#empUpdateModal form").find(".help-block").text("");
				getDepts("#empUpdateModal select");
				//getDepts("#dept_update_select");
				getEmp($(this).attr("update-id"));
				
				//把员工id即，编辑按钮上的id传递给更新按钮
				$("#emp_update_btn").attr("update-id",$(this).attr("update-id"));
				//弹出模态框
				$("#empUpdateModal").modal({
					backdrop : "static"
				});
			});
			//删除按钮绑定
			$(document).on("click",".delete_btn",function(){
				//弹出确认删除
				//alert($(this).parents("tr").find("td:eq(1)").text());
				var empName=$(this).parents("tr").find("td:eq(2)").text();
				var empId =$(this).attr("del-id");
				if(confirm("确认删除【"+empName+"】吗？")){
					//去人删除ajax请求。
					$.ajax({
						url:"${APP_PATH}/emp/"+empId,
						type:"DELETE",
						success:function(result){
							//alert(result.msg);
							to_page(currentNumPage);
						}
					});
					
				}
			});
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			})
		}
		//点击更新，更新员工信息
		setTimeout(function(){
			$("#emp_update_btn").click(function(){
				//验证邮箱 
				var email = $("#email_update_input").val();
				var regEmail = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
				if (!regEmail.test(email)) {
					//alert("邮箱格式不符合规则！");
					show_validate_msg("#email_update_input", "error", "邮箱格式不符合规则！");
					return false;
				} else {
					show_validate_msg("#email_update_input", "success", "邮箱格式符合规则！");
				}
				//发送ajax请求，保存更新的信息
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("update-id"),
					type:"PUT",
					data:$("#empUpdateModal form").serialize(),
					success:function(result){
						//alert(result.msg);
						if(result.code == 100){
						$("#empUpdateModal").modal("hide");
						to_page(currentNumPage);
						}else{
						alert("更新失败！");							
						}
					}
					
				});
			});	
		});
		//点击更新员工信息，更新中的模态框按钮的更新事件
		setTimeout(function(){
			$("#emp_update_btn").click(function(){
				
				//发送ajax请求，保存更新的信息
				$.ajax({
					url:"${APP_PATH}/emp/"+$(this).attr("update-id"),
					type:"PUT",
					data:$("#empUpdateModal form").serialize(),
					success:function(result){
						//alert(result.msg);
						if(result.code == 100){
						$("#empUpdateModal").modal("hide");
						to_page(currentNumPage);
						}else{
						alert("更新失败！");							
						}
					}
					
				});
			});	
		});
		//完成全选或全不选功能
		$("#check_all").click(function(){
			//attr获取checkbox的原生属性checked是undefined，原生属性用prop方法获得。attr获取自定义属性
			//alert($(this).prop("checked"));
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		//为每个check_item绑定点击事件，当一页的都选中后，check_all也设置为true.
		//因为check_item也是后来创建的，所以也用on方法绑定。
		$(document).on("click",".check_item",function(){
			//判断当前选择个数是否全部选中
			var flag = $(".check_item:checked").length==$(".check_item").length
				$("#check_all").prop("checked",flag);
		});
		//批量删除
		$("#emp_delete_all_btn").click(function(){
			var	empNames="";//用于显示
			var empDelIds="";//用于标记删除
			//遍历状态为checked的check_item
			$.each($(".check_item:checked"),function(){
				//找到check_item的父元素tr，然后找到第三个td
				empNames +=$(this).parents("tr").find("td:eq(2)").text()+"，";
				empDelIds +=$(this).parents("tr").find("td:eq(1)").text()+"-"
			});
			//去除字符串最后一位逗号。
			empNames=empNames.substring(0,empNames.length-1);
			empDelIds=empDelIds.substring(0,empDelIds.length-1);
			if(confirm("确认这些【"+empNames+"】都删除吗？")){
				$.ajax({
					url:"${APP_PATH}/emp/"+empDelIds,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page(currentNumPage);
					}
				});
			}
		})
	</script>
</body>
<!-- 员工新增模态窗 -->
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
							<input type="text" name="empName" class="form-control"
								id="empName_add_input" placeholder="empName"> <span
								class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="email_add_input" class="col-sm-2 control-label">email</label>
						<div class="col-sm-10">
							<input type="text" name="email" class="form-control"
								id="email_add_input" placeholder="email@fengzi.com"> <span
								class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="gender_add_input" class="col-sm-2 control-label">gender</label>
						<div class="col-sm-10">
							<label class="radio-inline"> <input type="radio"
								name="gender" id="gender1_add_input" checked="checked" value="M">男
							</label> <label class="radio-inline"> <input type="radio"
								name="gender" id="gender2_add_input" value="F">女
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
				<button type="button" class="btn btn-default" data-dismiss="modal"
					id="emp_close.btn">关闭</button>
				<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
			</div>
		</div>
	</div>
</div>

<!-- 员工修改模态窗 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title">员工修改</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal">
					<div class="form-group">
						<label for="empName_update_input" class="col-sm-2 control-label">empName</label>
						<div class="col-sm-10">
								 <p name="empName" class="form-control-static" id="empName_update_static"></p>
								 <span class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="email_update_input" class="col-sm-2 control-label">email</label>
						<div class="col-sm-10">
							<input type="text" name="email" class="form-control"
								id="email_update_input" placeholder="email@fengzi.com"> <span
								class="help-block"></span>
						</div>
					</div>
					<div class="form-group">
						<label for="gender_update_input" class="col-sm-2 control-label">gender</label>
						<div class="col-sm-10">
							<label class="radio-inline"> <input type="radio"
								name="gender" id="gender1_update_input" checked="checked" value="M">男
							</label> <label class="radio-inline"> <input type="radio"
								name="gender" id="gender2_update_input" value="F">女
							</label>
						</div>
					</div>
					<div class="form-group">
						<label for="deptName_update_input" class="col-sm-2 control-label">deptName</label>
						<div class="col-sm-4">
							<select class="form-control" name="dId" id="dept_update_select">

							</select>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal"
					id="emp_close.btn">关闭</button>
				<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
			</div>
		</div>
	</div>
</div>
</html>
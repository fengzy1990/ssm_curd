package com.fengzi.curd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fengzi.curd.bean.Department;
import com.fengzi.curd.bean.Msg;
import com.fengzi.curd.service.DepartmentService;

@Controller
public class DepartmentController {
	@Autowired
	private DepartmentService departmentService;
	
	//返回所有部门信息
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts(){
		List<Department> list = departmentService.getDepts();
		return Msg.success().add("depts", list);
	}
}

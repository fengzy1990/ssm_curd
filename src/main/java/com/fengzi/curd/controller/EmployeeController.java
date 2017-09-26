package com.fengzi.curd.controller;
/**
 * 
 * @author Administrator
 * 处理员工的CURD请求
 */

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fengzi.curd.bean.Employee;
import com.fengzi.curd.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {
	// 自动装配service层
	@Autowired
	EmployeeService employeeService;

	/**
	 * 查询员工数据(分页查询)
	 * 
	 * @return
	 */
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 引入PageHelper分页组件,在查询之前只需要调用如下。
		PageHelper.startPage(pn, 5);
		// 紧跟在后面的就是分页查询
		List<Employee> emps = employeeService.getALL();
		// 使用pageINFO包装查询结果，只需要将PAGEinfo交给页面就可以
		// 包装了详细的分页信息，包括查询出的结果。后面参数5表示连续显示5页
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		
		return "List";
	}
}

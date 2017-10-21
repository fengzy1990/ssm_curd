package com.fengzi.curd.controller;
/**
 * 
 * @author Administrator
 * 处理员工的CURD请求
 */

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fengzi.curd.bean.Employee;
import com.fengzi.curd.bean.Msg;
import com.fengzi.curd.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {
	// 自动装配service层
	@Autowired
	EmployeeService employeeService;

	/**
	 * 以json形式返回数据，ResponseBody实现转化json字符串 实现转化要导入jackson包
	 * 
	 * @param pn
	 * @return
	 */
	@RequestMapping("/empsjson")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 引入PageHelper分页组件,在查询之前只需要调用如下。
		PageHelper.startPage(pn, 5);
		// 紧跟在后面的就是分页查询
		List<Employee> emps = employeeService.getALL();
		// 使用pageINFO包装查询结果，只需要将PAGEinfo交给页面就可以
		// 包装了详细的分页信息，包括查询出的结果。后面参数5表示连续显示5页
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}

	/**
	 * 查询所有员工数据(分页查询)
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
		// model为请求域
		model.addAttribute("pageInfo", page);
		System.out.println("program  have started here!!");
		return "list";
	}

	// 检查用户名是否存在函数
	@ResponseBody
	@RequestMapping("/checkuser")
	public Msg checkUser(@RequestParam("empName") String empName) {
		// 先判断用户是否合法
		String regName = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if (!empName.matches(regName)) {
			return Msg.fail().add("val_msg", "用户名必须是2-5位中文，或4-16位英文-_组合！");
		}
		// 数据库重复性校验
		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success().add("val_msg", "用户名可用！");
		} else {
			return Msg.fail().add("val_msg", "用户名不可用！");
		}
	}

	/**
	 * 员工保存函数 支持JSR303校验，需要导入Hibernate-Validator包
	 * 
	 * @param employee
	 * @return
	 * @Valid 表示需要校验，与Employee中的声明的Pattern对应，是JSR303
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<>();
			// 校验失败，应该返回失败信息，显示在模态框中
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名：" + fieldError.getField());
				System.out.println("错误的信息：" + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}

	/**
	 * 查询某个员工信息
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id") Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	/**
	 * 更新员工信息
	 * ajax直接发送PUT请求，封装的Employee数据，除了empId不为空，其余都为null
	 * form请求体中有数据。
	 * 
	 * 原因：tomcat会将请求体中数据封装成一个MAP,requst.getParameter()就会从map中取值。
	 * springMVC在封装pojo对象，会把每个属性的值用request.geP...封装
	 * 也就是ajax发送put请求出现问题。put请求体中的数据用request.getP..拿不到数据。
	 * tomcat发现是put请求，不会封装请求体中的数据为map。只有post请求才会封装成map。
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
		//将要更新的员工数据
		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
}

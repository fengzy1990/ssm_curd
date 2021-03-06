package com.fengzi.curd.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.validator.PublicClassValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.fengzi.curd.bean.Employee;
import com.github.pagehelper.PageInfo;

/**
 * 使用spring测试模块提供的测试请求功能，测试curd请求正确性
 * spring4的测试环境需要servlet3的支持，替换maven引入的servlet包
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml",
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml" })
public class MvcTest {
	// 传入springmvc的ioc
	@Autowired
	WebApplicationContext context;
	// 虚拟MVC请求，获取到处理结果
	MockMvc mockMvc;

	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testPage() throws Exception {
		// 模拟请求，得到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();

		// 请求成功后，请求域会有PageInfo，可以取出进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页面：" + pi.getPageNum());
		System.out.println("总页码：" + pi.getPages());
		System.out.println("总记录数：" + pi.getTotal());
		System.out.println("在页面需要连续显示的页码");
		int[] nums = pi.getNavigatepageNums();
		for (int i : nums) {
			System.out.println(" " + i);
		}
		// 获取员工数据
		List<Employee> list = pi.getList();
		for (Employee employee : list) {
			System.out.println("ID:" + employee.getEmpId() + "===Name:" + employee.getEmpName());
			System.out.println( "deptname:" + employee.getDepartment().getDeptName());
		}
	}
}

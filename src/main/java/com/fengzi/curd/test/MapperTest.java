package com.fengzi.curd.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fengzi.curd.bean.Department;
import com.fengzi.curd.bean.Employee;
import com.fengzi.curd.dao.DepartmentMapper;
import com.fengzi.curd.dao.EmployeeMapper;

/**
 * 测试dao层
 * 
 * @author Administrator 推荐spring的项目可以使用spring的单元测试，可以自动注入需要的组件
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCURD() {

		System.out.println(departmentMapper);

		// 1.插入部门， 测试通过
		//departmentMapper.insertSelective(new Department(null, "开发部"));
		//departmentMapper.insertSelective(new Department(null, "测试部"));

		// 2、生成员工数据，测试员工插入
		// employeeMapper.insertSelective(new Employee(null, "zhangsan", "M",
		// "test@fengzi.com", 1));
		// 3.批量插入多个员工，使用可以执行批量操作的sqlSession
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@fengzi.com", 1));
		}
		System.out.println("批量完成");
	}
}

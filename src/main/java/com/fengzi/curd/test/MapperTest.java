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
import com.fengzi.curd.bean.EmployeeExample;
import com.fengzi.curd.bean.EmployeeExample.Criteria;
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
		/*EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 1000; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@fengzi.com", 1));
		}
		System.out.println("批量完成");*/
		//4.测试部门删除
		//departmentMapper.deleteByPrimaryKey(4);
		//5.测试 部门的更新
		//departmentMapper.updateByPrimaryKeySelective(new Department(3, "安全部"));
		//6.测试员工删除，按照主键删除
		//employeeMapper.deleteByPrimaryKey(1000);
		//删除员工，按照样例删除，匹配任何职，如下。
		/*EmployeeExample employeeExample=new EmployeeExample();
		Criteria criteria=employeeExample.createCriteria();
		criteria.andEmpNameEqualTo("zhangsan");
		employeeMapper.deleteByExample(employeeExample);*/
		//7.测试员工更新
		/*Employee employee=new Employee();
		employee.setEmpId(2);
		employee.setEmpName("zhangsan");
		employeeMapper.updateByPrimaryKeySelective(employee);
		employeeMapper.updateByPrimaryKey(record);*/
		//注意上面，updateByPrimaryKey是全量更新，所有字段必须齐全；updateByPrimaryKeySelective可以更新某一个字段。
	}
}

package com.fengzi.curd.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.fengzi.curd.dao.DepartmentMapper;

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

	@Test
	public void testCURD() {

		System.out.println(departmentMapper);
	}
}

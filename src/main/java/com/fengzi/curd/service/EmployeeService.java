package com.fengzi.curd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengzi.curd.bean.Employee;
import com.fengzi.curd.bean.EmployeeExample;
import com.fengzi.curd.bean.EmployeeExample.Criteria;
import com.fengzi.curd.dao.EmployeeMapper;

//service是一个业务逻辑组件
@Service
public class EmployeeService {
	// service层要反馈数据，肯定要调用dao层
	@Autowired
	EmployeeMapper employeeMapper;

	// 查询所有员工，这不是一个分页查询
	public List<Employee> getALL() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	// 保存员工信息
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	// 判断用户名是否存在函数
	//return true 表示用户名可用
	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		if (count == 0) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 按照员工id查询员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer id) {
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}
	/**
	 * 更新员工信息方法
	 * @param employee
	 */
	public void updateEmp(Employee employee) {
		// TODO Auto-generated method stub
		//按照主键有选择更新
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

}

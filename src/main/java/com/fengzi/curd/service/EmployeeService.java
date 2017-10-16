package com.fengzi.curd.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fengzi.curd.bean.Employee;
import com.fengzi.curd.dao.EmployeeMapper;

//service是一个业务逻辑组件
@Service
public class EmployeeService {
	// service层要反馈数据，肯定要调用dao层
	@Autowired
	EmployeeMapper employeeMapper;
	//查询所有员工，这不是一个分页查询
	public List<Employee> getALL() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

}

package com.fengzi.curd.dao;

import com.fengzi.curd.bean.Employee;
import com.fengzi.curd.bean.EmployeeExample;
import com.fengzi.curd.bean.EmployeeKey;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface EmployeeMapper {
	long countByExample(EmployeeExample example);

	int deleteByExample(EmployeeExample example);

	int deleteByPrimaryKey(EmployeeKey key);

	int insert(Employee record);

	int insertSelective(Employee record);

	List<Employee> selectByExample(EmployeeExample example);

	Employee selectByPrimaryKey(EmployeeKey key);

	List<Employee> selectByExampleWithDept(EmployeeExample example);

	Employee selectByPrimaryKeyWithDept(EmployeeKey key);

	int updateByExampleSelective(@Param("record") Employee record, @Param("example") EmployeeExample example);

	int updateByExample(@Param("record") Employee record, @Param("example") EmployeeExample example);

	int updateByPrimaryKeySelective(Employee record);

	int updateByPrimaryKey(Employee record);
}
package com.fengzi.curd.bean;

import javax.validation.constraints.Pattern;


public class Employee {
	private Integer empId;
	//JSR303校验
	@Pattern(regexp="(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
			message="用户名必须是2-5位中文，或4-16位英文-_组合！")
	private String empName;

	private String gender;
	
	//@Email
	@Pattern(regexp="^([A-Za-z0-9_\\-\\.])+\\@([A-Za-z0-9_\\-\\.])+\\.([A-Za-z]{2,4})$",
			message="邮箱格式不符合规则！")
	private String email;

	private Integer dId;
	// 在员工bean中添加部门信息
	private Department department;

	public Employee() {
		super();
	}

	public Employee(Integer empId, String empName, String gender, String email, Integer dId, Department department) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.gender = gender;
		this.email = email;
		this.dId = dId;
		this.department = department;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Integer getEmpId() {
		return empId;
	}

	public void setEmpId(Integer empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName == null ? null : empName.trim();
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender == null ? null : gender.trim();
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email == null ? null : email.trim();
	}

	public Integer getdId() {
		return dId;
	}

	public void setdId(Integer dId) {
		this.dId = dId;
	}
}
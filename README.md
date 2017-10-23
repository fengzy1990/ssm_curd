# SSM_CURD
2017年8月25日22:32:26 创建ssm_curd项目

1、使用了较为流行的SSM框架。使用了GITHUB控制开发版本及开发记录。

2、该项目使用了以下技术： spring springmvc mybatis bootstrap maven jquery ajax 等技术

3、curd寓意为 create：创建 update：更新 retrieve：检索 delete：删除

FENGYUE版权所有。

第一步：首先创建一个maven，web工程。eclipse直接新建maven project，可以使用模板创建。同样可以使用简单方法，然后选择war。 创建完成之后，项目右键属性在project facets上首先炫册去掉 dynamic web，apply。之后再选中dynamic web.选中之后 会再页面下出现配置 futher。。。 然后配置生成web.xml;注意是在src/main/webapp下，因为网页部署在这。 把web.xml修改结束标记为</ web-app > 
第二步：配置maven，即设置maven的全局的局部settings。当然也可以设置到pom.xml文件中。
在<profiles>内添加maven的jdk和编译器等一些基本的配置。
 <profile>
      <id>jdk-1.8</id>
      <activation>
      	<activeByDefault>true</activeByDefault>
        <jdk>1.8</jdk>
      </activation>
			<properties>
				<maven.compiler.source>1.8</maven.compiler.source>
				<maven.compiler.target>1.8</maven.compiler.target>
				<maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
			</properties>
     
  </profile>
  
 第三步：引入spring springmvc mybatis mybatis-spring 数据库连接池(c3p0)  sql驱动 等jar包。
 	 jstl,servlet-api(不引入jsp页面会报错),junit
 	 
第四步：引入前端bootstrap,jquery;具体的bootstrap可以参考官网资料
在jsp页面中，引入bootstrap样式。
<link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
引入bootstrap的js文件。
<script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
同时引入jQuery
 <script type="text/javascript" src="static/js/jquery-1.12.4-min.js"></script>
 第五步：配置web.xml spring springmvc mybatis等配置文件。
 ctrl+shift+t 打开Open Type查找类文件。
 第六步：配置springmvc和spring
 springmvc扫描控制类，spring控制业务
 第七步：mybatis逆向生成
 第八步：修改mybatis的mapper文件
 第九步：搭建spring的测试环境。
2017年9月5日23:19:49
修改之前bug，测试不通过问题。
mappertest已经能够成功插入数据库中数据.
在部门和职工类中添加了构造方法。
第十步：实现查询
1、首先访问INDEX.JSP页面；2、Index.jsp页面发出查询员工请求。
3、EmployeeController来接受请求，查出员工数据；4、来到list.jsp页面展示。
引入了PageHelper包，
<!-- 引入pagehelper插件 -->
<dependency>
	<groupId>com.github.pagehelper</groupId>
	<artifactId>pagehelper</artifactId>
	<version>5.0.0</version>
</dependency>
在mybatis-config.xml中配置数据
<plugins>
	<!-- com.github.pagehelper为PageHelper类所在包名 -->
	<plugin interceptor="com.github.pagehelper.PageInterceptor">
	</plugin>
</plugins>
第十一步：index.jsp跳转到list.jsp问题解决。
解决问题：运行tomcat服务器，一定要在新建的server内，双击，server locations中选user tomcat installtion。
并且设置部署位置由默认的wstwebapps变为webapps
第二：当时创建maven项目的时候，需要转为web项目，并且设置content根目录。
这边一定要设置准确，因为我们把web页面放在了/src/main/webapp内，并且web.xml文件也放置在内，
项目→proPerties→project facets，首先勾掉Dynamic web module确定，然后在选中，选中后会出现一行设置属性的文字（futher configuration availe...），点击进入,content directory中输入/src/main/webapp；这样web.xml就生成在该目录，tomcat服务器也能访问到了。
第十二步：
已经使用了index.jsp页面发送请求返回查询数据，接下来该改造查询，使用ajax方式
1、index.jsp页面直接发送ajax请求进行员工分页数据的查询
2、服务器将查询出的数据，以json的格式返回，当然也可以返回给浏览器，也可以手机端。
3、浏览器接收到json字符串，使用js进行解析，使用js通过dom增删改改变有河面。
4、返回json可以实现客户端的无关性。
2017年10月11日21:11:05 修正bug，修正查询出的数据不带员工部门名称。EmployeeService类中调用的方法为不带部门的方法，修正为带部门方法，即能正确查询。
第十三步：
2017年10月15日22:25:46已经完成了ajax数据查询以json数据返回
接下完成新增逻辑
点击新增，弹出对话框，接下来完成部门列表的查询，显示在对话框中，以供用户选择，然后用户输入数据保存。
第十四步：
2017年10月16日22:20:53
完成新增功能弹窗。规定REST的URI逻辑
/emp/{id} GET,表示查询员工
/emp      POST,保存员工
/emp/{id} PUT,修改员工
/emp/{id} DELETE,删除员工
注意：在弹出的职工新增功能模态框中，给保存按钮添加事件时，直接使用$("#").click...并不能触发点击事件。
需要在外层添加延迟加载,如下：
setTimeout(function(){
$("#btn").click(function(){
....
})
})
第十五步：
完成添加员工数据的校验：
要实现jQuery前端校验，ajax用户名重复校验，后端校验（spring 提供的JSR303）。
<!-- JSR303数据校验，支持Tomcat7及以上服务器；以下的服务器，需要将服务器的lib包替换新的el表达式 -->
2017年10月21日15:00:59
完成了添加员工的信息校验
1、完善前端校验，用户名重复校验
2、添加了后端的JSR303校验。增加了数据安全性。
3、导入了Hibernate-validate包，用于JSR303校验。
JSR303校验直接在Employee bean中进行写入。同时在controller中控制逻辑返回。
第十六步：实现修改逻辑
第十七步：
2017年10月23日20:52:20
完成删除逻辑。
第十八步：完成批量删除。
$('#XXX') 对应的id元素
$('.XXX') 对应的class元素
2017年10月23日22:26:18 已经完成了项目的批量删除，至此完成了项目的所有功能。


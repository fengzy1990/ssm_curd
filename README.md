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
设置

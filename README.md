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

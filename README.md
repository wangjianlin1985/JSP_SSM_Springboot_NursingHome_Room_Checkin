# JSP_SSM_Springboot_NursingHome_Room_Checkin
JSP基于SSM养老院房间入住管理响应式网站可升级SpringBoot毕业源码案例设计
## 程序开发环境：myEclipse/Eclipse/Idea都可以 + mysql数据库
## 前台技术框架： Bootstrap  后台架构框架: SSM
该系统分为三个身份，分别是用户，医护人员，管理员
### 用户，当用户没有登录的时候，只能查看房间信息，不能申请入住，需要申请入住必须要注册成为会员才能进行申请
(1)登陆注册模块：未注册用户进行登陆注册，才能进行申请入住
(2)申请入住模块:该模块可以进行申请，并且入住几个月，申请成功后生成订单信息
(3)查看我的账单：该模块主要用来用户申请成功后可以查看我的账单信息。
(4)查看老人信息模块：该模块可以查看所有该养老院的老人信息。
### 医护人员模块
（1）费用管理模块：该模块具有管理费用的功能，有入住缴费登记，退住结算管理，账单费用明细状况。查询及登记以上所有功能。
(2)老人看护管理模块：该模块主要用于日常的护士监测老人身体健康状况进行的一个管理记录，包括一些医嘱以及需要的特殊服务治疗等。
(3)接待管理模块：该模块主要用来管理日常家属来到的一些登记记录，用于维护养老院的安全。
### 管理员模块
（1）系统管理模块：该模块主要用来管理所有的角色用户信息，包括管理用户以及管理医护人员的账户信息。
（2）房间管理模块：房间管理模块包括，已住房间的管理，以及空闲房间的管理，以及总的房间管理
（3）人员信息管理模块：该模块的设计主要用来养老院内部的人员信息，包括他们的工资支出信息等。
（4）价格管理模块：该模块的设计主要是调整价格，每月的费用价格，根据实际的价格进行实时的调整。
（5）入住申请管理模块：前台用户进行申请，管理员进行审核，自动计算费用，生成订单给用户。
（6）统计收入模块：该模块主要给管理观看每月的收入变化趋势。
## 实体ER属性：
用户: 用户名,登录密码,姓名,性别,出生日期,用户照片,联系电话,邮箱,家庭地址,注册时间

老人: 老人编号,姓名,性别,年龄,老人照片,老人介绍,登记用户,登记时间

房间类型: 房间类型id,房间类型名称

房间: 房间编号,房间类型,房间名称,房间主图,房间价格,房间详情,房间状态

订单: 订单编号,入住房间,入住老人,入住日期,入住时间,订单总金额,订单状态,订单费用明细,订单时间

老人看护: 记录id,信息类别,信息标题,信息内容,发布时间

接待: 接待记录id,接待类别,接待主题,接待内容,接待日期

部门: 部门编号,部门名称,成立日期,负责人

员工: 用户名,登录密码,所在部门,姓名,性别,出生日期,员工照片,联系电话,家庭地址

工资: 工资id,员工,工资年份,工资月份,工资金额,发放日期,工资备注

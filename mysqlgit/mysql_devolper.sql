-- 数据库
-- oracle  mysql

-- mongodb   memcached   redis

-------------------------------------------------------------------------

--  
-- mysql怎么来创建数据库
CREATE  DATABASE  thzmdb2;
 
-- 存放数据的最基本的形式  table 
-- 设计数据库表的 三范式  ？？？？不知道，后面讲。

--  创建表  t_   v_   p_  f_
CREATE  TABLE  t_students
(
     sid  INT  PRIMARY  KEY   AUTO_INCREMENT, -- PRIMARY  KEY 主键约束
     sname  VARCHAR(20)  NOT NULL,  -- 非空约束
     spwd    CHAR(6)  NOT  NULL,
     birthday   TIMESTAMP   DEFAULT  NOW(),  -- 默认约束  --出生年月
     --  age  int    -- 年龄  体会一下出生年月和年龄哪个更合理
     sphone  CHAR(11)  NOT NULL,
     sface    VARCHAR(100)  ,  -- 学生的脸
     saddress  VARCHAR(20),
     ssex   CHAR(4)
    
)

-- 查询表的
SELECT   *    FROM  t_students


-- 插入数据
INSERT  INTO  t_students(sname,spwd,sphone,sface,saddress,ssex)
VALUES('彭勃','000000','13913321090','a1.png','九江','男');
INSERT  INTO  t_students(sname,spwd,sphone,sface,saddress,ssex)
VALUES('袁信莉','000000','13913321089','a2.png','自贡','女');
INSERT  INTO  t_students(sname,spwd,sphone,sface,saddress,ssex)
VALUES('王启明','000000','13913321091','a3.png','九江','男');
INSERT  INTO  t_students(sname,spwd,sphone,sface,saddress,ssex)
VALUES('张鹤','000000','13913321092','a4.png','南京','男');
INSERT  INTO  t_students(sname,spwd,sphone,sface,saddress,ssex)
VALUES('李鑫','000000','13913321093','a5.png','天水','男');

-- 创建表

CREATE  TABLE   t_emp
(
     eid  INT  PRIMARY KEY   AUTO_INCREMENT, -- 员工编号 
     ename  VARCHAR(20)  NOT NULL, --  员工姓名
     epwd   CHAR(6)  NOT NULL,-- 员工密码
     ebirthday  TIMESTAMP , --  员工出生年月
     eaddress   VARCHAR(50),-- 地址
     esalary   FLOAT  , -- 工资
     esex  CHAR(4), --  性别
     ephone  CHAR(11)  -- 手机号码
    
)


-- 查询数据
SELECT  *  FROM  t_emp

-- 插入数据   mysql客户端没有commit,提交数据是自动的
INSERT  INTO  t_emp(ename,epwd,ebirthday,eaddress,esalary,esex,ephone)
VALUES('李欣','000000','1976-12-30','南京',8900,'男','13913321086');


INSERT  INTO  t_emp(ename,epwd,ebirthday,eaddress,esalary,esex,ephone,money)
VALUES('陈赵梅','000000','1996-12-30','南京',8900,'女','13913321088',200);


INSERT  INTO  t_emp(ename,epwd,ebirthday,eaddress,esalary,esex,ephone,money)
VALUES('彭勃','000000','1976-12-30','南京',9900,'男','13913321085',NULL);

INSERT  INTO  t_emp(ename,epwd,ebirthday,eaddress,esalary,esex,ephone,money)
VALUES('孔虎强','000000','1976-12-30','南京',7900,'男','13913321082',NULL);

-- 更新数据
UPDATE  t_emp  SET  epwd='888888'
-- where 关键字
UPDATE t_emp  SET  epwd='999999'  WHERE eid='4'

-- 删除数据
DELETE  FROM  t_emp

DELETE  FROM  t_emp  WHERE ename='李欣'

-- 查询技术
 
   -- 聚合函数  统计函数
   
   -- count(),avg(),sum(),max(),min()
   
 SELECT  * FROM  t_emp
   
 SELECT  COUNT(*)  FROM  t_emp
   
 SELECT  SUM(esalary)  FROM  t_emp
   
 SELECT  AVG(esalary) FROM  t_emp
   
      
 SELECT  MAX(esalary) FROM  t_emp
   
 SELECT  MIN(esalary) FROM  t_emp
 
 
 -- mysql内置函数 
 -- 1. ifnull(字段，默认值) ,取值为空，给与默认值
 -- 2.FORMAT(字段，位数)
 -- 3.SUBSTR()
 -- 4. now()
 
 
 -- 总结DDL语言，create ，alter ，只能正确执行一次
 
 -- 总结DML语言，select，insert into,update,delete 可以反复执行
 
 
 -- 登录  username  userpwd
 
 -- and 和 两个条件都必须满足
 SELECT  COUNT(*)   FROM  t_emp  WHERE ename='贾春雷'  AND epwd='888898'
 
 
 
 --  sql查询技术 单表
 
 --  where  条件语句
 SELECT   * FROM  t_emp
 
 -- 修改表
 ALTER   TABLE   t_emp    ADD  money  FLOAT;
 
 -- 贾春雷  刘燕凤收入
 SELECT    esalary+IFNULL(money,0)  FROM   t_emp WHERE ename='贾春雷';
 
 SELECT    esalary+IFNULL(money,0)  FROM   t_emp WHERE ename='刘燕凤';
 
 
 -- 查询泰州员工的人的姓名
 SELECT  ename  FROM  t_emp  WHERE eaddress='泰州'
 
 -- 查询泰州员工的数量 
 SELECT  COUNT(*)  FROM  t_emp  WHERE eaddress='泰州'
 
 -- 查询工资大于1000小于3000的员工的姓名和性别
 SELECT   ename ,esex  FROM  t_emp  WHERE esalary>1000  AND  esalary<3000;
 
-- BETWEEN 值一 and 值二  >=值一  <=值二
SELECT   ename ,esex  FROM  t_emp  WHERE esalary  BETWEEN 1000  AND  3000;

-- 工资是1000   =一个值
SELECT   * FROM  t_emp  WHERE esalary=1000;

-- 工资是1000或2000   in(1.多个值)
SELECT   * FROM  t_emp  WHERE esalary  IN(1000,2000);

-- 排序

-- 查询员工结果是按工资按降序排列
SELECT   * FROM  t_emp  ORDER  BY esalary DESC

-- 升序
SELECT   * FROM  t_emp  ORDER  BY esalary ASC

-- 查询刘燕凤的工资占整个工资成本的比例
SELECT  esalary/(SELECT  SUM(esalary)  FROM  t_emp)  FROM  t_emp 
 WHERE ename='刘燕凤'
 
 -- FORMAT(字段，位数)
SELECT  FORMAT(esalary/(SELECT  SUM(esalary)  FROM  t_emp),3)  FROM  t_emp 
WHERE ename='刘燕凤'


-- 模糊查询   like

SELECT   *  FROM  t_emp   WHERE  ename LIKE '贾%'

SELECT   *  FROM  t_emp   WHERE  ename LIKE '贾_'

SELECT   *  FROM  t_emp   WHERE  ename LIKE '贾__'

SELECT   *  FROM  t_emp   WHERE  ename LIKE '%雷'

-- 分组查询   group  by 

SELECT   *  FROM  t_emp  

-- 统计每个地方的员工数量

SELECT COUNT(*), eaddress  FROM  t_emp  GROUP BY eaddress


-- 统计员工性别的数量
SELECT   COUNT(*),esex    FROM  t_emp  GROUP   BY esex

-- 统计每个地方的员工数量大于2个的   分组的条件限制一定是:having 

SELECT   COUNT(*) AS cn ,eaddress    FROM  t_emp  GROUP   BY eaddress
HAVING  cn>2

-- 统计每个地方的员工数量，数量按降序排列
-- 先分组，后排序

SELECT COUNT(*) AS  cn, eaddress  FROM  t_emp  
GROUP BY eaddress  ORDER  BY cn DESC



SELECT  COUNT(*),esex  FROM  t_emp  GROUP  BY  esex

SELECT   *  FROM  t_emp

ALTER  TABLE   t_emp  ADD  faceimg  VARCHAR(100);

SELECT   faceimg FROM   t_emp  WHERE ename=%s


---------------------------------------------------------------------------

-- 查看员工表

SELECT  * FROM   t_emp

-- 查询员工的年龄

-- 现在的时间 now()

SELECT  ename, SUBSTR(NOW(),1,4)-SUBSTR(ebirthday,1,4)
 FROM  t_emp
 
-- 统计员工每个年龄段的数量
SELECT  SUBSTR(NOW(),1,4)-SUBSTR(ebirthday,1,4) 
AS '年龄段',COUNT(*) AS  '人数'
 FROM  t_emp    GROUP   BY  
SUBSTR(NOW(),1,4)-SUBSTR(ebirthday,1,4)

-- 统计员工每个年龄段的数量数量大于1的
SELECT  SUBSTR(NOW(),1,4)-SUBSTR(ebirthday,1,4) 
AS '年龄段',COUNT(*) AS  '人数'
 FROM  t_emp    GROUP   BY  
SUBSTR(NOW(),1,4)-SUBSTR(ebirthday,1,4)
HAVING  COUNT(*)>1

-- 统计员工每个年龄段的数量,数量按升序排列

--  标识符  给程序的变量，方法，
-- 构造函数起名字的一个原则，原则：不能逾越
-- 1a=10

-- nkj_db

-- 三范式  设计表的规范，规范:可以逾越

-- 1.表中的字段是最小单位，所谓的最小单位意思是不能再分割。
-- 姓名 最小单位：参照本地化

-- 2. 在第一方式的基础上，表中的字段只参照一个主键

-- 员工ID  员工姓名   部门ID  部门名称
--  必须做表的实体的拆分
-- 表中的实体 ，主要分为3种关系
-- 1. 一对一关系    职工表--- 角色表  学生表-银行卡表
-- 2. 一对多关系 (现实:班级表和学生表，部门表和员工表
-- 商品分类表和商品表 ) 

-- 订单表和商品表  考虑???????????

-- 3. 多对多关系

--  学生表--------中间关系表[成绩表]---------科目表

-- 数字化校园业务关系系统

-- 1. 学生表 2.班级表 3. 角色表  4.科目表  5.成绩表

-- 2.班级表
CREATE  TABLE  t_classes
(
   cid  INT  PRIMARY  KEY  AUTO_INCREMENT,
   cname   VARCHAR(20)  NOT NULL, -- 班级名称
   caddress  VARCHAR(20)  NOT NULL, -- 班级地址
   cqq    VARCHAR(20)  -- 班级qq

)
--  3.角色表
CREATE  TABLE  t_role
(

   rid  INT  PRIMARY KEY  AUTO_INCREMENT,
   rname   VARCHAR(20)  NOT  NULL  -- (学生,社团,学生会)

)

-- 1.学生表
CREATE  TABLE  t_stus
(
   sid   INT  PRIMARY KEY AUTO_INCREMENT,
   sname  VARCHAR(20)  NOT NULL, -- 学生姓名
   spwd     CHAR(6)  NOT  NULL ,-- 学生密码
   ssex   CHAR(4)  NOT  NULL, --  学生性别
   state   INT,    -- 学生状态(1:正常 2:毕业 3:休学)
   sphone   CHAR(11),  -- 手机号码
   sqq    VARCHAR(20),  --  QQ号，
   sjob     INT , -- 学生的角色
   scid  INT  -- 班级编号
   
)

-- 科目表
CREATE  TABLE   t_km
(

   kid  INT  PRIMARY KEY  AUTO_INCREMENT,
   kname  VARCHAR(20)  NOT  NULL -- 科目名称

)

-- 成绩表
CREATE  TABLE  t_score
(
    scid  INT  PRIMARY KEY  AUTO_INCREMENT,
    sid  INT ,  -- 学生ID
    kid  INT,  -- 科目ID
    score  INT   -- 分数
)

-- 1.学生和角色  一对一
-- 2. 班级和学生  一对多
-- 3. 学生和科目  成绩表(中间关系表) 多对多

-- 3.参照以上两个方式，表中的一个字段不能由另外一个通过计算得出.
-- 职工表  职工工资  养老保险

---------------------------------------------------------
-- 多表
-- 学生表和角色表
--  定义角色表的数据
INSERT  INTO  t_role(rname)  VALUES('学生');
INSERT  INTO  t_role(rname)  VALUES('班长');
INSERT  INTO  t_role(rname)  VALUES('团支书');

-- 定义班级表的数据
INSERT  INTO  t_classes(cname,caddress,cqq)
VALUES('java班','7031','123456@qq.com');
INSERT  INTO  t_classes(cname,caddress,cqq)
VALUES('python班','7032','654321@qq.com');
INSERT  INTO  t_classes(cname,caddress,cqq)
VALUES('go班','7033','678901@qq.com');




-- 定义学生表的数据

INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('陈赵梅','000000','女',1,'13913321089','4561231@qq.com',1,1);

INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('王启明','000000','男',1,'13913321090','4561232@qq.com',2,1);

INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('刘冬孝','000000','男',1,'13913321091','4561233@qq.com',3,1);
INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('刘燕凤','000000','女',1,'13913321092','4561234@qq.com',1,2);
INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('路廷伟','000000','女',1,'13913321093','4561235@qq.com',2,2);
INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('王安乐','000000','男',1,'13913321094','4561236@qq.com',3,2);
INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('柳晓霖','000000','男',1,'13913321095','4561237@qq.com',1,3);
INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('钱涛','000000','男',1,'13913321096','4561238@qq.com',2,3);
INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('贾春雷','000000','男',1,'13913321097','4561239@qq.com',3,3);
INSERT  INTO  t_stus
(sname, spwd,ssex,state,sphone,sqq,sjob,scid)
VALUES('彭勃','000000','男',1,'13913321098','2561230@qq.com',1,1);


SELECT   *  FROM  t_stus

SELECT   *  FROM t_classes

-- 子查询，一个查询结果作为另外一个查询的条件
-- 查询java班同学的信息
SELECT     *    
FROM  t_stus  WHERE scid =
(SELECT  cid  FROM  t_classes   WHERE cname='java班')

-- 查询java同学的个数
SELECT     COUNT(*)   
FROM  t_stus  WHERE scid =
(SELECT  cid  FROM  t_classes   WHERE cname='java班')

-- 查询和编号是1这个班级的角色相同的学生的信息
SELECT  *  FROM  t_stus   WHERE sjob  IN
(SELECT  sjob  FROM  t_stus  WHERE scid=1)

-- 查询和编号是1这个班级的角色相同的学生的信息,
-- 但不包括1号班级的学生信息
SELECT  *  FROM  t_stus   WHERE sjob  IN 
(SELECT  sjob  FROM  t_stus  WHERE scid=1) AND scid<>1


-- 查询'刘燕凤'这个学生的班级名称，和班级QQ号
SELECT  cqq,cname  FROM  t_classes  WHERE cid=
(SELECT  scid   FROM  t_stus  WHERE sname='刘燕凤')

-- 查询和'刘燕凤'角色相同的学生的姓名(不包括刘燕凤)
SELECT   sname  FROM   t_stus  WHERE sjob=
(SELECT      sjob    FROM  t_stus  WHERE sname='刘燕凤')
AND  sname<>'刘燕凤'

-- 查询'彭勃'同学的职务名称
SELECT rname  FROM t_role  WHERE  rid=
(SELECT  sjob  FROM  t_stus  WHERE sname='彭勃')


SELECT   * FROM  t_emp

SELECT  COUNT(*) FROM  t_emp  WHERE ename=  AND  epwd=

SELECT  cname  FROM  t_classes

SELECT  COUNT(*)  FROM  t_classes

--  创建一张表
CREATE  TABLE  t_menu
(
   tid  INT   PRIMARY KEY  AUTO_INCREMENT,
   tname  VARCHAR(50), -- 标题名称
   turl  VARCHAR(50), -- 标题链接
   tstats  INT  -- 标题的状态 1:正常  0:不显示

)
-- 删除表
DROP  TABLE  t_menu

-- 插入数据
INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('Java频道','',1);
INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('python频道','',1);
INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('JavaScript频道','',1);
INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('DB频道','',1);
INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('小程序频道','',1);
INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('go频道','',1);
INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('php频道','',1);

INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('Fluter频道','',1

INSERT  INTO  t_menu(tname,turl,tstats)
VALUES('分布式频道','',1);

SELECT  * FROM t_menu

SELECT  tname,turl  FROM   t_menu
-- {{},{},{},{},{},{},{},{},{}}

-- 班级
SELECT  cid,cname  FROM  t_classes

SELECT  sname  FROM  t_stus  WHERE  scid=?

-- 
SELECT  *  FROM  t_stus

-- 男女的比例
SELECT ssex,COUNT(*) FROM t_stus  GROUP  BY ssex 

------------------多表的查询(2张表查询)--------------------------------------------
-- 班级表
SELECT   * FROM  t_classes


-- 学生表
SELECT   * FROM  t_stus

-- 角色表
SELECT  * FROM  t_role

-- 科目表
SELECT  *  FROM   t_km

-- 成绩表
SELECT  *  FROM  t_score

--  题目1.java班的学生数量
-- 子查询
SELECT  COUNT(*) FROM  t_stus  
WHERE  scid=(SELECT cid FROM  t_classes WHERE cname='java班')

-- 普通查询
SELECT  COUNT(*)  FROM  t_stus,t_classes WHERE scid=cid  AND 
cname='java班';

-- 连接查询  内连接查询
SELECT  COUNT(*)  FROM  t_stus INNER   JOIN  t_classes ON scid=cid  
WHERE 
cname='java班';

-- 题目2 每个班的学生的数量
SELECT  COUNT(*),cname FROM  t_classes INNER  JOIN  t_stus 
ON  scid = cid  GROUP  BY  cname ;

-- 题目3 每个班的学生的数量大于3人的班级名称
SELECT  COUNT(*),cname FROM  t_classes INNER  JOIN  t_stus 
ON  scid = cid  GROUP  BY  cname  HAVING  COUNT(*)>3;

-- 题目4 每个班的学生的数量结果按降序排列
SELECT  COUNT(*),cname FROM  t_classes INNER  JOIN  t_stus 
ON  scid = cid  GROUP  BY  cname  ORDER   BY  COUNT(*)  DESC

-- 题目5 java班学生的角色名称有哪些? java班学生的角色是领导的?
SELECT rname  FROM  t_role  WHERE  rid IN (SELECT  sjob FROM  t_stus  
WHERE  scid=(SELECT cid FROM  t_classes WHERE cname='java班'))
AND rname<>'学生'

--  DISTINCT 过滤重复
SELECT  DISTINCT(rname) FROM  t_role  INNER   JOIN  
(SELECT  sjob  FROM  t_classes   INNER   JOIN  t_stus   
ON  scid = cid  WHERE cname='java班') temp ON rid=temp.sjob;

-- java班学生选修‘英语’的均分  
 SELECT  kid  FROM  t_km  WHERE kname='英语'
 
SELECT  FORMAT(AVG(score),3)  FROM (SELECT  kid ,score FROM   
(SELECT kid ,score  FROM  t_score WHERE sid IN 
(SELECT  sid   FROM  t_stus WHERE scid
  =(SELECT  cid  FROM  t_classes  WHERE cname='java班'))) temp 
  WHERE temp.kid=
  ( SELECT  kid  FROM  t_km  WHERE kname='英语')) aa




INSERT   INTO   t_km(kname)  VALUES('英语');
INSERT   INTO   t_km(kname)  VALUES('语文');
INSERT   INTO   t_km(kname)  VALUES('数学');

SELECT   * FROM  t_stus

SELECT   * FROM  t_km

-- 科目表和学生表  多对多关系， 中间第三张关系表，成绩表
SELECT  *  FROM  t_score

INSERT  INTO  t_score(sid,kid,score)
VALUE(1,1,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(1,2,80);
INSERT  INTO  t_score(sid,kid,score)
VALUE(2,1,81);
INSERT  INTO  t_score(sid,kid,score)
VALUE(3,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(3,2,70);

INSERT  INTO  t_score(sid,kid,score)
VALUE(4,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(4,1,70);

INSERT  INTO  t_score(sid,kid,score)
VALUE(5,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(5,2,70);

INSERT  INTO  t_score(sid,kid,score)
VALUE(6,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(6,2,70);

INSERT  INTO  t_score(sid,kid,score)
VALUE(7,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(7,2,70);

INSERT  INTO  t_score(sid,kid,score)
VALUE(8,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(8,2,70);

INSERT  INTO  t_score(sid,kid,score)
VALUE(9,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(9,2,70);


INSERT  INTO  t_score(sid,kid,score)
VALUE(10,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(10,2,70);

INSERT  INTO  t_score(sid,kid,score)
VALUE(3,3,90);
INSERT  INTO  t_score(sid,kid,score)
VALUE(3,2,70);

-- 1.学生籍贯的比例
-- 2.学生职务的比例
-- 3.学生的年龄的比例

   

-- 软件 查询 70%

-- 联表查询和高级查询

-- 存储过程



-- 自定义函数










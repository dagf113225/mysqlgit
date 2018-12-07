-- oracle数据库教学之旅

select   *   from  t_depts;

select  *  from  t_students
-- 创建表，类型number,varchar2,char,date
create table  t_stus
(
   tid  number(5)  primary key ,
   tname  varchar2(20) , -- 不定长
   tpwd char(6),        -- 定长  , 4444
   birthday  date, -- 日期类型
   money  number(6,2) --6:总长度，2:小数点位数
)

-- 查询sql
select  *  from  t_stus


-- oracle自动增长，叫做序列
create  sequence  seq_t_stus
start  with  100
increment  by 1
nocache;  --没有缓存，立即生成


-- 插入数据  提交到oracle数据库缓存
insert  into  t_stus   values(seq_t_stus.nextval,
'王安乐','1111',to_date('1997-09-12','yyyy-MM-dd'),1000.77);

insert  into  t_stus   values(seq_t_stus.nextval,
'王启明','222222',to_date('1997-09-12','yyyy-MM-dd'),2000.77);
commit;
-- oracle提交， 正式提交
-- 事务 oracle手动事务
commit;

select   *  from  t_stus;

-- 更新数据
update   t_stus  set  tpwd='888888'  where tid=102;
commit;

-- 插入数据
insert  into  t_stus   values(seq_t_stus.nextval,
'路廷伟','4444',to_date('1997-09-12','yyyy-MM-dd'),3000.77);
commit;

-- 删除数据
delete  from   t_stus  

delete  from  t_stus  where tid=103;
commit;

-- 查询表中所有的学生的姓名
select  tname  from   t_stus;

select  *  from  t_depts
select  tname  from  t_employee

-- 查询属于生产部员工的姓名
select     tname  from   t_employee  
where  tdnum  in (select dnum  from   t_depts  where  dname='技术部')

-- 单表查询

-- 聚合函数 count(*)  sum()  max()  min()  avg() 需要大家练一下

-- 内置函数:1.trim()去除空格  char类型的字符串 2.round(值，位数)
--      3.nvl(),取值为空，取默认值  4.to_char() 转换成字符串
    
select  *  from  t_employee

-- 现在员工的数量
select  count(*)  from  t_employee

-- 登录  李涛 1234

-- char(),固定字符串，不够补足;
--varchar2() 。不定长字符串
select  count(*)   from  t_employee  where tname='李涛'  and  trim(tpwd)='1234';

--
select  *  from  t_employee

-- 李涛这个员工工资占总工资和百分比
select round(tsalary/(select  sum(tsalary)  from t_employee ),3) 
from  t_employee  where tname='李涛';

-- 查询员工工资最高的员工姓名
select   tname  from  t_employee   where   tsalary 
in (select  max(tsalary)  from t_employee);

-- 比较运算符 >,<,<>,
-- 职务不是工人的员工的信息
select   *  from  t_employee  where  tjob<>'工人';

-- 修改表
alter  table  t_employee  add   money  number(6,2);

-- 删除表的列
alter table  t_employee  drop  column  money;

-- 查询丁凯的收入
select  tsalary+nvl(tmoney,0) from  t_employee  where tname='丁凯';

-- 丁凯的收入占总收入的百分比？？？？？？？？？？？？？？？
-- 你们自己写.

--模糊查询   like  查询所有姓李的员工的数量
--
select  *  from  t_employee
-- 查询所有姓李的员工的数量
select count(*)  from  t_employee  where  tname  like '李%'
-- 查询所有姓李的两个字的员工的数量
select tname  from  t_employee  where  tname  like '李_'

--排序查询  order  by 

-- 工资按从高到低
select  *  from   t_employee  order  by  tsalary  asc
select  *  from   t_employee  order  by  tsalary  desc

--分组查询  group by 

-- 员工职务的数量比例
select  tjob,count(*) from   t_employee  group   by   tjob 

-- 员工籍贯的数量比例
select  taddress,count(*) from   t_employee  group   by   taddress 

-- 员工男女的比例 ???


-- 各个部门的员工的数量
select nvl(tdnum,'没有'),count(*) from 
t_employee  group   by   tdnum -- 这个报错，注意类型

select nvl(to_char(tdnum),'没有这个部门'),count(*) from 
t_employee  group   by   tdnum 

-- 补充  between...and..  and(和),or(或)   in(关键字)

-- 
select   *  from   t_employee

-- 职务是总经理或者工资大于5000的员工的信息
select   *  from   t_employee where  tjob='总经理'  or  tsalary>5000

------  分页查询
-- 1。查询这个表的前4条记录
select   *  from   t_employee

-- 2.oracle中有个伪列，隐藏的列  rownum,它始终在第一行，不不能够移动
select  rownum,e.*   from    t_employee    e

select  rownum,e.*   from    t_employee    e  where rownum<=4;

--2。查询这个表的第2条到第5条的记录
select  rownum,e.*   from    t_employee    e  where
rownum>=2 and rownum<=5;

select  rownum,e.*   from    t_employee    e  where
rownum   between   2  and  5;

-- 查询这个表的第2条到第5条的记录实现的方式为:
select  * from 
(select  rownum rm,e.*   from    t_employee    e  where rownum<=5) tmp
where tmp.rm>=2;

-- 分页查询  --1.每页2条，查第一页，3页数据
-- 1.第一页:2条  endNum:2条*第1页  startNum:>(第一页-1)*2条
-- 2.第三页:2条  endNum:2条*第3页  startNum:>(第三页-1)*2条

-----------------------------------------------------------------------------
-- 分页查询  --1.每页3条，查第一页，3页数据
-- 1.第一页:3条  endNum:3条*第1页  startNum:>(第一页-1)*3条
-- 2.第三页:3条  endNum:3条*第3页  startNum:>(第三页-1)*3条
select  rownum,e.*   from    t_employee    e


-- 分页查询  --1.每页3条,第2页的数据
select  *  from (select  rownum  rm,  e.* from   t_employee    e
where rownum<=3*2) temp  where  temp.rm>(2-1)*3


-- 多表查询 
select   *  from  t_depts

select  * from t_employee

--笛卡尔积
select   *  from  t_depts,t_employee

-- 普通连接查询

-- 查询每个员工的所属部门信息和个人信息

-- 员工的部门编号等于部门编号
-- 普通查询
select   *  from  t_depts d,t_employee  e
where  e.tdnum=d.dnum;

-- 内连接查询 A表 inner   join   B表 ..on 在什么条件下连接
select  * from  t_employee  e  inner   join  t_depts d 
on e.tdnum=d.dnum

-- 左连接查询  以左表为基准表
-- 查询每个员工的所属部门的信息(包括没有部门的员工)
select  * from  t_employee  e  left   join  t_depts d 
on e.tdnum=d.dnum

--右连接查询 以右表为基准表
-- 查询每个部门的所属员工(包括部门没有员工的部门信息)
select  * from  t_employee  e  right   join  t_depts d 
on e.tdnum=d.dnum

-- 全连接，所有的都查询，包括所有对应不上的。

select  * from  t_employee  e  full   join  t_depts d 
on e.tdnum=d.dnum


-- 查询李涛的部门的名称

--1.内连接查询
select d.dname   from   t_employee  e   inner  join  t_depts  d 
on  e.tdnum=d.dnum where e.tname='李涛';
--2.子查询  效率比较慢，建议使用连接查询
select  d.dname from  t_depts d  where 
d.dnum=(select  e.tdnum  from   t_employee  e where e.tname='李涛')

--3.查询质量部的员工的信息
select  e.tname,d.dname
from  t_depts  d  inner  join  t_employee e  on  
d.dnum=e.tdnum   where d.dname='质量部'

select  e.tname  from  t_employee  e  
where e.tdnum=(select d.dnum  from  t_depts  d  where d.dname='质量部')

select  e.tname, temp.dname from  
(select d.dnum ,d.dname from  t_depts  d  where d.dname='质量部') temp 
inner  join   t_employee  e   on temp.dnum=e.tdnum 


-- 查询每个部门的员工的数量
select   count(tname) ,d.dname  from     t_depts  d 
left   join t_employee  e  on  d.dnum=e.tdnum
group   by  d.dname 
-- 查询每个部门的员工的数量部门人数大于1人的
select   count(tname) ,d.dname  from     t_depts  d 
left   join t_employee  e  on  d.dnum=e.tdnum
group   by  d.dname   having  count(tname)>1


-- 查询每个部门的员工的数量按降序排列
select   count(tname) ,d.dname  from     t_depts  d 
left   join t_employee  e  on  d.dnum=e.tdnum
group   by  d.dname   order  by count(tname)  desc


-- 查询每个部门的籍贯的员工数量(双分组查询)
select   count(tname) ,d.dname ,nvl(e.taddress,'没有') from     t_depts  d 
left   join t_employee  e  on  d.dnum=e.tdnum
group   by  d.dname ,e.taddress

-- 高级查询

--PL-SQL块

-- 块,是把一组也就是多条sql在一起执行


--块的结构
declare
 -- 变量
begin
 -- 多条sql语句
end;
-----------------------------------------------------------------------------------------------
-- 检查用户是否是男的，如果是男的，工资加100，如果是女的，工资加50


-- 输入一个数，判断这个数是偶数和奇数
accept  num   prompt '请输入一个数';
declare
-- 定义一个变量  :=表示的是给变量赋值
numa number:=&num;
begin
  --判断这个数
  if   mod(numa,2)=0    then
    -- 输出  ||表示的是连接   
    dbms_output.put_line('这个数'||numa||'是偶数');
  else
     dbms_output.put_line('这个数'||numa||'是奇数');
  end  if;
end;
------------------------------------------------------------------------------------
select  * from  t_students

-- 输出一个学生的姓名，如果是男的,奖励500，如果是女的奖励1000元
-- 并输出这个学生的整体的信息
accept  uname  prompt '请输入一个学生的姓名:';
declare
  -- 定义学生的变量  := 是给一个变量赋值
  v_name  varchar2(50):='&uname';
  v_sex  t_students.stusex%type;
  v_salary  t_students.money%type;
  v_str  varchar2(200);
begin
   --查询这个学生的性别  在sql语句中赋值用into,但是只能附一个值， 不能附多个值
   select  stusex  into v_sex  from  t_students  where  stuname=v_name;
    dbms_output.put_line(v_name||',学生的性别为:'||v_sex);
    
  
    --对性别进行判断
    -- 比较值是一个 =
    if  v_sex='男' then
        v_salary:=500;
    else
        v_salary:=1000;
    end  if;
    -- 执行数据库学生表的的更新
    update  t_students  set  money=money+v_salary where 
    stuname=v_name;
    commit;
    
    --输出这个人的最新的信息
    select stuname||'工资为:'||money  into  v_str  from  t_students where 
    stuname=v_name;
    
    --输出
    dbms_output.put_line(v_str);
-- 异常  
exception
when others then

  v_str:='没得这个人';
 dbms_output.put_line(v_str);
end;

-- 循环控制  算1..100之和
declare 
  v_sum  number:=0;
begin
      
      -- for中的变量不需要定义
      for v_i  in 1..100  loop
         v_sum:=v_sum+v_i;
      end  loop;
      
      -- 输出和
      dbms_output.put_line('和为:'||v_sum);   
end;

select  *  from  t_test

delete  from  t_test;
commit;

-- 批量数据
declare 
begin
   for  v_i  in 1..5000000000  loop
        if  mod(v_i,2)=0  then
          insert  into  t_test values(v_i,'张'||v_i,sysdate);
        else 
          insert  into  t_test values(v_i,'李'||v_i,to_date('1992-12-30','yyyy-MM-dd'));
        end if;
    
   end  loop;
   commit;
end;

-- while...loop

--1.100之和
declare
v_i number:=1;
v_sum  number:=0;
begin

   while v_i<=100  loop
    v_sum:=v_sum+v_i;
    v_i:=v_i+1;
   end  loop;
    dbms_output.put_line('和为:'||v_sum); 
end;



--存储过程
-- 性能优越，编译一次，后面就不需要编译
-- 存储的名字，我们编程语言可以通过名字来call
-- 过程pl-sql块，一次性能够解决复杂业务逻辑。

-- 结构
select   *  from  t_emplog

delete  from  t_emplog

select  *  from  t_employee

commit;
--检查登录，并记录日志，日志表
-- select  判断   insert  
create  or  replace  procedure p_checkuser
(
   v_name   in  varchar2,  -- 传入的姓名
   v_pwd   in  varchar2,  --传入的密码
   v_msg  out  varchar2   -- 输出消息  --一个值
)
as
v_count   number:=0;
begin
   -- 检查登录
   select  count(*)  into v_count  from  t_employee e 
   where e.tname=v_name  and  trim(e.tpwd)=v_pwd;
  
   if v_count>0 then
      v_msg:='登录成功';
   else
      v_msg:='登录失败';
   end  if;
   
     dbms_output.put_line('输出的消息为:'||v_msg);
  
   -- 插入到日志表
   insert  into  t_emplog   values(seq_emplog.nextval,v_name,sysdate,v_msg);
   commit;
end;

-- 1.返回游标结果集

select   * from  t_depts
select  *  from  t_employee

-- 查询**（传入的参数）部门的员工的信息，
-- 如果是工人，工资加100，如果是临时工加50，如果是组长和总经理，工资加200
--输出这个部门的所有的员工的更新后的信息，和更新的数量。

create   or   replace   procedure   p_one
(
   v_dname  in  varchar2, -- 不需要有长度
   v_dmsg  out  varchar2,
   v_updatecount  out  number
)
as
v_count  number:=0;
v_money   number:=0;
v_upcount number:=0;
v_msg  varchar2(100);

 
begin
      --1. 健壮性考虑   这个部门有没有   一个值into 一行一列
      select  count(*)   into  v_count  from  t_depts where dname=v_dname;
      
      --2.判断这个部门存不存在
       if   v_count>0  then
            --1.查询这个部门的所属员工  部门名称
          --  select   *  from  t_employee  where tdnum =(select t_depts.dnum
          --  from  t_depts  where dname=v_dname);
          
          --结果集  在存储过程内部对游标的直接的遍历 
             for v_linedata  in  (select   *  from   t_employee e  right  join
                t_depts  d   on e.tdnum=d.dnum  where d.dname=v_dname) loop
                   -- dbms_output.put_line(v_linedata.tname||','||v_linedata.tjob);
                   
                      if v_linedata.tjob='工人'  then
                      
                           v_money:=100;
                      
                      elsif  v_linedata.tjob='临时工'  then
                           v_money:=50;
                      
                      else
                             v_money:=200;
                      end  if;
                      
                    --dbms_output.put_line(v_linedata.tname||','||v_linedata.tjob||','||v_money);
             
                   -- 更新员工的工资
                   update t_employee set tsalary =tsalary+v_money  where tname=v_linedata.tname;
                   commit;
                   v_upcount:=v_upcount+1;
               
                   --查询更新后的员工的信息
                   select  tname||',职务为:'||tjob||',工资为:'||tsalary  into v_msg  from    t_employee  where tname=v_linedata.tname;
               dbms_output.put_line('v_msg,'||v_msg);
                   v_dmsg:=v_dmsg||v_msg||',';
             end  loop;
             v_updatecount:=v_upcount;
            
             dbms_output.put_line('v_dmsg,'||v_dmsg);
       else  --没有这个部门
          dbms_output.put_line('没有这个部门');
          v_dmsg:='没有这个部门，请核实';
          v_updatecount:=0;
       end if;
exception

 when  others  then 
  v_dmsg:='这个部门是有的，但是没有员工';
  v_updatecount:=0;
end;

---直接返回游标
--2.游标直接返回编程语言

-- 每个部门的员工的职务的名称和数量
select dname,nvl(tjob,'没有员工或没有职务'),count(tjob)  from  t_depts  d left  join  
t_employee e on  d.dnum=
e.tdnum  group  by  dname,tjob;

-- 每个部门的员工的职务的名称和数量
-- sys_refcursor 游标类型 代表结果集，多条记录
create or replace  procedure  p_two
(
   v_datas  out sys_refcursor   
)
as
begin

-- 结果集的状态一定是打开的
open v_datas  for   select dname,nvl(tjob,'没有员工或没有职务'),count(tjob)  from  t_depts  d left  join  
t_employee e on  d.dnum=
e.tdnum  group  by  dname,tjob;
end;

 -- 返回输入部门的员工数量，返回职务的是**职务名称的员工的姓名和籍贯
 select  * from  t_employee
 --1.部门名称   职务名称  2.员工数量，员工的姓名和籍贯
 
 create   or   replace   procedure   p_three
 (
      v_dname  in  varchar2,
      v_job  in varchar2,
      v_empcount  out   number,
      v_empinfo  out  sys_refcursor,
      v_str1  out  varchar2,
      v_str2  out  varchar2
 )
 as
 v_jcount  number:=0;
v_dount  number:=0;
 begin
  -- 1.得到部门的员工数量
    select  count(*) into v_dount  from  t_depts d   where d.dname=v_dname;
    
    if  v_dount>0  then
    
          select  count(*)  into  v_empcount  from  t_depts  d  left   join  t_employee e
          on d.dnum=e.tdnum  where d.dname=v_dname;
    else
         v_str1:='没有这个部门';
    
    end  if;
  
   --2. 职务名称的员工姓名和籍贯
   select  count(*) into v_jcount  from  t_employee e  where e.tjob=v_job;
   
   if  v_jcount>0 then
           open v_empinfo  for
           select  tname,taddress  from   t_employee  e  where e.tjob=v_job;
   else
     
          v_str2:='没有这个职务名称';
   
   end if;
   

  
  exception 
  
  when   others  then 
    SYS.dbms_output.put_line('没有这个职务');
    v_empcount:=0;
    v_empinfo:=null;

 end;

--自定义函数  特殊的存储过程

-- 存储过程可以有多个返回值  out 参数
-- 自定义函数有且只能有一个输出参数   out参数

--这个部门的员工的数量
create  or replace  function f_one
(
v_dname  in  varchar2
) 
return number -- 这个地方不能加; 代表这个函数返回什么具体类型的函数
as

v_count   number :=0;   
begin
   select  count(*) into v_count  from t_employee e  right join  t_depts d  on e.tdnum=d.dnum
   where d.dname=v_dname;
   
   return v_count;
     
     

end;

--动态sql

-- 如果查询员工表的数量
-- 如果查询部门的表的数量

select  count(*)  from  t_employee

select  count(*)  from  t_depts


create  or replace  function f_one1
return number -- 这个地方不能加; 代表这个函数返回什么具体类型的函数
as

v_count   number :=0;   
begin
    
   select  count(*)  into  v_count  from  t_employee;
   return  v_count;
end;

-- 自定义函数+动态sql
-- 得到任意一张表的条数
-- 动态sql得到一个值
create  or  replace  function   f_exec
(
   v_tablename in  varchar2
)
return number
as
v_sql varchar2(1000):='';
v_count number:=0;
begin
  v_sql:='select  count(*)    from   '||v_tablename;
  
  -- 怎么执行sql execute  immediate
  execute  immediate v_sql into v_count;
  return v_count;

end;
-- 动态sql多个值,直接返回结果集
create  or  replace  function  f_execone
(
 
   v_tablename in  varchar2
)
return sys_refcursor
as
v_datas sys_refcursor;
v_sql varchar2(1000):='';
begin 
   v_sql:='select  *   from   '||v_tablename;
   
   -- 直接返回游标
   open v_datas  for  v_sql;
   return  v_datas;
   
end;

select  * from  t_depts

-- 动态sql多个值,在内部遍历
create  or  replace  function  f_exectwo
(
    v_tablename in  varchar2
)
return  varchar2
as
v_sql varchar2(1000):='';
v_datas sys_refcursor;
v_tname  varchar2(100):='';
tname  varchar2(20):='';
tid  number;
tphone varchar2(20):='';

begin
   
     v_sql:='select  *    from   '||v_tablename;
      dbms_output.put_line(v_sql);
     -- 执行动态sql
     open  v_datas  for v_sql;
     
     -- 内部对游标的遍历
     loop  fetch v_datas  into tid,tname,tphone;
         exit  when  v_datas%notfound;  --有没有数据被发现
           dbms_output.put_line(tid||','||tname||','||tphone);
           v_tname:=v_tname||tid||','||tname||','||tphone;
           
     end loop;
       dbms_output.put_line(v_tname);
return  v_tname;
end;

--游标

--事务






--触发器

--索引

--视图



--锁

-- 定时任务













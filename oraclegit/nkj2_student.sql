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

-- oracle提交， 正式提交
-- 事务 oracle手动事务
commit;





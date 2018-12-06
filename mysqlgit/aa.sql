CREATE  TABLE  t_fmenu
(
   fid  INT  PRIMARY KEY  AUTO_INCREMENT,
   fname  VARCHAR(50)
)

INSERT  INTO  t_fmenu(fname)  VALUES('考情管理');
INSERT  INTO  t_fmenu(fname)  VALUES('信息中心');
INSERT  INTO  t_fmenu(fname)  VALUES('协同办公');
INSERT  INTO  t_fmenu(fname)  VALUES('合同管理');
INSERT  INTO  t_fmenu(fname)  VALUES('人事流程');
INSERT  INTO  t_fmenu(fname)  VALUES('客户管理');

SELECT  *  FROM  t_fmenu

CREATE  TABLE  t_cmenu
(
   cid   INT  PRIMARY KEY   AUTO_INCREMENT,
   cname  VARCHAR(50),
   fcid  INT
)
SELECT  *  FROM  t_cmenu  WHERE fcid=?

INSERT  INTO  t_cmenu(cname,fcid)   VALUES('日常考勤',1);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('请假申请',1);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('加班/出差',1);


INSERT  INTO  t_cmenu(cname,fcid)   VALUES('通知公告',2);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('公司新闻',2);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('规章制度',2);


INSERT  INTO  t_cmenu(cname,fcid)   VALUES('公文流转',3);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('文件中心',3);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('内部邮件',3);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('即时通讯',3);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('短信提醒',3);


INSERT  INTO  t_cmenu(cname,fcid)   VALUES('内部合同',4);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('外部合同',4);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('到期合同',4);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('未签合同',4);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('保密合同',4);


INSERT  INTO  t_cmenu(cname,fcid)   VALUES('人事入职',5);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('职工保险',5);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('职工升值',5);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('薪资计划',5);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('员工福利',5);


INSERT  INTO  t_cmenu(cname,fcid)   VALUES('企业客户',6);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('一般客户',6);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('重要客户',6);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('小区客户',6);
INSERT  INTO  t_cmenu(cname,fcid)   VALUES('外地客户',6);

-- 分页  limit

SELECT   *  FROM  t_stus 

-- 每页条数3，第2页,(2-1)*3
-- LIMIT第一个参数是起始编号,第二个参数就是每页条数
SELECT   *  FROM  t_stus   LIMIT 3,3

SELECT   *  FROM  t_stus   LIMIT 0,3

SELECT   *  FROM  t_stus   LIMIT 6,3

-- 不支持直接计算
SELECT   *  FROM  t_stus   LIMIT (2-1)*3,3

SELECT  * FROM  t_fmenu
SELECT  cid ,cname   FROM  t_cmenu   WHERE fcid=1
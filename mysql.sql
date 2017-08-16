create table evo_push(
    useraccount varchar(300),
    deviceid varchar(300),
	updateDate  datetime
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

alter table org_employee modify column EMP_ID numeric(20);
alter table oa_custmenu_curmobile modify mobileid numeric(20);
alter table org_employee modify emp_id numeric(20);
alter table org_group modify group_id numeric(20);
alter table org_organization modify org_id numeric(20);
alter table org_organization_user modify org_id numeric(20),modify emp_id numeric(20);
update oa_custmenu_curmobile set mobileMenuOrder = 0 where mobileMenuOrder is null;
update oa_custmenu_curmobile set weburl='/dealfile/list.controller' where mobileMenuCode ='workflow';
update oa_custmenu_curmobile set weburl='/mail/mailBox.controller' where mobileMenuCode ='innermail';
update oa_custmenu_curmobile set weburl='/information/index.controller' where mobileMenuCode ='information';
update oa_custmenu_curmobile set weburl='/doc/getAllReceiveFile.controller' where mobileMenuCode ='documentmanager';
update oa_custmenu_curmobile set weburl='/post/index.controller' where mobileMenuCode ='forum';
update oa_custmenu_curmobile set weburl='/report/index.controller' where mobileMenuCode ='report';
update oa_custmenu_curmobile set imgName='desk_report.png' where mobileMenuCode ='report';
update oa_custmenu_curmobile set weburl='/worklog/getWorkLogList.controller' where mobileMenuCode ='workmanager_worklog';
update oa_custmenu_curmobile set weburl='/attendance/loadWxLocation.controller' where mobileMenuCode ='mobilelocation';
update oa_custmenu_curmobile set weburl='/naire/getAnswerQuestionnaireList.controller' where  mobileMenuCode='questionnaire';
update oa_custmenu_curmobile set weburl='/newmeeting/meetingNoticeList.controller' where mobileMenuCode ='meetingnotice';
update oa_custmenu_curmobile set weburl='/eventManages/eventManage.controller' where mobileMenuCode ='eventmanages';
update oa_custmenu_curmobile set weburl='/custmenu/custMenu.controller' where mobileMenuCode ='';
update oa_custmenu_curmobile set mobileMenuIsUse=1  where mobileMenuCode ='eventmanages';
update oa_custmenu_curmobile set clientIsUse=1 where mobileMenuCode ='eventmanages';
update oa_custmenu_curmobile set clientIsUse=0 where mobileMenuCode='workmanager_workreport';
update ezmobile_custmenu_curmobile set webappIsUse=0 where mobileMenuCode='workmanager_workreport';
insert  into `ezmobile_patchinfo`(`patch_Version`,`patch_Name`,`patch_Time`,`patch_editinfo`,`PATCH_EVO`,`isclientuse`) 
values ('1.2.1','1.2.1_webapp_20170625',sysdate(),'WanhuezOFFICE','0','0');
insert  into `ezmobile_patchinfo`(`patch_Version`,`patch_Name`,`patch_Time`,`patch_editinfo`,`PATCH_EVO`,`isclientuse`) 
values ('5.0','5.0_evo_20170625',sysdate(),'WanhuezOFFICE','0','1');










update oa_custmenu_curmobile set clientIsUse=0 where mobileMenuCode ='meetingassistant';
update oa_custmenu_curmobile set mobileMenuIsUse=0 where mobileMenuCode ='meetingassistant';
update oa_custmenu_curmobile set imgName='desk_mobilelocation.png' where mobileMenuCode ='mobilelocation';
update oa_custmenu_curmobile set imgName='desk_questionnaire.png' where mobileMenuCode ='questionnaire';
update oa_custmenu_curmobile set imgName='desk_meetingnotice.png' where mobileMenuCode ='meetingnotice';
update oa_custmenu_curmobile set imgName='desk_schedule.png' where mobileMenuCode ='eventmanages';
update oa_custmenu_curmobile set mobileMenuIsUse=0 where mobileMenuCode ='meetingassistant';
update oa_custmenu_curmobile set mobileMenuIsUse=0 where mobileMenuCode ='workmanager_workreport';
update oa_custmenu_curmobile set mobileMenuIsUse=0 where mobileMenuCode ='workmanager_calendar';
DELETE FROM org_organization;
DELETE FROM org_employee where  emp_id<>1;
DELETE FROM org_organization_user;
DELETE FROM org_group;
update sys_corp_set set timestamp = '0';
alter table org_organization add orgordercode decimal(10);
alter table org_employee add empMobilePhone varchar(20);
alter table org_employee add empDuty varchar(50);
alter table org_employee modify empDuty varchar(50) CHARACTER SET utf8;
insert  into `ezmobile_patchinfo`(`patch_Version`,`patch_Name`,`patch_Time`,`patch_editinfo`,`PATCH_EVO`,`isclientuse`) 
values ('1.2.2','1.2.2_webapp_20170710',sysdate(),'WanhuezOFFICE','0','0');












update oa_custmenu_curmobile set clientIsUse=0 where mobileMenuCode ='meetingassistant';
update oa_custmenu_curmobile set mobileMenuIsUse=0 where mobileMenuCode ='meetingassistant';
update oa_custmenu_curmobile set imgName='desk_mobilelocation.png' where mobileMenuCode ='mobilelocation';
update oa_custmenu_curmobile set imgName='desk_questionnaire.png' where mobileMenuCode ='questionnaire';
update oa_custmenu_curmobile set imgName='desk_meetingnotice.png' where mobileMenuCode ='meetingnotice';
update oa_custmenu_curmobile set imgName='desk_schedule.png' where mobileMenuCode ='eventmanages';
update oa_custmenu_curmobile set mobileMenuIsUse=0 where mobileMenuCode ='meetingassistant';
update oa_custmenu_curmobile set mobileMenuIsUse=0 where mobileMenuCode ='workmanager_workreport';
update oa_custmenu_curmobile set mobileMenuIsUse=0 where mobileMenuCode ='workmanager_calendar';
DELETE FROM org_organization;
DELETE FROM org_employee where  emp_id<>1;
DELETE FROM org_organization_user;
DELETE FROM org_group;
update sys_corp_set set timestamp = '0';
alter table org_organization add orgordercode decimal(10);
alter table org_employee add empMobilePhone varchar(20);
alter table org_employee add empDuty varchar(50);
alter table org_employee modify empDuty varchar(50) CHARACTER SET utf8;
insert  into `ezmobile_patchinfo`(`patch_Version`,`patch_Name`,`patch_Time`,`patch_editinfo`,`PATCH_EVO`,`isclientuse`) 
values ('1.2.3','1.2.3_webapp_20170724',sysdate(),'WanhuezOFFICE','0','0');









create table ezmobile_remindlist(
    id      float(20) not null auto_increment,
    useraccount  varchar(300),
    module  varchar(30),
    title   varchar(1000),
    paramstring   varchar(1000),
    isread        varchar(1),
    pushdatetime  datetime,
    PRIMARY KEY (id)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
alter table org_organization  MODIFY COLUMN orgParentOrgId decimal(20);
insert  into `ezmobile_patchinfo`(`patch_Version`,`patch_Name`,`patch_Time`,`patch_editinfo`,`PATCH_EVO`,`isclientuse`) 
values ('1.2.4','1.2.4_webapp_20170731',sysdate(),'WanhuezOFFICE','0','0');












insert  into `ezmobile_patchinfo`(`patch_Version`,`patch_Name`,`patch_Time`,`patch_editinfo`,`PATCH_EVO`,`isclientuse`) 
values ('1.2.5','1.2.5_webapp_20170804',sysdate(),'WanhuezOFFICE','0','0');










insert  into `ezmobile_patchinfo`(`patch_Version`,`patch_Name`,`patch_Time`,`patch_editinfo`,`PATCH_EVO`,`isclientuse`) 
values ('1.2.6','1.2.6_webapp_20170814',sysdate(),'WanhuezOFFICE','0','0');
create table nk_shoes(
                        nk_location varchar2(50),
                        nk_item_code varchar2(50) primary key,
                        nk_item_name varchar2(50),
                        nk_series varchar2(50),
                        nk_size number(4),
                        nk_stock number(6)
                        );
create table nk_series(
                        nk_series varchar2(50),
                        nk_item_name varchar2(50),
                        nk_code varchar2(50)
                        );
insert into nk_series values('����ƽ�', '����ƽ�1', 'AM_01');
insert into nk_series values('����ƽ�', '����ƽ�2', 'AM_02');
insert into nk_series values('�ٿ�', '�����÷�', 'BM_01');
insert into nk_series values('�ٿ�', '���䰡����', 'BM_02');

select * from nk_shoes;
select * from nk_series;
--����ƽ�1: 01, ����ƽ�2: 02, �����÷�: 03, ���䰡����: 04
--230: 01, 235:02, 240:03, 245:04, 250:05, 255:06, 260:07, 265:08, 270:09, 275:10
insert into nk_shoes values ('����', '����_AM_01_03' ,'����ƽ�1', '����ƽ�', 240, 30);
insert into nk_shoes values ('����', '����_AM_01_04' ,'����ƽ�1', '����ƽ�', 245, 3);
insert into nk_shoes values ('�뱸', '�뱸_AM_01_05' ,'����ƽ�1', '����ƽ�', 250, 23);
insert into nk_shoes values ('�λ�', '�λ�_AM_01_09' ,'����ƽ�1', '����ƽ�', 270, 34);
insert into nk_shoes values ('�λ�', '�λ�_AM_01_05' ,'����ƽ�1', '����ƽ�', 250, 10);
insert into nk_shoes values ('���ֵ�', '���ֵ�_AM_02_01' ,'����ƽ�2', '����ƽ�', 230, 11);
insert into nk_shoes values ('����', '����_AM_02_09' ,'����ƽ�2', '����ƽ�', 270, 30);
insert into nk_shoes values ('����', '����_AM_02_03' ,'����ƽ�2', '����ƽ�', 240, 1);
insert into nk_shoes values ('����', '����_BM_01_03' ,'�����÷�', '�ٿ�', 240, 30);
insert into nk_shoes values ('�λ�', '�λ�_BM_01_10' ,'�����÷�', '�ٿ�', 275, 8);
insert into nk_shoes values ('����', '����_BM_01_06' ,'�����÷�', '�ٿ�', 255, 10);
insert into nk_shoes values ('����', '����_BM_02_07' ,'���䰡����', '�ٿ�', 260, 25);
insert into nk_shoes values ('��õ', '��õ_BM_02_07' ,'���䰡����', '�ٿ�', 260, 25);
insert into nk_shoes values ('����', '����_BM_02_03' ,'���䰡����', '�ٿ�', 240, 60);
insert into nk_shoes values ('����', '����_BM_02_01' ,'���䰡����', '�ٿ�', 230, 25);

commit;
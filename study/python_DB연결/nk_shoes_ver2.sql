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
insert into nk_series values('에어맥스', '에어맥스1', 'AM_01');
insert into nk_series values('에어맥스', '에어맥스2', 'AM_02');
insert into nk_series values('바우어만', '줌윈플로', 'BM_01');
insert into nk_series values('바우어만', '줌페가수스', 'BM_02');

select * from nk_shoes;
select * from nk_series;
--에어맥스1: 01, 에어맥스2: 02, 줌윈플로: 03, 줌페가수스: 04
--230: 01, 235:02, 240:03, 245:04, 250:05, 255:06, 260:07, 265:08, 270:09, 275:10
insert into nk_shoes values ('서울', '서울_AM_01_03' ,'에어맥스1', '에어맥스', 240, 30);
insert into nk_shoes values ('서울', '서울_AM_01_04' ,'에어맥스1', '에어맥스', 245, 3);
insert into nk_shoes values ('대구', '대구_AM_01_05' ,'에어맥스1', '에어맥스', 250, 23);
insert into nk_shoes values ('부산', '부산_AM_01_09' ,'에어맥스1', '에어맥스', 270, 34);
insert into nk_shoes values ('부산', '부산_AM_01_05' ,'에어맥스1', '에어맥스', 250, 10);
insert into nk_shoes values ('제주도', '제주도_AM_02_01' ,'에어맥스2', '에어맥스', 230, 11);
insert into nk_shoes values ('서울', '서울_AM_02_09' ,'에어맥스2', '에어맥스', 270, 30);
insert into nk_shoes values ('대전', '대전_AM_02_03' ,'에어맥스2', '에어맥스', 240, 1);
insert into nk_shoes values ('서울', '서울_BM_01_03' ,'줌윈플로', '바우어만', 240, 30);
insert into nk_shoes values ('부산', '부산_BM_01_10' ,'줌윈플로', '바우어만', 275, 8);
insert into nk_shoes values ('광주', '광주_BM_01_06' ,'줌윈플로', '바우어만', 255, 10);
insert into nk_shoes values ('서울', '서울_BM_02_07' ,'줌페가수스', '바우어만', 260, 25);
insert into nk_shoes values ('인천', '인천_BM_02_07' ,'줌페가수스', '바우어만', 260, 25);
insert into nk_shoes values ('포항', '포항_BM_02_03' ,'줌페가수스', '바우어만', 240, 60);
insert into nk_shoes values ('서울', '서울_BM_02_01' ,'줌페가수스', '바우어만', 230, 25);

commit;
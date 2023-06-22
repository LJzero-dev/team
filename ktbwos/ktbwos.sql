drop database ktbwos;
create database ktbwos;
use ktbwos;
create table t_admin_info (
   ai_idx int auto_increment unique,		-- 일련번호
   ai_id varchar(20) primary key,			-- 아이디
   ai_pw varchar(20) not null,				-- 암호
   ai_name varchar(20) not null,			-- 이름
   ai_use char(1) default 'y',				-- 사용여부
   ai_date datetime default now()			-- 등록일
);
insert into t_admin_info (ai_id, ai_pw, ai_name) values ('test1', '1234', 'admin');

create table t_member_info (
   mi_idx int auto_increment unique,		-- 일련번호
   mi_id varchar(20) primary key,			-- 아이디
   mi_email varchar(50) unique not null,	-- 이메일
   mi_nick varchar(20) unique not null,		-- 닉네임
   mi_pw varchar(20) not null,				-- 비밀번호
   mi_status char(1) default 'a',			-- 상태
   mi_reason varchar(200) not null,			-- 사유
   mi_self int default 0,					-- 본인 여부
   mi_date datetime default now(),			-- 가입일
   mi_count int default 0,					-- 게시글 작성수
   mi_lastlogin datetime					-- 최종로그인
);
select * from t_member_info;
insert into t_member_info (mi_id, mi_email, mi_nick, mi_pw, mi_reason) values ('test2', 'hong@naver.com', '홍길동', '2222', '신규가입');
insert into t_member_info (mi_id, mi_email, mi_nick, mi_pw, mi_reason) values ('test3', 'jeon@naver.com', '전우치', '3333', '신규가입');
insert into t_member_info (mi_id, mi_email, mi_nick, mi_pw, mi_reason) values ('test4', 'lim@naver.com', '임꺽정', '4444', '신규가입');

create table t_notice_list(
   nl_idx int auto_increment unique,		-- 글번호
   ai_idx int not null,						-- 관리자 번호
   nl_title varchar(50) not null,			-- 제목
   nl_content text not null,				-- 내용
   nl_read int default 0,					-- 조회수
   nl_date datetime default now(),			-- 작성일
   nl_isview char(1) default 'y',			-- 게시 여부
   constraint fk_notice_list_ai_idx foreign key(ai_idx) references t_admin_info(ai_idx)
);
insert into t_notice_list (ai_idx, nl_title, nl_content) values (1, '공지사항1', '공지사항 내용입니다.');
show tables;
-- drop table t_qna_list;
create table t_qna_list (
   ql_idx int primary key auto_increment,	-- 글번호
   mi_idx int not null,						-- 회원번호
   ql_title varchar(100) not null,			-- 질문 제목
   ql_content text not null,				-- 질문 내용
   ql_img1 varchar(50),						-- 이미지1
   ql_img2 varchar(50),						-- 이미지2
   ql_qdate datetime default now(),			-- 질문 일자
   ql_isanswer char(1) default 'n',			-- 답변 여부
   ai_idx int,								-- 답변 관리자
   ql_answer text,							-- 답변 내용
   ql_adate datetime,						-- 답변 일자
   ql_isview char(1) default 'y',			-- 게시 여부
    constraint fk_t_qna_list_mi_idx foreign key(mi_idx) references t_member_info(mi_idx),
    constraint fk_t_qna_list_ai_idx foreign key(ai_idx) references t_admin_info(ai_idx)
);

insert into t_qna_list (mi_id, ql_title, ql_content, ql_img1, ql_img2) values ('test2', '질문제목1', '질문내용1', '../pds/a.jpg', '../pds/b.jpg');

create table t_free_list (
   fl_idx int primary key auto_increment,	-- 글번호
   fl_ismem char(1) default 'y',			-- 회원 여부
   fl_writer varchar(20) not null,			-- 작성자
   fl_pw varchar(20),				-- 비밀번호
   fl_title varchar(100) not null,			-- 제목
   fl_content text not null,				-- 내용
   fl_reply int default 0,					-- 댓글 개수
   fl_read int default 0,					-- 조회수
   fl_ip varchar(15) not null,				-- IP 주소
   fl_isview char(1) default 'y',			-- 게시 여부
   fl_date datetime default now()			-- 작성일
);
alter table t_free_list modify fl_pw varchar(20); 	-- fl_pw 컬럼값을 varchar(20)만으로 가지게 수정

insert into t_free_list (fl_writer, fl_pw, fl_title, fl_content, fl_ip) values ('홍길동', '2222', '자유게시글1번 입니다', '자유게시글 내용 1번 입니다', '127.0.0.0');
insert into t_free_list (fl_ismem, fl_writer, fl_pw, fl_title, fl_content, fl_ip) values ('n', '임꺽정', null, '자유게시글2번 입니다', '자유게시글 내용 2번 입니다', '127.0.0.0');

select * from t_free_list;
-- drop table t_free_reply;
create table t_free_reply (
   fr_idx int primary key auto_increment,	-- 댓글 번호
   fr_writer varchar(20) not null,			-- 작성자
   fl_idx int not null,						-- 게시글번호
   fr_ismem char(1) default 'y',			-- 회원여부
   fr_pw varchar(20),						-- 비밀번호
   fr_content varchar(200) not null,		-- 내용
   fr_ip varchar(15) not null,				-- IP 주소
   fr_isview char(1) default 'y',			-- 게시 여부
   fr_date datetime default now(),			-- 작성일
    constraint fk_free_reply_fl_idx foreign key(fl_idx) references t_free_list(fl_idx)
);
select * from t_free_reply;
insert into t_free_reply (fl_idx, fr_writer, fr_content, fr_ip) values (1, '홍길동', '댓글 1번입니다.', '127.0.0.0');

drop table t_pds_list;
create table t_pds_list (
   pl_idx int primary key auto_increment,	-- 글번호
   ai_idx int not null,						-- 관리자번호
   pl_title varchar(50) not null,			-- 제목
   pl_content text not null,				-- 내용
   pl_data1 varchar(100) not null,			-- 파일1
   pl_data2 varchar(100),					-- 파일2
   pl_read int default 0,					-- 조회수
   pl_isview char(1) default 'y',			-- 게시 여부
   pl_date datetime default now(),			-- 작성일
    constraint fk_pds_list_ai_idx foreign key(ai_idx) references t_admin_info(ai_idx)
);

insert into t_pds_list (ai_idx, pl_title, pl_content, pl_data1, pl_data2) values (1, '자료글 1번글입니다.', '자료글 2번글입니다.', '../pds/c.png', '../pds/d.png');

drop table t_request_list;
select * from t_request_list;
create table t_request_list (
   rl_idx int primary key auto_increment,		-- 게시판 번호
   rl_ctgr char(1) default 'a',					-- 게시판 테마 분류
   rl_title varchar(50) not null,				-- 요청 제목
   rl_name varchar(50) unique not null,			-- 게시판 이름
   rl_writer varchar(20) not null,				-- 회원 닉네임
   rl_write char(1) not null,					-- 글작성 권한여부
   rl_reply_use char(1) not null,				-- 댓글 사용 여부
   rl_reply_write char(1),						-- 댓글 작성 권한
   rl_isview char(1) default 'y',				-- 글 노출 여부
   rl_table_name varchar(20),					-- 테이블 이름
   rl_status char(1) default 'a',				-- 승인여부
   rl_reason varchar(50),						-- 미승인사유
   rl_content text not null,					-- 요청 내용
   rl_date datetime default now()				-- 요청일
);

show tables;
select * from t_request_list;
select * from t_request_list  where 1=1  and rl_title like '%1%' order by rl_status ;
insert into t_request_list (rl_ctgr, rl_title, rl_name, rl_writer, rl_write, rl_reply_use, rl_reply_write, rl_content) values ('a', '홍길동 키우기 게시판 요청합니다', '홍길동 키우기', '전우치', 'y', 'y', 'y', '만들어 주세요');

-- drop table t_best_list;
select * from t_best_list;
create table t_best_list (
	bl_idx int primary key auto_increment,	-- 인기 게시판 일련번호
	bl_table_name varchar(20) not null,		-- 게시판 테이블 이름
	rl_name varchar(50) not null,			-- 게시판 이름
    bl_count int default 1,					-- 게시글 조회 회수
	bl_date datetime default now(),			-- 게시판 조회일
	constraint fk_best_list_rl_name foreign key(rl_name) references t_request_list(rl_name)
);
select * from t_best_list;
select * from t_request_list;
insert into t_best_list (bl_table_name, rl_name) values ('ball', '야구');
insert into t_best_list (bl_table_name, rl_name) values ('', '');
select bl_count from t_best_list where bl_table_name = 'ball' and date(bl_date) = date(now());
update t_best_list set bl_count = bl_count + 1 where bl_table_name = 'ball' and date(bl_date) = date(now());

select * from t_best_list;
select bl_date from t_best_list where bl_date < left(now(), 7) and bl_date > left(DATEADD(DAY, -10, now()), 7);

update t_member_info set mi_count = mi_count + 1 where mi_nick = '전우치';
select * from t_member_info;
-- 통합검색 tip
select * from (
	select * from t_baseball_list
    union
    select * from t_tree_list
) a where br_title like '%검색어%';

use ktbwos;
show tables;
select * from t_request_list;
show tables;
select * from t_member_info;
insert into t_member_info (mi_id,mi_email,mi_nick,mi_pw,mi_status,mi_reason) values ('date1','date1@naver.com','a홍','5555','b','신규');
insert into t_member_info (mi_id,mi_email,mi_nick,mi_pw,mi_status,mi_reason) values ('date2','date2@naver.com','b홍','6666','b','신규');
insert into t_member_info (mi_id,mi_email,mi_nick,mi_pw,mi_status,mi_reason) values ('date3','date3@naver.com','c홍','7777','c','신규');
insert into t_member_info (mi_id,mi_email,mi_nick,mi_pw,mi_status,mi_reason) values ('date4','date4@naver.com','d홍','8888','c','신규');
insert into t_member_info (mi_id,mi_email,mi_nick,mi_pw,mi_status,mi_reason) values ('date5','date5@naver.com','e홍','9999','c','신규');
select * from t_member_info   where mi_status = 'all' and mi_nick like '%꺽%';
select * from t_member_info   where mi_status != 'all' and mi_nick like '%꺽%';

select * from t_notice_list;
select * from t_admin_info;
insert into t_notice_list (ai_idx ,nl_title, nl_content) values ('1','공지 제목','공지 내용');

select * from t_request_list;
update t_request_list set rl_read = rl_read + 1 where rl_table_name = '';
select * from t_member_info;
select rl_ctgr, rl_name, rl_table_name from t_request_list where rl_status = 'y' order by rl_read desc limit 10;
select nl_idx, nl_title, date(nl_date) from t_notice_list;


update t_requset_list set rl_status = 'n', rl_title = '', rl_reason = '' where fr_idx ='';


select * from t_best_list;
select * from t_121212_list;
update t_best_list set bl_count = bl_count - '' where bl_table_name = '' and date(bl_date) = date('') ;


select * from t_request_list;
select * from t_best_list;
select * from t_ball_list;

select * from t_request_list;
show tables;


show tables;

select 121212_read from t_121212_list where 121212_idx = 1;




create table t_request_list (
   rl_idx int primary key auto_increment,		-- 게시판 번호
   rl_ctgr char(1) default 'a',					-- 게시판 테마 분류
   rl_title varchar(50) not null,				-- 요청 제목
   rl_name varchar(50) unique not null,			-- 게시판 이름
   rl_writer varchar(20) not null,				-- 회원 닉네임
   rl_write char(1) not null,					-- 글작성 권한여부
   rl_reply_use char(1) not null,				-- 댓글 사용 여부
   rl_reply_write char(1),						-- 댓글 작성 권한
   rl_isview char(1) default 'y',				-- 글 노출 여부
   rl_table_name varchar(20),					-- 테이블 이름
   rl_status char(1) default 'a',				-- 승인여부
   rl_reason varchar(50),						-- 미승인사유
   rl_content text not null,					-- 요청 내용
   rl_date datetime default now()				-- 요청일
);

create table t_best_list (
	bl_idx int primary key auto_increment,	-- 인기 게시판 일련번호
	bl_table_name varchar(20) not null,		-- 게시판 테이블 이름
	rl_name varchar(50) not null,			-- 게시판 이름
    bl_count int default 1,					-- 게시글 조회 회수
	bl_date datetime default now(),			-- 게시판 조회일
	constraint fk_best_list_rl_name foreign key(rl_name) references t_request_list(rl_name)
);

select a.rl_ctgr, a.rl_name, a.rl_table_name
from t_request_list a inner join t_best_list b on a.rl_table_name = b.bl_table_name
where a.rl_status = 'y' and date(b.bl_date) > date_add(date(now()), interval -30 day)
group by a.rl_ctgr, a.rl_name, a.rl_table_name order by sum(b.bl_count) desc;


select * from t_member_info;
select * from t_qna_list;




select * from t_request_list;




select rl_name from t_request_list where rl_table_name = '';






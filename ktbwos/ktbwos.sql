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
   mi_idx int auto_increment unique,		-- 회원번호
   mi_id varchar(20) primary key,			-- 아이디
   mi_email varchar(50) unique not null,	-- 이메일
   mi_nick varchar(20) unique not null,		-- 닉네임
   mi_pw varchar(20) not null,				-- 비밀번호
   mi_status char(1) default 'a',			-- 상태
   mi_reason varchar(200) not null,			-- 사유
   mi_self int default 0,					-- 본인 여부
   mi_count int default 0,					-- 게시글 작성개수
   mi_date datetime default now(),			-- 가입일
   mi_lastlogin datetime					-- 최종로그인
);
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

-- drop table t_qna_list;
create table t_qna_list (
   ql_idx int primary key auto_increment,	-- 글번호
   mi_idx int not null,						-- 회원 번호
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

insert into t_qna_list (mi_idx, ql_title, ql_content, ql_img1, ql_img2) values (1, '질문제목1', '질문내용1', '../pds/a.jpg', '../pds/b.jpg');

create table t_free_list (
   fl_idx int primary key auto_increment,	-- 글번호
   fl_ismem char(1) default 'y',			-- 회원 여부
   fl_writer varchar(20) not null,			-- 작성자
   fl_pw varchar(20) not null,				-- 비밀번호
   fl_title varchar(100) not null,			-- 제목
   fl_content text not null,				-- 내용
   fl_reply int default 0,					-- 댓글 개수
   fl_read int default 0,					-- 조회수
   fl_ip varchar(15) not null,				-- IP 주소
   fl_isview char(1) default 'y',			-- 게시 여부
   fl_date datetime default now()			-- 작성일
);

insert into t_free_list (fl_writer, fl_pw, fl_title, fl_content, fl_ip) values ('홍길동', '2222', '자유게시글1번 입니다', '자유게시글 내용 1번 입니다', '127.0.0.0');

-- drop table t_free_reply;
create table t_free_reply (
   fr_idx int primary key auto_increment,	-- 댓글 번호
   fl_idx int not null,						-- 게시글번호
   mi_idx int not null,						-- 회원 번호
   fr_content varchar(200) not null,		-- 내용
   fr_ip varchar(15) not null,				-- IP 주소
   fr_isview char(1) default 'y',			-- 게시 여부
   fr_date datetime default now(),			-- 작성일
    constraint fk_free_reply_mi_idx  foreign key(mi_idx) references t_member_info(mi_idx)
);

insert into t_free_reply (fl_idx, mi_idx, fr_content, fr_ip) values (1, 1, '댓글 1번입니다.', '127.0.0.0');



drop table t_pds_list;
create table t_pds_list (
   pl_idx int primary key auto_increment,	-- 글번호
   ai_idx int not null,						-- 관리자 번호
   pl_title varchar(50) not null,			-- 제목
   pl_content text not null,				-- 내용
   pl_data1 varchar(100) not null,			-- 파일1
   pl_data2 varchar(100),					-- 파일2
   pl_read int default 0,					-- 조회수
   pl_date datetime default now(),			-- 작성일
    constraint fk_pds_list_ai_idx foreign key(ai_idx) references t_admin_info(ai_idx)
);

insert into t_pds_list (ai_idx, pl_title, pl_content, pl_data1, pl_data2) values (1, '자료글 1번글입니다.', '자료글 2번글입니다.', '../pds/c.png', '../pds/d.png');

drop table t_request_list;
create table t_request_list (
   rl_idx int primary key auto_increment,		-- 게시판 번호
   rl_ctgr char(1) default 'a',					-- 게시판 테마 분류
   rl_title varchar(50) not null,				-- 요청 제목
   rl_name varchar(50) unique not null,			-- 게시판 이름
   rl_writer varchar(20) not null,						-- 회원 닉네임
   rl_write char(1) not null,					-- 글작성 권한여부
   rl_reply_use char(1) not null,				-- 댓글 사용 여부
   rl_reply_write char(1),						-- 댓글 작성 권한
   rl_table_name varchar(20),					-- 테이블 이름
   rl_status char(1) default 'a',				-- 승인여부
   rl_reason varchar(50),						-- 미승인사유
   rl_content text not null,					-- 요청 내용
   rl_date datetime default now()				-- 요청일
);

insert into t_request_list (rl_ctgr, rl_title, rl_name, rl_writer, rl_write, rl_reply_use, rl_reply_write, rl_content) values ('a', '홍길동 키우기 게시판 요청합니다', '홍길동 키우기', '전우치', 'y', 'y', 'y', '만들어 주세요');
select * from t_request_list;


drop table t_best_list;

create table t_best_list (
	bl_idx int primary key auto_increment,	-- 인기 게시판 일련번호
	rl_idx int not null,					-- 게시판 번호
	rl_name varchar(50) not null,			-- 게시판 이름
	bl_count int default 0,					-- 게시글 조회수 합
	bl_date datetime default now(),			-- 게시판 조회일
    constraint fk_best_list_rl_idx foreign key(rl_idx) references t_request_list(rl_idx),
    constraint fk_best_list_rl_name foreign key(rl_name) references t_request_list(rl_name)
);



select bl_date from t_best_list where bl_date < left(now(), 7) and bl_date > left(DATEADD(DAY, -10, now()), 7);







show tables;
-- 통합검색 tip
select * from (
	select * from t_baseball_list
    union
    select * from t_tree_list
) a where br_title like '%검색어%';

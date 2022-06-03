CREATE SEQUENCE board_num;

CREATE TABLE board_tbl (
    bno number(10, 0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

drop table board_tbl;

alter table board_tbl add constraint pk_board primary key(bno);

insert into board_tbl (bno, title, content, writer) values (board_num.nextval, '테스트글', '테스트본문', '글쓴이');
insert into board_tbl (bno, title, content, writer) values (board_num.nextval, '1등이다', '1등으로 글적었다', '신동호');
insert into board_tbl (bno, title, content, writer) values (board_num.nextval, '2등이다', '이상하게 2등이다', '관리자');

commit;

SELECT * FROM board_tbl;

DELETE FROM board_tbl WHERE bno = 9;

alter sequence board_num nocache;

UPDATE board_tbl SET title = '첫글', content = '첫번째 테스트', writer = '왜안되는거임?', updatedate = SYSDATE WHERE bno = 1;

commit;
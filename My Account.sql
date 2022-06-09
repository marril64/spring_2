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

insert into board_tbl (bno, title, content, writer) values (board_num.nextval, '�׽�Ʈ��', '�׽�Ʈ����', '�۾���');
insert into board_tbl (bno, title, content, writer) values (board_num.nextval, '1���̴�', '1������ ��������', '�ŵ�ȣ');
insert into board_tbl (bno, title, content, writer) values (board_num.nextval, '2���̴�', '�̻��ϰ� 2���̴�', '������');

commit;

SELECT * FROM board_tbl;

SELECT MIN(bno) FROM board_tbl;

DELETE FROM board_tbl WHERE bno = 9;

alter sequence board_num nocache;

UPDATE board_tbl SET title = 'ù��', content = 'ù��° �׽�Ʈ', writer = '�־ȵǴ°���?', updatedate = SYSDATE WHERE bno = 1;

commit;

insert into board_tbl (bno, title, content, writer)
(select board_num.nextval, title, content, writer from board_tbl);

commit;

SELECT count(*) FROM board_tbl;

SELECT
/*+ INDEX_DESC(board_tbl pk_board) */
rownum, rowid, board_tbl.* FROM board_tbl;

select * from
(select /*+ INDEX_DESC(board_tbl pk_board) */
rownum rn, board_tbl.* from board_tbl where rownum <= (5*10))
    where rn > (5-1)*10;

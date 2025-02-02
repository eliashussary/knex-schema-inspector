create user db_test identified by db_test;
alter session set current_schema = db_test;

create table teams (
  id number(10) not null primary key,
  uuid char(36) not null,
  name varchar2(100),
  description clob,
  credits number(10),
  created_at timestamp(0),
  activated_at date,
  constraint uuid unique (uuid)
);

-- Generate ID using sequence and trigger
create sequence teams_seq start with 1 increment by 1;

create or replace trigger teams_seq_tr
 before insert on teams for each row
 when (new.id is null)
begin
 select teams_seq.nextval into :new.id from dual;
end;
/

create table users (
  id number(10) not null primary key,
  team_id number(10) not null,
  email varchar2(100),
  password varchar2(60),
  constraint fk_team_id
    foreign key (team_id)
    references teams (id)
);

-- Generate ID using sequence and trigger
create sequence users_seq start with 1 increment by 1;

create or replace trigger users_seq_tr
  before insert on users for each row
  when (new.id is null)
begin
  select users_seq.nextval into :new.id from dual;
end;
/

create table page_visits (
  request_path varchar2(100),
  user_agent varchar2(200),
  created_at timestamp(0)
);

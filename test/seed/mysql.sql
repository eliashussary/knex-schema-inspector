create table teams (
  id int not null auto_increment primary key,
  uuid char(36) not null,
  name varchar(100),
  description text,
  credits integer(11) comment "Remaining usage credits",
  created_at datetime,
  activated_at date,
  unique key uuid (uuid)
);

create table users (
  id int not null auto_increment primary key,
  team_id int not null,
  email varchar(100),
  password varchar(60),
  constraint fk_team_id
    foreign key (team_id)
    references teams (id)
);

-- One table without a primary key
create table page_visits (
  request_path varchar(100),
  user_agent varchar(200),
  created_at datetime
);

-----------------------------
-- 1.0
-----------------------------
--Aidan Harrington

-----------------------------
-- 1.1
-----------------------------
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='a1_auditions')
DROP TABLE a1_auditions
go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='a1_actors')
DROP TABLE a1_actors
go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='a1_roles')
DROP TABLE a1_roles
go

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='a1_ranges')
DROP TABLE a1_ranges 
go

-----------------------------
-- 1.2
-----------------------------

create table a1_actors(
actor_id int not null,
actor_firstname varchar(20) not null,
actor_lastname varchar(20) not null,
actor_birthdate date null,
actor_range varchar(20) null,
actor_can_dance bit null default 0
)

GO

-----------------------------
-- 1.3
-----------------------------
create table a1_auditions(
audition_id int identity (1,1) not null,
audition_date date null,
audition_show varchar(20) not null,
audition_city varchar(20) not null default '0',
audition_theater varchar(20) not null,
audition_actor_id int not null,
audition_role_id int not null
)
GO

-----------------------------
-- 1.4
-----------------------------
create table a1_ranges(
vocal_range varchar(20) not null
)


GO

-----------------------------
-- 1.5
-----------------------------
create table a1_roles(
role_id int identity (1,1) not null,
role_name varchar(20) not null

)

GO



-----------------------------
-- 2.1
-----------------------------
alter table a1_actors
add
constraint pk_a1_actor_id primary key (actor_id),
constraint u_a1_actor_id unique (actor_id)
--I'm aware that this unique key isn't on the instructions, but the instructions also say this must be a unique integer, but not a surrogate key, so I'm doing it
GO

-----------------------------
-- 2.2
-----------------------------
alter table a1_auditions
add
constraint pk_a1_audition_id primary key(audition_id)
GO

-----------------------------
-- 2.3
-----------------------------
alter table a1_ranges
add
constraint pk_a1_vocal_range primary key(vocal_range)
GO

-----------------------------
-- 2.4
-----------------------------
alter table a1_roles
add
constraint pk_a1_role_id primary key(role_id),
constraint u_role_name unique(role_name)
GO

-----------------------------
-- 3.1
-----------------------------
alter table a1_actors
add
constraint fk_actor_range foreign key(actor_range) references a1_ranges(vocal_range)


GO

-----------------------------
-- 3.2
-----------------------------
alter table a1_auditions
add
constraint fk_audition_actor_id foreign key(audition_actor_id) references a1_actors(actor_id),
constraint fk_audition_role_id foreign key(audition_role_id) references a1_roles(role_id)

GO

-----------------------------
-- 4
-----------------------------

-- nothing to code here - don't forget your database diagram


-----------------------------
-- 5.1
-----------------------------
insert into a1_roles(role_name)
values
('Cinderella'), 
('Evil Stepmother'), 
('Fairy Godmother'), 
('Prince Charming')
	
GO

-----------------------------
-- 5.2
-----------------------------
insert into a1_ranges(vocal_range)
values
('alto'),
('bass'),
('soprano'),
('tenor')

GO

-----------------------------
-- 5.3
-----------------------------	
insert into a1_actors(
actor_id, 
actor_firstname, 
actor_lastname, 
actor_birthdate, 
actor_range, 
actor_can_dance)
values
(101, 'Harry', 'Stylus', '02/01/1994', 'tenor', 1),
(102, 'Taylor', 'Swiffer', '12/13/1989', 'alto', 0),
(103, 'Flo', 'Miller', '01/09/2000', 'tenor', 1),
(104, 'Hannah', 'Dakota', '11/23/1992', 'alto', 1),
(105, 'Tyler', 'theDestroyer', '03/06/1991', 'bass', 0),
(106, 'Doja', 'Dog', '10/21/1995', 'soprano', 1)


GO

-----------------------------
-- 5.4
-----------------------------	
insert into a1_auditions(
audition_date,
audition_show,
audition_city,
audition_theater,
audition_actor_id,
audition_role_id)
values
('11/07/2022','Cinderella', 'New York City', 'Lincoln Center', 101, 1),
('11/14/2022','Cinderella', 'Chicago', 'Chicago Theatre', 102, 2),
('11/21/2022','Cinderella', 'New York City', 'Lincoln Center', 103, 3),
('11/21/2022','Cinderella', 'Boston', 'The Wilbur', 104, 4),
('11/28/2022','Cinderella', 'Boston', 'Boch Center', 105, 2),
('11/28/2022','Cinderella', 'New York City', 'Broadway Theatre', 106, 1)


GO

-----------------------------
-- 6.1
-----------------------------
select actor_firstname + ' ' + actor_lastname as actor_name, actor_birthdate, actor_range, audition_show, audition_city, audition_theater, role_name
from a1_actors
join a1_auditions on actor_id=audition_actor_id
join a1_roles on role_id=audition_role_id


GO

-----------------------------
-- 6.2
-----------------------------
select COUNT(audition_actor_id) as audition_count, role_name
from a1_auditions
join a1_roles on role_id=audition_role_id
group by role_name
 

GO

				



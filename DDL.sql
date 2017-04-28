/*
Ashish Patel
Pleasantville Community Theater part4
*/



/*drop table queries*/

DROP TABLE Ticket CASCADE CONSTRAINTS;
DROP TABLE Donation CASCADE CONSTRAINTS;
DROP TABLE Ticket_Sale CASCADE CONSTRAINTS;
DROP TABLE Performance CASCADE CONSTRAINTS;
DROP TABLE duesPayment CASCADE CONSTRAINTS;
DROP TABLE Subscriber CASCADE CONSTRAINTS;
DROP TABLE production CASCADE CONSTRAINTS;
DROP TABLE Sponsor CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE Play CASCADE CONSTRAINTS;
DROP TABLE Zips CASCADE CONSTRAINTS;

/*Level 1
Zips, play
*/
Create table Zips (
z_zip number(5),
Z_street varchar2(30),
Z_city varchar2(30),
Z_state varchar2(2),
CONSTRAINT Zips_z_zip_pk PRIMARY KEY (z_zip)
);

create table Play(
p_title varchar2(30),
p_author varchar2(30),
p_numberOfActs number(3),
p_setChanges varchar2(20),
CONSTRAINT Play_p_title_pk PRIMARY KEY (p_title));

/*Level 2
member,sponsor,subscriber, prod, duesPayment
*/

create table member(
m_mem_id number(5),
m_f_name varchar2(30),
m_l_name varchar2(30),
m_date_joined date,
z_zip number(5),
m_area_code varchar2(3),
m_phone_number varchar2(8),
m_current_office_held varchar2(30),
CONSTRAINT Member_m_mem_id_pk PRIMARY KEY (m_mem_id),
CONSTRAINT Member_z_zip_fk FOREIGN KEY (z_zip) REFERENCES Zips(z_zip)
);

create table Sponsor(
s_spon_id number(5),
s_name varchar2(30),
z_zip number(5),
s_area_code varchar2(3),
s_phone_number varchar2(7),
CONSTRAINT Sponsor_s_spon_id_pk PRIMARY KEY (s_spon_id),
CONSTRAINT Sponsor_z_zip_fk FOREIGN KEY (z_zip) REFERENCES zips(z_zip)
);

create table production(
pd_prod_id number(5),
pd_start_date DATE,
p_title varchar2(30),
pd_end_date date,
pd_prod_year number(4),
CONSTRAINT production_p_title_fk FOREIGN KEY (p_title) REFERENCES Play(p_title),
CONSTRAINT production_pd_prod_id_pk PRIMARY KEY(pd_prod_id)
);

create table Subscriber (
sb_sub_id number(5),
sb_f_name varchar2(30),
sb_l_name varchar2(30),
z_zip number(5),
sb_area_code number(3),
sb_phone_number number(7),
CONSTRAINT Subscriber_sb_sub_id_pk PRIMARY KEY (sb_sub_id),
CONSTRAINT Subscriber_z_zip_fk FOREIGN KEY (z_zip) REFERENCES Zips(z_zip)
);

create table duesPayment(
dp_dues_year varchar2(30),
dp_amount varchar2(30),
dp_date_paid date,
m_mem_id number(5), 
CONSTRAINT duesPayment_m_mem_id_fk foreign key (m_mem_id) REFERENCES member(m_mem_id),
CONSTRAINT duesPayment_pk Primary KEY(dp_dues_year,m_mem_id));
  
 
/*Level 3
 performance
*/

create table Performance(
pm_perf_id number(5),
pd_prod_id number(5),
pm_date_time date,
CONSTRAINT Performance_pm_perf_id_pk PRIMARY KEY (pm_perf_id),
CONSTRAINT Performance_pd_prod_id_fk FOREIGN KEY (pd_prod_id) REFERENCES production(pd_prod_id)
);

/*Level 4
ticket_sale, donation, member-prod
*/

create table ticket_sale(
ts_sale_id number(10),
ts_sale_date date,
ts_total_amount number(7),
pm_perf_id number(5),
pd_prod_id number(5),
sb_sub_id number(5),
CONSTRAINT ticket_sale_ts_sale_id_pk  PRIMARY KEY (ts_sale_id),
CONSTRAINT ticket_sale_pd_prod_id_fk FOREIGN KEY (pd_prod_id) REFERENCES production(pd_prod_id),
CONSTRAINT ticket_sale_pm_perf_id_fk FOREIGN KEY (pm_perf_id) REFERENCES performance(pm_perf_id),
CONSTRAINT ticket_sale_sb_sub_id_fk FOREIGN KEY (sb_sub_id) REFERENCES subscriber(sb_sub_id)
);

create table donation (
s_spon_id number(5) CONSTRAINT donations_spon_id_fk REFERENCES sponsor(s_spon_id),
d_date date,
d_type varchar2(30),
d_value varchar2(30),
pd_prod_id number(5),
CONSTRAINT donation_pd_prod_id_fk FOREIGN KEY (pd_prod_id) REFERENCES production(pd_prod_id),
CONSTRAINT donation_pk PRIMARY KEY(d_date,s_spon_id)
);

/*level 5  ticket*/
create table ticket(
ts_sale_id number(10),
t_seat_loc varchar2(10),
t_price varchar2(30),
t_type varchar2(30),
CONSTRAINT ticket_ts_sale_id_fk FOREIGN KEY (ts_sale_id)REFERENCES ticket_sale(ts_sale_id),
CONSTRAINT ticket_pk PRIMARY KEY (t_seat_loc,ts_sale_id)
);


/*
zips data
*/

insert into zips values (32308,'9815 circle dr','Tallahasse','FL');
insert into zips values (42180,'172 Alto Park','Seattle','WA');
insert into zips values (51875,'850 East Main','Santa Ana','CA');
insert into zips values (11795,'994 Kirkman Road','Northpoint','NY');
insert into zips values (37812,'194 College Blvd','Newton','GA');
insert into zips values (37822,'123 Stans Drive','Hartford','CN');
insert into zips values (57812,'518 Garfield Ave','Danbury','AZ');
insert into zips values (86524,'648 Firefile Road','Bristol','NC');


/*
Play Data
*/

insert into play values ('Hamlet','William Shakspeare',10,'columbo');
insert into play values ('Macbeth','William Shakspeare',5,'clybourne park');
insert into play values ('Romeo and Juliet','William Shakspeare',15,'The price is right');
insert into play values ('Waiting for Godot','Samuel Beckett',7,'columbo');
insert into play values ('A Doll''s House','Henrik Ibsen',3,'mills park');

/*member data
*/
insert into member values (12345,'Neal','Graham',TO_DATE('12/10/2006','mm/dd/yyyy'),51875,'904','5551897','Jacksonville');
insert into member values (23456,'Myra','Sanchez',TO_DATE('8/14/2004','mm/dd/yyyy'),32308,'418','5684977','Samson');
insert into member values (34567,'Lisa','Smith',TO_DATE('11/10/2004','mm/dd/yyyy'),51875,'482','4521364','Surat');
insert into member values (45678,'Paul','Lewis',TO_DATE('12/10/2005','mm/dd/yyyy'),42180,'658','4598775','Noida');
insert into member values (56789,'Thomas','James',TO_DATE('12/10/2005','mm/dd/yyyy'),11795,'482','7845213','Colosa');

/*sponsor data
*/
insert into sponsor values (85469,'Red Chilli',37822,'847','5984671');
insert into sponsor values (63254,'Sony',86524,'877','4125845');
insert into sponsor values (86457,'The Walt Disney Company',37822,'784','3546872');
insert into sponsor values (46853,'Viacom',57812,'937','8846975');
insert into sponsor values (29865,'NBCUniversal',865244,'998','7659842');

/*production data*/

insert into production values(64587,TO_DATE('06/12/2004', 'mm/dd/yyyy'),'Macbeth',TO_DATE('12/12/2004', 'mm/dd/yyyy'),2004);
insert into production values(64857,TO_DATE('08/13/2006', 'mm/dd/yyyy'),'Hamlet',TO_DATE('12/13/2006', 'mm/dd/yyyy'),2006);
insert into production values(64578,TO_DATE('05/14/2007', 'mm/dd/yyyy'),'Macbeth',TO_DATE('12/14/2007', 'mm/dd/yyyy'),2007);
insert into production values(64875,TO_DATE('04/15/2005', 'mm/dd/yyyy'),'Romeo and Juliet',TO_DATE('12/15/2005', 'mm/dd/yyyy'),2005);
insert into production values(64758,TO_DATE('10/25/2006', 'mm/dd/yyyy'),'Waiting for Godot',TO_DATE('12/16/2006', 'mm/dd/yyyy'),2006);


/*subscriber data*/
insert into subscriber values(43568,'Shella','winterson',32308,'586','4857694');
insert into subscriber values(43685,'Kelly','Shen',42180,'586','4857695');
insert into subscriber values(43865,'Cella','Seth',51875,'586','4857696');
insert into subscriber values(43658,'Judi','Mia',11795,'586','4857697');
insert into subscriber values(43856,'Alie','Pear',42180,'586','4857698');


/*duespayment data*/
insert into duespayment values('2005,2006','1000',TO_DATE('8/14/2004', 'mm/dd/yyyy'),23456);
insert into duespayment values('2004,2005','2000',TO_DATE('12/10/2006','mm/dd/yyyy'),12345);
insert into duespayment values('2005','3000',TO_DATE('12/10/2004','mm/dd/yyyy'),34567);
insert into duespayment values('2005,2007','1000',TO_DATE('12/10/2005','mm/dd/yyyy'),56789);
insert into duespayment values('2005,2006','2000',TO_DATE('12/10/2005','mm/dd/yyyy'),45678);


/*performance data*/
insert into performance values(56846,64587,TO_DATE('04/12/2005 10:00', 'mm/dd/yyyy hh24:mi'));
insert into performance values(56468,64857,TO_DATE('05/12/2007 11:15', 'mm/dd/yyyy hh24:mi'));
insert into performance values(56684,64578,TO_DATE('06/12/2008 12:30', 'mm/dd/yyyy hh24:mi'));
insert into performance values(56864,64875,TO_DATE('07/12/2005 01:45', 'mm/dd/yyyy hh24:mi'));
insert into performance values(56648,64758,TO_DATE('08/12/2006 02:00', 'mm/dd/yyyy hh24:mi'));


/*ticket sale data*/
insert into ticket_sale values (78945,TO_DATE('01/01/2005', 'mm/dd/yyyy'),'100',56846,64587,43568);
insert into ticket_sale values (78459,TO_DATE('03/23/2007', 'mm/dd/yyyy'),'200',56468,64857,43685);
insert into ticket_sale values (78594,TO_DATE('02/20/2008', 'mm/dd/yyyy'),'300',56684,64578,43865);
insert into ticket_sale values (78954,TO_DATE('05/11/2005', 'mm/dd/yyyy'),'100',56864,64875,43658);
insert into ticket_sale values (78495,TO_DATE('08/01/2006', 'mm/dd/yyyy'),'200',56648,64758,43856);

/*donation data*/
insert into donation values (85469,TO_DATE('8/14/2002', 'mm/dd/yyyy'),'Cash','10000',64587);
insert into donation values (63254,TO_DATE('5/1/2003', 'mm/dd/yyyy'),'Check','30000',64857);
insert into donation values (86457,TO_DATE('2/12/2001', 'mm/dd/yyyy'),'Good','Clothes',64578);
insert into donation values (46853,TO_DATE('11/25/2004', 'mm/dd/yyyy'),'Cash','10000',64875);
insert into donation values (29865,TO_DATE('6/29/2002', 'mm/dd/yyyy'),'Service','Free Food',64758);


/*ticket data*/
insert into ticket values (78945,'T125','100','silver');
insert into ticket values (78459,'C85','200','Gold');
insert into ticket values (78594,'A10','300','Platinum');
insert into ticket values (78954,'Z150','100','silver');
insert into ticket values (78495,'E100','200','Gold');


select * from ticket;

select pm_date_time from performance;










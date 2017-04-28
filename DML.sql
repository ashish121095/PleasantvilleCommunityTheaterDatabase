/*
Ashish Patel
s29
project_phase5
*/

/* Q-1-a 
Request: select ticket price and average ticket prive as Avg ticket price with group by function.
*/
select t_price, TRUNC(AVG(t_price),2) "Avg ticket price" from ticket where t_price not like '_0%' group by t_price;

/*Q-1-b
Request: select members who has due amount more than 1000 with due amount and their member id in an accending order of member id.
*/
select dp_amount , m_mem_id from DUESPAYMENT group by dp_amount, m_mem_id having DP_AMOUNT > 1000 order by m_mem_id;

/*Q-1-c with 2 tables
I don't have three related tables so I have used inner join with two tables.
Request: select member's first and last name who has due amount more than 1000 from member table based on member id 
*/
select m_f_name as first_name, m_l_name as last_name, dp_amount 
  from member,duespayment  
  where member.m_mem_id = duespayment.m_mem_id and dp_amount > 1000 order by dp_amount;

/*Q-1-d
Request: select sponsor's name and donation value in money based on sponsor id using full outer join query
*/
select s_spon_id,s_name,d_type,d_value from s29.sponsor left outer join s29.donation using (s_spon_id) where pd_prod_id is not null;
	
/*Q-1-e
Request: display member's first name with lower case and last name with upper case
*/
SELECT * FROM member WHERE SOUNDEX(m_f_name) = SOUNDEX('Neal') order by m_mem_id; 

/*Q-1-f
Request: display ticket sale id and ticket sale date from ticket sale where ticket sale is made for specific production id and performance id
is equal to subscriber id 43685. This has been achieved by using two sub-queries.
*/
select ts_sale_id, ts_sale_date from ticket_sale 
  where ticket_sale.pd_prod_id = 
  (select ticket_sale.PD_PROD_ID from TICKET_SALE where sb_sub_id = 43685)
  and PM_PERF_ID = (select TICKET_SALE.PM_PERF_ID from ticket_sale where SB_SUB_ID = 43685);
	
	
/*Q-2 with View 
I have created view of member's first name, last name and date joined to select experienced members according to play.
*/	
CREATE VIEW V_Member
AS SELECT m_f_Name, m_l_Name, m_date_joined
FROM member;

select * from v_member;

/* -------------------------------------------------------THIS IS OPTIONAL--------------------------------------------------------------------------------
Q-2 with index
I have created index for p_title and p_author to see which play has been written by which author. This becomes very useful with large amount of data.
*/	
create index play_index on  play (p_title,p_author); 

select p_author, p_title from play;


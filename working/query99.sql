-- start query 99 in stream 0 using template query99.tpl
--\timing on

SELECT  
   substring("w_warehouse_name",1,20)
  ,"sm_type"
  ,"cc_name"
  ,sum(case when ("cs_ship_date_sk" - "cs_sold_date_sk" <= 30 ) then 1 else 0 end)  as "30 days" 
  ,sum(case when ("cs_ship_date_sk" - "cs_sold_date_sk" > 30) and 
                 ("cs_ship_date_sk" - "cs_sold_date_sk" <= 60) then 1 else 0 end )  as "31-60 days" 
  ,sum(case when ("cs_ship_date_sk" - "cs_sold_date_sk" > 60) and 
                 ("cs_ship_date_sk" - "cs_sold_date_sk" <= 90) then 1 else 0 end)  as "61-90 days" 
  ,sum(case when ("cs_ship_date_sk" - "cs_sold_date_sk" > 90) and
                 ("cs_ship_date_sk" - "cs_sold_date_sk" <= 120) then 1 else 0 end)  as "91-120 days" 
  ,sum(case when ("cs_ship_date_sk" - "cs_sold_date_sk"  > 120) then 1 else 0 end)  as ">120 days" 
FROM
   "catalog_sales"
  ,"warehouse"
  ,"ship_mode"
  ,"call_center"
  ,"date_dim"
WHERE
    "d_month_seq" between 1223 and 1223 + 11
and "cs_ship_date_sk"   = "d_date_sk"
and "cs_warehouse_sk"   = "w_warehouse_sk"
and "cs_ship_mode_sk"   = "sm_ship_mode_sk"
and "cs_call_center_sk" = "cc_call_center_sk"
GROUP BY
   substring("w_warehouse_name",1,20)
  ,"sm_type"
  ,"cc_name"
ORDER BY substring("w_warehouse_name",1,20)
        ,"sm_type"
        ,"cc_name"
LIMIT 100;

--\timing off
-- end query 99 in stream 0 using template query99.tpl
-- done

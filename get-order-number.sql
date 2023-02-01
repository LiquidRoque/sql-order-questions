With a as (
SELECT
T1.id AS "User_ID",
T2."createdAt" AS "Order Date",
T2.status AS "Status",
Row_number() over (partition by T2."userId" order by T2."createdAt") as ordernumber
from "public"."user" AS T1
LEFT JOIN "public"."ordering" AS T2 ON (T2."userId" = T1.id)
GROUP BY T2."createdAt",t2."userId",T1.id, T2.status
)

Select * from a where ordernumber=1
AND "Status" = 'delivered'
Order by a."Order Date",ordernumber

-- requires upper bound. runs like a dog
declare @a int = 1
declare @b int = 4
declare @maxdepth int = 5
;
with paths as (
    select 0 as rownum, n
    from (
        values ( @a )
    ) as seed (n)

    UNION ALL
     
    select rownum + 1
         , up.value as n
	from (
		select rownum , n * 2 as dub, n+2 as add2, case when (n / 2) * 2 = n then n / 2 else null end as half
		from paths as a
		where rownum < @maxdepth
	) as a
	unpivot( value for field in ( dub, add2, half ) ) as up
)
select min(paths.rownum) as answer
from paths
where n = @b

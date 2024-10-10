
select *
from world_layoffs.layoffs_staging;

with duplicate_cte as (
select *,
ROW_NUMBER() OVER(
partition by ls.company, ls.location, ls.industry, ls.total_laid_off, ls.percentage_laid_off, ls.`date`, ls.stage, ls.country, ls.funds_raised_millions) as row_num
from world_layoffs.layoffs_staging ls
)

select *
from world_layoffs.layoffs_staging2 ls;

select distinct industry
from world_layoffs.layoffs_staging2 ls
order by 1;

select *
from world_layoffs.layoffs_staging2 
where company like 'Airbnb%';

select t1.company, t1.industry
from world_layoffs.layoffs_staging2 t1
where t1.company like 'Bally_s Interactive';


select t1.industry, t2.industry
from world_layoffs.layoffs_staging2 t1
join world_layoffs.layoffs_staging2 t2
	on t1.company = t2.company 
    and t1.location = t2.location
where (t1.industry = '' or t1.industry is null)
and not(t2.industry = '' or t2.industry is null);

update world_layoffs.layoffs_staging2 t1
join world_layoffs.layoffs_staging2 t2
	on t1.company = t2.company 
    and t1.location = t2.location
set t1.industry = t2.industry
where (t1.industry = '' or t1.industry is null)
and not(t2.industry = '' or t2.industry is null)
;

select *
from world_layoffs.layoffs_staging2 t1
where t1.total_laid_off is null and t1.percentage_laid_off is null;

select * 
from world_layoffs.layoffs_staging2 t1
;

alter table layoffs_staging2
drop column row_num;



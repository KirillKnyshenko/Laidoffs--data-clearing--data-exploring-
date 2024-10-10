-- Анализ дата сета

select *
from world_layoffs.layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from world_layoffs.layoffs_staging2;

select *
from world_layoffs.layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc;

select company, sum(total_laid_off)
from world_layoffs.layoffs_staging2
group by company
order by 2 desc;

select industry, sum(total_laid_off)
from world_layoffs.layoffs_staging2
group by industry
order by 2 desc;

select country, sum(total_laid_off) as sum_laidoffs
from world_layoffs.layoffs_staging2
group by country
having sum_laidoffs is not null
order by 2 desc;

select YEAR(`date`), sum(total_laid_off)
from world_layoffs.layoffs_staging2
group by 1
order by 1 desc;

select stage, sum(total_laid_off)
from world_layoffs.layoffs_staging2
group by stage
order by 1;

select min(`date`), max(`date`)
from world_layoffs.layoffs_staging2;

with Rolling_total as
(select substring(`date`, 1, 7) as `MONTH`, sum(total_laid_off) as total_off
from world_layoffs.layoffs_staging2
group by `MONTH`
having `MONTH` is not null
order by 1) 

select `MONTH`, total_off, sum(total_off) over(order by `MONTH`) as rolling_total
from Rolling_total;

select distinct substring(`date`, 1, 7) as `MONTH`, country, sum(total_laid_off) over(partition by country) as month_total
from world_layoffs.layoffs_staging2
order by 1, 2;



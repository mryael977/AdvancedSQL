use `advanced publications`;

drop temporary table publications.challenge1;

create temporary table publications.challenge1 
select titles.title_id as `Title ID`, titleauthor.au_id as `Author ID`, titles.price * sales.qty * titles.royalty /100
		* titleauthor.royaltyper / 100 as `Royalty for each sale for each author`
from publications.titles titles
inner join publications.titleauthor titleauthor
on titles.title_id = titleauthor.title_id
inner join publications.sales sales
on titles.title_id = sales.title_id
inner join publications.authors authors
on titleauthor.au_id = authors.au_id;


select `Title Id`, `Author ID`, sum(`Royalty for each sale for each author`) as Step2
from publications.challenge1
group by `Author ID`, `Title Id`;

select `Author ID`, titles.advance + titles.royalty as `Total Profits`
from publications.challenge1
inner join publications.titles
on challenge1.`Title ID` = titles.title_id
group by `Title Id`
order by `Total Profits` desc;


create table `most_profiting_authors` as
select titleauthor.au_id as AUTHOR_ID, titles.advance + titles.royalty as Total_Profits
from publications.titleauthor titleauthor
inner join publications.titles titles
on titleauthor.title_id = titles.title_id
group by AUTHOR_ID
order by Total_Profits desc;





create database SocialBuzz;

Use contentSocialBuzz;

create table Content (
ContentID Varchar(252) Primary key,
UserID Varchar(252),
Type character(20),
Category character(50),
URL Varchar(500)
);

create table Reactions (
SNo INT Primary key,
ContentID Varchar(252),
UserID Varchar(252),
Type character(20),
Datetime datetime,
foreign key (ContentID) references Content(ContentID)
);

create table ReactionTypes (
SNo INT,
Type character(20),
Sentiment character (20),
Score INT,
foreign key (SNo) references Reactions(SNo)
);
select * from Reactions;

alter table Content 
rename column Type to Type_Category;

alter table Reactions 
rename column Type to Type_Reactions;

select distinct(Category) from Content;

update Content
set Category = 'culture'
where Category like '"cul%';

update Content
set Category = 'Animals'
where Category like '"anim%';

update Content
set Category = 'dogs'
where Category like '"dog%';

update Content
set Category = 'cooking'
where Category like '"coo%';

update Content
set Category = 'veganism'
where Category like '"veg%';

update Content
set Category = 'tennis'
where Category like '"ten%';

update Content
set Category = 'studying'
where Category like '"stud%';

update Content
set Category = 'public speaking'
where Category like '"public%';

update Content
set Category = 'science'
where Category like '"scienc%';

update Content
set Category = 'food'
where Category like '"food%';

update Content
set Category = 'technology'
where Category like '"tech%';

update Content
set Category = 'soccer'
where Category like '"socc%';


create table Final_data as
select Category, Type_Reactions, Score, Sentiment, Datetime from Content as c
Left join Reactions as r on c.ContentID = r.ContentID
Left join ReactionTypes as rt on rt.Type = r.Type_Reactions
Where Score is not NULL
;

Create table Top_category as
Select Category, sum(Score) as Score from Final_Data
group by Category
Order by Score DESC limit 5;

select * from Final_Data;

select  Type_reactions, count(Type_Reactions) as reactions from Final_Data
group by Type_Reactions
Order by reactions DESC;

select  Category, count(Sentiment) as Negative_sentiment from Final_Data
where Sentiment = 'negative'
group by Category
Order by Negative_sentiment DESC;

Create table Month_stats as
select Monthname(datetime) as month, count(month(datetime)) as count from Final_data
group by month
order by count DESC;


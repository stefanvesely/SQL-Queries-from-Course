select * from series;

select * from reviews;


-- challenge 1
select title, rating from series join reviews on series.id = reviews.series_id order by title; 

-- challenge 2

select title, AVG(rating) as AverageRating from series join reviews on series.id = reviews.series_id group by series.id order by title;

-- Challenge 3

select first_name as Name, last_name as Surname, rating as Rating from reviewers join reviews on reviews.reviewer_id = reviewers.id order by Name, Surname;

-- Challenge 4

select title as Unreviewed from series left join reviews on series.id = reviews.series_id where rating is null; 
select * from series left join reviews on series.id = reviews.series_id where rating is null;

-- Challenge 5

select genre, round (AVG(rating), 2) as rating from series join reviews on series.id = reviews.series_id group by genre;

-- challenge 6

select 
first_name, 
last_name,ifnull(min(rating), 0) as low, 
ifnull(max(rating),0) as high, 
ifnull(avg(rating),0) as average, 
count(reviewers.id) as 'count',
case 
when count(rating) >= 1 then 'active'
else 'inactive'
end as status
from reviewers left join reviews on reviewers.id = reviews.reviewer_id group by reviewers.id; 

-- if (query, true, false)

-- challenge 7

select series.title as 'TVShow', 
reviews.rating as 'Rating', 
concat(reviewers.first_name, ' ', reviewers.last_name) as ReviewerName 
from series 
join reviews on series.id = reviews.series_id 
join reviewers on reviewers.id = reviews.reviewer_id order by title;






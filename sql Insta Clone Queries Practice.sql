-- challenge 1

select * from users order by created_at asc limit 5; -- five oldest users;


-- challenge 2

select count(dayname(created_at)) as count, dayname(created_at) as weekday from users group by weekday order by count desc;

-- challenge 3

select 
count(photos.id) as postcount, 
username 
from users 
left join photos on photos.user_id = users.id where photos.user_id is null group by username;

-- challenge 4
/*
select count(*) as winner,photos.image_url, photos.user_id, users.id, users.username from likes 
join photos on photos.id = likes.photo_id 
join users on photos.user_id = users.id 
group by likes.photo_id order by winner limit 1;*/ -- First try

select count(*) as likes, photo_id, users.username, photos.image_url from likes 
join photos on photos.id = likes.photo_id
join users on photos.user_id = users.id
group by photo_id order by likes desc limit 1;


-- challenge 5
-- select count(*) from photos group by user_id;
-- select count(amount) from (select count(*) as amount from photos group by user_id) as total;
-- avg for active users
select 
(select sum(amount) from (select count(*) as amount from photos group by user_id) as total)
/ 
(select count(amount) from (select count(*) as amount from photos group by user_id) as total) 
as averageforactive;

-- select (select count(*)from photos) / (select count(*) from photos group by user_id);
-- avg for total users
select (select count(*) from photos) / (select count(*) from users);

-- challenge 6

select count(*) as amount, tag_name from photo_tags 
join tags on tags.id = photo_tags.tag_id 
group by tag_id order by amount desc limit 5;

-- challenge 7

select count(*) as total, users.username,
case 
when 
count(*) = (select count(*) from photos) then 'bot'
else 'not'
end as bots
from likes join users on likes.user_id = users.id 
group by likes.user_id order by bots asc; -- having bots = 'bot'

-- done -- 

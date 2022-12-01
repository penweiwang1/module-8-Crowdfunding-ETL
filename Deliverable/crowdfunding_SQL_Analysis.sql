-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT*FROM campaign;

SELECT cp.cf_id,
SUM(cp.backers_count)
FROM campaign as cp
WHERE (cp.outcome = 'live')
GROUP BY cp.cf_id 
ORDER BY SUM(cp.backers_count) DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT*FROM backers;

SELECT b.cf_id,
COUNT (b.backer_id)
FROM backers as b
GROUP BY b.cf_id 
ORDER BY COUNT(b.backer_id) DESC;


-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT ct.first_name,
	ct.last_name,
	ct.email,
	(cp.goal-cp.pledged) as remaining_goal_amount 
INTO email_contacts_remaining_goal_amount
FROM contacts as ct
INNER JOIN campaign as cp
ON (ct.contact_id = cp.contact_id)
WHERE (cp.outcome = 'live')
ORDER BY remaining_goal_amount DESC;


-- Check the table


-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

SELECT b.email,
	b.first_name,
	b.last_name,
	cp.cf_id,
	cp.company_name,
	cp.description,
	cp.end_date, 
	(cp.goal-cp.pledged) as left_of_goal
INTO email_backers_remaining_goal_amount
FROM backers as b
INNER JOIN campaign as cp
ON (b.cf_id = cp.cf_id)
ORDER BY b.last_name, b.email ASC;

-- Check the table



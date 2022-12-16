SELECT 
	MAX(jobs.salary) AS "maximumSalary",
	MAX(roles.name) AS role
FROM jobs
JOIN roles
	ON roles.id = "roleId"
WHERE jobs.active = 'true'
GROUP BY "roleId"
ORDER BY "maximumSalary" ASC
;

	
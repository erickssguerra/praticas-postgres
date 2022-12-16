SELECT 
	MAX(jobs.salary) AS "maximumSalary",
	"roleId" AS role
FROM jobs
WHERE jobs.active = 'true'
GROUP BY "roleId"
ORDER BY "roleId" ASC
;

	
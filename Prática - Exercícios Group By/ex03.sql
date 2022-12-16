SELECT 
	MAX(users.name) AS writer,
	COUNT(testimonials.message) AS "testimonialCount"
FROM testimonials
JOIN users
ON users.id = testimonials."writerId"
WHERE testimonials."writerId" = 435
GROUP BY (testimonials."writerId")
;
SELECT 
	testimonials."writerId" AS writer,
	COUNT(testimonials.message) AS "testimonialCount"
FROM
	testimonials
WHERE
	testimonials."writerId" = 435
GROUP BY
	(testimonials."writerId")
;
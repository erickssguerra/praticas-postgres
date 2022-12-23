SELECT users.name AS writer, COUNT(*) AS "testimonialsCount"
FROM testimonials t
JOIN users ON t."writerId" = user.id
WHERE users.id = 435
GROUP BY users.id;
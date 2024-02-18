{% test primary_key(model, column_name) %}

WITH validation AS (
    SELECT
        {{ column_name}} AS primary_key,
        COUNT(1) AS occurences
    FROM {{ model }}
    GROUP BY 1)
SELECT *
FROM validation
WHERE primary_key IS NULL
    OR occurences > 1

{% endtest %}
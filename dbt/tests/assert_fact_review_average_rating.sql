{{ config(
    tags=['load_audit'],
    severity='warn',
) }}

-- Warn if the overall average_rating across all reviews drops below 1.5,
-- which likely signals an upstream parsing/scraping issue rather than
-- genuine customer sentiment.



select avg_rating, 'average_rating_too_low' as failure_reason
from (
    select avg(average_rating) as avg_rating
    from {{ ref('fct_review') }}
) as overall
where avg_rating < 1.5




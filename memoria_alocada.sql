SELECT datname,
CASE WHEN relfilenode IS NOT NULL THEN 'ALLOCATED' ELSE 'FREE' END,
pg_size_pretty(count(*) * current_setting('block_size')::integer) AS size
FROM pg_buffercache b
LEFT JOIN pg_database d ON d.oid = b.reldatabase
GROUP BY 1,2;


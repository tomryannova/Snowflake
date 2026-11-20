-- Example script run by the GitHub workflow.
-- Adjust the column names (id, word) to match your table if it already exists.

CREATE TABLE IF NOT EXISTS test1.wonderbus.test_table_1 (
    id   INTEGER,
    word STRING
);

-- MERGE instead of INSERT so re-running the workflow doesn't create duplicates
MERGE INTO test1.wonderbus.test_table_1 AS t
USING (
    SELECT column1 AS id, column2 AS word
    FROM VALUES (10, 'getz'), (11, 'it'), (12, 'on!')
) AS s
ON t.id = s.id
WHEN MATCHED THEN UPDATE SET t.word = s.word
WHEN NOT MATCHED THEN INSERT (id, word) VALUES (s.id, s.word);

SELECT * FROM test1.wonderbus.test_table_1 ORDER BY id;


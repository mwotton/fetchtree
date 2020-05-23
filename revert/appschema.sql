-- Revert fetchtree:appschema from pg

BEGIN;

drop schema fetchtree;

COMMIT;

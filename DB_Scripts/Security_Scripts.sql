-- Users:

-- NoDatabaseAccess
-- ReadDatabaseAccess
-- NoExecutingProcedures
-- ReadRole1/2
-- ExecuteRole1/2

-- Password:
-- Admin98
-- Admin99


--SERVER ROLE TO READ-ONLY

CREATE SERVER ROLE [ReadDatabaseRole]

GRANT VIEW ANY DEFINITION TO ReadDataBaseRole

GRANT VIEW SERVER STATE TO ReadDataBaseRole

GRANT CONTROL SERVER TO ReadDataBaseRole

ALTER SERVER ROLE ReadDataBaseRole 
ADD MEMBER ReadRole1

ALTER SERVER ROLE ReadDataBaseRole 
ADD MEMBER ReadRole2


--SERVER ROLE TO EXECUTE PROCEDURES

CREATE SERVER ROLE ExecuteRole

GRANT EXECUTE TO ExecuteRole --// DENY EXECUTE TO ExecuteRole Para quitar los permisos

ALTER SERVER ROLE [ExecuteRole] 
ADD MEMBER [ExecuteRole1]

ALTER SERVER ROLE [ExecuteRole] 
ADD MEMBER [ExecuteRole2]



## PostgreSQL

`psql — PostgreSQL interactive terminal`

Connect to PostgreSQL:
```sh
psql -h <hostname> -p <port> -U <username> -d <database>
```

The basic commands:
```sh
\q                  # quit psql
\l                  # list all databases
\c <database>       # connect to a different database
\d                  # list all tables in the current database
\d <table_name>     # describe a table
\i <file_path>      # execute SQL statements from a file
```

> how to use the database script
   + contract_db_import.js [destination] [input files]
   + test-export_contracts.js [destination] [input files]
   + xml_export_async.js [destination] [input files]


> setting up postgresql w/ brew or installing from source
   + installing from source? 
      https://www.postgresql.org/docs/17/installation.html
      https://www.postgresql.org/docs/17/install-getsource.html
   + installing with homebrew? 
      https://www.moncefbelyamani.com/how-to-install-postgresql-on-a-mac-with-homebrew-and-lunchy/
      1. brew install postgresql@17 // or some other version
      2. brew link postgresql@17
      3. brew services start postgresql@17
      4. brew services list         // should list postgresql@17 as a running service, this can be automated to run at start
   + install the pg npm plugin and ensure it's added to the package file. 
   + The goal here is to be able to send excel data into the postgres server without too much pain. 
   
   + running with brew (should use the built in applications)
      > brew services start postgresql@int
      > brew services stop postgresql@int
      > brew services restart ...
      > brew services list
      

   + commands for postgresql
   createdb - creates a database
   dropdb - deletes a database
   psql given_database_name - interactive editor for the database
      examples: 
      psql -U username -d database name   // verify that a server is Grunning 
   initdb - makes a new postgres database cluster
      examples: initdb -D /usr/local/pgsql/data
      initdb -W --pwprompt 
      initdb -W --pwfile -A scram-sha-256 (ch. 20)
      
   pg_ctl - control the postgres service
      examples: -- make sure it's not already running through the brew scripts
      pg_ctl -D /usr/local/var/postgresql@17 start
      pg_ctl -D /usr/local/var/postgresql@17 stop
      pg_ctl -D /usr/local/var/postgresql@17 restart
      // these above are considered the barebones ways to start the server
      postgres -D /usr/local/pgsql/data >logfile 2>&1 &  // typical shell syntax for starting in the background
      pg_ctl start -l logfile                            // is a wrapper that does the same thing
       

   + important locations
      > /usr/local/var/postgresql@int
      > /usr/local/opt/postgresql@int   
   
   + commands in psql -- not neccesarily needed, a tool for the cli at first. 
      https://www.postgresql.org/docs/17/app-psql.html
   \h - list available commands
   help - help text
   \? - more help
   \l, \list - will show you the available databases and tables
   \c, \connect - switch between different databases
   \dt - inspect created tables 
   CREATE TABLE weather (
    city            varchar(80),
    temp_lo         int,           -- low temperature
    temp_hi         int,           -- high temperature
    prcp            real,          -- precipitation
    date            date
   ); - creating a table, this is from the command line but could be run from a file. 
   INSERT INTO weather (city, temp_hi, temp_lo, prcp, date) VALUES('New York', 36, 44, 0.4, '1996-01-16'); - define columns, insert into columns
  
   + adding and managing users
      > if we are running a server that is available to the outside world, it is best ro run it under a separate user account. 
      > the reason is that if a database is compromised in any way only that user should be affected. 
      > the user account is the unix user domain that is used
   + Creating a database cluster (ch. 18.2, 22)
      > this is a section of memory dedicated to the actual database
      > after init, the database cluster will contain a databse named postgres
      > this is the default name for many utilities, user and third party applications
      > no default place where the data is stored, common places are: 
      /usr/local/pgsql/data 
      /var/lib/pgsql/data
      the data directory must be initialized before use, using:
      initdb
      > changing group permissions on the datacluster requires shutting the server down first
      > for clusters that allow access from the owner, use 0700 for dir and 0600 for files
      > for clusters that allow read access from the group, the appropriate modes are 0750 for dirs and 0640 for files    
      > when using secondary file systems (ie not in the "root" directory) don't use the mounting point, use a subdirectory. 
      This avoids any potential permission issues and clean failure 
      
      

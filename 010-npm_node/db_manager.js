const Database = require('better-sqlite3');

class Db_manager {
   constructor(db_path) {
      this.db_path = db_path;
      this.connections = new Map();
   }

   get_connection(db_name) {
      if (!this.connections.has(db_name)) {
         const db = new Database(`${db_name}.db`, {
            verbose: process.env.DEBUG ? console.log: null,
         });
         db.pragma('journal_mode = WAL');
         this.connections.set(db_name, db);
      }
      return this.connections.get(db_name);
   }

   close_all() {
      for (const [name, db] of this.connections) {
         db.close();
      }
      this.connections.clear();
   }
}

module.exports = Db_manager;

const { Pool } = require('pg');

const pool = new Pool({
  user: 'hugo.cridlig',
  host: 'ep-wispy-hall-a2usahtz.eu-central-1.aws.neon.tech',
  database: 'quiz-app',
  password: 'rWoJNdxK68nT',
  port: 5432, // default PostgreSQL port
  ssl : true
});

module.exports = pool;

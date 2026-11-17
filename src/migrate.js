const fs = require('fs');
const path = require('path');
const pool = require('./db');

async function main() {
    const fileName = process.argv[2] || 'schema.sql';
    const filePath = path.join(__dirname, '../db', fileName);
    const sql = fs.readFileSync(filePath, 'utf8');
    await pool.query(sql);
    console.log('Schema created');
    await pool.end();
}

main().catch((err) => {
    console.error('Error:', err.message);
    process.exit(1);
});
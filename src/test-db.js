const pool = require('./db');

async function main() {
    const result = await pool.query('SELECT now() AS time');
    console.log('Connected! DB time:', result.rows[0].time);
    await pool.end();
}

main().catch((err) => {
    console.error('Error:', err.message);
    process.exit(1);
});
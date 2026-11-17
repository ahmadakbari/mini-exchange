const pool = require('./db');

async function tryQuery(title, sql) {
    try {
        await pool.query(sql);
        console.log(`❌ ${title}: ACCEPTED (bad!)`);
    } catch (err) {
        console.log(`✅ ${title}: rejected -> ${err.message}`);
    }
}

async function main() {
    await tryQuery(
        'Negative balance',
        'UPDATE accounts SET balance = -50 WHERE id = 1'
    );

    await tryQuery(
        'Duplicate USDT wallet',
        "INSERT INTO accounts (user_id, asset_code) VALUES (1, 'USDT')"
    );

    await tryQuery(
        'Wallet for non-existent user',
        "INSERT INTO accounts (user_id, asset_code) VALUES (999, 'USDT')"
    );

    await tryQuery(
        'Transfer to yourself',
        'INSERT INTO transfers (from_account_id, to_account_id, amount) VALUES (1, 1, 10)'
    );

    await tryQuery(
        'Negative transfer amount',
        'INSERT INTO transfers (from_account_id, to_account_id, amount) VALUES (1, 2, -10)'
    );

    await pool.end();
}

main();
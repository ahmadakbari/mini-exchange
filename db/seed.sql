INSERT INTO assets (code, decimals) VALUES
  ('USDT', 6),
  ('BTC', 8);

INSERT INTO users (email) VALUES
  ('ali@test.com'),
  ('sara@test.com');

INSERT INTO accounts (user_id, asset_code, balance) VALUES
  (1, 'USDT', 1000),
  (2, 'USDT', 500);
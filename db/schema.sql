-- کاربران
CREATE TABLE users (
  id         BIGSERIAL PRIMARY KEY,
  email      TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- دارایی‌ها
CREATE TABLE assets (
  code     TEXT PRIMARY KEY,
  decimals INT  NOT NULL
);

-- ولت‌ها: هر کاربر برای هر دارایی یک حساب
CREATE TABLE accounts (
  id         BIGSERIAL PRIMARY KEY,
  user_id    BIGINT NOT NULL REFERENCES users(id),
  asset_code TEXT   NOT NULL REFERENCES assets(code),
  balance    NUMERIC(38, 18) NOT NULL DEFAULT 0,
  CHECK (balance >= 0),
  UNIQUE (user_id, asset_code)
);

-- انتقال‌ها
CREATE TABLE transfers (
  id              BIGSERIAL PRIMARY KEY,
  from_account_id BIGINT NOT NULL REFERENCES accounts(id),
  to_account_id   BIGINT NOT NULL REFERENCES accounts(id),
  amount          NUMERIC(38, 18) NOT NULL,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (amount > 0),
  CHECK (from_account_id <> to_account_id)
);

-- دفتر کل: هر انتقال = دو ردیف
CREATE TABLE ledger_entries (
  id          BIGSERIAL PRIMARY KEY,
  transfer_id BIGINT NOT NULL REFERENCES transfers(id),
  account_id  BIGINT NOT NULL REFERENCES accounts(id),
  amount      NUMERIC(38, 18) NOT NULL,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT now(),
  CHECK (amount <> 0)
);

CREATE INDEX idx_ledger_account ON ledger_entries(account_id);
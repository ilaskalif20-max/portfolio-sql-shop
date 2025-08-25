PRAGMA foreign_keys = ON;

CREATE TABLE categories (
    category_id     INTEGER PRIMARY KEY,
    name            TEXT NOT NULL,
    parent_id       INTEGER REFERENCES categories(category_id)
);

CREATE TABLE products (
    product_id      INTEGER PRIMARY KEY,
    category_id     INTEGER NOT NULL REFERENCES categories(category_id),
    name            TEXT NOT NULL,
    price           NUMERIC NOT NULL CHECK (price >= 0),
    is_active       INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1)),
    created_at      TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE customers (
    customer_id     INTEGER PRIMARY KEY,
    full_name       TEXT NOT NULL,
    email           TEXT NOT NULL UNIQUE,
    created_at      TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE addresses (
    address_id      INTEGER PRIMARY KEY,
    customer_id     INTEGER NOT NULL REFERENCES customers(customer_id),
    line1           TEXT NOT NULL,
    city            TEXT NOT NULL,
    country         TEXT NOT NULL,
    is_default      INTEGER NOT NULL DEFAULT 0 CHECK (is_default IN (0,1))
);

CREATE TABLE warehouses (
    warehouse_id    INTEGER PRIMARY KEY,
    name            TEXT NOT NULL,
    city            TEXT NOT NULL
);

CREATE TABLE inventory (
    product_id      INTEGER NOT NULL REFERENCES products(product_id),
    warehouse_id    INTEGER NOT NULL REFERENCES warehouses(warehouse_id),
    qty_on_hand     INTEGER NOT NULL CHECK (qty_on_hand >= 0),
    PRIMARY KEY (product_id, warehouse_id)
);

-- Заказы
CREATE TABLE orders (
    order_id            INTEGER PRIMARY KEY,
    customer_id         INTEGER NOT NULL REFERENCES customers(customer_id),
    order_date          TEXT NOT NULL DEFAULT (datetime('now')),
    status              TEXT NOT NULL CHECK (status IN ('new','paid','shipped','delivered','cancelled','returned')),
    shipping_address_id INTEGER REFERENCES addresses(address_id)
);

CREATE TABLE order_items (
    order_id    INTEGER NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id  INTEGER NOT NULL REFERENCES products(product_id),
    qty         INTEGER NOT NULL CHECK (qty > 0),
    unit_price  NUMERIC NOT NULL CHECK (unit_price >= 0),
    discount    NUMERIC NOT NULL DEFAULT 0 CHECK (discount BETWEEN 0 AND 1),
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE payments (
    payment_id  INTEGER PRIMARY KEY,
    order_id    INTEGER NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
    amount      NUMERIC NOT NULL CHECK (amount >= 0),
    method      TEXT NOT NULL CHECK (method IN ('card','cash','bank','crypto')),
    status      TEXT NOT NULL CHECK (status IN ('authorized','captured','failed','refunded')),
    paid_at     TEXT
);

CREATE TABLE product_views (
    view_id     INTEGER PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(customer_id),
    product_id  INTEGER NOT NULL REFERENCES products(product_id),
    viewed_at   TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE reviews (
    review_id   INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL REFERENCES customers(customer_id),
    product_id  INTEGER NOT NULL REFERENCES products(product_id),
    rating      INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment     TEXT,
    created_at  TEXT NOT NULL DEFAULT (datetime('now')),
    UNIQUE(customer_id, product_id)
);

CREATE TABLE shipments (
    shipment_id INTEGER PRIMARY KEY,
    order_id    INTEGER NOT NULL REFERENCES orders(order_id),
    carrier     TEXT NOT NULL,
    tracking_no TEXT,
    shipped_at  TEXT,
    delivered_at TEXT
);

CREATE INDEX idx_products_category ON products(category_id);

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);
CREATE INDEX idx_views_product ON product_views(product_id);
CREATE INDEX idx_views_customer ON product_views(customer_id);
CREATE INDEX idx_reviews_product ON reviews(product_id);
CREATE INDEX idx_inventory_warehouse ON inventory(warehouse_id);

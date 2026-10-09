-- Create products table
CREATE TABLE IF NOT EXISTS products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    quantity_in_stock INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    id SERIAL PRIMARY KEY,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL DEFAULT 0,
    status VARCHAR(50) DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create order_items table (many-to-many between orders and products)
CREATE TABLE IF NOT EXISTS order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id INTEGER NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Seed initial products
INSERT INTO products (name, description, price, quantity_in_stock) VALUES
    ('Laptop', 'High-performance laptop', 999.99, 15),
    ('Keyboard', 'Mechanical keyboard', 149.99, 50),
    ('Mouse', 'Wireless mouse', 29.99, 100),
    ('Monitor', '4K Ultra HD monitor', 399.99, 8),
    ('USB-C Cable', 'Universal charging cable', 19.99, 200),
    ('Headphones', 'Noise-cancelling headphones', 199.99, 25),
    ('Webcam', '1080p webcam', 79.99, 30),
    ('SSD', '1TB external SSD', 129.99, 40)
ON CONFLICT DO NOTHING;

-- Seed initial orders (optional sample data)
INSERT INTO orders (total, status) VALUES
    (1149.98, 'completed'),
    (229.98, 'completed'),
    (399.99, 'pending')
ON CONFLICT DO NOTHING;

-- Grant permissions
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO postgres;

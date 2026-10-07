-- A handful of realistic rows for manual testing (Phase 2 checklist item).

INSERT INTO restaurants (name, address, phone, created_at) VALUES
    ('Relish Divine Dining', '12 MG Road, Bhubaneswar', '+91-9000000001', NOW());

INSERT INTO dining_tables (restaurant_id, table_number, capacity, created_at) VALUES
    (1, 1, 2, NOW()),
    (1, 2, 4, NOW()),
    (1, 3, 4, NOW()),
    (1, 4, 6, NOW());

INSERT INTO menu_items (restaurant_id, name, description, price, category, available, created_at) VALUES
    (1, 'Paneer Tikka', 'Char-grilled cottage cheese, mint chutney', 240.00, 'Starters', TRUE, NOW()),
    (1, 'Butter Chicken', 'Tomato-butter gravy, served with rice or naan', 380.00, 'Main Course', TRUE, NOW()),
    (1, 'Dal Makhani', 'Slow-cooked black lentils', 220.00, 'Main Course', TRUE, NOW()),
    (1, 'Gulab Jamun', 'Two pieces, served warm', 120.00, 'Desserts', TRUE, NOW()),
    (1, 'Masala Chai', 'Spiced milk tea', 60.00, 'Beverages', TRUE, NOW());

INSERT INTO customers (name, email, phone, created_at) VALUES
    ('Asha Rao', 'asha.rao@example.com', '+91-9800000001', NOW()),
    ('Vikram Shah', 'vikram.shah@example.com', '+91-9800000002', NOW());

INSERT INTO bookings (customer_id, dining_table_id, booking_time, party_size, status, created_at) VALUES
    (1, 2, DATE_ADD(NOW(), INTERVAL 1 DAY), 4, 'CONFIRMED', NOW()),
    (2, 1, DATE_ADD(NOW(), INTERVAL 2 DAY), 2, 'PENDING', NOW());

INSERT INTO orders (booking_id, status, created_at) VALUES
    (1, 'PLACED', NOW());

INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price, notes) VALUES
    (1, 2, 2, 380.00, 'One extra spicy'),
    (1, 3, 1, 220.00, NULL),
    (1, 5, 2, 60.00, NULL);

-- Phase 2 (continued): a richer dummy dataset so joins, aggregates and
-- status filters actually have something interesting to return.
--
-- Written as a NEW versioned migration (never edit V2 -- it is already
-- applied and Flyway checksums it). This file assumes it runs straight
-- after V1 + V2 with nothing deleted in between, so the auto-increment
-- ids line up with the comments below:
--   restaurants   : 1 existing -> adds 2  (ids 2-3)
--   dining_tables : 4 existing -> adds 7  (ids 5-11)
--   menu_items    : 5 existing -> adds 12 (ids 6-17)
--   customers     : 2 existing -> adds 6  (ids 3-8)
--   bookings      : 2 existing -> adds 9  (ids 3-11)
--   orders        : 1 existing -> adds 4  (ids 2-5)
--   order_items   : 3 existing -> adds 9  (ids 4-12)

-- ---------------------------------------------------------------------
-- Restaurants: a 2nd and 3rd location, so "revenue/bookings per
-- restaurant" queries have more than one row to compare.
-- ---------------------------------------------------------------------
INSERT INTO restaurants (name, address, phone, created_at) VALUES
    ('Spice Route Kitchen', 'Andheri West, Mumbai', '+91-9000000002', NOW()),
    ('Coastal Breeze Cafe', 'Calangute Beach Road, Goa', '+91-9000000003', NOW());

-- ---------------------------------------------------------------------
-- Dining tables for the two new restaurants.
-- ---------------------------------------------------------------------
INSERT INTO dining_tables (restaurant_id, table_number, capacity, created_at) VALUES
    (2, 1, 2, NOW()),
    (2, 2, 2, NOW()),
    (2, 3, 4, NOW()),
    (2, 4, 6, NOW()),
    (3, 1, 2, NOW()),
    (3, 2, 4, NOW()),
    (3, 3, 8, NOW());

-- ---------------------------------------------------------------------
-- Menu items: a couple more for restaurant 1 (including one marked
-- unavailable, to prove the "available=TRUE" filter actually filters),
-- plus full menus for restaurants 2 and 3.
-- ---------------------------------------------------------------------
INSERT INTO menu_items (restaurant_id, name, description, price, category, available, created_at) VALUES
    (1, 'Veg Biryani', 'Basmati rice, mixed vegetables, saffron', 260.00, 'Main Course', TRUE, NOW()),
    (1, 'Chocolate Lava Cake', 'Warm cake with molten centre', 180.00, 'Desserts', TRUE, NOW()),
    (1, 'Mutton Rogan Josh', 'Slow-braised mutton, Kashmiri spices', 420.00, 'Main Course', FALSE, NOW()),

    (2, 'Tandoori Chicken', 'Half chicken, char-grilled', 320.00, 'Starters', TRUE, NOW()),
    (2, 'Pav Bhaji', 'Mashed vegetable curry, buttered pav', 180.00, 'Main Course', TRUE, NOW()),
    (2, 'Vada Pav', 'Mumbai-style potato fritter bun', 50.00, 'Starters', TRUE, NOW()),
    (2, 'Sev Puri', 'Crisp puris, chutneys, sev', 90.00, 'Starters', TRUE, NOW()),
    (2, 'Kulfi', 'Traditional milk ice cream', 100.00, 'Desserts', TRUE, NOW()),

    (3, 'Goan Fish Curry', 'Coconut-based curry, rice', 360.00, 'Main Course', TRUE, NOW()),
    (3, 'Prawn Balchao', 'Spicy-tangy prawn pickle curry', 400.00, 'Main Course', TRUE, NOW()),
    (3, 'Bebinca', 'Layered Goan dessert', 150.00, 'Desserts', TRUE, NOW()),
    (3, 'Feni Cocktail', 'Cashew feni based cocktail', 220.00, 'Beverages', FALSE, NOW());

-- ---------------------------------------------------------------------
-- More customers, so the same person can show up across multiple
-- bookings/restaurants (repeat-customer queries).
-- ---------------------------------------------------------------------
INSERT INTO customers (name, email, phone, created_at) VALUES
    ('Priya Nair', 'priya.nair@example.com', '+91-9800000003', NOW()),
    ('Rohit Mehta', 'rohit.mehta@example.com', '+91-9800000004', NOW()),
    ('Sneha Iyer', 'sneha.iyer@example.com', '+91-9800000005', NOW()),
    ('Arjun Kapoor', 'arjun.kapoor@example.com', '+91-9800000006', NOW()),
    ('Divya Menon', 'divya.menon@example.com', '+91-9800000007', NOW()),
    ('Karan Malhotra', 'karan.malhotra@example.com', '+91-9800000008', NOW());

-- ---------------------------------------------------------------------
-- Bookings: a mix of past/future times and every BookingStatus value,
-- spread across all 3 restaurants and several customers (including
-- repeat visits by customers 1-3).
-- ---------------------------------------------------------------------
INSERT INTO bookings (customer_id, dining_table_id, booking_time, party_size, status, created_at) VALUES
    (3, 6,  DATE_SUB(NOW(), INTERVAL 3 DAY), 2, 'COMPLETED', NOW()),
    (4, 7,  DATE_SUB(NOW(), INTERVAL 1 DAY), 3, 'COMPLETED', NOW()),
    (1, 9,  DATE_ADD(NOW(), INTERVAL 5 DAY), 2, 'CONFIRMED', NOW()),
    (5, 10, DATE_ADD(NOW(), INTERVAL 3 DAY), 4, 'PENDING',   NOW()),
    (6, 3,  DATE_SUB(NOW(), INTERVAL 2 DAY), 4, 'CANCELLED', NOW()),
    (7, 11, DATE_ADD(NOW(), INTERVAL 7 DAY), 6, 'CONFIRMED', NOW()),
    (2, 8,  DATE_SUB(NOW(), INTERVAL 5 DAY), 5, 'COMPLETED', NOW()),
    (8, 4,  DATE_ADD(NOW(), INTERVAL 1 HOUR), 2, 'SEATED',   NOW()),
    (3, 1,  DATE_ADD(NOW(), INTERVAL 10 DAY), 2, 'PENDING',  NOW());

-- ---------------------------------------------------------------------
-- Orders: only for bookings that actually got seated (COMPLETED /
-- SEATED). The CONFIRMED/PENDING/CANCELLED bookings deliberately have
-- no order yet, so a LEFT JOIN "bookings without an order" query has
-- real rows to find.
-- ---------------------------------------------------------------------
INSERT INTO orders (booking_id, status, created_at) VALUES
    (3,  'PAID',       NOW()),
    (4,  'PAID',       NOW()),
    (9,  'PAID',       NOW()),
    (10, 'PREPARING',  NOW());

-- ---------------------------------------------------------------------
-- Order items for the new orders -- each referencing menu items from
-- the SAME restaurant as the booking's table, so joins stay realistic.
-- ---------------------------------------------------------------------
INSERT INTO order_items (order_id, menu_item_id, quantity, unit_price, notes) VALUES
    (2, 9,  1, 320.00, NULL),
    (2, 11, 2, 50.00,  'Extra chutney'),
    (3, 10, 2, 180.00, NULL),
    (3, 13, 3, 100.00, NULL),
    (4, 9,  3, 320.00, 'Table of 5'),
    (4, 12, 2, 90.00,  NULL),
    (4, 13, 5, 100.00, NULL),
    (5, 1,  1, 240.00, NULL),
    (5, 6,  1, 260.00, 'No onions');

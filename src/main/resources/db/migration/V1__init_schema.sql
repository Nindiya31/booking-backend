-- Phase 2: core schema for the restaurant table + ordering domain.

CREATE TABLE restaurants (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150)  NOT NULL,
    address     VARCHAR(255),
    phone       VARCHAR(30),
    created_at  TIMESTAMP     NOT NULL
) ENGINE=InnoDB;

CREATE TABLE dining_tables (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id  BIGINT       NOT NULL,
    table_number   INT          NOT NULL,
    capacity       INT          NOT NULL,
    created_at     TIMESTAMP    NOT NULL,
    CONSTRAINT fk_dining_tables_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurants (id)
        ON DELETE CASCADE,
    CONSTRAINT uq_dining_tables_restaurant_number
        UNIQUE (restaurant_id, table_number)
) ENGINE=InnoDB;

CREATE TABLE menu_items (
    id             BIGINT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id  BIGINT        NOT NULL,
    name           VARCHAR(150)  NOT NULL,
    description    VARCHAR(500),
    price          DECIMAL(10,2) NOT NULL,
    category       VARCHAR(60),
    available      BOOLEAN       NOT NULL DEFAULT TRUE,
    created_at     TIMESTAMP     NOT NULL,
    CONSTRAINT fk_menu_items_restaurant
        FOREIGN KEY (restaurant_id) REFERENCES restaurants (id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE customers (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150)  NOT NULL,
    email       VARCHAR(200)  NOT NULL,
    phone       VARCHAR(30),
    created_at  TIMESTAMP     NOT NULL,
    CONSTRAINT uq_customers_email UNIQUE (email)
) ENGINE=InnoDB;

CREATE TABLE bookings (
    id               BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_id      BIGINT      NOT NULL,
    dining_table_id  BIGINT      NOT NULL,
    booking_time     TIMESTAMP   NOT NULL,
    party_size       INT         NOT NULL,
    status           VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    created_at       TIMESTAMP   NOT NULL,
    CONSTRAINT fk_bookings_customer
        FOREIGN KEY (customer_id) REFERENCES customers (id)
        ON DELETE RESTRICT,
    CONSTRAINT fk_bookings_dining_table
        FOREIGN KEY (dining_table_id) REFERENCES dining_tables (id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE orders (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_id  BIGINT      NOT NULL,
    status      VARCHAR(20) NOT NULL DEFAULT 'OPEN',
    created_at  TIMESTAMP   NOT NULL,
    CONSTRAINT fk_orders_booking
        FOREIGN KEY (booking_id) REFERENCES bookings (id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE order_items (
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id      BIGINT        NOT NULL,
    menu_item_id  BIGINT        NOT NULL,
    quantity      INT           NOT NULL,
    unit_price    DECIMAL(10,2) NOT NULL,
    notes         VARCHAR(255),
    CONSTRAINT fk_order_items_order
        FOREIGN KEY (order_id) REFERENCES orders (id)
        ON DELETE CASCADE,
    CONSTRAINT fk_order_items_menu_item
        FOREIGN KEY (menu_item_id) REFERENCES menu_items (id)
        ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_bookings_customer ON bookings (customer_id);
CREATE INDEX idx_bookings_table ON bookings (dining_table_id);
CREATE INDEX idx_orders_booking ON orders (booking_id);
CREATE INDEX idx_order_items_order ON order_items (order_id);
CREATE INDEX idx_order_items_menu_item ON order_items (menu_item_id);

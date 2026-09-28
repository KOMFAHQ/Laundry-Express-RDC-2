BEGIN;

CREATE TABLE alembic_version (
    version_num VARCHAR(32) NOT NULL, 
    CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num)
);

-- Running upgrade  -> initial

CREATE TYPE userrole AS ENUM ('CUSTOMER', 'PARTNER_OWNER', 'PARTNER_STAFF', 'DRIVER', 'LOGISTICS_MANAGER', 'ADMIN', 'SUPER_ADMIN');

CREATE TYPE userstatus AS ENUM ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'PENDING_VERIFICATION');

CREATE TABLE users (
    id UUID NOT NULL, 
    email VARCHAR(255) NOT NULL, 
    phone VARCHAR(50) NOT NULL, 
    password_hash VARCHAR(255) NOT NULL, 
    name VARCHAR(255) NOT NULL, 
    role userrole NOT NULL, 
    status userstatus NOT NULL, 
    is_email_verified BOOLEAN NOT NULL, 
    is_phone_verified BOOLEAN NOT NULL, 
    is_2fa_enabled BOOLEAN NOT NULL, 
    last_login_at TIMESTAMP WITH TIME ZONE, 
    email_verified_at TIMESTAMP WITH TIME ZONE, 
    phone_verified_at TIMESTAMP WITH TIME ZONE, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    PRIMARY KEY (id), 
    UNIQUE (email), 
    UNIQUE (phone)
);

CREATE UNIQUE INDEX ix_users_email ON users (email);

CREATE UNIQUE INDEX ix_users_phone ON users (phone);

CREATE TABLE user_profiles (
    id UUID NOT NULL, 
    user_id UUID NOT NULL, 
    first_name VARCHAR(100), 
    last_name VARCHAR(100), 
    avatar_url TEXT, 
    preferred_language VARCHAR(10) NOT NULL, 
    theme_preference VARCHAR(20) NOT NULL, 
    date_of_birth TIMESTAMP WITH TIME ZONE, 
    gender VARCHAR(20), 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(user_id) REFERENCES users (id), 
    UNIQUE (user_id)
);

CREATE UNIQUE INDEX ix_user_profiles_user_id ON user_profiles (user_id);

CREATE TABLE refresh_tokens (
    id UUID NOT NULL, 
    user_id UUID NOT NULL, 
    token_hash VARCHAR(255) NOT NULL, 
    device_info TEXT, 
    ip_address VARCHAR(45), 
    user_agent TEXT, 
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL, 
    revoked_at TIMESTAMP WITH TIME ZONE, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(user_id) REFERENCES users (id), 
    UNIQUE (token_hash)
);

CREATE UNIQUE INDEX ix_refresh_tokens_token_hash ON refresh_tokens (token_hash);

CREATE INDEX ix_refresh_tokens_user_id ON refresh_tokens (user_id);

CREATE TABLE password_reset_tokens (
    id UUID NOT NULL, 
    user_id UUID NOT NULL, 
    token_hash VARCHAR(255) NOT NULL, 
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL, 
    used_at TIMESTAMP WITH TIME ZONE, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(user_id) REFERENCES users (id), 
    UNIQUE (token_hash)
);

CREATE UNIQUE INDEX ix_password_reset_tokens_token_hash ON password_reset_tokens (token_hash);

CREATE INDEX ix_password_reset_tokens_user_id ON password_reset_tokens (user_id);

CREATE TABLE customer_addresses (
    id UUID NOT NULL, 
    user_id UUID NOT NULL, 
    label VARCHAR(100) NOT NULL, 
    contact_name VARCHAR(255), 
    contact_phone VARCHAR(50), 
    address_line_1 VARCHAR(255) NOT NULL, 
    address_line_2 VARCHAR(255), 
    city VARCHAR(100) NOT NULL, 
    commune VARCHAR(100) NOT NULL, 
    zone VARCHAR(100), 
    reference_point TEXT, 
    latitude FLOAT, 
    longitude FLOAT, 
    instructions TEXT, 
    is_default BOOLEAN NOT NULL, 
    created_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT now() NOT NULL, 
    PRIMARY KEY (id), 
    FOREIGN KEY(user_id) REFERENCES users (id)
);

CREATE INDEX ix_customer_addresses_user_id ON customer_addresses (user_id);

INSERT INTO alembic_version (version_num) VALUES ('initial') RETURNING alembic_version.version_num;

-- Running upgrade initial -> 05dc81e265f7

ALTER TABLE order_attachments ADD FOREIGN KEY(order_id) REFERENCES orders (id);

ALTER TABLE order_events ADD FOREIGN KEY(order_id) REFERENCES orders (id);

ALTER TABLE order_items ADD FOREIGN KEY(order_id) REFERENCES orders (id);

ALTER TABLE order_items ADD FOREIGN KEY(service_id) REFERENCES partner_services (id);

ALTER TABLE order_status_history ADD FOREIGN KEY(order_id) REFERENCES orders (id);

ALTER TABLE orders ADD FOREIGN KEY(pickup_address_id) REFERENCES customer_addresses (id);

ALTER TABLE orders ADD FOREIGN KEY(customer_id) REFERENCES users (id);

ALTER TABLE orders ADD FOREIGN KEY(partner_id) REFERENCES partners (id);

ALTER TABLE orders ADD FOREIGN KEY(delivery_address_id) REFERENCES customer_addresses (id);

ALTER TABLE partner_documents ADD FOREIGN KEY(partner_id) REFERENCES partners (id);

ALTER TABLE partner_locations ADD FOREIGN KEY(partner_id) REFERENCES partners (id);

ALTER TABLE partner_operating_hours ADD FOREIGN KEY(partner_id) REFERENCES partners (id);

ALTER TABLE partner_services ADD FOREIGN KEY(service_type_id) REFERENCES service_types (id);

ALTER TABLE partner_services ADD FOREIGN KEY(partner_id) REFERENCES partners (id);

ALTER TABLE partner_staff ADD FOREIGN KEY(user_id) REFERENCES users (id);

ALTER TABLE partner_staff ADD FOREIGN KEY(partner_id) REFERENCES partners (id);

ALTER TABLE password_reset_tokens DROP CONSTRAINT password_reset_tokens_token_hash_key;

ALTER TABLE pricing_rules ADD FOREIGN KEY(service_id) REFERENCES partner_services (id);

ALTER TABLE refresh_tokens DROP CONSTRAINT refresh_tokens_token_hash_key;

ALTER TABLE service_types ADD FOREIGN KEY(category_id) REFERENCES service_categories (id);

ALTER TABLE user_profiles DROP CONSTRAINT user_profiles_user_id_key;

ALTER TABLE users DROP CONSTRAINT users_email_key;

ALTER TABLE users DROP CONSTRAINT users_phone_key;

UPDATE alembic_version SET version_num='05dc81e265f7' WHERE alembic_version.version_num = 'initial';

COMMIT;


/**
    База данных магазина будет состоять из 7 таблиц. Users, users_roles и roles будут отвечать за пользователей, автори-
  зацию их в системе и маппирование ролей. Таблицы category, products будут описывать продукты и категории, в которых
  эти продукты лежат. Таблица order_lines будет корзиной товаров, а таблица orders будет связана с конкретными пользо-
  вателями и представлять конкретный сформированный заказ
 */



-- Таблица пользователей. Идентична сущности Юзер, сделанной на уроке
CREATE TABLE IF NOT EXISTS users(
                        id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        username VARCHAR(100) NOT NULL,
                        password VARCHAR(100) NOT NULL,
                        first_name VARCHAR(100) NOT NULL,
                        last_name VARCHAR(100) NOT NULL,
                        email VARCHAR(100) UNIQUE NOT NULL

);

INSERT INTO users (id, username,password,first_name,last_name,email) VALUES
                        (1,'admin', '$2y$10$72R3hM0PQn6RwRRLs9Vvn.8qiLQ/..o6gcrvxyfodIs73jJEj23da', 'Bob', 'Zaytsev', 'admin@admin.ru'),
                        (2,'user', '$2y$10$YNIoi4EP1oCoXaEx7y3Utur2hGFyPX32Oskd1thyQ1BxuhZwP2ur6', 'John', 'Davis', 'user@user.ru');

-- Таблица ролей. Идентична сущности Роль, сделанной на уроке
CREATE TABLE IF NOT EXISTS  roles(
                        id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        name VARCHAR(100) NOT NULL
);

INSERT INTO roles (id, name) VALUES
                        (1, 'ADMIN'),
                        (2, 'USER');


-- Таблица для маппинга пользователей и ролей через внешний ключ. Идентична сделанному на уроке
CREATE TABLE IF NOT EXISTS  users_roles(
                        id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                        user_id BIGINT NOT NULL,
                        role_id BIGINT NOT NULL,
                        FOREIGN KEY (user_id) REFERENCES users (id),
                        FOREIGN KEY (role_id) REFERENCES roles (id),
                        UNIQUE (user_id, role_id)
);

INSERT INTO users_roles (user_id, role_id) VALUES
                             (1,1),
                             (2,2);


CREATE TABLE IF NOT EXISTS  category(
                                        id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                        category_id BIGINT NOT NULL,
                                        category_name VARCHAR(100) NOT NULL,
                                        category_desc VARCHAR(255)
);

INSERT INTO category (category_id, category_name, category_desc) VALUES
                                        (1, 'Мониторы', 'Отличные мониторы по отличной цене'),
                                        (2, 'Компьюетры', 'Отличные Компьюетры по отличной цене'),
                                        (3, 'Телефоны', 'Отличные Телефоны по отличной цене'),
                                        (4, 'Материнские платы', 'Отличные Материнские платы по отличной цене');

-- Таблица с продуктами. Название продукта, описание, цена и общее количество. Указаны значения, которые не
-- могут быть нулевыми
CREATE TABLE IF NOT EXISTS products(
                         id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                         product_name VARCHAR(100) NOT NULL,
                         product_desc VARCHAR(255),
                         product_price DOUBLE NOT NULL,
                         product_quantity INT NOT NULL,
                         category_id BIGINT NOT NULL,
                         FOREIGN KEY (category_id) REFERENCES category (id)
);

INSERT INTO products (category_id, product_name, product_desc, product_price, product_quantity) VALUES
                         (1, 'Монитор LG 27GP850-B', '27-дюймовый игровой монитор от LG с Nano
IPS, временем отклика 1 мс (GtG), поддержкой WQHD, 180 Гц в разгоне и HDMI 2.0.', 39990, 4),
                         (2,'Ноутбук Apple MacBook Air 13 Late 2020', 'Вунедрвафля, которая не
даст тебе засохнуть', 81290.5, 10),
                         (3,'IPhone 13', 'Телефончик', 150000.99, 10),
                         (4,'Asus ASRock A-350Q', 'Материнская плата', 16598, 12);

-- Заказ пользователя.
CREATE TABLE IF NOT EXISTS  orders(
                          id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                          user_id BIGINT NOT NULL,
                          paid TINYINT NOT NULL DEFAULT false,
                          FOREIGN KEY (user_id) REFERENCES users (id)
);

-- Корзина пользователя.
CREATE TABLE IF NOT EXISTS  order_lines (
                                      id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
                                      order_id BIGINT NOT NULL,
                                      product_id BIGINT NOT NULL,
                                      price DOUBLE NOT NULL,
                                      quantity INT NOT NULL,
                                      FOREIGN KEY (product_id) REFERENCES products (id),
                                      FOREIGN KEY (order_id) REFERENCES orders (id)
);


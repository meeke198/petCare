use heroku_fd2d0778887fe46;
create table `user`(
                       `id`				bigint not null auto_increment,
                       `full_name`			varchar(255) not null,
                       `username`			varchar(255) not null,
                       `password`			varchar(255) not null,
                       `email`				varchar(100) check(`email` LIKE '%_@_%.__%'),
                       `address`			varchar(255),
                       `phone`				varchar(10),
                       `avatar`			varchar(255),
                       `is_status`			bit not null check(`is_status` = 0 or `is_status` = 1),
                       `dob` 				date,
                       `descript`			varchar(255),
                       PRIMARY KEY (id)
);

create table `role`(
                       `id`		bigint not null auto_increment,
                       `name`		varchar(255) not null,
                       `desc`		varchar(255) not null,
                       PRIMARY KEY (id)
);

create table `user_role`(
                            `id`		bigint primary key auto_increment,
                            `user_id`	bigint not null,
                            `role_id`	bigint not null
);

create table product(
                        `id`			bigint primary key auto_increment,
                        `name`			varchar(100) not null,
                        `description` 	longtext not null,
                        `image` 		varchar(255) not null,
                        `price` 		double(16,2) not null,
	`product_code` 	varchar(20) not null unique,
	`protein` 		varchar(200) not null,
	`fats` 			varchar(200) not null,
	`carbohydrates` varchar(200) not null,
	`minerals` 		varchar(200) not null,
	`vitamins` 		varchar(200) not null,
	`animal` 		varchar(200) not null,
    `sale`          int default 0 check(`sale` >= 0 and `sale` <= 100),
	`status` 		bit not null check(`status` = 0 or `status` = 1),
    `mark_id`		bigint not null,
    `category_id` 	bigint
);

create table image_detail(
                             `id`           bigint primary key auto_increment,
                             `url` 		   varchar(255) not null,
                             `product_id`   bigint
);

create table category(
                         `id`			bigint primary key auto_increment,
                         `name`			varchar(40) not null unique
);

create table mark(
                     `id`			bigint primary key auto_increment,
                     `tag`			varchar(10) unique,
                     `tag_badge`		varchar(10)
);

-- /////////////////////// --
create table `centers`
(
    id			int primary key auto_increment,
    `name`		varchar(30)  not null,
    phone		varchar(10)  not null,
    email		varchar(100) not null,
    address		varchar(200) not null,
    is_active	bit default 1,
    user_id		bigint not null
);

create table `packages`
(
    id          int primary key auto_increment,
    `name`      varchar(20) not null,
    is_active   bit default 1
);

create table `package_details`
(
    id				int primary key auto_increment,
    `description`	varchar(250) not null,
    image       	varchar(255) not null,
    price       	float not null,
    `status`      	varchar(50),
    is_active      	bit default 1,
    center_id   	int not null,
    package_id  	int not null
);

create table `services`
(
    id						int primary key auto_increment,
    `name`					varchar(200) not null,
    price					float not null,
    `description`			varchar(250) not null,
    `active`				bit default 1,
    `package_detail_id`		int not null
);

create table `service_images`
(
    id         int primary key auto_increment,
    url        varchar(255) not null,
    service_id int not null
);

create table `package_detail_reviews`
(
    id         			int primary key auto_increment,
    review     			varchar(255) not null,
    star       			int,
    `date`       		datetime,
    `active`     		bit default 1,
    package_detail_id	int not null,
    user_id    			bigint not null
);

create table `sellers`
(
    id        int primary key auto_increment,
    `name`    varchar(30)  not null,
    phone     varchar(10)  not null,
    email     varchar(100) not null,
    address   varchar(200) not null,
    `active`  bit default 1,
    center_id int not null
);

create table `orders`
(
    id           int primary key auto_increment,
    phone_number varchar(20)  not null,
    note         varchar(200),
    `date`       datetime not null,
    address      varchar(200) not null,
    `status`     varchar(100) not null,
    total        double,
    user_id      bigint not null
);

create table `order_detail`
(
    id        int primary key auto_increment,
    item_name varchar(200),
    image     varchar(300),
    quantity  int not null,
    total     double not null,
    note      varchar(200),
    orders_id int not null
);

create table `favorites`
(
    id 		bigint primary key auto_increment,
    user_id bigint not null
);

create table `favorite_products`
(
    id			bigint primary key auto_increment,
    product_id	bigint not null,
    favorite_id	bigint not null
);

-- Khóa ngoại
/*Product - image-detail*/
ALTER TABLE product
    ADD CONSTRAINT fk_product_category
        FOREIGN KEY (`category_id`)
            REFERENCES category(`id`);

ALTER TABLE product
    ADD CONSTRAINT fk_product_mark
        FOREIGN KEY (`mark_id`)
            REFERENCES mark(`id`);

ALTER TABLE image_detail
    ADD CONSTRAINT fk_image_detail_product
        FOREIGN KEY (`product_id`)
            REFERENCES product(`id`);

/*Customer - Role*/
ALTER TABLE `user_role`
    ADD CONSTRAINT fk_user_role_user
        FOREIGN KEY(`user_id`)
            REFERENCES `user`(`id`);

ALTER TABLE `user_role`
    ADD CONSTRAINT fk_user_role_role
        FOREIGN KEY(`role_id`)
            REFERENCES `role`(`id`);

/*Center - Service*/
ALTER TABLE `package_details`
    ADD CONSTRAINT `FK_package_details_centers`
        FOREIGN KEY(center_id)
            REFERENCES centers(`id`);

ALTER TABLE `package_details`
    ADD CONSTRAINT `FK_package_details_packages`
        FOREIGN KEY(package_id)
            REFERENCES packages(`id`);

ALTER TABLE `services`
    ADD CONSTRAINT `FK_service_package_detail`
        FOREIGN KEY(package_detail_id)
            REFERENCES package_details(`id`);

ALTER TABLE `centers`
    ADD CONSTRAINT `FK_center_user`
        FOREIGN KEY(user_id)
            REFERENCES `user`(`id`);

ALTER TABLE `service_images`
    ADD CONSTRAINT `FK_service_service_image`
        FOREIGN KEY(service_id)
            REFERENCES services(`id`);

ALTER TABLE `sellers`
    ADD CONSTRAINT `FK_seller_center`
        FOREIGN KEY(center_id)
            REFERENCES centers(`id`);

ALTER TABLE `package_detail_reviews`
    ADD CONSTRAINT `FK_package_detail_review_package`
        FOREIGN KEY(package_detail_id)
            REFERENCES package_details (`id`);

ALTER TABLE `package_detail_reviews`
    ADD CONSTRAINT `FK_package_detail_review_user`
        FOREIGN KEY(user_id)
            REFERENCES `user`(`id`);

ALTER TABLE  `orders`
    ADD CONSTRAINT `FK_order_user`
        FOREIGN KEY(user_id)
            REFERENCES `user`(`id`);

ALTER TABLE `order_detail`
    ADD CONSTRAINT `FK_order_detail_order`
        FOREIGN KEY(orders_id)
            REFERENCES `orders`(`id`);

ALTER TABLE `favorites`
    ADD CONSTRAINT `FK_favorites_user`
        FOREIGN KEY(user_id)
            REFERENCES `user`(`id`);

ALTER TABLE `favorite_products`
    ADD CONSTRAINT `FK_favorite_products_products`
        FOREIGN KEY(product_id)
            REFERENCES product(`id`);

ALTER TABLE `favorite_products`
    ADD CONSTRAINT `FK_favorite_products_favorites`
        FOREIGN KEY(favorite_id)
            REFERENCES favorites(`id`);

-- Insert
/*Customer - Role*/
INSERT INTO `role`(`id`, `name`,`Desc`)
VALUES
    (1, 'ROLE_ADMIN','ADMIN'),
    (2, 'ROLE_OWNER','CENTER'),
    (3, 'ROLE_SELLER','SALES ASSOCIATE'),
    (4, 'ROLE_CUSTOMER','CUSTOMER');

INSERT INTO `user`(`id`,`full_name`,`username`,`password`,`email`,`is_status`,avatar)
VALUES
    (1,'Luong','kakashi','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','luong@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (2,'Hieu','hieuthuhai','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','hieu@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (3,'Phong','phongxoan','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','xoan@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (4,'A La','kakashi1','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','a@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (5,'B to','kakashi2','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','b@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (6,'C xoc','kakashi3','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','c@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (7,'D dit','kakashi4','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','d@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (8,'E et','kakashi5','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','e@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (9,'Minh','kakashi6','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','f@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (10,'Phong Xoan','kakashi7','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','g@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (11,'Tong','kakashi8','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','h@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (12,'Tut','kakashi9','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','x@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (13,'Loe','kakashi10','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','y@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg'),
    (14,'Gay','kakashi11','$2a$12$3StsBnHAgc9gnLhm1nIpUeQzdtf0SpdDiFTEsF9M2YQr0TAKoKmSq','z@codegym.com',1,'https://res.cloudinary.com/dr3rwgzpl/image/upload/v1684729641/Product/cute-panda-with-coffee-cartoon-illustration-vector_dog4rb.jpg');

INSERT INTO `user_role`(`id`,`user_id`, `role_id`)
VALUES
    (1,1,1),
    (2,2,2),
    (3,2,4),
    (4,3,4),
    (5,3,2);

/*Product - Cart*/
INSERT INTO category(`id`,`name`)
VALUES
    (1,'Milk'),
    (2,'Pate'),
    (3,'Seed'),
    (4,'Vegetable');

INSERT INTO mark(`id`,`tag`,`tag_badge`)
VALUES
    (1,'',''),
    (2,'offer',''),
    (3,'hot',''),
    (4,'Hot Sale','sale'),
    (5,'Sold Out','sold-out');

INSERT INTO product (`id`,`name`, `description`, image, price, product_code, protein, fats, carbohydrates, minerals, vitamins, animal, `status`, mark_id, category_id, sale)
VALUES (1,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3pyl7Oei9BjUXDBHNpbAwcV2gAdvG2_a8bSh2Gd6473AK_rPL0yloJx8jbxRWKuTck9I&usqp=CAU',
        55000, 'PATE011', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (2,'Beef pate for dogs', 'One care beef',
        'https://www.petmart.vn/wp-content/uploads/2019/04/pate-cho-cho-vi-thit-bo-iris-one-care-beef100g-768x768.jpg',
        35000, 'PATE01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 1, 2, 0),
       (3,'Cat milk powder', 'BBN Goat’s Milk New Zealand',
        'https://bizweb.dktcdn.net/100/458/454/products/petag-kmr-sua-bot-thay-the-danh-cho-meo-so-sinh-340g-1673494505588.png?v=1673494516117',
        5000, 'MILK01', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 10),
       (4,'Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSi1O11-lKyc1Bu5JUBsps0Ck0DJrptR9RMXw&usqp=CAU', 25000,
        'SEED03', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3, 0),
       (5,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgGLI32CNvJQz4NdV6Xl6808OoVtVezzOcJKg5mFmL7Ix1VMnTgT0yxtvH3NwlourMZ_M&usqp=CAU',
        55000, 'PATE012', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (6,'Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-hat-kitcat-cho-meo-chicken-cuisine-goi-1-2kg.jpg?v=1669097725000',
        25000, 'KITKAT01', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3, 0),
       (7,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://bizweb.dktcdn.net/100/092/840/products/thuc-an-dong-hop-kitcat-complete-cho-meo-12-vi.png?v=1669015221000',
        55000, 'PATE02', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (8,'Cabbage',
        'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_uAtOa-ViSMz7B77QqMM1cikd-p9xYu6IRA&usqp=CAU', 85000,
        'RAU01', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 3, 4, 10),
       (9,'Pate for dogs',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8Z3oqhYUuRGrGPekuWwgjyFe1fOKT3W7qRA&usqp=CAU', 55000,
        'PATE010', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (10,'Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRf2R4hT8A0AL7OYH_ydiB4vvDmnxUhN9D7g&usqp=CAU', 25000,
        'GRASS01', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass03', 1, 4, 3, 0),
       (11,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTnSm4NZ-mhf8M4t2bqUYMC89lxBEz21bYEqQ&usqp=CAU', 55000,
        'PATE09', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (12,'Hay for rabbits',
        'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuKB-PDP6OBZqFOA1XxYtSyI9OdDZQMrwjGw&usqp=CAU', 65000,
        'HAY01', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 5, 4, 30),
       (13,'Dog milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToGsTVVGmvh715WPWGaG5Nh9Qj4MqZvAO_ow&usqp=CAU', 5000,
        'MILK02', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 0),
       (14,'Coriander',
        'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvt1RTgzCFLku-ME87YWu23Mnr3WOiInWbZg&usqp=CAU', 45000,
        'Coriander01', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 1, 4, 10),
       (15,'Sugar beet',
        'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkOGTGkD5vGjppgoLH6zYcxfJCqcz6ks1Q-6GUZ-OdRK4tPWaouKYp4057NLSi8B7zPCw&usqp=CAU',
        35000, 'SUGERBEET01', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 2, 4, 0),
       (16,'Pate for cat', 'One care beef',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSotOxcypXkSkcb3TOTVC5sNZi2l3Vd3rbydg&usqp=CAU', 35000,
        'PATE04', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 3, 2, 0),
       (17,'Dog milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWarBrQ3-FK3ayX3QkOHARbsF1zP2tERSSag&usqp=CAU', 5000,
        'MILK03', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 5, 1, 10),
       (18,'Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ7PREwOPsySq4hSWOibEQCNUKN_tQfWVifdA&usqp=CAU', 25000,
        'GRASS04', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       (19,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCegJXpRx0B3CYATMVJNdRvm_aIcFT4R2vxQ&usqp=CAU', 55000,
        'PATE08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (20,'Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz6zVhvgeRe-oOxdf4fNj_odclRSdhajOQNg&usqp=CAU', 25000,
        'GRASS05', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       (21,'Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwvsbJrHp9daEJhSBt_TSjuoMjjHikJ-PRVw&usqp=CAU', 25000,
        'KITKAT04', '1g', '2g', '20g', '50mg', '', '', 1, 2, 3, 0),
       (22,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQwHkksi0p04qJXMX1nCFPjifYUSo03wspqg&usqp=CAU', 55000,
        'PATE07', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (23,'Dog milk powder', 'BBN Goat’s Milk New Zealand',
        'https://www.petmart.vn/wp-content/uploads/2016/09/sua-bot-cho-bbn-goats-milk-new-zealand-768x768.jpg', 5000,
        'MILK04', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 0),
       (24,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8KHG1MmyokfGq0nGzp01aXClQs5AXDUKUVg&usqp=CAU', 55000,
        'PATE03', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 4, 2, 10),
       (25,'Cabbage',
        'Vegetables contain a lot of fiber, vitamins and minerals, helping rabbits have a nutritionally complete diet.',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_uAtOa-ViSMz7B77QqMM1cikd-p9xYu6IRA&usqp=CAU', 85000,
        'RAU08', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'cabbage01', 1, 5, 4, 0),
       (26,'Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcST0iPUMOSmEEOGByl7TO0pYO4m9L2uS3-skQ&usqp=CAU', 25000,
        'SEED02', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3, 0),
       (27,'Dog and Cat milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTW6Pk20H9wK_qDYr7sqxkvWNacLfeUXCPRuw&usqp=CAU', 5000,
        'MILK05', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 20),
       (28,'Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSZWTPPnsP4BLbQ-afBI1C_NGKyCVdcQ2G8w&usqp=CAU', 25000,
        'GRASS03', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       (29,'Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz6zVhvgeRe-oOxdf4fNj_odclRSdhajOQNg&usqp=CAU', 25000,
        'GRASS02', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       (30,'Hay for rabbits',
        'Hay is a simple food option for rabbits. They contain a lot of fiber, which helps rabbits digest better. In addition, hay also helps rabbits reduce stress and eliminate boredom',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuKB-PDP6OBZqFOA1XxYtSyI9OdDZQMrwjGw&usqp=CAU', 65000,
        'HAY04', '5g', '4g', '16g', '20mg', 'vitamin A, D, E, K', 'HAY', 1, 2, 4, 0),
       (31,'Cat milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQuht6t7E2HWryG0jPfbnVjhQ8gyJ6Wl5JRVw&usqp=CAU', 5000,
        'MILK06', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 3, 1, 0),
       (32,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSKjcSHu4te5W0E5mRU5RzAh5gwPzxu7wzEQ&usqp=CAU', 55000,
        'PATE06', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (33,'Coriander',
        'Coriander is a vegetable with a delicious taste and rich in nutrients. Rabbits often love coriander and they can help strengthen the rabbits immune system',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvt1RTgzCFLku-ME87YWu23Mnr3WOiInWbZg&usqp=CAU', 45000,
        'Coriander06', '8g', '3g', '22g', '200mg', 'vitamin A, D, E, K', 'Coriander', 1, 3, 4, 10),
       (34,'Sugar beet',
        'Beets are a nutritious and high fiber vegetable. They help rabbits digest better and can help improve their heart health',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkOGTGkD5vGjppgoLH6zYcxfJCqcz6ks1Q-6GUZ-OdRK4tPWaouKYp4057NLSi8B7zPCw&usqp=CAU',
        35000, 'SUGERBEET10', '6g', '5g', '12g', '210mg', 'vitamin A, D, E, K', 'SugerBeet', 1, 4, 4, 0),
       (35,'Dog milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGxzeTy1-U5R5G6qFBpdOtNpagd3cdgxyp8-8OGsenXQXc7VLQpKWSb0deTQnPQvIYdUY&usqp=CAU',
        5000, 'MILK07', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 4, 1, 0),
       (36,'Cat milk powder', 'BBN Goat’s Milk New Zealand',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrsEVF8cN8_ZmkjIabtALUULFDAux2CUSMWg&usqp=CAU', 5000,
        'MILK08', '1g', '0.5g', '30g', '100mg', 'vitamin C', '', 1, 1, 1, 0),
       (37,'Pate for cats',
        'Pate for Cats Kitcat Complete Cuisine is a wet food, ensuring enough nutrition, fiber, and minerals as a complete diet. The product is suitable for busy owners who do not have time to prepare complete meals for their cats',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY5vgcgrMM1LOHuCrtS6k7CH-ploNgAsBct7K4kKL9kZhKjJHhAjve-DuBCccRPdc1htY&usqp=CAU ',
        55000, 'PATE015', '8g', '3g', '12g', '200mg', 'vitamin A, D, E, K', 'Beef', 1, 2, 2, 20),
       (38,'Grass seed for squirrel',
        'Grass seeds are a suitable natural food source for rabbits. They contain a lot of fiber and essential nutrients to maintain the health of your rabbit',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQs_PPUIjnt6HPYgHZ2uB26unbqO1FJbDHZZQ&usqp=CAU', 25000,
        'GRASS06', '15g', '4g', '22g', '200mg', 'vitamin A, D, E, K', 'grass08', 1, 1, 3, 0),
       (39,'Cat food',
        'Cat Food - Kitcat Grain Food is produced and packaged according to international standards, the ingredients of the food are made from selected and high-grade raw materials. Food will be the most balanced and healthy source of nutrition for the cat to develop fully',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTzeDA7w_rOUT6LmGJjQSKdXmxCDqH5jbMvTg&usqp=CAU', 25000,
        'SEED04', '1g', '2g', '20g', '50mg', '', '', 1, 5, 3, 0);

INSERT INTO `image_detail`(`id`,`url`, `product_id`)
VALUES (1,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 1),
       (2,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8YqqS2PVX_hhWJBrxTTuFlAo7OWD1W3jyoQ&usqp=CAU', 1),
       (3,'https://media.istockphoto.com/id/1326701268/photo/kibble-and-canned-dog-food-in-bowls-two-types-of-dog-food.jpg?b=1&s=170667a&w=0&k=20&c=GHHLtQPDq2dZEUTR-N8ECZUdeYnASDgwhp_jN8br8u8=',
        1),
       (4,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLiG7n-qIt2T9zM8XnqNYMfQoy7ifoSNGV5g&usqp=CAU', 1),
       (5,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw1sqY_ercoHYbPZIfm2y2iwB-bzYTAXls8Q&usqp=CAU', 1),
       (6,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 2),
       (7,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgO_Cez7kPjpb5O_39hUk1vZmVBMhs3lNotA&usqp=CAU', 2),
       (8,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSh3_NMnt-k78pW9B8c5jjC7sBhEug9kHSbBA&usqp=CAU', 2),
       (9,'https://freshpet.com/wp-content/uploads/2020/01/FP_DogPage_Puppy_2020_v2.jpg', 2),
       (10,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFN2jUeLRupXQf8isZjC0nDxFGBy5ylHIhA3Sc_mEG0oDpV-eyYJ4i5-jhnSyRYvQejyU&usqp=CAU',
        2),
       (11,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 3),
       (12,'https://youdidwhatwithyourweiner.com/wp-content/uploads/2023/01/Water-Added-to-Dry-Dog-Food-800x600.jpg', 3),
       (13,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiIQ1qWNJcPya9yEc6ditzalfPVAuM-FQgnzorhsCg9Vd95cuR_MpM8Rxb2mze9aHiTX8&usqp=CAU',
        3),
       (14,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbbAiS_TnXDGzNYLtAB8EaFDjzixTYOo_3nTQGsMtVPNm22sOtcVnRXHezl2__1dB7ZaA&usqp=CAU',
        3),
       (15,'https://thumbs.dreamstime.com/b/puppy-bowl-dry-dog-food-isolated-white-background-70006967.jpg', 3),
       (16,'https://e3.365dm.com/23/05/2048x1152/skynews-dog-dog-food-study-finds_6141795.jpg', 4),
       (17,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 4),
       (18,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZIBQIUTpxtnXdIrMQ1384pVwtBkjc54yw5Q&usqp=CAU', 4),
       (19,'https://static.wixstatic.com/media/3e3a39_1f4234364d544e449969759ccc9427d1~mv2.jpg/v1/fill/w_680,h_680,al_c,lg_1,q_85/3e3a39_1f4234364d544e449969759ccc9427d1~mv2.jpg',
        4),
       (20,'https://img.freepik.com/free-photo/domestic-pet-food-assortment_23-2148982332.jpg', 4),
       (21,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 5),
       (22,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQq1xPCFwR6Kxq2WFPxysF6cR8ZdIdjHO4sFA&usqp=CAU', 5),
       (23,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 5),
       (24,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 5),
       (25,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 5),
       (26,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       (27,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       (28,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       (29,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       (30,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 6),
       (31,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       (32,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       (33,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       (34,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       (35,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 7),
       (36,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       (37,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       (38,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       (39,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       (40,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 8),
       (41,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       (42,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       (43,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       (44,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       (45,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 9),
       (46,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       (47,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       (48,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       (49,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       (50,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 10),
       (51,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       (52,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       (53,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       (54,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       (55,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 11),
       (56,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       (57,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       (58,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       (59,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       (60,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 12),
       (61,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       (62,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       (63,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       (64,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       (65,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 13),
       (66,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       (67,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       (68,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       (69,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       (70,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 14),
       (71,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       (72,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       (73,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       (74,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       (75,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 15),
       (76,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       (77,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       (78,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       (79,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       (80,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 16),
       (81,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       (82,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       (83,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       (84,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       (85,'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 17),
       (86, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       (87, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       (88, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       (89, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       (90, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 18),
       (91, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       (92, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       (93, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       (94, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       (95, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 19),
       (96, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       (97, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       (98, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       (99, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       (100, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 20),
       (101, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       (102, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       (103, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       (104, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       (105, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 21),
       (106, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       (107, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       (108, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       (109, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       (110, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 22),
       (111, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       (112, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       (113, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       (114, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       (115, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 23),
       (116, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 24),
       (117, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 24),
       (118, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 24),
       (119, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 24),
       (120, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 24),
       (121, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       (122, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       (123, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       (124, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       (125, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 25),
       (126, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       (127, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       (128, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       (129, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       (130, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 26),
       (131, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       (132, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       (133, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       (134, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       (135, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 27),
       (136, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       (137, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       (138, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       (139, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       (140, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 28),
       (141, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       (142, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       (143, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       (144, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       (145, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 29),
       (146, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       (147, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       (148, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       (149, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       (150, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 30),
       (151, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       (152, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       (153, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       (154, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       (155, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 31),
       (156, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       (157, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       (158, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       (159, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       (160, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 32),
       (161, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       (162, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       (163, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       (164, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       (165, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 33),
       (166, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       (167, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       (168, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       (169, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       (170, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295448/ImageProduct/images_cas6uz.jpg', 34),
       (171, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       (172, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       (173, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       (174, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       (175, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 35),
       (176, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       (177, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       (178, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       (179, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       (180, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295281/ImageProduct/images_iiz6zr.jpg', 36),
       (181, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       (182, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       (183, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       (184, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       (185, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295221/ImageProduct/pate-gan-ga_qduh4y.jpg', 37),
       (186, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       (187, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       (188, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       (189, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       (190, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 38),
       (191, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39),
       (192, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39),
       (193, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39),
       (194, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39),
       (195, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684295319/ImageProduct/images_vzevgi.jpg', 39);



INSERT INTO centers (`id`, `name`, `phone`, `email`, `address`, `user_id`)
VALUES
    (1, 'Pet Care Center', '1234567890', 'petcarecente@gmail.com.com', '123 Main St', 1),
    (2, 'Animal Hospital', '9876543210', 'animalhospital@gmail.com', '456 Elm St', 2),
    (3, 'Paws and Claws Clinic', '5551234567', 'appointments@gmail.com', '789 Oak Ave', 3),
    (4, 'Pet Lovers Vet', '9998887777', 'competloversvet@gmail.com', '321 Pine Rd', 4),
    (5, 'Happy Pets Clinic', '5551112222', 'happypetsclinic@gmail.com', '789 Maple Ave', 5),
    (6, 'Cat Lovers Veterinary', '4445556666', 'appointments@gmail.com', '456 Oak St', 6),
    (7, 'Doggy Daycare Center', '7778889999', 'doggydaycarecenter@gmail.com', '123 Pine Rd', 7),
    (8, 'Exotic Animal Hospital', '2223334444', 'comexoticanimalhospital@gmail.com', '789 Elm St', 8),
    (9, 'Birds and Beyond Clinic', '8889990000', 'beyondclinic@gmail.com', '456 Maple Ave', 9),
    (10, 'Feline Friends Veterinary', '6667778888', 'appointments@gmail.com', '123 Oak St', 10),
    (11, 'Happy Tails Boarding', '3334445555', 'comhappytailsboarding@gmail.com', '789 Pine Rd', 10),
    (12, 'Reptile Care Center', '9990001111', 'contact@gmail.comreptilecarecenter.com', '456 Elm St', 10),
    (13, 'Pawsome Pet Resort', '7778889999', 'pawsomepetresort@gmail.com', '123 Maple Ave', 10),
    (14, 'Small Animal Clinic', '2223334444', 'appointments@gmail.com', '789 Oak St', 10),
    (15, 'Avian Veterinary Services', '8889990000', 'comavianvetservices@gmail.com', '456 Pine Rd', 10),
    (16, 'Whiskers and Paws Clinic', '6667778888', 'comwhiskersandpawsclinic@gmail.com', '123 Elm St', 10),
    (17, 'Critter Care Center', '3334445555', 'infocomcrittercarecenter@gmail.com', '789 Maple Ave', 10),
    (18, 'Equine Veterinary Clinic', '9990001111', 'appointmentscomequinevetclinic@gmail.com', '456 Oak St', 10),
    (19, 'Purrfect Pet Grooming', '7778889999', 'infocompurrfectpetgrooming@gmail.com', '123 Pine Rd', 10),
    (20, 'Aquatic Animal Hospital', '2223334444', 'comaquaticanimalhospitalcontact@gmail.com', '789 Elm St', 10),
    (21, 'Rabbit and Rodent Clinic', '8889990000', 'infocomrabbitandrodentclinic12@gmail.com', '456 Maple Ave', 10);


insert into packages(`id`,`name`)
values (1,'Day care'),
       (2,'Walking Service'),
       (3,"Pet's Sap"),
       (4,'Training Program');

INSERT INTO `package_details`(`id`,`description`, `image`, `price`, `status`, `is_active`, `center_id`, `package_id`)
VALUES
    (1, 'Essential vaccinations for your pet', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376796/Packages/dog-massage-therapy-picture-id909810936_gtpm6j.jpg', 80.0, 'Active', 1, 1, 1),
    (2, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 60.0, 'Active', 1, 1, 2),
    (3, 'Professional training for your pet', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376948/Packages/jrmrtpfwcgk92c3iefen.jpg', 100.0, 'Active', 1, 2, 3),
    (4, 'Safe and comfortable boarding for your pet', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376983/Packages/caninemassagefeat-1080x675_hvebpl.jpg', 40.0, 'Active', 1, 3, 1),
    (5, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376983/Packages/caninemassagefeat-1080x675_hvebpl.jpg', 65.0, 'Active', 1, 2, 1),
    (6, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377007/Packages/oakland-and-east-bay-dog-daycare-1024x683_csvb5i.jpg', 61.0, 'Active', 1, 3, 1),
    (7, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377039/Packages/images_otmqqy.jpg', 70.0, 'Active', 1, 4, 1),
    (8, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377079/Packages/images_l2npht.jpg', 63.0, 'Active', 1, 5, 1),
    (9, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377116/Packages/images_y4dyct.jpg', 90.0, 'Active', 1, 6, 1),
    (10, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377150/Packages/rs_h_1000_cg_true_m_eqc1z7.jpg', 67.0, 'Active', 1, 7, 1),
    (11, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377180/Packages/images_sfguki.jpg', 45.0, 'Active', 1, 8, 1),
    (12, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377227/Packages/images_es7beo.jpg', 34.0, 'Active', 1, 9, 1),
    (13, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377252/Packages/images_tqmpxw.jpg', 33.0, 'Active', 1, 10, 1),
    (14, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377276/Packages/images_xhk5e2.jpg', 39.0, 'Active', 1, 11, 1),
    (15, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377360/Packages/images_fz4ihk.jpg', 22.0, 'Active', 1, 3, 2),
    (16, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377427/Packages/images_ithwde.jpg', 54.0, 'Active', 1, 4, 2),
    (17, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377461/Packages/images_womxnd.jpg', 53.0, 'Active', 1, 5, 2),
    (18, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377504/Packages/images_vjgni4.jpg', 61.0, 'Active', 1, 6, 2),
    (19, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377526/Packages/images_fbqldb.jpg', 69.0, 'Active', 1, 7, 2),
    (20, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377550/Packages/images_ww33bd.jpg', 66.0, 'Active', 1, 8, 2),
    (21, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377584/Packages/images_awbr7q.jpg', 60.0, 'Active', 1, 9, 2),
    (22, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377767/Packages/ServiceImage/images_kd4ium.jpg', 34.0, 'Active', 1, 10, 2),
    (23, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377780/Packages/ServiceImage/home-2_eoovki.jpg', 57.0, 'Active', 1, 11, 2),
    (24, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377805/Packages/ServiceImage/pet-care_cat-care_thumb_fgw2hf.jpg', 35.0, 'Active', 1, 12, 2),
    (25, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377816/Packages/ServiceImage/images_zansmg.jpg', 46.0, 'Active', 1, 13, 2),
    (26, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377827/Packages/ServiceImage/jack-russell-terrier-dog-holding-260nw-2100518530_wojavq.jpg', 86.0, 'Active', 1, 4, 3),
    (27, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377935/Packages/ServiceImage/s3wf6poxajhl0fa0adbu.jpg', 43.0, 'Active', 1, 5, 3),
    (28, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377973/Packages/ServiceImage/images_jvdrwd.jpg', 90.0, 'Active', 1, 6, 3),
    (29, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377994/Packages/ServiceImage/images_g9vmwq.jpg', 45.0, 'Active', 1, 7, 3),
    (30, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378011/Packages/ServiceImage/images_una9lg.jpg', 86.0, 'Active', 1, 8, 3),
    (31, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378061/Packages/ServiceImage/images_obdjp4.jpg', 35.0, 'Active', 1, 9, 3),
    (32, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378127/Packages/ServiceImage/images_vz5c3h.jpg', 37.0, 'Active', 1, 10, 3),
    (33, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378142/Packages/ServiceImage/images_rfh8op.jpg', 86.0, 'Active', 1, 11, 3),
    (34, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378162/Packages/ServiceImage/images_leocve.jpg', 45.0, 'Active', 1, 12, 3),
    (35, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378187/Packages/ServiceImage/images_sdyeow.jpg', 64.0, 'Active', 1, 13, 3),
    (36, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378208/Packages/ServiceImage/images_pqgm2f.jpg', 76.0, 'Active', 1, 14, 3),
    (37, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378230/Packages/ServiceImage/images_bxpyvu.jpg', 46.0, 'Active', 1, 15, 3),
    (38, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378251/Packages/ServiceImage/images_kmpwb2.jpg', 97.0, 'Active', 1, 16, 4),
    (39, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 45.0, 'Active', 1, 17, 4),
    (40, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 65.0, 'Active', 1, 18, 4),
    (41, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 86.0, 'Active', 1, 19, 4),
    (42, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 45.0, 'Active', 1, 12, 4),
    (43, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 67.0, 'Active', 1, 11, 4),
    (44, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 56.0, 'Active', 1, 9, 4),
    (45, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 68.0, 'Active', 1, 8, 4),
    (46, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 67.0, 'Active', 1, 7, 4),
    (47, 'Pamper your pet with a grooming session', 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684376888/Packages/16735324573a9cefdabf6cc000ef1f49028cce059c_nyzkus.jpg', 66.0, 'Active', 1, 6, 4);


INSERT INTO services (id, name, price, description, package_detail_id)
VALUES (1, 'Basic Check-up', 50.0, 'Routine health check-up for your pet', 1),
       (2, 'Vaccination', 30.0, 'Essential vaccinations for your pet', 2),
       (3, 'Grooming', 40.0, 'Grooming session for your pet', 3),
       (4, 'Dental Cleaning', 70.0, 'Professional dental cleaning for your pet', 1),
       (5, 'Training Session', 80.0, 'Training session for your pet', 2),
       (6, 'Nutrition Consultation', 60.0, 'Consultation for your pet''s nutrition', 3),
       (7, 'Microchipping', 50.0, 'Microchipping service for identification', 4),
       (8, 'Bathing', 20.0, 'Bathing service for your pet', 5),
       (9, 'Behavioral Training', 100.0, 'Training to address behavioral issues', 6),
       (10, 'Flea and Tick Treatment', 35.0, 'Treatment for fleas and ticks', 16),
       (11, 'Cat Boarding', 40.0, 'Boarding services for cats', 17),
       (12, 'Deworming', 25.0, 'Deworming treatment for your pet', 18),
       (13, 'Bird Grooming', 30.0, 'Grooming services for pet birds', 19),
       (14, 'Exotic Pet Care', 90.0, 'Specialized care for exotic pets', 20),
       (15, 'Dog Walking', 25.0, 'Professional dog walking service', 2),
       (16, 'Dental Surgery', 150.0, 'Surgical procedures for pet dental issues', 4),
       (17, 'Pet Massage', 50.0, 'Relaxing massage therapy for your pet', 3),
       (18, 'Allergy Testing', 120.0, 'Testing to identify pet allergies', 6),
       (19, 'Rehabilitation Therapy', 150.0, 'Therapy for pets recovering from injuries', 1),
       (20, 'Pet Bathing', 25.0, 'Bathing service for your pet', 2),
       (21, 'Eye and Ear Care', 70.0, 'Specialized care for pet eye and ear issues', 3),
       (22, 'Pet Dental Care', 80.0, 'Professional dental care for your pet', 5),
       (23, 'Tick Removal', 15.0, 'Removal of ticks from your pet', 7),
       (24, 'Pet Sitting', 40.0, 'Professional pet sitting service', 1),
       (25, 'Nail Trimming', 15.0, 'Trimming your pet''s nails', 8),
       (26, 'Wound Care', 60.0, 'Care for pet wounds and injuries', 9),
       (27, 'Pet Dental Scaling', 100.0, 'Scaling and cleaning for pet teeth', 9),
       (28, 'Pet CPR Training', 80.0, 'Training on pet CPR techniques', 10),
       (29, 'Pet Photography', 80.0, 'Professional pet photography service', 1),
       (30, 'Dog Training', 120.0, 'Training to teach basic commands and obedience', 2),
       (31, 'Pet Transportation', 50.0, 'Transportation service for your pet', 3),
       (32, 'Pet Nail Trimming', 15.0, 'Professional nail trimming for your pet', 4),
       (33, 'Pet Dental Cleaning', 100.0, 'Deep cleaning for your pet''s teeth', 5),
       (34, 'Pet Behavioral Training', 80.0, 'Training to modify pet behavior', 6),
       (35, 'Pet Eye Care', 70.0, 'Specialized care for pet eye conditions', 7),
       (36, 'Pet Bath and Brush', 35.0, 'Bathing and brushing service for your pet', 8),
       (37, 'Pet Health Check-up', 50.0, 'Comprehensive health check-up for your pet', 9),
       (38, 'Pet Dental Examination', 60.0, 'Thorough examination of your pet''s dental health', 11),
       (39, 'Pet Tick Treatment', 40.0, 'Treatment for ticks infestation on your pet', 14),
       (40, 'Overnight Pet Care', 60.0, 'Care for your pet overnight', 12),
       (41, 'Pet Microchip Installation', 50.0, 'Installation of microchip for pet identification', 5),
       (42, 'Pet First Aid Training', 90.0, 'Training on administering first aid to your pet', 6),
       (43, 'Pet Massage Therapy', 70.0, 'Relaxing massage therapy for your pet', 7),
       (44, 'Pet Allergy Treatment', 120.0, 'Treatment for pet allergies', 8),
       (45, 'Pet Rehabilitation Exercises', 80.0, 'Exercises to aid pet rehabilitation', 9),
       (46, 'Pet Ear Cleaning', 30.0, 'Cleaning your pet''s ears', 1);

INSERT INTO service_images (id, url, service_id)
VALUES (1, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377733/Packages/ServiceImage/PEts-like-humans-article-COVER_yzla70.jpg', 1),
       (2, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377767/Packages/ServiceImage/images_kd4ium.jpg', 1),
       (3, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377780/Packages/ServiceImage/home-2_eoovki.jpg', 2),
       (4, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377805/Packages/ServiceImage/pet-care_cat-care_thumb_fgw2hf.jpg', 2),
       (5, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377816/Packages/ServiceImage/images_zansmg.jpg', 3),
       (6, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377827/Packages/ServiceImage/jack-russell-terrier-dog-holding-260nw-2100518530_wojavq.jpg', 3),
       (7, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377935/Packages/ServiceImage/s3wf6poxajhl0fa0adbu.jpg', 4),
       (8, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377973/Packages/ServiceImage/images_jvdrwd.jpg', 4),
       (9, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377994/Packages/ServiceImage/images_g9vmwq.jpg', 1),
       (10, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378011/Packages/ServiceImage/images_una9lg.jpg', 2),
       (11, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378061/Packages/ServiceImage/images_obdjp4.jpg', 3),
       (12, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378127/Packages/ServiceImage/images_vz5c3h.jpg', 4),
       (13, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378142/Packages/ServiceImage/images_rfh8op.jpg', 1),
       (14, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378162/Packages/ServiceImage/images_leocve.jpg', 2),
       (15, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378187/Packages/ServiceImage/images_sdyeow.jpg', 3),
       (16, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378208/Packages/ServiceImage/images_pqgm2f.jpg', 4),
       (17, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378230/Packages/ServiceImage/images_bxpyvu.jpg', 1),
       (18, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378251/Packages/ServiceImage/images_kmpwb2.jpg', 3),
       (19, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377973/Packages/ServiceImage/images_jvdrwd.jpg', 10),
       (20, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377994/Packages/ServiceImage/images_g9vmwq.jpg', 9),
       (21, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378011/Packages/ServiceImage/images_una9lg.jpg', 9),
       (22, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378061/Packages/ServiceImage/images_obdjp4.jpg', 8),
       (23, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378127/Packages/ServiceImage/images_vz5c3h.jpg', 7),
       (24, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378142/Packages/ServiceImage/images_rfh8op.jpg', 11),
       (25, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378162/Packages/ServiceImage/images_leocve.jpg', 12),
       (26, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378187/Packages/ServiceImage/images_sdyeow.jpg', 13),
       (27, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378208/Packages/ServiceImage/images_pqgm2f.jpg', 14),
       (28, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377973/Packages/ServiceImage/images_jvdrwd.jpg', 15),
       (29, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377994/Packages/ServiceImage/images_g9vmwq.jpg', 16),
       (30, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378011/Packages/ServiceImage/images_una9lg.jpg', 17),
       (31, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378061/Packages/ServiceImage/images_obdjp4.jpg', 18),
       (32, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378127/Packages/ServiceImage/images_vz5c3h.jpg', 19),
       (33, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378142/Packages/ServiceImage/images_rfh8op.jpg', 20),
       (34, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378162/Packages/ServiceImage/images_leocve.jpg', 21),
       (35, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378187/Packages/ServiceImage/images_sdyeow.jpg', 22),
       (36, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378208/Packages/ServiceImage/images_pqgm2f.jpg', 25),
       (37, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377973/Packages/ServiceImage/images_jvdrwd.jpg', 5),
       (38, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684377994/Packages/ServiceImage/images_g9vmwq.jpg', 6),
       (39, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378011/Packages/ServiceImage/images_una9lg.jpg', 7),
       (40, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378061/Packages/ServiceImage/images_obdjp4.jpg', 8),
       (41, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378127/Packages/ServiceImage/images_vz5c3h.jpg', 9),
       (42, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378142/Packages/ServiceImage/images_rfh8op.jpg', 10),
       (43, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378162/Packages/ServiceImage/images_leocve.jpg', 12),
       (44, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378187/Packages/ServiceImage/images_sdyeow.jpg', 13),
       (45, 'https://res.cloudinary.com/dhnom0aq3/image/upload/v1684378208/Packages/ServiceImage/images_pqgm2f.jpg', 14);


INSERT INTO package_detail_reviews (id, review, star, `date`, package_detail_id, user_id)
VALUES (1, 'Great service package, highly recommended!', 5, '2022-01-01 10:00:00', 1, 1),
       (2, 'The service package was good, but could be better.', 4, '2022-02-01 11:00:00', 2, 2),
       (3, 'I really enjoyed the service package, will come back again!', 5, '2022-03-01 12:00:00', 1, 1),
       (4, 'Service package was okay, nothing special.', 3, '2022-04-01 13:00:00', 3, 1),
       (5, 'Highly professional service package, exceeded my expectations!', 5, '2022-05-01 14:00:00', 3, 2),
       (6, 'The service package was a bit pricey, but the quality was good.', 4, '2022-06-01 15:00:00', 2, 1),
       (7, 'Great value for money, highly recommend this service package!', 5, '2022-07-01 16:00:00', 3, 1),
       (8, 'Service package was good, but could be better.', 4, '2022-08-01 17:00:00', 1, 2),
       (9, 'The service package was excellent, highly recommended!', 5, '2022-09-01 18:00:00',2,3),
       (10, 'I had a good experience with the service package, but it was a bit too expensive.', 3, '2022-10-01 19:00:00',2,1),
       (11, 'The service package was good, but I expected more.', 4, '2022-11-01 20:00:00',3,2),
       (12, 'I was satisfied with the service package, but there is room for improvement.', 4, '2022-12-01 21:00:00',1,3),
       (13, 'The service package was great, exceeded my expectations!', 5, '2023-01-01 22:00:00',1,4),
       (14, 'I had a good experience with the service package, but it was a bit overpriced.', 4, '2023-02-01 23:00:00',2,3),
       (15, 'The service package was excellent, highly recommended!', 5, '2023-03-01 00:00:00',3,1),
       (16, 'The service package was good, but I expected more.', 4, '2023-04-01 01:00:00',6,1),
       (17, 'I enjoyed the service package, but the price was a bit high.', 4, '2023-05-01 02:00:00',1,2),
       (18, 'The service package was good, but it could be better.', 3, '2023-06-01 03:00:00',3,2),
       (19, 'Great service package, highly recommended!', 5, '2023-07-01 04:00:00',1,4),
       (20, 'The service package was good, but the quality was inconsistent.', 3, '2023-08-01 05:00:00', 2, 1);



INSERT INTO `orders` (id, phone_number, note, `date`, address, `status`, total, user_id)
VALUES (1,'1234567890', 'Please deliver ASAP', '2023-05-19 10:00:00', '123 Main St, City, Country', 'Pending', 45.3, 1);

INSERT INTO `orders` (id,phone_number, note, `date`, address, `status`, total, user_id)
VALUES (2,'9876543210', 'Call before delivery', '2023-05-20 15:30:00', '456 Elm St, City, Country', 'Processing', 35.3,
        2);

INSERT INTO `orders` (id, phone_number, note, `date`, address, `status`, total, user_id)
VALUES (3,'5555555555', 'No onions, please', '2023-05-21 18:00:00', '789 Oak St, City, Country', 'Completed', 35.3, 1);

INSERT INTO `order_detail` (id, item_name, image, quantity, total, note, orders_id)
VALUES (4,'Item 1', 'https://loremflickr.com/641/480/food', 2, 10.99, 'No special instructions', 1);

INSERT INTO `order_detail` (id, item_name, image, quantity, total, note, orders_id)
VALUES (5,'Item 2', 'https://loremflickr.com/641/480/food', 1, 5.99, 'Extra cheese', 1);

INSERT INTO `order_detail` (id, item_name, image, quantity, total, note, orders_id)
VALUES (6,'Item 3', 'https://loremflickr.com/641/480/food', 3, 20.99, 'Gluten-free option', 2);

INSERT INTO `order_detail` (id, item_name, image, quantity, total, note, orders_id)
VALUES (7,'Item 4', 'https://loremflickr.com/641/480/food', 1, 7.99, 'Spicy', 3);

INSERT INTO `order_detail` (id, item_name, image, quantity, total, note, orders_id)
VALUES (8,'Item 5', 'https://loremflickr.com/641/480/food', 2, 15.99, 'No onions', 3);

Insert into `favorites` (id, user_id)
values (1,1),
       (2,2),
       (3,3);

insert into `favorite_products` (id, favorite_id,product_id)
values (1,1,1),
       (2,1,2),
       (3,2,4),
       (4,2,3);
create table cart
(
    `id`            bigint primary key auto_increment,
    `amount_item`   int           default 0,
    `total_payment` double(16, 4) default 0.0000,
    `cart_date`     date,
    `user_id`       bigint not null unique
);

create table cart_detail
(
    `id`          bigint primary key auto_increment,
    `type`        bit    not null check (`type` = 0 or `type` = 1),
    `cart_id`     bigint not null,
    `type_id`     bigint not null,
    `total_price` double not null,
    `amount`      int    not null,
    `status`      bit check (`status` = 0 or `status` = 1)
);


use heroku_fd2d0778887fe46;
select * from package_detail_reviews;
drop table role;
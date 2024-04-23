-- Users table
CREATE TABLE Users (
    user_id NUMBER NOT NULL PRIMARY KEY,
    username VARCHAR2(15),
    first_name VARCHAR2(30) NOT NULL,
    last_name VARCHAR2(30), 
    phone_number VARCHAR2(20) NOT NULL,
    bio VARCHAR2(50),
    is_premium NUMBER(1) DEFAULT 0 NOT NULL,
    last_online_timestamp TIMESTAMP NOT NULL
);

-- Groups table
CREATE TABLE Groups (
    chat_id NUMBER NOT NULL PRIMARY KEY,
    title VARCHAR2(50) NOT NULL,
    description VARCHAR2(100),
    available_reactions NUMBER(1) DEFAULT 1 NOT NULL,
    is_private NUMBER(1) DEFAULT 1 NOT NULL,
    is_history_hidden NUMBER(1) DEFAULT 1 NOT NULL,
    creation_date DATE NOT NULL,
    creater_id NUMBER NOT NULL,
    FOREIGN KEY (creater_id) REFERENCES Users(user_id)
);

-- Users_Groups table
CREATE TABLE Users_Groups (
    user_group_id NUMBER NOT NULL PRIMARY KEY,
    user_id NUMBER NOT NULL,
    chat_id NUMBER NOT NULL,
    role VARCHAR2(15),
    is_muted NUMBER(1) DEFAULT 0 NOT NULL,
    is_admin NUMBER(1) DEFAULT 0 NOT NULL,
    change_group_info NUMBER(1) DEFAULT 0 NOT NULL,
    manage_messages NUMBER(1) DEFAULT 0 NOT NULL,
    add_members NUMBER(1) DEFAULT 0 NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (chat_id) REFERENCES Groups(chat_id)
);

-- Channels table
CREATE TABLE Channels (
    channel_id NUMBER NOT NULL PRIMARY KEY,
    title VARCHAR2(50) NOT NULL,
    description VARCHAR2(100),
    available_reactions NUMBER(1) DEFAULT 1 NOT NULL,
    is_private NUMBER(1) NOT NULL,
    is_verified NUMBER(1) DEFAULT 0 NOT NULL,
    creation_date DATE NOT NULL,
    is_signed_message NUMBER(1) DEFAULT 0 NOT NULL,
    comment_chat_id NUMBER UNIQUE,
    creater_id NUMBER NOT NULL,
    FOREIGN KEY (comment_chat_id) REFERENCES Groups(chat_id),
    FOREIGN KEY (creater_id) REFERENCES Users(user_id)
);

-- Users_Channels table
CREATE TABLE Users_Channels (
    user_channel_id NUMBER NOT NULL PRIMARY KEY,
    user_id NUMBER NOT NULL,
    channel_id NUMBER NOT NULL,
    data_joined TIMESTAMP,
    is_muted NUMBER(1) DEFAULT 0 NOT NULL,
    is_admin NUMBER(1) DEFAULT 0 NOT NULL,
    change_channel_info NUMBER(1) DEFAULT 0 NOT NULL,
    manage_messages NUMBER(1) DEFAULT 0 NOT NULL,
    add_members NUMBER(1) DEFAULT 0 NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (channel_id) REFERENCES Channels(channel_id)
);

-- Messages table (Private)
CREATE TABLE Messages (
    message_id NUMBER NOT NULL PRIMARY KEY,
    message VARCHAR2(5000) NOT NULL,
    data_written TIMESTAMP NOT NULL,
    is_edit NUMBER(1) DEFAULT 0 NOT NULL,
    sender_id NUMBER NOT NULL,
    receiver_id NUMBER NOT NULL,
    is_reply_message NUMBER(1) DEFAULT 0 NOT NULL,
    is_forward_message NUMBER(1) DEFAULT 0 NOT NULL,
    reply_to_message_id NUMBER,
    forward_origin_id NUMBER,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id),
    FOREIGN KEY (reply_to_message_id) REFERENCES Messages(message_id),
    FOREIGN KEY (forward_origin_id) REFERENCES Users(user_id)
);

-- Folders table
CREATE TABLE Folders (
    folder_id NUMBER NOT NULL PRIMARY KEY,
    icon VARCHAR2(4) NOT NULL,
    name_folder VARCHAR2(10) NOT NULL,
    user_id NUMBER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Payments_Methods table
CREATE TABLE Payments_Methods (
    payment_method_id NUMBER NOT NULL PRIMARY KEY,
    user_id NUMBER NOT NULL,
    card_number VARCHAR2(16) NOT NULL,
    card_type VARCHAR2(20) NOT NULL,
    expiration_month NUMBER(2) NOT NULL,
    expiration_year NUMBER(2) NOT NULL,
    cvc_code NUMBER(3) NOT NULL,
    cardholder_name VARCHAR2(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Payments table
CREATE TABLE Payments (
    payment_id NUMBER NOT NULL PRIMARY KEY,
    user_id NUMBER NOT NULL,
    payment_method_id NUMBER NOT NULL,
    amount NUMBER(5, 2) NOT NULL,
    currency CHAR(3) NOT NULL,
    payment_date DATE NOT NULL,
    premium_duration DATE NOT NULL,
    auto_renewal NUMBER(1) DEFAULT 0 NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (payment_method_id) REFERENCES Payments_Methods(payment_method_id)
);

-- Insert data into the Users table 
INSERT INTO Users VALUES (0, 'dima_varich', 'Dmytro', 'Varich', '421956169055', 'Universe Architect 🌌', 1, CURRENT_TIMESTAMP);
INSERT INTO Users VALUES (1, 'emismi', 'Emily', 'Smith', '380956239273', '🎨 Artistic dreamer, creating beauty', 0, CURRENT_TIMESTAMP); 
INSERT INTO Users VALUES (2, NULL, 'James', NULL, '1234567890', '🏈 Athletic spirit, conquering fields', 0, CURRENT_TIMESTAMP); 
INSERT INTO Users VALUES (3, 'michael_will', 'Michael', 'Williams', '1987654321', NULL, 1, CURRENT_TIMESTAMP); 
INSERT INTO Users VALUES (4, NULL, 'Olivia', NULL, '1555123456', NULL, 0, CURRENT_TIMESTAMP); 
INSERT INTO Users VALUES (5, 'martinez123', 'Sophia', 'Martinez', '1789456123', '🌿 Eco warrior, saving nature', 1, CURRENT_TIMESTAMP); 
INSERT INTO Users VALUES (6, 'just_in', 'Justin', NULL, '1333222111', ' 🎸 Musician rocking stages', 0, CURRENT_TIMESTAMP); 
INSERT INTO Users VALUES (7, NULL, 'Alexander', 'Anderson', '1444333222', NULL, 1, CURRENT_TIMESTAMP); 
INSERT INTO Users VALUES (8, 'bella_is_one', 'Isabella', NULL, '1777888999', NULL, 1, CURRENT_TIMESTAMP); 
INSERT INTO Users VALUES (9, 'garcia233', 'Ethan', 'Garcia', '1888999000', '🍳 Culinary artist, cooking delights', 0, CURRENT_TIMESTAMP);

-- Insert data into the Groups table 
INSERT INTO Groups VALUES (0, 'Programming101', 'A group for learning programming basics.', 1, 0, 1, TO_DATE('2024-03-06', 'YYYY-MM-DD'), 0);
INSERT INTO Groups VALUES (1, 'Art Lovers', NULL, 1, 1, 0, TO_DATE('2024-03-07', 'YYYY-MM-DD'), 1);
INSERT INTO Groups VALUES (2, 'Fitness Gurus', 'Join us for fitness tips and motivation!', 0, 1, 1, TO_DATE('2024-03-08', 'YYYY-MM-DD'), 2);
INSERT INTO Groups VALUES (3, 'Travel Enthusiasts', 'Share your travel experiences and recommendations.', 0, 1, 0, TO_DATE('2024-03-09', 'YYYY-MM-DD'), 7);
INSERT INTO Groups VALUES (4, 'Book Club', 'Discuss your favorite books and authors with fellow bookworms.', 1, 0, 1, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 4);
INSERT INTO Groups VALUES (5, 'Photography Enthusiasts', 'Share and critique photography.', 1, 0, 0, TO_DATE('2024-03-11', 'YYYY-MM-DD'), 8);
INSERT INTO Groups VALUES (6, 'Cooking Lovers', NULL, 1, 0, 1, TO_DATE('2024-03-12', 'YYYY-MM-DD'), 9);
INSERT INTO Groups VALUES (7, 'Music Fans', 'Discuss your favorite bands and music genres.', 1, 1, 0, TO_DATE('2024-03-13', 'YYYY-MM-DD'), 6);
INSERT INTO Groups VALUES (8, 'Technology Geeks', NULL, 0, 0, 1, TO_DATE('2024-03-14', 'YYYY-MM-DD'), 3);
INSERT INTO Groups VALUES (9, 'Pet Lovers', 'Share pictures and stories of your beloved pets.', 0, 0, 1, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 5);

-- Insert data into the Users_Groups table 
INSERT INTO Users_Groups VALUES (0, 0, 0, 'Owner', 0, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (1, 1, 1, NULL, 1, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (2, 2, 2, 'Coach', 1, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (3, 3, 8, 'Mentor', 0, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (4, 4, 4, NULL, 0, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (5, 5, 9, 'Creater', 0, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (6, 6, 7, 'Owner', 1, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (7, 7, 3, NULL, 0, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (8, 8, 5, 'Photographer', 0, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (9, 9, 6, 'Chef', 1, 1, 1, 1, 1);
INSERT INTO Users_Groups VALUES (10, 0, 6, NULL, 0, 1, 0, 1, 1);
INSERT INTO Users_Groups VALUES (11, 1, 7, 'Moderator', 1, 1, 1, 0, 1);
INSERT INTO Users_Groups VALUES (12, 2, 9, 'Animal Lover', 1, 1, 0, 1, 0);
INSERT INTO Users_Groups VALUES (13, 3, 3, NULL, 0, 1, 0, 0, 1);
INSERT INTO Users_Groups VALUES (14, 4, 0, 'Geek', 0, 1, 1, 0, 1);
INSERT INTO Users_Groups VALUES (15, 5, 1, 'Enthusiast', 0, 0, 0, 1, 1);
INSERT INTO Users_Groups VALUES (16, 6, 2, 'Motivator', 0, 1, 1, 0, 1);
INSERT INTO Users_Groups VALUES (17, 7, 5, NULL, 0, 1, 0, 1, 1);
INSERT INTO Users_Groups VALUES (18, 8, 4, 'Moderator', 0, 0, 0, 0, 1);
INSERT INTO Users_Groups VALUES (19, 9, 8, NULL, 1, 0, 1, 0, 1);

-- Insert data into the Channels table
INSERT INTO Channels VALUES (0, 'TechTalks', 'Latest tech news and discussions', 1, 0, 1, TO_DATE('2024-03-01', 'YYYY-MM-DD'), 0, NULL, 0);
INSERT INTO Channels VALUES (1, 'DailyFitness', 'Your daily dose of fitness', 0, 0, 0, TO_DATE('2024-03-02', 'YYYY-MM-DD'), 1, NULL, 1);
INSERT INTO Channels VALUES (2, 'BookReaders', 'A community of book lovers', 1, 1, 1, TO_DATE('2024-03-03', 'YYYY-MM-DD'), 0, NULL, 2);
INSERT INTO Channels VALUES (3, 'TravelGuide', 'Guides and tips for travelers', 0, 0, 1, TO_DATE('2024-03-04', 'YYYY-MM-DD'), 1, NULL, 3);
INSERT INTO Channels VALUES (4, 'MusicMatters', 'All about music', 1, 1, 0, TO_DATE('2024-03-05', 'YYYY-MM-DD'), 0, NULL, 4);
INSERT INTO Channels VALUES (5, 'ArtistsCorner', 'For the artists and the art lovers', 0, 1, 1, TO_DATE('2024-03-06', 'YYYY-MM-DD'), 1, NULL, 5);
INSERT INTO Channels VALUES (6, 'CoderHub', 'Coding resources and discussions', 1, 0, 0, TO_DATE('2024-03-07', 'YYYY-MM-DD'), 0, NULL, 6);
INSERT INTO Channels VALUES (7, 'HealthyEating', 'Nutrition and healthy eating', 0, 0, 1, TO_DATE('2024-03-08', 'YYYY-MM-DD'), 1, NULL, 7);
INSERT INTO Channels VALUES (8, 'SciFiWorld', 'Science Fiction discussions and fan theories', 1, 1, 0, TO_DATE('2024-03-09', 'YYYY-MM-DD'), 0, NULL, 8);
INSERT INTO Channels VALUES (9, 'CinemaLovers', 'Discussions about films and cinema', 0, 1, 1, TO_DATE('2024-03-10', 'YYYY-MM-DD'), 1, NULL, 9);

-- Insert data into the Users_Channels table
INSERT INTO Users_Channels VALUES (0, 0, 0, TIMESTAMP '2024-03-01 08:00:00', 0, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (1, 1, 1, TIMESTAMP '2024-03-02 09:00:00', 1, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (2, 2, 2, TIMESTAMP '2024-03-03 10:00:00', 0, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (3, 3, 3, TIMESTAMP '2024-03-04 11:00:00', 1, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (4, 4, 4, TIMESTAMP '2024-03-05 12:00:00', 0, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (5, 5, 5, TIMESTAMP '2024-03-06 13:00:00', 1, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (6, 6, 6, TIMESTAMP '2024-03-07 14:00:00', 0, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (7, 7, 7, TIMESTAMP '2024-03-08 15:00:00', 1, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (8, 8, 8, TIMESTAMP '2024-03-09 16:00:00', 0, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (9, 9, 9, TIMESTAMP '2024-03-10 17:00:00', 1, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (10, 0, 5, TIMESTAMP '2024-03-11 18:00:00', 0, 1, 0, 0, 1);
INSERT INTO Users_Channels VALUES (11, 1, 6, TIMESTAMP '2024-03-12 19:00:00', 1, 0, 0, 0, 0);
INSERT INTO Users_Channels VALUES (12, 2, 7, TIMESTAMP '2024-03-13 20:00:00', 0, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (13, 3, 8, TIMESTAMP '2024-03-14 21:00:00', 1, 0, 0, 0, 0);
INSERT INTO Users_Channels VALUES (14, 4, 9, TIMESTAMP '2024-03-15 22:00:00', 0, 1, 1, 1, 1);
INSERT INTO Users_Channels VALUES (15, 5, 0, TIMESTAMP '2024-03-16 23:00:00', 1, 0, 0, 0, 0);
INSERT INTO Users_Channels VALUES (16, 6, 1, TIMESTAMP '2024-03-17 12:00:00', 0, 1, 1, 0, 1);
INSERT INTO Users_Channels VALUES (17, 7, 2, TIMESTAMP '2024-03-18 13:00:00', 1, 0, 0, 0, 0);
INSERT INTO Users_Channels VALUES (18, 8, 3, TIMESTAMP '2024-03-19 14:00:00', 0, 1, 0, 1, 1);
INSERT INTO Users_Channels VALUES (19, 9, 4, TIMESTAMP '2024-03-20 15:00:00', 0, 0, 0, 0, 0);

-- Insert data into the Messages table
INSERT INTO Messages VALUES (0, 'Hello, everyone!', TIMESTAMP '2024-03-01 09:00:00', 0, 0, 1, 0, 0, NULL, NULL);
INSERT INTO Messages VALUES (1, 'Good morning!', TIMESTAMP '2024-03-02 08:30:00', 1, 1, 0, 1, 0, 0, NULL);
INSERT INTO Messages VALUES (2, 'How are you all doing today?', TIMESTAMP '2024-03-03 10:15:00', 0, 2, 3, 0, 0, NULL, NULL);
INSERT INTO Messages VALUES (3, 'I am excited for our upcoming trip!', TIMESTAMP '2024-03-04 14:00:00', 1, 3, 4, 0, 1, NULL, 6);
INSERT INTO Messages VALUES (4, 'Just finished reading a great book!', TIMESTAMP '2024-03-05 16:45:00', 0, 4, 5, 0, 0, NULL, NULL);
INSERT INTO Messages VALUES (5, 'Check out this amazing photo I took!', TIMESTAMP '2024-03-06 18:20:00', 1, 5, 6, 0, 0, NULL, NULL);
INSERT INTO Messages VALUES (6, 'Anyone up for cooking together this weekend?', TIMESTAMP '2024-03-07 20:00:00', 1, 6, 7, 0, 1, NULL, 0);
INSERT INTO Messages VALUES (7, 'What is your favorite genre of music?', TIMESTAMP '2024-03-08 22:30:00', 1, 7, 8, 0, 0, NULL, NULL);
INSERT INTO Messages VALUES (8, 'Just watched an amazing sci-fi movie!', TIMESTAMP '2024-03-09 12:15:00', 0, 8, 9, 0, 0, NULL, NULL);
INSERT INTO Messages VALUES (9, 'I recommend everyone to watch the latest thriller!', TIMESTAMP '2024-03-10 10:45:00', 0, 9, 8, 1, 1, 9, 2);

-- Insert data into the Folders table
INSERT INTO Folders VALUES (0, '💻', 'Work', 0);
INSERT INTO Folders VALUES (1, '👥', 'Personal', 1);
INSERT INTO Folders VALUES (2, '💻', 'Projects', 2);
INSERT INTO Folders VALUES (3, '💵', 'Business', 3);
INSERT INTO Folders VALUES (4, '📁', 'Documents', 4);
INSERT INTO Folders VALUES (5, '🎵', 'Music', 5);
INSERT INTO Folders VALUES (6, '📖', 'Book', 6);
INSERT INTO Folders VALUES (7, '👥', 'Archive', 7);
INSERT INTO Folders VALUES (8, '📁', 'Downloads', 8);
INSERT INTO Folders VALUES (9, '📂', 'Backup', 9);
INSERT INTO Folders VALUES (10, '📖', 'Study', 0);
INSERT INTO Folders VALUES (11, '💵', 'Investing', 1);
INSERT INTO Folders VALUES (12, '📁', 'Documents', 2);
INSERT INTO Folders VALUES (13, '🎵', 'Audio', 3);
INSERT INTO Folders VALUES (14, '📁', 'Cars', 4);
INSERT INTO Folders VALUES (15, '👥', 'Private', 5);
INSERT INTO Folders VALUES (16, '💵', 'Money', 6);
INSERT INTO Folders VALUES (17, '📖', 'TUKE', 7);
INSERT INTO Folders VALUES (18, '📁', 'Projects', 8);
INSERT INTO Folders VALUES (19, '👥', 'Contacts', 9);

-- Insert data into the Payments_Methods table
INSERT INTO Payments_Methods VALUES (0, 0, '1234567890123456', 'American Express', 12, 24, 123, 'Dmytro Varich');
INSERT INTO Payments_Methods VALUES (1, 1, '9876543210987654', 'Mastercard', 11, 23, 456, 'Emily Smith');
INSERT INTO Payments_Methods VALUES (2, 2, '1111222233334444', 'Visa', 10, 25, 789, 'James Johnson');
INSERT INTO Payments_Methods VALUES (3, 3, '4444333322221111', 'Discover', 9, 24, 321, 'Michael Williams');
INSERT INTO Payments_Methods VALUES (4, 4, '5555666677778888', 'Visa', 8, 23, 654, 'Olivia Wilson');
INSERT INTO Payments_Methods VALUES (5, 5, '8888999911112222', 'Mastercard', 7, 25, 987, 'Sophia Martinez');
INSERT INTO Payments_Methods VALUES (6, 6, '7777666655554444', 'Discover', 6, 24, 657, 'Justin Kim');
INSERT INTO Payments_Methods VALUES (7, 7, '3333444455556666', 'American Express', 5, 23, 391, 'Alexander Anderson');
INSERT INTO Payments_Methods VALUES (8, 8, '2222333344445555', 'Visa', 4, 25, 789, 'Isabella Brown');
INSERT INTO Payments_Methods VALUES (9, 9, '6666777788889999', 'Mastercard', 3, 24, 143, 'Ethan Garcia');

-- Insert data into the Payments table
INSERT INTO Payments VALUES (0, 0, 0, 50.00, 'USD', TO_DATE('2023-03-01', 'YYYY-MM-DD'), TO_DATE('2024-03-08', 'YYYY-MM-DD'), 1);
INSERT INTO Payments VALUES (1, 9, 9, 45.00, 'GPB', TO_DATE('2023-03-10', 'YYYY-MM-DD'), TO_DATE('2024-03-10', 'YYYY-MM-DD'), 0);
INSERT INTO Payments VALUES (2, 1, 1, 5.50, 'EUR', TO_DATE('2023-12-02', 'YYYY-MM-DD'), TO_DATE('2024-01-02', 'YYYY-MM-DD'), 0);
INSERT INTO Payments VALUES (3, 2, 2, 125.25, 'UAH', TO_DATE('2024-01-02', 'YYYY-MM-DD'), TO_DATE('2024-02-02', 'YYYY-MM-DD'), 0);
INSERT INTO Payments VALUES (4, 6, 6, 5.50, 'EUR', TO_DATE('2024-02-07', 'YYYY-MM-DD'), TO_DATE('2024-03-07', 'YYYY-MM-DD'), 0);
INSERT INTO Payments VALUES (5, 8, 8, 5.00, 'USD', TO_DATE('2024-03-04', 'YYYY-MM-DD'), TO_DATE('2024-04-04', 'YYYY-MM-DD'), 1);
INSERT INTO Payments VALUES (6, 5, 5, 65.00, 'EUR', TO_DATE('2024-03-05', 'YYYY-MM-DD'), TO_DATE('2025-03-05', 'YYYY-MM-DD'), 1);
INSERT INTO Payments VALUES (7, 3, 3, 4.50, 'GPB', TO_DATE('2024-03-06', 'YYYY-MM-DD'), TO_DATE('2024-04-06', 'YYYY-MM-DD'), 0);
INSERT INTO Payments VALUES (8, 0, 0, 50.00, 'USD', TO_DATE('2024-03-08', 'YYYY-MM-DD'), TO_DATE('2025-03-08', 'YYYY-MM-DD'), 1);
INSERT INTO Payments VALUES (9, 7, 7, 800.00, 'UAH', TO_DATE('2024-03-09', 'YYYY-MM-DD'), TO_DATE('2025-03-09', 'YYYY-MM-DD'), 1);

-- Drop all tables
DROP TABLE Payments;
DROP TABLE Payments_Methods;
DROP TABLE Folders;
DROP TABLE Messages;
DROP TABLE Users_Channels;
DROP TABLE Users_Groups;
DROP TABLE Channels;
DROP TABLE Groups;
DROP TABLE Users;

-- Delete (Truncate) all values in table
TRUNCATE TABLE Payments;
TRUNCATE TABLE Payments_Methods;
TRUNCATE TABLE Folders;
TRUNCATE TABLE Messages;
TRUNCATE TABLE Users_Channels;
TRUNCATE TABLE Users_Groups;
TRUNCATE TABLE Channels;
TRUNCATE TABLE Groups;
TRUNCATE TABLE Users;

-- Retrieve titles and descriptions for global search by letter 'P' 
SELECT title, description
FROM Groups
WHERE is_private = 0 AND UPPER(title) LIKE 'P%'
ORDER BY title;

-- Selecting Folders belonging to user with user_id = 0
SELECT CONCAT(icon, name_folder) AS folder_list
FROM Folders
WHERE user_id = 0;

-- Retrieve the first name of users along with the titles of the Groups and Channels they created
SELECT U.first_name, G.title AS group_title, CN.title AS channel_title
FROM Users U
INNER JOIN Groups G ON U.user_id = G.creater_id
INNER JOIN Channels CN ON U.user_id = CN.creater_id;

-- Retrieve usernames and associated cardholder names from Payment Methods, using a left outer join 
SELECT U.first_name, PM.cardholder_name
FROM Users U
LEFT OUTER JOIN Payments_Methods PM ON U.user_id = PM.user_id;

-- Retrieve users' first names along with the messages they have received, using a full outer join
SELECT U.first_name, M.message 
FROM Users U
FULL OUTER JOIN Messages M ON U.user_id = M.receiver_id;

-- Count of participants in Groups
SELECT G.title, COUNT(UG.user_id) AS participants_count
FROM Users_Groups UG 
JOIN Groups G ON UG.chat_id = G.chat_id
GROUP BY G.title, G.chat_id
HAVING COUNT(UG.user_id) > 1
ORDER BY G.chat_id;

-- Total Payments made by each user 
SELECT PM.cardholder_name, U.username, U.first_name, U.phone_number, SUM(P.amount) AS amount_sum, P.currency
FROM Payments P
JOIN Payments_Methods PM ON P.payment_method_id = PM.payment_method_id
JOIN Users U ON P.user_id = U.user_id
GROUP BY PM.cardholder_name, U.username, U.first_name, U.phone_number, P.currency
ORDER BY PM.cardholder_name;

-- Retrieve titles from both Groups and Channels
SELECT title FROM Groups 
UNION 
SELECT title FROM Channels;

-- Retrieve user information along with the count of messages received by each user
SELECT U.user_id, U.username, U.first_name, (SELECT COUNT(message) FROM Messages M WHERE M.receiver_id = U.user_id) AS message_count
FROM Users U;

-- Retrieve all columns from the Users table for users who have folders with names appearing more than once
SELECT * 
FROM Users
WHERE user_id IN (
    SELECT user_id
    FROM Folders
    WHERE name_folder IN (
        SELECT name_folder
        FROM Folders
        GROUP BY name_folder
        HAVING COUNT(name_folder) > 1
    )
);

-- Create sequence for user_id
CREATE SEQUENCE user_id_seq
    MINVALUE 1
    START WITH 10
    INCREMENT BY 1
    CACHE 20;

-- Drop sequence 
DROP SEQUENCE user_id_seq;

-- Create trigger and generates a new user ID before inserting a row into the Users table
CREATE OR REPLACE TRIGGER User_Id_Trigger
BEFORE INSERT ON Users  
FOR EACH ROW
BEGIN 
    SELECT user_id_seq.NEXTVAL
    INTO :new.user_id
    FROM dual;
END; 

-- Test by inserting new values without primary key
INSERT INTO Users (username, first_name, last_name, phone_number, bio, is_premium, last_online_timestamp) 
VALUES ('john_doe', 'John', 'Doe', '+1234567890', 'Software Engineer 👨‍💻', 0, CURRENT_TIMESTAMP);

INSERT INTO Users (username, first_name, last_name, phone_number, bio, is_premium, last_online_timestamp) 
VALUES ('alice_smith', 'Alice', 'Smith', '+9876543210', 'Web Developer 💻', 1, CURRENT_TIMESTAMP);

INSERT INTO Users (username, first_name, last_name, phone_number, bio, is_premium, last_online_timestamp) 
VALUES ('emily_brown', 'Emily', 'Brown', '+5555555555', 'Graphic Designer 🎨', 1, CURRENT_TIMESTAMP);

SELECT * FROM Users

-- Create trigger and notifies administrators about suspicious messages from Messages table
CREATE OR REPLACE TRIGGER Notification_To_Admin_Trigger
AFTER INSERT ON Messages
FOR EACH ROW 
WHEN (LOWER(NEW.message) LIKE 'terror%' OR LOWER(NEW.message) LIKE 'drug%' OR LOWER(NEW.message) LIKE 'weapon%')
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Message for Administrators: ');
    DBMS_OUTPUT.PUT_LINE('Suspicious Message: ' || :NEW.message || ' from user_id: ' || :NEW.receiver_id);
END;

-- Launch on the console
SET SERVEROUTPUT ON;

-- Checking if the trigger is working for detecting suspicious Messages 
INSERT INTO Messages VALUES (10, 'Terrorism should never be tolerated.', TIMESTAMP '2024-03-01 09:00:00', 0, 0, 1, 0, 0, NULL, NULL);
INSERT INTO Messages VALUES (11, 'I heard there is a drug trafficking ring in the city.', TIMESTAMP '2024-03-02 08:30:00', 1, 1, 0, 1, 0, 0, NULL);
INSERT INTO Messages VALUES (12, 'He is carrying a weapon with him.', TIMESTAMP '2024-03-03 10:15:00', 0, 2, 3, 0, 0, NULL, NULL);
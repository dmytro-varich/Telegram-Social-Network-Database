# 📁 Telegram Social Network Database

## Introduction 
The main task of this assignment was to implement a database for the Telegram social network. Telegram is a platform for instant messaging and multimedia content exchange among users over the internet. The database for this social network contains multiple tables with various attributes. Our goal was to create similar tables and demonstrate their potential implementation. In our database, we created primary tables that we considered important, namely Users, Groups, Channels, Messages, Folders, Payments, and Payments_Methods. Additionally, we also created so-called junction tables, which connect two tables together: Users_Groups and Users_Channels.

Before the actual implementation of the database in the code, it is necessary to characterize what each table means and what role it plays. The first and main table, which is linked to all tables in our database, is the Users table, which stores information about users in the social network. Then there are two tables that serve similar functions and mainly have identical attributes. Additionally, they are connected by additional tables because they have the same N:M relationship. These are the Groups and Channels tables, which store information about groups and channels associated with users. Next is one of the important tables in the Telegram application database itself, which has many more attributes and similar tables - the Messages table. It contains information about messages that a user has sent, along with other metadata. The Folders table does not display all the options it demonstrates in the actual messenger database, for example, in the application itself, the Folders table should have a junction table that stores information about the identifiers of chats to which the user wants to attach a specific folder. In our case, we only have the folder name and an icon created by the user. And the last tables in our database are Payments and Payments_Methods. It should be noted that a user's payment will be recorded in the table only if they have purchased a premium subscription for their account, and Payments_Methods is just an auxiliary table that stores data about the user's payment method.

After formulating a description for each table, we proceed to create an ER-diagram and a Relational Schema for further organization and better understanding of the implementation of our database in the code. It is in these schemas that we can visually see the attributes in the tables, their relationships, associations, and keys, which gives us an undeniable advantage before meeting task deadlines.

The actual creation of tables and their subsequent population with data was carried out using the Oracle SQL language and its object-relational system. Simple CREATE and INSERT commands allowed us to fulfill the first part of the task and begin with the second part. 

The second part includes operations such as DROP and TRUNCATE, solely to demonstrate our skills and knowledge in their usage. However, the main focus of this work is also on displaying potential queries to the database of the real Telegram application, using commands such as SELECT, as well as their combination with other commands, and the use of SEQUENCE and TRIGGER.

## ER-diagram
![ER-diagram](https://github.com/dmytro-varich/Telegram-Social-Network-Database/blob/main/Telegram_Social_Network_Database-ER-diagram.drawio.png)   

## Relational Schema
![Relational Schema](https://github.com/dmytro-varich/Telegram-Social-Network-Database/blob/main/Telegram_Social_Network_Database-Relational-Schema.drawio.png)

## Conclusion
The outcome of our work can be deemed successful as we have created a comprehensive database and populated it with fictitious data, thereby validating real-world scenarios for the Telegram application. One of our key objectives was to learn the fundamentals of relational database creation and validate this knowledge in practice. It is also worth noting that we adhered to the planned timelines, enabling us to confidently evaluate our work as excellent.

## Author
I'm Dmytro Varich, currently pursuing my studies at [TUKE](https://www.tuke.sk/wps/portal) University with a focus on Intelligent Systems. This documentation serves as part of my Assignment 1,2 submission for the "Application of Database Systems" course. Additionally, it is also shared on my [Telegram](https://t.me/varich_channel) channel.

Contact Email: dmytro.varich@student.tuke.sk
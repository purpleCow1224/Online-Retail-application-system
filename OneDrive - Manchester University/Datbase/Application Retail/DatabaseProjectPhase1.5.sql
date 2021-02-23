use retail;
CREATE TABLE supplier (
  Supplier_ID           int(10) NOT NULL AUTO_INCREMENT, 
  Supplier_Name         varchar(50), 
  Street                varchar(30), 
  zip                   int(10) UNSIGNED, 
  State                 varchar(2), 
  City                  varchar(20), 
  Supplier_email        varchar(25), 
  Supplier_phone_number varchar(12), 
  Supplier_bank_account int(10), 
  PRIMARY KEY (Supplier_ID));

CREATE TABLE Product (
  Product_ID          int(10) NOT NULL AUTO_INCREMENT, 
  Supplier_ID         int(10) NOT NULL, 
  Product_Name        varchar(20), 
  Product_Description varchar(255), 
  Quantity_of_stock   int(4), 
  Price               Float(4, 2), 
  PRIMARY KEY (Product_ID));

ALTER TABLE product	
    ADD CONSTRAINT FK_A_supplier_ID 
        FOREIGN KEY (Supplier_ID)
            REFERENCES supplier(Supplier_ID);

CREATE TABLE `Transaction` (
  Transaction_ID  int(10) NOT NULL AUTO_INCREMENT, 
  Account_ID      int(10) NULL, 
  Card_type       Enum('VISA', 'MC','DISC','AMEX'), 
  Card_Name       varchar(60), 
  Card_Number     int(16) UNIQUE, 
  Expiry_Date     DATE, 
  CVV             int(3), 
  Billing_Address varchar(100), 
  Payment_Due     FlOAT(8,2), 
  Order_Number    int(10) NULL, 
   
  PRIMARY KEY (Transaction_ID));

ALTER TABLE transaction	
    ADD CONSTRAINT FK_a_transaction_ID
        FOREIGN KEY (Account_ID)
            REFERENCES Customer(Account_ID)
                ON UPDATE CASCADE;

ALTER TABLE transaction	
    ADD CONSTRAINT FK_b_transaction_ID
        FOREIGN KEY (Order_Number)
            REFERENCES order(Order_Number)
                ON UPDATE CASCADE;


CREATE TABLE Customer (
  Account_ID  int(10) NOT NULL AUTO_INCREMENT, 
  Employee_ID int(10), 
  First_Name  varchar(15), 
  Last_Name   varchar(15), 
  Email       varchar(35), 
  Phone       varchar(12), 
  Street      varchar(30), 
  City        varchar(20), 
  State       varchar(2), 
  Zip_Code    int(5) Unsigned, 
  PRIMARY KEY (Account_ID));

ALTER TABLE Customer	
    ADD CONSTRAINT fk_a_Employee_id 
        FOREIGN KEY (Employee_id)
            REFERENCES employee(Employee_id)
                ON UPDATE CASCADE;

CREATE TABLE Employee (
  Employee_ID         int(10) NOT NULL AUTO_INCREMENT,
  Superior_employee_ID  int(10), 
  First_Name          varchar(15), 
  Last_Name           varchar(15), 
  email               varchar(35), 
  Job_title           varchar(15), 

  PRIMARY KEY (Employee_ID));

ALTER TABLE employee
    ADD Constraint fk_Superior_employee_ID 
        foreign key(Employee_ID) 
            references Employee(Employee_ID)
                ON UPDATE CASCADE;

CREATE TABLE Order_Detail (
  Product_ID int(10) NOT NULL, 
   Order_Number    int(10) NOT NULL, 
  Quantity_Wanted   int(10), 
  Price_Each           int(10), 
  PRIMARY KEY (Product_ID, 
  Order_Number));

CREATE TABLE Orders (
  Order_Number   int(10) NOT NULL AUTO_INCREMENT, 
  Account_ID     int(10) NULL, 
  Shipping_Date  Date, 
  Status         Enum('yes','NO'), 
  Order_date     Date, 
  Transaction_ID int(10), 
  PRIMARY KEY (Order_Number));

ALTER TABLE Orders
    ADD Constraint fk_b_order_ID 
        foreign key(Transaction_ID) 
            references transaction(Transaction_ID)
                ON UPDATE CASCADE;

ALTER TABLE Orders
    ADD Constraint fk_b_account_id 
        foreign key(Account_ID) 
            references customer(Account_ID)
                ON UPDATE CASCADE;



Insert into employee()
Values (1,1,'Naomi','Taddesse','helloatone@gmail.com','President');

Insert into employee()
Values (2,2,'Yonael','Dawit','Yonaelemail@gmail.com','Vice President');

Insert into customer
Values (Null, 1, 'Johm', 'Hwoler', 'jhowler@manchester.edu', '240-654-9998', '2796 shepperton terrace', 'Silver Diner', 'NC', '87654');

Insert into customer
Values (Null, 2, 'Zaid', 'Hollister', 'ZHDeneke@manchester.edu', '240-654-8364', 'Huntington sharp st', 'Wolf Diner', 'IN', '53654');

Insert into supplier()
Values(Null,'ShenkoraAgeda Industries', 'plymoth 123', 45353, 'NM', 'IN','ShenkoraAgeda@gmail.com',2322324567, 432342788);

Insert into supplier()
Values(Null,'ShoaDabo Industries', 'Summit 123', 45389, 'NM', 'IN','ShoaDabo@gmail.com',233324567, 444753555);  

Insert into product()
Values(NULL,01,'Vans Sneaker', 'A comfortable shoe that is best for hiking and walking', 8, 89.09 );

Insert into product()
Values(NULL,02,'Nike Sneakers', 'A shoes that makes your feet feel like they are in heaven', 7, 90.00 );     

Insert into Orders
VALUES(null, '3', '2020-12-16', 'yes', '2020-12-11', '1');

Insert into Orders
VALUES(null, '5', '2020-12-17', 'NO', '2020-10-11', '2');

Insert into order_detail()
Values(1,1,2,56.09);

Insert into order_detail()
Values(2,2,5,545.09); 

Insert into transaction() 
Values(1,2,'VISA', 'Hagos Gebrehiwot', 45452578,'2030-09-03',644,' 5343 Helman st', 432.8,1);

Insert into transaction() 
Values(2,3,'Amex', 'Katara Simpleton', 674895578,'2040-09-03',644,' 5343 oakwood st', 5763.8,2);

/* 1 Checks if phone in customer is in a certain format
*/

ALTER TABLE customer
ADD CONSTRAINT CHK_PhoneNum CHECK (Phone LIKE ('___-___-____'));

/* 2 Checks if phone in supplier is in a certain format
*/

ALTER TABLE supplier
ADD CONSTRAINT CHK_SupPhoneNum CHECK (Supplier_phone_number LIKE ('___-___-____'));

/* 3 Checks if email in employee is in a certain format
*/

ALTER TABLE employee
ADD CONSTRAINT CHK_EmpEmail CHECK (email LIKE ('%@%.%'));

/* 4 Checks if email in customer is in a certain format
*/

ALTER TABLE customer
ADD CONSTRAINT CHK_CustEmail CHECK (email LIKE ('%@%.%'));

/* 5 Checks if email in supplier is in a certain format
*/

ALTER TABLE supplier
ADD CONSTRAINT CHK_SupEmail CHECK (Supplier_email LIKE ('%@%.%'));

/* TRIGGERS
*/


/* 1 deletes the account id in transaction where it matches the deleted account id in customer
*/

delimiter //
DROP TRIGGER IF EXISTS Cust_acc_del //
CREATE TRIGGER Cust_acc_del BEFORE DELETE ON customer
FOR EACH ROW
BEGIN   
        Delete From transaction where Account_ID = OLD.Account_ID;
END //
delimiter ;

/* 2 deletes the account_ID from order where it matches the deleted account id in customer
*/   

delimiter //
DROP TRIGGER IF EXISTS Ord_acc_del //
CREATE TRIGGER Ord_acc_del BEFORE DELETE ON customer
FOR EACH ROW
BEGIN   
        Delete From Orders where Account_ID = OLD.Account_ID;
END //
delimiter ;

/* 2.1 Test case for Ord_acc_del
*/
 
DELETE FROM customer
    WHERE Account_ID = 3;  

/* 3 deletes the Order number from transaction it matches the deleted Order Number in ORDER
*/ 

delimiter //
DROP TRIGGER IF EXISTS Trans_ord_del //
CREATE TRIGGER Trans_ord_del BEFORE DELETE ON Transaction
FOR EACH ROW
BEGIN   
        Delete From Orders where Order_Number = OLD.Order_Number;
END //
delimiter ;

/* 3.1 Test case for Trans_ord_del
*/
 
DELETE FROM Transaction
    WHERE Order_Number = 1;

/* 4 Will not let you insert a tuple in order detail unless the producd id and order number exist
*/

delimiter //
DROP TRIGGER IF EXISTS OrdDet_bef_ins //
CREATE TRIGGER OrdDet_bef_ins BEFORE Insert ON Order_Detail
    FOR EACH ROW
    BEGIN  

--      check to make sure the specified Product_ID DOES NOT already exists in that relation.
        IF NEW.Product_ID  NOT IN (Select Product_ID From product) Then
            SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Product_ID may not exist';       
        End IF; 

--      check to make sure the specified Order_Number DOES exist in the customer relation.
        IF NEW.Order_Number  NOT IN (select Order_Number From Orders) Then
                 SIGNAL SQLSTATE '45002' SET MESSAGE_TEXT = 'Order_Number may not exist';            
        END IF;

    END //
delimiter ; 

/* 4.1 Test case for OrdDet_bef_ins(product ID)
*/
 
Insert Into Order_Detail
    VALUES('3', '2', '30', 58.99);

/* 4.2 Test case for OrdDet_bef_ins(pOrder_Number)
*/
 
Insert Into Order_Detail
    VALUES('2', '15', '30', 58.99);

/* 5 Will not let you insert a tuple in order unless the account_ID exist
*/

delimiter //
DROP TRIGGER IF EXISTS Ord_bef_ins //
CREATE TRIGGER Ord_bef_ins BEFORE Insert ON Orders
    FOR EACH ROW
    BEGIN  

--      check to make sure the specified account_ID DOES NOT already exists in that relation.
        IF NEW.account_ID  NOT IN (Select account_ID From customer) Then
            SIGNAL SQLSTATE '45003' SET MESSAGE_TEXT = 'account_ID may not exist';       
        End IF; 


    END //
delimiter ;

/* 5.1 Test case for Ord_bef_ins
*/
 
Insert Into Orders
    VALUES(null, 15, '2020-08-07', 'No', '2020-08-06', 2);

/* 6 Will not let you insert a tuple in transaction unless the account_ID and order number exist
*/

delimiter //
DROP TRIGGER IF EXISTS trans_bef_ins //
CREATE TRIGGER trans_bef_ins BEFORE Insert ON transaction
    FOR EACH ROW
    BEGIN  

--      check to make sure the specified account_ID DOES NOT already exists in that relation.
        IF NEW.account_ID  NOT IN (Select account_ID From customer) Then
            SIGNAL SQLSTATE '45004' SET MESSAGE_TEXT = 'account_ID may not exist';       
        End IF; 

--      check to make sure the specified Order_Number DOES exist in the customer relation.
        IF NEW.Order_Number  NOT IN (select Order_Number From Orders) Then
                 SIGNAL SQLSTATE '45005' SET MESSAGE_TEXT = 'Order_Number may not exist';            
        END IF;

    END //
delimiter ; 

/* 6.1 Test case for trans_bef_ins
*/

Insert Into transaction
    VALUES(null, 15, 'VISA', 'Naomi Dawit', '20200806', '2030-07-03', 656, '2803 kebe road', '765.99', 1);


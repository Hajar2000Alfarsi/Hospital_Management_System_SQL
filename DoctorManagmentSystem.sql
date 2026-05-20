CREATE DATABASE Hospital

USE Hospital

CREATE TABLE Patient (
p_id int IDENTITY(1,1) PRIMARY KEY,
f_name varchar(10),
l_name varchar(10),
email varchar(25) CHECK (email like '%_@_%._%'),
p_address varchar(50),
date_of_birth date,
blood_group varchar(10),
gender varchar(8) Check (gender IN ('Male','Female')),
);

CREATE TABLE Patient_phone(
patient_id int,
phone_number varchar(20),
PRIMARY KEY(patient_id, phone_number),
FOREIGN KEY (patient_id) REFERENCES Patient(p_id)
);

CREATE TABLE Department(
dep_id int IDENTITY(10,1) PRIMARY KEY,
dep_name varchar(15),
dep_location varchar(30),
number_of_doctor int,
contact_number varchar(10),
dep_head int
);

CREATE TABLE Doctor(
d_id int IDENTITY(100,1) PRIMARY KEY,
name varchar(15),
specialization varchar(20),
email varchar(25) CHECK (email like '%_@_%._%'),
license_no varchar(30) unique,
qualification varchar(50),
years_of_experience int,
supervised_id int,
dep_id int,
FOREIGN KEY (supervised_id) REFERENCES Doctor(d_id),
FOREIGN KEY (dep_id) REFERENCES Department(dep_id)
);

CREATE TABLE Doctor_phone(
doctor_id int,
phone_number varchar(10),
PRIMARY KEY(doctor_id, phone_number),
FOREIGN KEY (doctor_id) REFERENCES Doctor(d_id)
);

ALTER TABLE Department
ADD CONSTRAINT FK_DEP_HEAD
FOREIGN KEY (dep_head) REFERENCES Doctor(d_id);

CREATE TABLE billing(
b_id int IDENTITY(1000,1) PRIMARY KEY,
patient_id int,
b_date date,
total_amount decimal(10,3),
payment_status varchar(20),
payment_method varchar(20),
due_date date,
FOREIGN KEY (patient_id) REFERENCES Patient(p_id)
);

CREATE TABLE Appointment(
app_id int IDENTITY(100000,1) PRIMARY KEY,
patient_id int,
doctor_id int,
bill_id int,
app_status varchar(20),
app_type varchar(20),
reason varchar(30),
app_time time,
app_date date,

FOREIGN KEY (patient_id) REFERENCES Patient(p_id),
FOREIGN KEY (doctor_id) REFERENCES Doctor(d_id),
FOREIGN KEY (bill_id) REFERENCES billing(b_id),
);

CREATE TABLE H_Services(
s_id int IDENTITY(10,1),
patient_id int,
department_id int,
s_name int,
s_type int,
s_description int,
unit_price int,

FOREIGN KEY (patient_id) REFERENCES Patient(p_id),
FOREIGN KEY (department_id) REFERENCES Department(dep_id)
);

DROP TABLE H_Services;

CREATE TABLE H_Services(
s_id int IDENTITY(10,1) PRIMARY KEY,
patient_id int,
department_id int,
s_name varchar(10),
s_type varchar(10),
s_description varchar(10),
unit_price decimal(10,3),

FOREIGN KEY (patient_id) REFERENCES Patient(p_id),
FOREIGN KEY (department_id) REFERENCES Department(dep_id)
);

CREATE TABLE Appointment_Services(
service_id int,
appointment_id int,
quantity int,
PRIMARY KEY(service_id, appointment_id),
FOREIGN KEY (service_id) REFERENCES H_Services(s_id),
FOREIGN KEY (appointment_id) REFERENCES Appointment(app_id),
);

CREATE TABLE MedicalRecord(
mr_id int IDENTITY (120000,1) PRIMARY KEY,
patient_id int,
doctor_id int,
appointment_id int,
visit_date date,
preciribed_medications varchar(100),
doctor_notes varchar(100),
follow_up_required varchar(50),
requirement_plan varchar(100),
diagnosis varchar(100),

FOREIGN KEY (patient_id) REFERENCES Patient(p_id),
FOREIGN KEY (doctor_id) REFERENCES Doctor(d_id),
FOREIGN KEY (appointment_id) REFERENCES Appointment(app_id),
);
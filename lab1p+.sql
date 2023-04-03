-- Solution for Lab 1 P+
 
CREATE TABLE department(
    department_name int PRIMARY KEY,
    building_nr int
);

CREATE TABLE employee(
    employee_id int PRIMARY KEY,
    department_name varchar(255) REFERENCES department(departmentName),
    phone_nr int,
    name varchar(255)
);
 
CREATE TABLE doctor(
    doctor_id int REFERENCES employee(employee_id),
    specialization varchar(255),
    room_nr int
);
 
CREATE TABLE nurse(
    nurse_id int REFERENCES employee(employee_id),
    degree varchar(255)
);
 
CREATE TABLE patient(
    patient_id int PRIMARY KEY,
    diagnisises varchar(255),
    age int,
    name varchar(255)
);

CREATE TABLE works_at(
    employee_id int REFERENCES employee(employee_id),
    department_name varchar(255) REFERENCES department(departmentName)
    start_date date
);

CREATE TABLE mentoring(
    mentor_id int REFERENCES employee(employee_id),
    mentee_id int REFERENCES employee(employee_id)
);

CREATE TABLE treating(
    doctor_id int REFERENCES doctor(doctor_id),
    patient_id int REFERENCES patient(patient_id)
);

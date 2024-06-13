CREATE SCHEMA department;
CREATE TABLE department.students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    email VARCHAR(100),
    phone VARCHAR(15)
);
CREATE TABLE department.fees (
    fee_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES department.students(student_id),
    amount DECIMAL(10, 2),
    date_paid DATE,
    payment_method VARCHAR(50)
);
CREATE TABLE department.courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    course_code VARCHAR(10)
);

CREATE TABLE department.enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES department.students(student_id),
    course_id INT REFERENCES department.courses(course_id),
    enrollment_date DATE
);
CREATE TABLE department.lectures (
    lecture_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE department.lecture_course_assignments (
    assignment_id SERIAL PRIMARY KEY,
    lecture_id INT REFERENCES department.lectures(lecture_id),
    course_id INT REFERENCES department.courses(course_id)
);
CREATE TABLE department.teaching_assistants (
    ta_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE department.lecture_ta_assignments (
    assignment_id SERIAL PRIMARY KEY,
    lecture_id INT REFERENCES department.lectures(lecture_id),
    ta_id INT REFERENCES department.teaching_assistants(ta_id)
);


INSERT INTO department.students (first_name, last_name, dob, email, phone)
VALUES
('Donatus', 'Dodzi', '2005-08-13', 'don.jazzy@st.ug.gmail.com', '+233201538001'),
('Vanessa', 'Oforiwaa', '2005-07-20', 'Vanserwaa@st.ug.gmail.com', '+2332712974002'),
('Nana', 'Kwesi', '1999-03-25', 'nana.kwesi@st.ug.gmail.com', '+2335697434003'),
('Bernadine', 'Amoah', '2002-12-10', 'Bernadine.amoah@st.ug.gmail.com', '+233531239704'),
('Isaac', 'viodi', '2005-11-05', 'isaac.antwi@st.ug.gmail.com', '+2332456893005');

INSERT INTO department.fees (student_id, amount, date_paid, payment_method)
VALUES
(1, 350.00, '2024-01-15', 'mobile money'),
(2, 520.00, '2024-02-02', 'online bank'),
(3, 300.00, '2024-03-25', 'credit card'),
(4, 350.00, '2024-04-10', 'GCB'),
(5, 350.00, '2024-04-05', 'mobile money');
INSERT INTO department.courses (course_name, course_code)
VALUES
('Software Engineering', 'CPEN101'),
('Data Structures and Algorithms', 'DSA102'),
('Linear Circuit', 'CPEN103'),
('Python Programming', 'CPEN104');
INSERT INTO department.enrollments (student_id, course_id)
VALUES
(1, 1), 
(2, 2),
(3, 3),
(4, 4), 
(5, 1); 

INSERT INTO department.lectures (first_name, last_name, email, phone)
VALUES
    ('John', 'Assiamah', 'JohnAsi@gmail.com', '+233201153567'),
    ('Isaac', 'Aboagye', 'IkeAboao@gmail.com', '+23321846678'),
    ('Margaret', 'Ansah', 'MargaretAnsah@gmail.com', '+23355696789'),
    ('Kenneth', 'broni', 'KennBroTech@gmail.com', '+233214567430');
INSERT INTO department.lecture_course_assignments (lecture_id, course_id)
VALUES
    (1, 1), -- Lecture 1 assigned to Software Engineering
    (2, 2), -- Lecture 2 assigned to Data Structures and Algorithms
    (3, 3), -- Lecture 3 assigned to Linear Circuit
    (4, 4); -- Lecture 4 assigned to Python Programming

INSERT INTO department.teaching_assistants (first_name, last_name, email, phone)
VALUES
    ('Bamzy', 'Appiah', 'kwameappiah@gmail.com', '+2335375613555'),
    ('Rodney', 'Mensah', 'abenamensah@gmail.com', '+233241749624'),
    ('Foster', 'Anopa', 'kofiagyapong@gmail.com', '+233277435734'),
    ('Najat', 'Owusu', 'akosuaowusu@gmail.com', '+2332334784763');
INSERT INTO department.lecture_ta_assignments (lecture_id, ta_id)
VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4);
CREATE OR REPLACE FUNCTION department.calculate_outstanding_fees()
RETURNS JSON AS $$
DECLARE
    result JSON;
BEGIN
    SELECT json_agg(row_to_json(fees_due)) INTO result
    FROM (
        SELECT 
            s.student_id,
            s.first_name,
            s.last_name,
            COALESCE(SUM(f.amount), 0) AS total_paid,
            5000 - COALESCE(SUM(f.amount), 0) AS outstanding_fees
        FROM 
            department.students s
        LEFT JOIN 
            department.fees f ON s.student_id = f.student_id
        GROUP BY 
            s.student_id
    ) AS fees_due;

    RETURN result;
END;
$$ LANGUAGE plpgsql;

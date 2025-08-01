test_cases = [
    {
        "query": "What is the ECTS value of the course 'French 2.1'?",
        "gold_passages": ["French 2.1 - 4 ECTS"]
    },
    {
        "query": "Which core course in Semester 3 covers algorithms?",
        "gold_passages": ["Algorithms and Data Structures - 3 ECTS"]
    },
    {
        "query": "How many ECTS is 'Advanced Programming with Python'?",
        "gold_passages": ["Advanced Programming with Python - 4 ECTS"]
    },
    {
        "query": "Name one optional course in Semester 4 related to Image Processing.",
        "gold_passages": ["Image Processing - 3 ECTS"]
    },
    {
        "query": "Which course in Semester 5 teaches Machine Learning basics?",
        "gold_passages": ["Machine Learning and Data Mining I - 3 ECTS"]
    },
    {
        "query": "What is the credit for the 'Computer Graphics' course?",
        "gold_passages": ["Computer Graphics - 3 ECTS"]
    },
    {
        "query": "List one Program Outcome related to teamwork.",
        "gold_passages": ["Leadership and skills to work in Cross-disciplinary teams."]
    },
    {
        "query": "What department email should prospective students contact for admission?",
        "gold_passages": ["Email: admission@usth.edu.vn"]
    },
    {
        "query": "Where is the ICT Department office located?",
        "gold_passages": ["Room 408, 4th floor, A21 building, University of Science and Technology of Hanoi"]
    },
    {
        "query": "What specialization options are mentioned in the program introduction?",
        "gold_passages": [
            "mobile and web development, security and system, and data mining"
        ]
    },
    {
        "query": "How many ECTS is 'Law on IP rights'?",
        "gold_passages": ["Law on IP rights - 1 ECTS"]
    },
    {
        "query": "What is the ECTS value for 'French 2.2'?",
        "gold_passages": ["French 2.2 - 4 ECTS"]
    },
    {
        "query": "How many credits is 'Probability and Statistics'?",
        "gold_passages": ["Probability and Statistics - 4 ECTS"]
    },
    {
        "query": "What is the credit for 'Object-Oriented Programming'?",
        "gold_passages": ["Object-Oriented Programming - 4 ECTS"]
    },
    {
        "query": "What is the ECTS for 'Numerical Methods'?",
        "gold_passages": ["Numerical Methods - 3 ECTS"]
    },
    {
        "query": "How many ECTS is 'Software Testing and Quality Assurance'?",
        "gold_passages": ["Software Testing and Quality Assurance – 3 ECTS"]
    },
    {
        "query": "What is the ECTS of 'Advanced Databases'?",
        "gold_passages": ["Advanced Databases - 3 ECTS"]
    },
    {
        "query": "How many ECTS is the 'Internship'?",
        "gold_passages": ["Internship - 12 ECTS"]
    },
    {
        "query": "What is the telephone number for the ICT Department?",
        "gold_passages": ["Tel: (+84-24) 32 12 18 01"]
    },
    {
        "query": "What is the phone number of the Department of Admission?",
        "gold_passages": ["Tel: ( + 84-24) 7772 7748"]
    },
    {"query": "What are the accepted subject combinations for the Biotechnology - Drug Discovery program?",
        "gold_passages": [
            "Maths - Chemistry - Biology", 
            "Maths - Physics - Chemistry", 
            "Maths - Physics - Biology", 
            "Maths - Biology - English"
    ]},  # fileciteturn3file0
    {
        "query": "Which subject combinations are accepted for the Cyber Security program?",
        "gold_passages": [
            "Maths - Physics - Informatics", 
            "Maths - Physics - English", 
            "Maths - Informatics - English"
        ]},  # fileciteturn3file0
    {
        "query": "List the accepted subject combinations for Information and Communication Technology.",
        "gold_passages": [
            "Maths - Informatics - English", 
            "Maths - Physics - Informatics", 
            "Maths - Physics - English"
    ]},
    {
        "query": "What combinations are required for the Aeronautical Engineering program?",
            "gold_passages": [
                "Maths - Physics - Informatics", 
                "Maths - Physics - English", 
                "Maths - Physics - Chemistry", 
                "Maths - Chemistry - English"
    ]},

    {
        "query": "What is the university code on the MOET for USTH?",
        "gold_passages": ["University code on the Ministry of Education and Training (MOET): KCN"]
    },  # fileciteturn3file1
    {
        "query": "What is the enrollment target for Bachelor’s programs in 2025?",
        "gold_passages": ["Enrollment target: 1088"]
    },  # fileciteturn3file1
    {
        "query": "What is the code for the Chemistry program?",
        "gold_passages": ["Code: 7440112"]
    },  # fileciteturn3file1
    {
        "query": "What is the code for the Aeronautical Engineering program?",
        "gold_passages": ["Code: 7520120"]
    },  # fileciteturn3file1
    {
        "query": "What is the standard duration of a regular Bachelor's degree program at USTH?",
        "gold_passages": ["The standard duration of a Bachelor's degree program is 3 years (equivalent to 180 ECTS)"]
    },  # fileciteturn3file1
    {
        "query": "How long is the Pharmacy program duration?",
        "gold_passages": ["The duration of training for the Pharmacy program is 5 years"]
    },  # fileciteturn3file1
    {
        "query": "What is the application fee for a candidate?",
        "gold_passages": ["Application fees: 500,000 VND/candidate"]
    },  # fileciteturn3file1
    {
        "query": "What is the tuition fee for Vietnamese students in Aeronautical Engineering?",
        "gold_passages": ["Vietnamese students enrolled in the Aeronautical Engineering program ... will pay 100,000,000 VND per year"]
    },  # fileciteturn3file1
    {
        "query": "What is the tuition fee for international students in Aeronautical Engineering?",
        "gold_passages": ["international students in the same program will pay 140,500,000 VND per year"]
    },  # fileciteturn3file1
    # From Annex 3 – conversion table
    {
        "query": "What TOEFL iBT score range corresponds to an IELTS Academic score of 5.0?",
    "gold_passages": ["an IELTS Academic score of 5.0 is equivalent to a TOEFL iBT score of 35 to 45"]
    },  # fileciteturn3file0
    {
        "query": "What TOEFL iBT score range corresponds to an IELTS Academic score of 6.5?",
        "gold_passages": ["an IELTS score of 6.5 equals a TOEFL iBT score of 79 to 93"]
    },  # fileciteturn3file0
    {
        "query": "What Cambridge English Scale score corresponds to an IELTS score of 8.0?",
        "gold_passages": ["an IELTS score of 8.0 equals ... a Cambridge score of 200"]
    },  # fileciteturn3file0
    {
        "query": "What PTE Academic score is equivalent to an IELTS score of 9.0?",
        "gold_passages": ["an IELTS score of 9.0 equals ... a PTE score of 83"]
    },
    {
        "query": "Do students have to wear their student ID cards when entering USTH premises?",
        "gold_passages": [
            "Students entering/exiting the premises of VAST/USTH/buildings/classrooms across all USTH campuses are required to wear/present their student ID cards."  # :contentReference[oaicite:0]{index=0}
        ]
    },
    {
        "query": "What should a student do if their ID card is lost or damaged?",
        "gold_passages": [
            "In cases where a student ID card is lost or damaged, students must register for a replacement at the Department of Student Affairs."  # :contentReference[oaicite:1]{index=1}
        ]
    },

    {
        "query": "What attire is required under the USTH dress code?",
        "gold_passages": [
            "Clothing must be neat, tidy, clean, modest, and appropriate according to the traditional customs of Vietnam and university culture. Specifically, it includes wearing a shirt or a short-sleeved t-shirt, trousers or long jeans, or skirts falling below the knee (for female students); wearing shoes or sandals with back straps."  # :contentReference[oaicite:2]{index=2}
        ]
    },
    {
        "query": "Which clothing items are explicitly prohibited on campus?",
        "gold_passages": [
            "Prohibited attire: casual homewear, sleepwear or pajamas; clothes including: sheer or see-through fabrics, body-exposed lace; shorts, ripped or dirty jeans, skirts above the knee, low-rise trousers or skirts; body-exposed short tops, low-cut tops, tank tops, strapless tops, sleeveless shirts; flip-flops, thong sandals, slippers, house shoes."  # :contentReference[oaicite:3]{index=3}
        ]
    },
    {
        "query": "Through which gates are students allowed to enter the 18 Hoang Quoc Viet campus?",
        "gold_passages": [
            "At the 18 Hoang Quoc Viet campus: Entry and exit are permitted only through Gate 2 and Gate 3. It is STRICTLY PROHIBITED to enter or exit through Gate 1 (the central gate), or the area in front of buildings A1 and A2."  # :contentReference[oaicite:4]{index=4}
        ]
    },
    {
        "query": "What is the maximum speed limit on USTH premises?",
        "gold_passages": [
            "Speed limit compliance: The maximum allowed speed is 20 km/h. A safe distance must be maintained, and parking is prohibited at junctions within the Institute's premises."  # :contentReference[oaicite:5]{index=5}
        ]
    },
    {
        "query": "Where should students park vehicles at the 18 Hoang Quoc Viet campus?",
        "gold_passages": [
            "At the 18 Hoang Quoc Viet campus: Vehicles should be parked in the two-story parking garage (monthly ticket) or the basement parking of A21 building (daily ticket). Vehicles must NOT be parked in the vicinity of other buildings on the campus."  # :contentReference[oaicite:6]{index=6}
        ]
    },
    {
        "query": "Are students allowed to eat in classrooms or laboratories?",
        "gold_passages": [
            "Students are NOT allowed to eat in classrooms, lecture halls, or laboratories. Students must maintain cleanliness and dispose of trash in trash bins."  # :contentReference[oaicite:7]{index=7}
        ]
    },
    {
        "query": "What temperature must air conditioning be set to at minimum?",
        "gold_passages": [
            "Air conditioning should only be set to temperatures above 26°C, and all electrical devices must be turned off when leaving the room."  # :contentReference[oaicite:8]{index=8}
        ]
    },
    {
        "query": "Is smoking allowed inside USTH buildings?",
        "gold_passages": [
            "The university STRICTLY PROHIBITS smoking (including both traditional cigarettes and e-cigarettes) within all buildings, classrooms, and lecture halls."  # :contentReference[oaicite:9]{index=9}
        ]
    },
    {
        "query": "What teaching-learning forms are defined at USTH?",
        "gold_passages": [
            "Depending on the modules, there are 3 forms of teaching - learning:\n\n"
            "a) Lecture hours: students study lectures or tutorials in the classroom …;\n"
            "b) Practical hours: students study through practice, doing experiments …;\n"
            "c) Compulsory tutorial hours: students study academic materials individually or in groups …"
        ]
    },
    {
        "query": "Which modules' results do not count toward GPA but are required for graduation?",
        "gold_passages": [
            "Conditional modules are the National Defense Education, Philosophy (for Vietnamese students) and complementary skills. The results of conditional modules are not counted to the grade point average (GPA), but are the condition for graduation." 
        ]
    },
    {
        "query": "How many total ECTS credits must undergraduates complete, and how many per semester?",
        "gold_passages": [
            "USTH follows the Bologna process (European Credit Transfer and Accumulation System - ECTS) with total credits of 180 ECTS for 3 years, equivalent to 30 ECTS for one semester."
        ]
    },
    {
        "query": "What items must a module syllabus include?",
        "gold_passages": [
            "A syllabus must contain the following main contents:\n"
            "a) Information about the academic department;\n"
            "b) Information about the lecturer;\n"
            "c) Information about the module (title, code, conditional or elective or compulsory, the number of credits, prerequisites, etc.);\n"
            "d) Information about learning and teaching modes;\n"
            "e) Course objectives, course contents and teaching methods;\n"
            "f) Learning materials (textbooks, reference materials);\n"
            "g) Requirements and regulations on module testing and assessment."
        ]
    },
    {
        "query": "What is the maximum allowed duration to complete a three-year program?",
        "gold_passages": [
            "The maximum time for students to complete the course: 6 years for 3-year program, 7 years for 4-year program."
        ]
    },
    {
        "query": "What competencies are defined in the learning outcomes?",
        "gold_passages": [
            "The Undergraduate program at USTH ensure the following competencies of graduates:\n"
            "a) Being a responsible citizen …;\n"
            "b) Being able to apply knowledge to science and technology …;\n"
            "c) Being able to conduct experiments …;\n"
            "d) Being able to work in multi-disciplinary teams;\n"
            "e) Being able to identify, formulate, and solve engineering problems;\n"
            "f) Being able to communicate effectively …;\n"
            "g) Having understanding about the impact of engineering solutions …;\n"
            "h) Being able to acquire knowledge, gain skills and engage in life-long learning;\n"
            "i) Having knowledge of contemporary social issues;\n"
            "j) Being able to use the techniques, skills, and modern engineering tools necessary for practice."
        ]
    },
    {
        "query": "What foreign language proficiency is required for USTH undergraduates?",
        "gold_passages": [
            "For students getting a diploma of USTH, the required proficiency is equivalent to B2 level according to the Common European Framework of Reference for Language (CEFR)."
        ]
    },
    {
        "query": "On what basis does USTH define its annual enrolment targets?",
        "gold_passages": [
            "Based on the social demand, facilities and conditions to assure academic quality, and the situation of students having jobs that fit their major after graduation, USTH annually defines the enrolment targets for each specialty for the following academic year, reporting and submitting to the University Council of USTH for decision."
        ]
    },
    {
        "query": "What is the minimum number of credits a student may register per semester?",
        "gold_passages": [
            "Students are allowed to register at least 24 credits per semester excluding credits of retaking the semester or module."
        ]
    },
    {
        "query": "How many weeks of teaching and how many weeks of exams are in a semester?",
        "gold_passages": [
            "Each semester is comprised of 16 - 18 weeks of teaching and learning and 2 weeks for final examination."
        ]
    },


]
 
    
    
    

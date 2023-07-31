-- 1
SELECT Name FROM Departments
WHERE Building = (SELECT Building FROM Departments WHERE Name = '��������� ����������');

--2
SELECT Name FROM Departments
WHERE Building = (SELECT Building FROM Departments WHERE Name = '��������� ��������')
UNION
SELECT Name FROM Departments
WHERE Building = (SELECT Building FROM Departments WHERE Name = '��������� ���������');

--3
SELECT TOP 1 Departments.Name, COUNT(Donations.Id) AS DonationCount
FROM Departments
LEFT JOIN Donations ON Departments.Id = Donations.DepartmentId
GROUP BY Departments.Name
ORDER BY DonationCount ASC;

--4 
SELECT Surname FROM Doctors 
WHERE Salary + Premium > (SELECT Salary + Premium FROM Doctors WHERE Name = '����' AND Surname = '������');

--5
SELECT Name FROM Wards
WHERE Places > (SELECT AVG(Places) FROM Wards
				WHERE DepartmentId = (SELECT Id FROM Departments
				WHERE Name = '��������� ���������'));

--6 
SELECT Name + ' ' + Surname AS FullName FROM Doctors
WHERE Salary + Premium > (SELECT (Salary + Premium) + 100 FROM Doctors
						  WHERE Name + ' ' + Surname = '������ ������');

--7
SELECT Name FROM Departments 
WHERE Id = (SELECT DoctorId FROM DoctorExaminations
			WHERE DoctorId = (SELECT Id FROM Doctors 
			WHERE Name + ' ' + Surname = '������� �������'))

--8
SELECT Sponsors.Name
FROM Sponsors
WHERE NOT EXISTS (
    SELECT Donations.Id
    FROM Donations
    INNER JOIN Departments ON Donations.DepartmentId = Departments.Id
    WHERE (Departments.Name = '��������� ����������' OR Departments.Name = '��������� ���������')
    AND Donations.SponsorId = Sponsors.Id
);

--9
SELECT Doctors.Surname
FROM Doctors
INNER JOIN DoctorExaminations ON Doctors.Id = DoctorExaminations.DoctorId
WHERE DoctorExaminations.StartTime >= '12:00' AND DoctorExaminations.EndTime <= '15:00';

--3. Sã se listeze structura tabelelor din schema HR (EMPLOYEES, DEPARTMENTS,
--JOBS, JOB_HISTORY, LOCATIONS, COUNTRIES, REGIONS), observând tipurile de
--date ale coloanelor

DESCRIBE employees;
DESCRIBE departments;
DESCRIBE jobs;
DESCRIBE job_history;
DESCRIBE locations;
DESCRIBE countries;
DESCRIBE regions;

--4. Sã se listeze conþinutul tabelelor din schema consideratã, afiºând valorile tuturor
--câmpurilor. 
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM job_history;
SELECT * FROM locations;
SELECT * FROM countries;
SELECT * FROM regions;

--5. Sã se afiºeze codul angajatului, numele, codul job-ului, data angajarii. Ce fel de
--operaþie este aceasta (selecþie sau proiecþie)?
--6. Modifica?i cererea anterioarã astfel încât, la rulare, capetele coloanelor sã aibã numele
--cod, nume, cod job, data angajarii
--5 & 6
SELECT employee_id as cod, last_name as nume, job_id as "Cod job", hire_date as "Data"
FROM employees;
--selectie -> selectecteaza liniile dupa alegere
--proiectie -> alege doar niste coloane?
-- e o proiectie deoarece se aleg doar unele coloane, in acest caz fiind proiectii.

--7. Sã se listeze, cu ºi fãrã duplicate, codurile job-urilor din tabelul EMPLOYEES
--listare cu duplicate
SELECT job_id 
FROM employees;

--listare fara duplicate
SELECT DISTINCT job_id
FROM employees;

--8. Sã se afiºeze numele concatenat cu job_id-ul, separate prin virgula ?i spatiu. Eticheta?i
--coloana “Angajat si titlu”.
--pentru siruri de caractere se folosesc ' ', nu " " (considerate alias-uri)
SELECT last_name || ', ' || job_id as "Angajat si titlu"
FROM employees;

--9. Crea?i o cerere prin care sã se afi?eze toate datele din tabelul EMPLOYEES pe o
--singurã coloanã. Separaþi fiecare coloanã printr-o virgulã. Etichetati coloana ”Informatii
--complete”.

SELECT employee_id || ', ' || first_name || ', ' || last_name || ', ' || email || ', ' ||
        phone_number || ', ' || hire_date || ', ' || job_id || ', ' || salary || ', ' ||
        commission_pct || ', ' || manager_id || ', ' || department_id as "Informatii complete"
FROM employees;

--10. Sã se listeze numele si salariul angajaþilor care câºtigã mai mult de 2850. 
SELECT last_name, salary
FROM employees
WHERE salary > 2850;

--11. Sã se creeze o cerere pentru a afiºa numele angajatului ºi codul departamentului
--pentru angajatul având codul 104
SELECT last_name, department_id
FROM employees
WHERE employee_id = 104;

--12. Sã se afiºeze numele ºi salariul angajaþilor al cãror salariu nu se aflã în intervalul
--[1500, 2850].
--varianta 1
SELECT last_name, salary
FROM employees
WHERE salary < 1500 OR salary > 2850;

--varianta 2
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 1500 AND 2850

--13. Sã se afiºeze numele, job-ul ºi data la care au început lucrul salariaþii angajaþi între 20
--Februarie 1987 ºi 1 Mai 1989. Rezultatul va fi ordonat crescãtor dupã data de început.

SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989' --interval inchis
ORDER BY hire_date;


--14. Sã se afiºeze numele salariaþilor ºi codul departamentelor pentru toti angajaþii din
--departamentele 10, 30 ?i 50 în ordine alfabeticã a numelor.
SELECT last_name, department_id
FROM employees
WHERE department_id in (10, 30, 50)
ORDER BY last_name;

--15. Sã se listeze numele ºi salariile angaja?ilor care câºtigã mai mult decât 1500 ºi
--lucreazã în departamentul 10, 30 sau 50. Se vor eticheta coloanele drept Angajat si
--Salariu lunar. 
SELECT last_name as "Angajat", salary as "Salariu lunar"
FROM employees
WHERE department_id in (10, 30, 50) AND salary > 1500;

--16. Care este data curentã? Afiºaþi diferite formate ale acesteia
--Functia care returneazã data curentã este SYSDATE. Pentru completarea sintaxei
--obligatorii a comenzii SELECT, se utilizeazã tabelul DUAL:
SELECT SYSDATE
FROM dual;
--Datele calendaristice pot fi formatate cu ajutorul funcþiei TO_CHAR(data, format),
--unde formatul poate fi alcãtuit dintr-o combinaþie a elementelor din tabelul
--dat in laboratorul 1.

--17. Sã se afi?eze numele ºi data angajãrii pentru fiecare salariat care a fost angajat în
--1987. Se cer 2 soluþii: una în care se lucreazã cu formatul implicit al datei ºi alta prin
--care se formateazã data.
--solutia 1
SELECT last_name, hire_date
FROM employees
WHERE hire_date LIKE ('%87%');
--nu e prea recomandata

--solutia 2
SELECT last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY')='1987'; 
--' ' nu sunt obligatorii

--solutia 3
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR from hire_date)='1987';

--18. Sã se afi?eze numele, prenumele ?i data angajãrii persoanelor care au început
--activitatea într-o zi a lunii egalã cu cea a datei curente.
--varianta cu to_char
SELECT last_name, first_name
FROM employees
WHERE TO_CHAR(hire_date, 'DD')=(SELECT TO_CHAR(SYSDATE, 'DD') FROM dual);
--from dual nu e necesar

--varianta cu extract
SELECT last_name, first_name
FROM employees
WHERE EXTRACT(DAY from hire_date)=EXTRACT(DAY from SYSDATE);

--19. Sã se afiºeze numele ºi job-ul pentru toþi angajaþii care nu au manager.
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

--20. Sã se afi?eze numele, salariul ?i comisionul pentru toti salaria?ii care câ?tigã comision
--(se presupune cã aceasta înseamnã prezen?a unei valori nenule în coloana
--respectivã). Sã se sorteze datele în ordine descrescãtoare a salariilor ?i comisioanelor.
--varianta 1
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY salary, commission_pct DESC;

--varianta 2 
SELECT last_name, salary sal, commission_pct com      
FROM employees                                        
WHERE commission_pct IS NOT NULL                     
ORDER BY sal DESC, com DESC;
-- oridne FROM, WHERE, SELECT, ORDER BY

--varianta 3
SELECT last_name, salary sal, commission_pct com      
FROM employees                                        
WHERE commission_pct IS NOT NULL                  
ORDER BY 2 DESC, 3 DESC;    --ordonez dupa a doua expresie de la select si dupa a treia expresie


--21. Eliminaþi clauza WHERE din cererea anterioarã. Unde sunt plasate valorile NULL în
--ordinea descrescãtoare?
SELECT last_name, salary, commission_pct
FROM employees
ORDER BY salary, commission_pct DESC;
--la inceput

--22. Sã se listeze numele tuturor angaja?ilor care au a treia literã din nume ‘A’
--Obs: Pentru compararea ºirurilor de caractere, împreunã cu operatorul LIKE se utilizeazã
--caracterele wildcard:
--? % - reprezentând orice ºir de caractere, inclusiv ºirul vid;
--? _ (underscore) – reprezentând un singur caracter ºi numai unul
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

--23. Sã se listeze numele tuturor angajatilor care au 2 litere ‘L’ in nume ºi lucreazã în
--departamentul 30 sau managerul lor este 102.
SELECT last_name
FROM employees
WHERE LOWER(last_name) LIKE '%l%l%' AND (department_id = 30 or manager_id = 102);


--24. Sã se afiseze numele, job-ul si salariul pentru toti salariatii al caror job conþine ºirul
--“CLERK” sau “REP” ?i salariul nu este egal cu 1000, 2000 sau 3000. (operatorul NOT
--IN)
SELECT last_name, job_id, salary
FROM employees
WHERE (job_id LIKE '%CLERK%' OR job_id LIKE '%REP%')  AND salary NOT IN(1000, 2000, 3000);

--25. Sã se afi?eze numele departamentelor care nu au manager. 
SELECT department_name
FROM departments
WHERE manager_id IS NULL;

---






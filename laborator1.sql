
--3. S� se listeze structura tabelelor din schema HR (EMPLOYEES, DEPARTMENTS,
--JOBS, JOB_HISTORY, LOCATIONS, COUNTRIES, REGIONS), observ�nd tipurile de
--date ale coloanelor

DESCRIBE employees;
DESCRIBE departments;
DESCRIBE jobs;
DESCRIBE job_history;
DESCRIBE locations;
DESCRIBE countries;
DESCRIBE regions;

--4. S� se listeze con�inutul tabelelor din schema considerat�, afi��nd valorile tuturor
--c�mpurilor. 
SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM jobs;
SELECT * FROM job_history;
SELECT * FROM locations;
SELECT * FROM countries;
SELECT * FROM regions;

--5. S� se afi�eze codul angajatului, numele, codul job-ului, data angajarii. Ce fel de
--opera�ie este aceasta (selec�ie sau proiec�ie)?
--6. Modifica?i cererea anterioar� astfel �nc�t, la rulare, capetele coloanelor s� aib� numele
--cod, nume, cod job, data angajarii
--5 & 6
SELECT employee_id as cod, last_name as nume, job_id as "Cod job", hire_date as "Data"
FROM employees;
--selectie -> selectecteaza liniile dupa alegere
--proiectie -> alege doar niste coloane?
-- e o proiectie deoarece se aleg doar unele coloane, in acest caz fiind proiectii.

--7. S� se listeze, cu �i f�r� duplicate, codurile job-urilor din tabelul EMPLOYEES
--listare cu duplicate
SELECT job_id 
FROM employees;

--listare fara duplicate
SELECT DISTINCT job_id
FROM employees;

--8. S� se afi�eze numele concatenat cu job_id-ul, separate prin virgula ?i spatiu. Eticheta?i
--coloana �Angajat si titlu�.
--pentru siruri de caractere se folosesc ' ', nu " " (considerate alias-uri)
SELECT last_name || ', ' || job_id as "Angajat si titlu"
FROM employees;

--9. Crea?i o cerere prin care s� se afi?eze toate datele din tabelul EMPLOYEES pe o
--singur� coloan�. Separa�i fiecare coloan� printr-o virgul�. Etichetati coloana �Informatii
--complete�.

SELECT employee_id || ', ' || first_name || ', ' || last_name || ', ' || email || ', ' ||
        phone_number || ', ' || hire_date || ', ' || job_id || ', ' || salary || ', ' ||
        commission_pct || ', ' || manager_id || ', ' || department_id as "Informatii complete"
FROM employees;

--10. S� se listeze numele si salariul angaja�ilor care c�tig� mai mult de 2850. 
SELECT last_name, salary
FROM employees
WHERE salary > 2850;

--11. S� se creeze o cerere pentru a afi�a numele angajatului �i codul departamentului
--pentru angajatul av�nd codul 104
SELECT last_name, department_id
FROM employees
WHERE employee_id = 104;

--12. S� se afi�eze numele �i salariul angaja�ilor al c�ror salariu nu se afl� �n intervalul
--[1500, 2850].
--varianta 1
SELECT last_name, salary
FROM employees
WHERE salary < 1500 OR salary > 2850;

--varianta 2
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 1500 AND 2850

--13. S� se afi�eze numele, job-ul �i data la care au �nceput lucrul salaria�ii angaja�i �ntre 20
--Februarie 1987 �i 1 Mai 1989. Rezultatul va fi ordonat cresc�tor dup� data de �nceput.

SELECT last_name, job_id, hire_date
FROM employees
WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989' --interval inchis
ORDER BY hire_date;


--14. S� se afi�eze numele salaria�ilor �i codul departamentelor pentru toti angaja�ii din
--departamentele 10, 30 ?i 50 �n ordine alfabetic� a numelor.
SELECT last_name, department_id
FROM employees
WHERE department_id in (10, 30, 50)
ORDER BY last_name;

--15. S� se listeze numele �i salariile angaja?ilor care c�tig� mai mult dec�t 1500 �i
--lucreaz� �n departamentul 10, 30 sau 50. Se vor eticheta coloanele drept Angajat si
--Salariu lunar. 
SELECT last_name as "Angajat", salary as "Salariu lunar"
FROM employees
WHERE department_id in (10, 30, 50) AND salary > 1500;

--16. Care este data curent�? Afi�a�i diferite formate ale acesteia
--Functia care returneaz� data curent� este SYSDATE. Pentru completarea sintaxei
--obligatorii a comenzii SELECT, se utilizeaz� tabelul DUAL:
SELECT SYSDATE
FROM dual;
--Datele calendaristice pot fi formatate cu ajutorul func�iei TO_CHAR(data, format),
--unde formatul poate fi alc�tuit dintr-o combina�ie a elementelor din tabelul
--dat in laboratorul 1.

--17. S� se afi?eze numele �i data angaj�rii pentru fiecare salariat care a fost angajat �n
--1987. Se cer 2 solu�ii: una �n care se lucreaz� cu formatul implicit al datei �i alta prin
--care se formateaz� data.
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

--18. S� se afi?eze numele, prenumele ?i data angaj�rii persoanelor care au �nceput
--activitatea �ntr-o zi a lunii egal� cu cea a datei curente.
--varianta cu to_char
SELECT last_name, first_name
FROM employees
WHERE TO_CHAR(hire_date, 'DD')=(SELECT TO_CHAR(SYSDATE, 'DD') FROM dual);
--from dual nu e necesar

--varianta cu extract
SELECT last_name, first_name
FROM employees
WHERE EXTRACT(DAY from hire_date)=EXTRACT(DAY from SYSDATE);

--19. S� se afi�eze numele �i job-ul pentru to�i angaja�ii care nu au manager.
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

--20. S� se afi?eze numele, salariul ?i comisionul pentru toti salaria?ii care c�?tig� comision
--(se presupune c� aceasta �nseamn� prezen?a unei valori nenule �n coloana
--respectiv�). S� se sorteze datele �n ordine descresc�toare a salariilor ?i comisioanelor.
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


--21. Elimina�i clauza WHERE din cererea anterioar�. Unde sunt plasate valorile NULL �n
--ordinea descresc�toare?
SELECT last_name, salary, commission_pct
FROM employees
ORDER BY salary, commission_pct DESC;
--la inceput

--22. S� se listeze numele tuturor angaja?ilor care au a treia liter� din nume �A�
--Obs: Pentru compararea �irurilor de caractere, �mpreun� cu operatorul LIKE se utilizeaz�
--caracterele wildcard:
--? % - reprezent�nd orice �ir de caractere, inclusiv �irul vid;
--? _ (underscore) � reprezent�nd un singur caracter �i numai unul
SELECT last_name
FROM employees
WHERE last_name LIKE '__a%';

--23. S� se listeze numele tuturor angajatilor care au 2 litere �L� in nume �i lucreaz� �n
--departamentul 30 sau managerul lor este 102.
SELECT last_name
FROM employees
WHERE LOWER(last_name) LIKE '%l%l%' AND (department_id = 30 or manager_id = 102);


--24. S� se afiseze numele, job-ul si salariul pentru toti salariatii al caror job con�ine �irul
--�CLERK� sau �REP� ?i salariul nu este egal cu 1000, 2000 sau 3000. (operatorul NOT
--IN)
SELECT last_name, job_id, salary
FROM employees
WHERE (job_id LIKE '%CLERK%' OR job_id LIKE '%REP%')  AND salary NOT IN(1000, 2000, 3000);

--25. S� se afi?eze numele departamentelor care nu au manager. 
SELECT department_name
FROM departments
WHERE manager_id IS NULL;

---






--1. Scrie�i o cerere care are urm�torul rezultat pentru fiecare angajat:
--<prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3
--ori mai mare>. Etichetati coloana �Salariu ideal�. Pentru concatenare, utiliza�i at�t
--func�ia CONCAT c�t �i operatorul �||�.

SELECT CONCAT(CONCAT(employees.first_name, ' '), employees.last_name ) || ' castiga ' || employees.salary
 || ' lunar dar doreste ' || 3*employees.salary "Salariu ideal"
FROM employees;

--2. Scrie�i o cerere prin care s� se afi�eze prenumele salariatului cu prima litera majuscul�
--�i toate celelalte litere minuscule, numele acestuia cu majuscule �i lungimea numelui,
--pentru angaja�ii al c�ror nume �ncepe cu J sau M sau care au a treia liter� din nume A.
--Rezultatul va fi ordonat descresc�tor dup� lungimea numelui. Se vor eticheta
--coloanele corespunz�tor. Se cer 2 solu�ii (cu operatorul LIKE �i func�ia SUBSTR).

SELECT INITCAP(employees.first_name) "Prenume", UPPER(employees.last_name) "Nume", 
LENGTH(last_name) "Lungimea numelui"
FROM employees
WHERE employees.last_name LIKE 'M%' OR employees.last_name LIKE 'J%' or SUBSTR(last_name, 3, 1)='a'
ORDER BY LENGTH(last_name) desc;

--3. S� se afi�eze, pentru angaja�ii cu prenumele �Steven�, codul �i numele acestora,
--precum �i codul departamentului �n care lucreaz�. C�utarea trebuie s� nu fie casesensitive,
--iar eventualele blank-uri care preced sau urmeaz� numelui trebuie ignorate.

SELECT employees.employee_id "Codul angajatului" , employees.last_name "Numele angajatului", 
employees.department_id "Codul departamentului"
FROM employees
--WHERE UPPER(first_name) LIKE 'STEVEN'; se poate si asa
WHERE 'STEVEN' IN UPPER(first_name);

--4. S� se afi�eze pentru to�i angaja�ii al c�ror nume se termin� cu litera 'e', codul, numele,
--lungimea numelui �i pozi�ia din nume �n care apare prima data litera 'a'. 
--Utiliza�i aliasuri corespunz�toare pentru coloane. 

SELECT employees.employee_id "Codul angajatului", employees.last_name "Numele angajatului",
LENGTH(employees.last_name) "Lungimea numelui", INSTR(LOWER(employees.last_name), 'a', 1)
"Prima aparitie 'a'"
FROM employees
WHERE last_name LIKE '%e';

--5. S� se afi�eze detalii despre salaria�ii care au lucrat un num�r �ntreg de s�pt�m�ni
--p�n� la data curent�.
--Obs: Solu?ia necesit� rotunjirea diferen?ei celor dou� date calendaristice. De ce este
--necesar acest lucru?

SELECT * 
FROM employees
WHERE MOD(ROUND((SYSDATE) - employees.hire_date), 7) = 0;

--6. S� se afi�eze codul salariatului, numele, salariul, salariul m�rit cu 15%, exprimat cu
--dou� zecimale �i num�rul de sute al salariului nou rotunjit la 2 zecimale. Eticheta�i
--ultimele dou� coloane �Salariu nou�, respectiv �Numar sute�. Se vor lua �n considerare
--salaria�ii al c�ror salariu nu este divizibil cu 1000.

SELECT employees.employee_id, employees.last_name, employees.salary, 
CAST(salary*1.15 AS DECIMAL(10,2)) "Salariu nou", CAST(salary*0.0115 AS DECIMAL(10,2)) 
"Numar sute"
FROM employees
WHERE MOD(employees.salary, 1000)  <> 0;

--7. S� se listeze numele �i data angaj�rii salaria�ilor care c�tig� comision. S� se
--eticheteze coloanele �Nume angajat�, �Data angajarii�. Utiliza�i func�ia RPAD pentru a
--determina ca data angaj�rii s� aib� lungimea de 20 de caractere.

SELECT employees.last_name "Nume angajat", RPAD(employees.hire_date, 20) "Data angajarii"
FROM employees
WHERE employees.commission_pct IS NOT NULL;

--8. S� se afi�eze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile.

SELECT TO_CHAR(SYSDATE+30, 'MON-DD-YYYY-HH24:MI:SS')
FROM dual;

--9. S� se afi�eze num�rul de zile r�mase p�n� la sf�r�itul anului.

SELECT ROUND(TO_DATE('31-DEC-2021') - SYSDATE)
FROM dual;

--10. a) S� se afi�eze data de peste 12 ore.
--b) S� se afi�eze data de peste 5 minute
--Obs: C�t reprezint� 5 minute dintr-o zi? 1/288

--a)
SELECT TO_CHAR(SYSDATE+0.5, 'MON-DD-YYYY-HH24:MI:SS')
FROM dual;

--b)
SELECT TO_CHAR(SYSDATE+ 1/288, 'MON-DD-YYYY-HH24:MI:SS')
FROM dual;

--11. S� se afi�eze numele �i prenumele angajatului (�ntr-o singur� coloan�), data angaj�rii
--�i data negocierii salariului, care este prima zi de Luni dup� 6 luni de serviciu.
--Eticheta�i aceast� coloan� �Negociere�

SELECT last_name || ' ' || first_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date, 6), 'Monday') "Negociere"
FROM employees;

--12. Pentru fiecare angajat s� se afi�eze numele �i num�rul de luni de la data angaj�rii.
--Eticheta�i coloana �Luni lucrate�. S� se ordoneze rezultatul dup� num�rul de luni
--lucrate. Se va rotunji num�rul de luni la cel mai apropiat num�r �ntreg.

SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) "Luni lucrate"
FROM employees
ORDER BY "Luni lucrate";

--13. S� se afi�eze numele, data angaj�rii �i ziua s�pt�m�nii �n care a �nceput lucrul fiecare
--salariat. Eticheta�i coloana �Zi�. Ordona�i rezultatul dup� ziua s�pt�m�nii, �ncep�nd cu
--Luni. 

SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') "Zi"
FROM employees
ORDER BY TO_CHAR(hire_date,'D');

--14. S� se afi�eze numele angaja�ilor �i comisionul. Dac� un angajat nu c�tig� comision,
--s� se scrie �Fara comision�. Eticheta�i coloana �Comision�.

SELECT last_name, NVL(TO_CHAR(commission_pct), 'Fara comision') "Comision"
FROM employees
ORDER BY 2; --optional

--15. S� se listeze numele, salariul �i comisionul tuturor angaja�ilor al c�ror venit lunar
--(salariu + valoare comision) dep�e�te 10000. 

SELECT last_name, salary, commission_pct
FROM employees
WHERE salary+salary*commission_pct > 10000;

--16. S� se afi�eze numele, codul job-ului, salariul �i o coloan� care s� arate salariul dup�
--m�rire. Se presupune c� pentru IT_PROG are loc o m�rire de 20%, pentru SA_REP
--cre�terea este de 25%, iar pentru SA_MAN are loc o m�rire de 35%. Pentru ceilal�i
--angaja�i nu se acord� m�rire. S� se denumeasc� coloana "Salariu renegociat".

SELECT last_name, job_id, salary, DECODE(job_id, 'IT_PROG', 1.2*salary, 'SA_REP', 1.25*salary,
'SA_MAN', 1.35*salary) "Salariu renegociat"
FROM employees;

--17. S� se afi�eze numele salariatului, codul �i numele departamentului pentru to�i
--angaja�ii.

SELECT employees.last_name, employees.department_id, departments.department_name
FROM employees, departments
WHERE employees.department_id=departments.department_id;

--varianta cu alias-uri
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id;

--Obs: Am realizat opera�ia de join �ntre tabelele employees �i departments, pe baza
--coloanei comune department_id. Observa�i utilizarea alias-urilor. Ce se �nt�mpl� dac�
--elimin�m condi�ia de join?
--Obs: Numele sau alias-urile tabelelor sunt obligatorii �n dreptul coloanelor care au acela�i
--nume �n mai multe tabele. Altfel, nu sunt necesare dar este recomandat� utilizarea lor
--pentru o mai bun� claritate a cererii.

--18. S� se listeze codurile ?i denumirile job-urilor care exist� �n departamentul 30.

SELECT e.department_id, d.department_name
FROM employees e join departments d on e.department_id = d.department_id
WHERE d.department_id=30;
--cred

--19. S� se afi�eze numele angajatului, numele departamentului �i ora?ul pentru to�i
--angaja�ii care c�tig� comision.

SELECT employees.last_name, departments.department_name, locations.city
FROM employees, departments, locations
WHERE employees.department_id = departments.department_id AND 
departments.location_id = locations.location_id;

--20. S� se afi�eze numele salariatului �i numele departamentului pentru to�i salaria�ii care
--au litera A inclus� �n nume.

SELECT employees.last_name, departments.department_name
FROM employees join departments on employees.department_id=departments.department_id
WHERE UPPER(employees.last_name) LIKE '%A'; 

--21. S� se afi�eze numele, titlul job-ului �i denumirea departamentului pentru to�i angaja�ii
--care lucreaz� �n Oxford.

SELECT employees.last_name, jobs.job_title, departments.department_name
FROM employees, jobs, departments, locations
WHERE employees.department_id=departments.department_id AND
locations.location_id=departments.department_id AND 
employees.job_id=jobs.job_id AND locations.city LIKE 'Oxford';

--22. S� se afi�eze codul angajatului �i numele acestuia, �mpreun� cu numele �i codul
--�efului s�u direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager.
--Obs: Realiz�m opera�ia de self-join (inner join al tabelului cu el �nsu�i).

SELECT e.employee_id "Ang#", e.last_name "Angajat", e.manager_id "Mgr#", ee.last_name "Manager"
FROM employees e LEFT JOIN employees ee ON (ee.employee_id=e.manager_id); 

--SAU
SELECT ang.employee_id "Ang#", ang.last_name "Angajat", man.employee_id "Mgr#",
man.last_name "Manager" 
FROM employees ang LEFT JOIN employees man ON (ang.manager_id = man.employee_id); 

--23. S� se modifice cererea anterioar� pentru a afi�a to�i salaria�ii, inclusiv cei care nu au
--�ef.
--Obs: Realiz�m opera�ia de outer-join, indicat� �n SQL prin �(+)� plasat la dreapta coloanei
--deficitare �n informa�ie.

SELECT e.employee_id AS Angajat#, e.last_name AS Angajat, e.manager_id AS Manager#, m.last_name AS Manager
FROM employees e, employees m
where e.manager_id = m.employee_id (+); 

--24. Scrie�i o cerere care afi�eaz� numele angajatului, codul departamentului �n care
--acesta lucreaz� �i numele colegilor s�i de departament. Se vor eticheta coloanele
--corespunz�tor.

SELECT e.last_name "Nume", e.department_id "Cod", ee.last_name "Colegi"
FROM employees e LEFT JOIN employees ee ON (ee.department_id = e.department_id);
--nu stiu daca e 100% corect

--25. Crea�i o cerere prin care s� se afi�eze numele, codul job-ului, titlul job-ului, numele
--departamentului �i salariul angaja�ilor. Se vor include ?i angaja?ii al c�ror departament
--nu este cunoscut.

SELECT employees.last_name, employees.job_id, jobs.job_title,departments.department_name, 
employees.salary
FROM employees, departments, jobs
WHERE employees.job_id = jobs.job_id;

--26. S� se afi�eze numele �i data angaj�rii pentru salaria�ii care au fost angaja�i dup�
--Gates.

SELECT e.last_name, e.hire_date
FROM employees e, employees gates
WHERE e.hire_date > gates.hire_date AND gates.last_name LIKE 'Gates'
ORDER BY e.hire_date;

--27. S� se afi�eze numele salariatului �i data angaj�rii �mpreun� cu numele �i data
--angaj�rii �efului direct pentru salaria�ii care au fost angaja�i �naintea �efilor lor. Se vor
--eticheta coloanele Angajat, Data_ang, Manager si Data_mgr.

SELECT ang.last_name "Angajat", ang.hire_date "Data_ang", man.last_name "Manager",
man.hire_date "Data_mgr"
FROM employees ang LEFT JOIN employees man ON (ang.manager_id = man.employee_id)
WHERE ang.hire_date < man.hire_date;

-------------------------------------------------------------------------------







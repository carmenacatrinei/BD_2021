--1. Scrieþi o cerere care are urmãtorul rezultat pentru fiecare angajat:
--<prenume angajat> <nume angajat> castiga <salariu> lunar dar doreste <salariu de 3
--ori mai mare>. Etichetati coloana “Salariu ideal”. Pentru concatenare, utilizaþi atât
--funcþia CONCAT cât ºi operatorul “||”.

SELECT CONCAT(CONCAT(employees.first_name, ' '), employees.last_name ) || ' castiga ' || employees.salary
 || ' lunar dar doreste ' || 3*employees.salary "Salariu ideal"
FROM employees;

--2. Scrieþi o cerere prin care sã se afiºeze prenumele salariatului cu prima litera majusculã
--ºi toate celelalte litere minuscule, numele acestuia cu majuscule ºi lungimea numelui,
--pentru angajaþii al cãror nume începe cu J sau M sau care au a treia literã din nume A.
--Rezultatul va fi ordonat descrescãtor dupã lungimea numelui. Se vor eticheta
--coloanele corespunzãtor. Se cer 2 soluþii (cu operatorul LIKE ºi funcþia SUBSTR).

SELECT INITCAP(employees.first_name) "Prenume", UPPER(employees.last_name) "Nume", 
LENGTH(last_name) "Lungimea numelui"
FROM employees
WHERE employees.last_name LIKE 'M%' OR employees.last_name LIKE 'J%' or SUBSTR(last_name, 3, 1)='a'
ORDER BY LENGTH(last_name) desc;

--3. Sã se afiºeze, pentru angajaþii cu prenumele „Steven”, codul ºi numele acestora,
--precum ºi codul departamentului în care lucreazã. Cãutarea trebuie sã nu fie casesensitive,
--iar eventualele blank-uri care preced sau urmeazã numelui trebuie ignorate.

SELECT employees.employee_id "Codul angajatului" , employees.last_name "Numele angajatului", 
employees.department_id "Codul departamentului"
FROM employees
--WHERE UPPER(first_name) LIKE 'STEVEN'; se poate si asa
WHERE 'STEVEN' IN UPPER(first_name);

--4. Sã se afiºeze pentru toþi angajaþii al cãror nume se terminã cu litera 'e', codul, numele,
--lungimea numelui ºi poziþia din nume în care apare prima data litera 'a'. 
--Utilizaþi aliasuri corespunzãtoare pentru coloane. 

SELECT employees.employee_id "Codul angajatului", employees.last_name "Numele angajatului",
LENGTH(employees.last_name) "Lungimea numelui", INSTR(LOWER(employees.last_name), 'a', 1)
"Prima aparitie 'a'"
FROM employees
WHERE last_name LIKE '%e';

--5. Sã se afiºeze detalii despre salariaþii care au lucrat un numãr întreg de sãptãmâni
--pânã la data curentã.
--Obs: Solu?ia necesitã rotunjirea diferen?ei celor douã date calendaristice. De ce este
--necesar acest lucru?

SELECT * 
FROM employees
WHERE MOD(ROUND((SYSDATE) - employees.hire_date), 7) = 0;

--6. Sã se afiºeze codul salariatului, numele, salariul, salariul mãrit cu 15%, exprimat cu
--douã zecimale ºi numãrul de sute al salariului nou rotunjit la 2 zecimale. Etichetaþi
--ultimele douã coloane “Salariu nou”, respectiv “Numar sute”. Se vor lua în considerare
--salariaþii al cãror salariu nu este divizibil cu 1000.

SELECT employees.employee_id, employees.last_name, employees.salary, 
CAST(salary*1.15 AS DECIMAL(10,2)) "Salariu nou", CAST(salary*0.0115 AS DECIMAL(10,2)) 
"Numar sute"
FROM employees
WHERE MOD(employees.salary, 1000)  <> 0;

--7. Sã se listeze numele ºi data angajãrii salariaþilor care câºtigã comision. Sã se
--eticheteze coloanele „Nume angajat”, „Data angajarii”. Utilizaþi funcþia RPAD pentru a
--determina ca data angajãrii sã aibã lungimea de 20 de caractere.

SELECT employees.last_name "Nume angajat", RPAD(employees.hire_date, 20) "Data angajarii"
FROM employees
WHERE employees.commission_pct IS NOT NULL;

--8. Sã se afiºeze data (numele lunii, ziua, anul, ora, minutul si secunda) de peste 30 zile.

SELECT TO_CHAR(SYSDATE+30, 'MON-DD-YYYY-HH24:MI:SS')
FROM dual;

--9. Sã se afiºeze numãrul de zile rãmase pânã la sfârºitul anului.

SELECT ROUND(TO_DATE('31-DEC-2021') - SYSDATE)
FROM dual;

--10. a) Sã se afiºeze data de peste 12 ore.
--b) Sã se afiºeze data de peste 5 minute
--Obs: Cât reprezintã 5 minute dintr-o zi? 1/288

--a)
SELECT TO_CHAR(SYSDATE+0.5, 'MON-DD-YYYY-HH24:MI:SS')
FROM dual;

--b)
SELECT TO_CHAR(SYSDATE+ 1/288, 'MON-DD-YYYY-HH24:MI:SS')
FROM dual;

--11. Sã se afiºeze numele ºi prenumele angajatului (într-o singurã coloanã), data angajãrii
--ºi data negocierii salariului, care este prima zi de Luni dupã 6 luni de serviciu.
--Etichetaþi aceastã coloanã “Negociere”

SELECT last_name || ' ' || first_name, hire_date, NEXT_DAY(ADD_MONTHS(hire_date, 6), 'Monday') "Negociere"
FROM employees;

--12. Pentru fiecare angajat sã se afiºeze numele ºi numãrul de luni de la data angajãrii.
--Etichetaþi coloana “Luni lucrate”. Sã se ordoneze rezultatul dupã numãrul de luni
--lucrate. Se va rotunji numãrul de luni la cel mai apropiat numãr întreg.

SELECT last_name, ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) "Luni lucrate"
FROM employees
ORDER BY "Luni lucrate";

--13. Sã se afiºeze numele, data angajãrii ºi ziua sãptãmânii în care a început lucrul fiecare
--salariat. Etichetaþi coloana “Zi”. Ordonaþi rezultatul dupã ziua sãptãmânii, începând cu
--Luni. 

SELECT last_name, hire_date, TO_CHAR(hire_date, 'DAY') "Zi"
FROM employees
ORDER BY TO_CHAR(hire_date,'D');

--14. Sã se afiºeze numele angajaþilor ºi comisionul. Dacã un angajat nu câºtigã comision,
--sã se scrie “Fara comision”. Etichetaþi coloana “Comision”.

SELECT last_name, NVL(TO_CHAR(commission_pct), 'Fara comision') "Comision"
FROM employees
ORDER BY 2; --optional

--15. Sã se listeze numele, salariul ºi comisionul tuturor angajaþilor al cãror venit lunar
--(salariu + valoare comision) depãºeºte 10000. 

SELECT last_name, salary, commission_pct
FROM employees
WHERE salary+salary*commission_pct > 10000;

--16. Sã se afiºeze numele, codul job-ului, salariul ºi o coloanã care sã arate salariul dupã
--mãrire. Se presupune cã pentru IT_PROG are loc o mãrire de 20%, pentru SA_REP
--creºterea este de 25%, iar pentru SA_MAN are loc o mãrire de 35%. Pentru ceilalþi
--angajaþi nu se acordã mãrire. Sã se denumeascã coloana "Salariu renegociat".

SELECT last_name, job_id, salary, DECODE(job_id, 'IT_PROG', 1.2*salary, 'SA_REP', 1.25*salary,
'SA_MAN', 1.35*salary) "Salariu renegociat"
FROM employees;

--17. Sã se afiºeze numele salariatului, codul ºi numele departamentului pentru toþi
--angajaþii.

SELECT employees.last_name, employees.department_id, departments.department_name
FROM employees, departments
WHERE employees.department_id=departments.department_id;

--varianta cu alias-uri
SELECT e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.department_id=d.department_id;

--Obs: Am realizat operaþia de join între tabelele employees ºi departments, pe baza
--coloanei comune department_id. Observaþi utilizarea alias-urilor. Ce se întâmplã dacã
--eliminãm condiþia de join?
--Obs: Numele sau alias-urile tabelelor sunt obligatorii în dreptul coloanelor care au acelaºi
--nume în mai multe tabele. Altfel, nu sunt necesare dar este recomandatã utilizarea lor
--pentru o mai bunã claritate a cererii.

--18. Sã se listeze codurile ?i denumirile job-urilor care existã în departamentul 30.

SELECT e.department_id, d.department_name
FROM employees e join departments d on e.department_id = d.department_id
WHERE d.department_id=30;
--cred

--19. Sã se afiºeze numele angajatului, numele departamentului ºi ora?ul pentru toþi
--angajaþii care câºtigã comision.

SELECT employees.last_name, departments.department_name, locations.city
FROM employees, departments, locations
WHERE employees.department_id = departments.department_id AND 
departments.location_id = locations.location_id;

--20. Sã se afiºeze numele salariatului ºi numele departamentului pentru toþi salariaþii care
--au litera A inclusã în nume.

SELECT employees.last_name, departments.department_name
FROM employees join departments on employees.department_id=departments.department_id
WHERE UPPER(employees.last_name) LIKE '%A'; 

--21. Sã se afiºeze numele, titlul job-ului ºi denumirea departamentului pentru toþi angajaþii
--care lucreazã în Oxford.

SELECT employees.last_name, jobs.job_title, departments.department_name
FROM employees, jobs, departments, locations
WHERE employees.department_id=departments.department_id AND
locations.location_id=departments.department_id AND 
employees.job_id=jobs.job_id AND locations.city LIKE 'Oxford';

--22. Sã se afiºeze codul angajatului ºi numele acestuia, împreunã cu numele ºi codul
--ºefului sãu direct. Se vor eticheta coloanele Ang#, Angajat, Mgr#, Manager.
--Obs: Realizãm operaþia de self-join (inner join al tabelului cu el însuºi).

SELECT e.employee_id "Ang#", e.last_name "Angajat", e.manager_id "Mgr#", ee.last_name "Manager"
FROM employees e LEFT JOIN employees ee ON (ee.employee_id=e.manager_id); 

--SAU
SELECT ang.employee_id "Ang#", ang.last_name "Angajat", man.employee_id "Mgr#",
man.last_name "Manager" 
FROM employees ang LEFT JOIN employees man ON (ang.manager_id = man.employee_id); 

--23. Sã se modifice cererea anterioarã pentru a afiºa toþi salariaþii, inclusiv cei care nu au
--ºef.
--Obs: Realizãm operaþia de outer-join, indicatã în SQL prin “(+)” plasat la dreapta coloanei
--deficitare în informaþie.

SELECT e.employee_id AS Angajat#, e.last_name AS Angajat, e.manager_id AS Manager#, m.last_name AS Manager
FROM employees e, employees m
where e.manager_id = m.employee_id (+); 

--24. Scrieþi o cerere care afiºeazã numele angajatului, codul departamentului în care
--acesta lucreazã ºi numele colegilor sãi de departament. Se vor eticheta coloanele
--corespunzãtor.

SELECT e.last_name "Nume", e.department_id "Cod", ee.last_name "Colegi"
FROM employees e LEFT JOIN employees ee ON (ee.department_id = e.department_id);
--nu stiu daca e 100% corect

--25. Creaþi o cerere prin care sã se afiºeze numele, codul job-ului, titlul job-ului, numele
--departamentului ºi salariul angajaþilor. Se vor include ?i angaja?ii al cãror departament
--nu este cunoscut.

SELECT employees.last_name, employees.job_id, jobs.job_title,departments.department_name, 
employees.salary
FROM employees, departments, jobs
WHERE employees.job_id = jobs.job_id;

--26. Sã se afiºeze numele ºi data angajãrii pentru salariaþii care au fost angajaþi dupã
--Gates.

SELECT e.last_name, e.hire_date
FROM employees e, employees gates
WHERE e.hire_date > gates.hire_date AND gates.last_name LIKE 'Gates'
ORDER BY e.hire_date;

--27. Sã se afiºeze numele salariatului ºi data angajãrii împreunã cu numele ºi data
--angajãrii ºefului direct pentru salariaþii care au fost angajaþi înaintea ºefilor lor. Se vor
--eticheta coloanele Angajat, Data_ang, Manager si Data_mgr.

SELECT ang.last_name "Angajat", ang.hire_date "Data_ang", man.last_name "Manager",
man.hire_date "Data_mgr"
FROM employees ang LEFT JOIN employees man ON (ang.manager_id = man.employee_id)
WHERE ang.hire_date < man.hire_date;

-------------------------------------------------------------------------------







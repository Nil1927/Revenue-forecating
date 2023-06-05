CREATE schema Revenue_Management;

SELECT * FROM p21_bi_intern_test_appointments;
SELECT * FROM p21_bi_intern_test_revenues;

#### Finding the total_patient_monthly
    SELECT 
        mo as month_of_first_visit,
		count(distinct patient_id) as total_new_patinet
	FROM
    (
SELECT 
	clinic_id,
    patient_id,
    appointment_id,
    min(appointment_date) as first_visit,
    month(appointment_date) as mo,
	count(distinct appointment_id) as total_appointment
FROM
	p21_bi_intern_test_appointments
GROUP BY clinic_id,patient_id
order by month(appointment_date)) as a
GROUP BY mo;
	

### Weekly_revenue_sheet
SELECT 
	week(appointment_date) as week_of_year,
    sum(revenues) as total_revenue
FROM
(
SELECT 
	a.*,
    b.revenues
FROM
	p21_bi_intern_test_appointments a
LEFT JOIN
	p21_bi_intern_test_revenues b on a.appointment_id = b.appointment_id) as c
GROUP BY 	week(appointment_date)
ORDER BY 	week(appointment_date);
	
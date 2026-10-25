-- Analyse du churn Telco (SQLite, table : customers)

-- Q1 : taux de churn par type de contrat
SELECT Contract,
       COUNT(*) AS nb_clients,
       SUM(ChurnFlag) AS nb_partis,
       ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 1) AS taux_churn_pct
FROM customers
GROUP BY Contract
ORDER BY taux_churn_pct DESC;

-- Q2 : taux de churn par tranche d'ancienneté
SELECT CASE
         WHEN tenure <= 12 THEN '1. 0-12 mois'
         WHEN tenure <= 24 THEN '2. 13-24 mois'
         WHEN tenure <= 48 THEN '3. 25-48 mois'
         ELSE '4. plus de 48 mois'
       END AS anciennete,
       COUNT(*) AS nb_clients,
       SUM(ChurnFlag) AS nb_partis,
       ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 1) AS taux_churn_pct
FROM customers
GROUP BY anciennete
ORDER BY anciennete;

-- Q3 : churn selon le type d'internet et le support technique
SELECT InternetService,
       TechSupport,
       COUNT(*) AS nb_clients,
       ROUND(100.0 * SUM(ChurnFlag) / COUNT(*), 1) AS taux_churn_pct
FROM customers
WHERE InternetService <> 'No'
GROUP BY InternetService, TechSupport
ORDER BY taux_churn_pct DESC;
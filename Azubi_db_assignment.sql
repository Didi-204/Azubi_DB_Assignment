--QUESTION 1
SELECT COUNT(u_id) FROM users;
--QUESTION 2
SELECT COUNT(send_amount_currency) FROM transfers
WHERE send_amount_currency='CFA';
--QUESTION 3
SELECT COUNT(DISTINCT u_id) FROM transfers
WHERE send_amount_currency='CFA'
--QUESTION 4
SELECT COUNT(atx_id) FROM agent_transactions WHERE EXTRACT (MONTH
FROM when_created)=2018 GROUP BY EXTRACT (MONTH FROM when_created);
--QUESTION 5
SELECT COUNT(amount) FROM agent_transactions 
WHERE amount>0 OR amount<0 
AND when_created BETWEEN '2020-07-13 00:00:00' AND '2020-07-19 23:59:59';
--QUESTION 6
SELECT agents.city, 
COUNT (amount) AS "atx volume city summary" FROM agent_transactions 
INNER JOIN agents ON agents.agent_id = agent_transactions.agent_id 
WHERE agent_transactions.when_created > current_date - interval '7 days' GROUP BY agents.city;
--QUESTION 7
SELECT (agents.country) AS "country", (agents.city) AS "city", 
COUNT (agent_transactions.amount) AS "atx volume city summary" 
FROM agent_transactions
INNER JOIN agents ON agents.agent_id = agent_transactions.agent_id 
WHERE agent_transactions.when_created > current_date - interval '7 days' 
GROUP BY (agents.country), (agents.city);
--QUESTION 8
SELECT wallets.ledger_location 
AS "country", agent_transactions.send_amount_currency AS "kind",
SUM (agent_transactions.send_amount_scalar) 
AS "volume" FROM transfers
AS agent_transactions INNER JOIN wallets
ON agent_transactions.transfer_id=wallets.wallet_id
WHERE agent_transactions.when_created = CURRENT_DATE - INTERVAL '1 WEEK'
GROUP BY wallets.ledger_location,agent_transactions.send_amount_currency;
--QUESTION 9
SELECT COUNT(transfers.source_wallet_id) 
AS unique_senders, 
COUNT (transfer_id) 
AS transaction_count, transfers.kind 
AS transfer_kind, wallets.ledger_location 
AS country, SUM (transfers.send_amount_scalar) 
AS volume FROM transfers 
INNER JOIN wallets 
ON transfers.source_wallet_id = wallets.wallet_id 
WHERE transfers.when_created > CURRENT_DATE - INTERVAL '1 week'
GROUP BY wallets.ledger_location, transfers.kind; 
QUESTION 10
SELECT source_wallet_id FROM transfers
WHERE send_amount_currency='CFA'
AND send_amount_scalar>100000000
AND when_created > CURRENT_DATE - INTERVAL '1 MONTH';

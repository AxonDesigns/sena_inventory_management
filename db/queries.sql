SELECT pt.product, (
        SUM(
            CASE
                WHEN t.type = 'Income' THEN pt.amount
                WHEN t.type = 'Expense' THEN - pt.amount
                ELSE 0
            END
        ) * p.price
    ) AS stock
FROM
    product_transactions pt
    JOIN products p ON pt.product = p.id
    JOIN transactions t ON pt.transaction = t.id;
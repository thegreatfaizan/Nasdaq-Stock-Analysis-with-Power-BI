-- Creating Database
CREATE DATABASE `nasdaq`;

-- Creating Tables
CREATE TABLE `nasdaq`.`nasdaq_screener` (
    `symbol` VARCHAR(255) NOT NULL,
    `last_sale` DECIMAL(10, 2) NULL,
    `market_cap` DECIMAL(18,2) NULL,
    `country` VARCHAR(255) NULL,
    `sector` VARCHAR(255) NULL,
    `industry` VARCHAR(255) NULL,
    PRIMARY KEY (`symbol`)
);

CREATE TABLE `nasdaq`.`income_statements` (
  `symbol` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NULL,
  `date` DATE NULL,
  `total_revenue` DECIMAL(18,2) NULL,
  `cost_of_revenue` DECIMAL(18,2) NULL,
  `gross_profit` DECIMAL(18,2) NULL,
  `research_and_development` DECIMAL(18,2) NULL,
  `sales_general_and_admin` DECIMAL(18,2) NULL,
  `non_recurring_items` DECIMAL(18,2) NULL,
  `other_operating_items` DECIMAL(18,2) NULL,
  `operating_income` DECIMAL(18,2) NULL,
  `additional_income_expense_items` DECIMAL(18,2) NULL,
  `earning_before_interest_and_tax` DECIMAL(18,2) NULL,
  `interest_expense` DECIMAL(18,2) NULL,
  `earning_before_tax` DECIMAL(18,2) NULL,
  `income_tax` DECIMAL(18,2) NULL,
  `minority_interest` DECIMAL(18,2) NULL,
  `equity_earnings_loss_unconsolidated_subsidiary` DECIMAL(18,2) NULL,
  `net_income_cont_operations` DECIMAL(18,2) NULL,
  `net_income` DECIMAL(18,2) NULL,
  `net_income_applicable_to_common_shareholders` DECIMAL(18,2) NULL,
  FOREIGN KEY (`symbol`) REFERENCES `nasdaq_screener`(`symbol`)
);

CREATE TABLE `nasdaq`.`balance_sheets` (
  `symbol` VARCHAR(255) NOT NULL,
  `name` VARCHAR(255) NULL,
  `date` DATE NULL,
  `cash_and_cash_equivalents` DECIMAL(18,2) NULL,
  `short_term_investments` DECIMAL(18,2) NULL,
  `net_receivables` DECIMAL(18,2) NULL,
  `inventory` DECIMAL(18,2) NULL,
  `other_current_assets` DECIMAL(18,2) NULL,
  `total_current_assets` DECIMAL(18,2) NULL,
  `long_term_investments` DECIMAL(18,2) NULL,
  `fixed_assets` DECIMAL(18,2) NULL,
  `goodwill` DECIMAL(18,2) NULL,
  `intangible_assets` DECIMAL(18,2) NULL,
  `other_assets` DECIMAL(18,2) NULL,
  `deferred_asset_charges` DECIMAL(18,2) NULL,
  `total_assets` DECIMAL(18,2) NULL,
  `accounts_payable` DECIMAL(18,2) NULL,
  `short_term_debt_current_portion_long_term_debt` DECIMAL(18,2) NULL,
  `other_current_liabilities` DECIMAL(18,2) NULL,
  `total_current_liabilities` DECIMAL(18,2) NULL,
  `long_term_debt` DECIMAL(18,2) NULL,
  `other_liabilities` DECIMAL(18,2) NULL,
  `deferred_liability_charges` DECIMAL(18,2) NULL,
  `misc_stocks` DECIMAL(18,2) NULL,
  `minority_interest` DECIMAL(18,2) NULL,
  `total_liabilities` DECIMAL(18,2) NULL,
  `common_stocks` DECIMAL(18,2) NULL,
  `capital_surplus` DECIMAL(18,2) NULL,
  `retained_earnings` DECIMAL(18,2) NULL,
  `treasury_stock` DECIMAL(18,2) NULL,
  `other_equity` DECIMAL(18,2) NULL,
  `total_equity` DECIMAL(18,2) NULL,
  `total_liabilities_equity` DECIMAL(18,2) NULL,
  FOREIGN KEY (`symbol`) REFERENCES `nasdaq_screener`(`symbol`)
);

-- Quries ensuring if the data successfully imported
SELECT sector, COUNT(symbol)
FROM nasdaq.nasdaq_screener
GROUP BY sector;

SELECT symbol
FROM nasdaq.nasdaq_screener
WHERE market_cap = (SELECT MAX(market_cap) FROM nasdaq.nasdaq_screener);

SELECT symbol, last_sale
FROM nasdaq.nasdaq_screener
ORDER BY last_sale DESC;

SELECT nasdaq.nasdaq_screener.symbol, nasdaq.balance_sheets.name, SUM(nasdaq.balance_sheets.total_assets)
FROM nasdaq.nasdaq_screener
LEFT JOIN nasdaq.balance_sheets
ON nasdaq.nasdaq_screener.symbol = nasdaq.balance_sheets.symbol
GROUP BY nasdaq.nasdaq_screener.symbol, nasdaq.balance_sheets.name
ORDER BY SUM(nasdaq.balance_sheets.total_assets) DESC;

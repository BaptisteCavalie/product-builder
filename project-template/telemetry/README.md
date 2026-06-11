# Télémétrie

runs.jsonl : une ligne JSON par run de /feature ou /critique.
Schéma : {"date","feature","tours","blockers","majors","minors","nits","escalade","dimensions_faibles":[]}

Usage : observer les tendances, PAS gater. Une dimension faible récurrente
(≥3 runs) = un trou structurel dans un skill → /retro le signale.

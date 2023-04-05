# MonteCarlo-Hawkes

Este GitHub é relacionado ao projeto de graduação "Implementação de Monte Carlo em Hardware aplicado à previsão do preço médio de ativos", de Maurício Gabriel Garcia Catellan (orientador: Vanderlei Bonato).

O objetivo do trabalho é a implementação em hardware de um modelo estocástico de previsão de preços de livros de oferta limitados. Tal modelo é um processo de Hawkes proposto por Luis Henrique Claudino Silva em "Aplicação do processo de Hawkes multivariado para prever o movimento do preço médio de livro de ofertas".

O repositório se divide da seguinte forma:

**Data Processing**
Processamento de dados de livro de oferta limitado extraídos de https://www.kaggle.com/datasets/praanj/limit-orderbook-data .
A partir dele, obtêm-se os parâmetros utilizados no modelo estocástico de previsão.
**

**Hardware Monte Carlo**
Implementação em Hardware da simulação de Monte Carlo do Processo de Hawkes, utilizando como entrada os parâmetros obtidos em Data Processing e o número de simulações, e dando como saída a probabilidade do preço subir no próximo evento de mudança de preço.

Implementação feita em Verilog, projetada para funcionar numa FPGA Cyclone IV E.

**MonteCarlo**
Implementação em software da simulação de Monte Carlo do processo de Hawkes, feita a fim de ser comparada com a implementação em hardware.


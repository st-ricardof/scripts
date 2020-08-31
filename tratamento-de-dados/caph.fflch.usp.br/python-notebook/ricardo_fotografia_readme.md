O tratamento de dados relativo à fotografia está separado em 2 etapas.
1) O tratamento é feito sobre cada tabela:
    fotografia_geralBD.ipynb se refere ao documento /tratamento-de-dados/caph.fflch.usp.br/data/TabelaGeralBd.csv e o seu resultado é salvo em fotografia_geralBD.csv;
    fotografia_tabela49.ipynb se refere ao documento /tratamento-de-dados/caph.fflch.usp.br/data/TabelaCatalogo49.csv e o seu resultado em salvo em fotografia_tabela49.csv;
    Enquanto papel_fotografico.ipynb já faz o merge entre essas duas tabelas e o seu resultado é salvo em papelfotografico.csv
2) O notebook merge_fotografia.ipynb faz o merge entre esses três csv acima, sintetizando tudo em documento final (fotografia_final.csv) que é importado no drupal no site do caph.
As exceções identificadas se encontram em fotografia_analise.csv, a esmagadora maioria dos registros se refere a duplicações de dados entre a tabelaGeralBd e TabelaCatalogo49, contendo o mesmo tombo, mas com algum campo de valor diferente entre eles; geralmente esta coluna é o 'número'. Também há registro sem tombo. 

Nota: fotografia_geralBD.csv, fotografia_tabela49.csv, papelfotografico.csv não se encontram neste repositório pois se referem a arquivos auxiliares, para obtê-los basta executar seus respectivos notebooks.
SELECT 
    ContaUsuario,
    COUNT(*) AS Visualizacoes_Totais,
    SUM(CASE WHEN Categoria = 'FILME' THEN 1 ELSE 0 END) AS Filmes,
    SUM(CASE WHEN Categoria = 'SERIE' THEN 1 ELSE 0 END) AS Series,
    PlanoAtual,
    CASE 
        WHEN SUM(MinutosAssistidos) > 5000 THEN 'USUARIO ATIVO'
        ELSE 'USUARIO INATIVO'
    END AS Classificacao
FROM [streaming].[HistoricoVisualizacoes]
WHERE DataVisualizacao BETWEEN '2025-01-01' AND GETDATE()
GROUP BY ContaUsuario, PlanoAtual
ORDER BY Visualizacoes_Totais DESC;

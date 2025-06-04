SELECT 
    MatriculaAluno,
    COUNT(CASE WHEN Presenca = 'N' THEN 1 END) AS Total_Faltas,
    SUM(CASE WHEN Justificativa IS NOT NULL THEN 1 ELSE 0 END) AS Faltas_Justificadas,
    AVG(CASE WHEN Presenca = 'N' THEN NotaFinal ELSE NULL END) AS Media_Nota_Faltas,
    CASE 
        WHEN COUNT(CASE WHEN Presenca = 'N' THEN 1 END) > 10 THEN 'ATENÇÃO: Muitas faltas'
        ELSE 'OK'
    END AS AlertaFrequencia
FROM [academico].[RegistroFrequencia]
WHERE AnoLetivo = 2025
GROUP BY MatriculaAluno
HAVING COUNT(CASE WHEN Presenca = 'N' THEN 1 END) > 0
ORDER BY Total_Faltas DESC;

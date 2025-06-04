SELECT 
    UsuarioResponsavel,
    COUNT(*) AS Total_Tarefas,
    SUM(CASE WHEN Status = 'CONCLUIDA' THEN 1 ELSE 0 END) AS Tarefas_Concluidas,
    SUM(CASE WHEN Status = 'PENDENTE' THEN 1 ELSE 0 END) AS Tarefas_Pendentes,
    SUM(CASE WHEN Status = 'ATRASADA' THEN 1 ELSE 0 END) AS Tarefas_Atrasadas,
    MAX(DataConclusao) AS Ultima_Tarefa_Concluida
FROM [projetos].[TarefasEquipe]
WHERE DataCriacao >= '2025-01-01'
GROUP BY UsuarioResponsavel
ORDER BY Tarefas_Atrasadas DESC;

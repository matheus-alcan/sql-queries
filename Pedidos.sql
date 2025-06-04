SELECT 
    ClienteID AS ID_Cliente,
    COUNT(PedidoID) AS Total_Pedidos,
    COUNT(CASE WHEN StatusPedido = 'ENTREGUE' THEN 1 ELSE 0 END) AS Pedidos_Entregues,
    COUNT(CASE WHEN StatusPedido = 'CANCELADO' THEN 1 ELSE 0 END) AS Pedidos_Cancelados,
    COUNT(CASE WHEN DataEntrega IS NULL AND DataPrevista < GETDATE() THEN 1 ELSE 0 END) AS Pedidos_Atrasados,
    SUM(ValorTotal) AS Valor_Total_Ativo,
    CASE
        WHEN COUNT(CASE WHEN StatusPedido = 'CANCELADO' THEN 1 END) > 0.5 * COUNT(PedidoID)
            THEN 'ALERTA: Alta taxa de cancelamento'
        WHEN COUNT(CASE WHEN StatusPedido = 'ENTREGUE' THEN 1 END) = 0
            THEN 'ALERTA: Nenhuma entrega'
        ELSE 'NORMAL'
    END AS StatusGeral
FROM [dbo].[PedidosClientes]
WHERE StatusPedido <> 'CANCELADO'
GROUP BY ClienteID
ORDER BY Valor_Total_Ativo DESC;

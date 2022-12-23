SELECT * FROM produtos WHERE id IN (SELECT id_produto FROM compras WHERE id_cliente = (SELECT id FROM clientes WHERE nome = 'Chico Buarque de Holanda'));

# eu apaguei sem querer o cliente 'Benício Freire Sampaio', por isso usei o 'Chico Buarque de Holanda'
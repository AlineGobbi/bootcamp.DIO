
# Desafio: Criando um sistema bancário com Funções

## Objetivo Geral

Separar as funções existentes de saque, depósito e extrato em funções. Criar duas novas funções: cadastrar usuário (cliente) e cadastrar conta bancária. 

### Desafio

Deixar o código mais modularizado, utilizando funções.

### Função de saque

Deve receber os argumentos apenas por nome (keyword only). 

### Função de depósito

Deve receber os argumentos apenas por posição (positional only).

### Função de extrato

Deve receber os argumentos por posição e nome.

### Criar usuário (cliente)

Deve armazenar os usuários em uma lista, um usuário é composto por: nome, data de nascimento, cpf e endereço. O endereço é uma string com o formato: logradouro, nro - bairro - cidade/sigla estado. Deve ser armazenado somente os números do CPF. Não podemos cadastrar 2 usuários com o mesmo CPF.

### Criar conta corrente

Deve armazenar contas em uma lista, uma conta é composta por: agência, número da conta e usuário. O número da conta é sequencial, iniciado em 1. O número da agência é fixo: "0001". O usuário pode ter mais de uma conta, mas uma conta pertence a somente um usuário. 
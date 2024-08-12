# Project-Shared-Wallet
Project Solidity 


# Projeto de Contratos Inteligentes

Este projeto contém dois contratos inteligentes implementados na linguagem Solidity para gerenciar permissões de saque e gerenciar uma carteira simples. O projeto utiliza a biblioteca SafeMath para operações matemáticas seguras e eventos para rastreamento de transações.

## Estrutura do Projeto

O projeto é dividido em dois contratos principais:

1. **AllowanceManager**: Gerencia permissões de saque.
2. **SimpleWallet**: Gerencia depósitos, retiradas e interage com o contrato AllowanceManager.

## Funcionalidades

### AllowanceManager

- **Definição de Permissão**: Permite definir o allowance (permissão de saque) para diferentes endereços.
- **Redução de Permissão**: Permite reduzir o allowance para um endereço específico.
- **Eventos**:
  - `AllowanceChanged(address indexed who, uint256 oldAllowance, uint256 newAllowance)`: Emitido quando o allowance de um endereço é alterado.

### SimpleWallet

- **Depósitos**: Permite que o contrato receba éter e emite um evento quando o dinheiro é depositado.
- **Retiradas**: Permite retirar éter do contrato para um endereço, baseado na permissão definida pelo AllowanceManager ou se for o proprietário.
- **Interação com AllowanceManager**: Verifica permissões e ajusta allowances antes de permitir retiradas.
- **Eventos**:
  - `Deposited(address indexed from, uint256 amount)`: Emitido quando é depositado éter no contrato.
  - `Withdrawn(address indexed to, uint256 amount)`: Emitido quando é retirado éter do contrato.
  - `MoneyReceived(address indexed from, uint256 amount)`: Emitido quando o contrato recebe éter.
  - `MoneySent(address indexed to, uint256 amount)`: Emitido quando é retirado éter do contrato.
  - `InsufficientFunds(address indexed caller, uint256 requestedAmount, uint256 availableAmount)`: Emitido quando há fundos insuficientes no contrato para uma retirada.

## Dependências

- [OpenZeppelin Contracts](https://docs.openzeppelin.com/contracts/4.x/) - Utilizado para a biblioteca SafeMath e funcionalidades de propriedade.

## Implantação

1. **Implantar o contrato `AllowanceManager`**:
   - Compile e implante o contrato `AllowanceManager` primeiro.

2. **Implantar o contrato `SimpleWallet`**:
   - Compile e implante o contrato `SimpleWallet`, fornecendo o endereço do contrato `AllowanceManager` como parâmetro para o construtor.

## Testes

- **Definir Permissões**:
  - Teste a definição de allowances para diferentes endereços usando a função `setAllowance` do contrato `AllowanceManager`.

- **Retirar Fundos**:
  - Teste retiradas com permissões adequadas e sem permissões usando a função `withdraw` do contrato `SimpleWallet`.

- **Eventos**:
  - Verifique a emissão correta dos eventos para depósitos, retiradas e alterações de permissões.

- **Renúncia de Propriedade**:
  - A função `renounceOwnership` é impedida e não deve ser possível renunciar à propriedade do contrato.

## Segurança

- **SafeMath**: Utiliza SafeMath para operações matemáticas seguras para evitar estouros.
- **Renúncia de Propriedade**: A função `renounceOwnership` foi desativada para evitar perda acidental de controle.

## Contribuições

Se você deseja contribuir para este projeto, siga estas etapas:

1. Faça um fork deste repositório.
2. Crie uma nova branch para sua feature ou correção.
3. Submeta um pull request com uma descrição clara das alterações.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE).




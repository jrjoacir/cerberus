# Documentação de Entidade

## Entidades

Entidade |Descrição
:-------|:-----------
**Clients**|A entidade **Clients** representa um cliente que pode contratar um produto. O nome do cliente é um atributo único portanto é possível referenciar um cliente unicamente através do seu nome.
**Products**|A entidade **Products** representa um produto digital ou um seriço que pode ser oferecido para um ou mais clientes. O nome do produto é um atributo único, portanto é possível referenciar um produto unicamente através de seu nome.
**Contracts**|A entidade **Contracts** representa a relação de negócio entre clientes e produtos, como uma assinatura. Cada contrato esta associado a vários grupos (papéis) de usuários, que tem acesso a este contrato.
**Features**|A entidade **Features** representa cada uma das funcionalidade de um produto. Funcionalidade pode ter diversas interpretações: um módulo de sistema, uma pequena função de sistema, uma tarefa ou processo de sistema, entre outros. Então, use-os como preferir. O nome da funcionalidade é único para um produto.
**Users**|A entidade **Users** representa os usuários do sistema que requerem direito de acesso as funcionalidades do produto. O atributo login é único.
**Roles**|A entidade **Roles** representa os papéis que os usuários podem exercer. Algumas pessoa gostam de chamá-lo de grupos de usuários. O atributo nome é único por contrato.
**Features_Roles**|A entidade **Features_Roles** une papéis de usuários (*roles*) a funcionalidade (*features*). Ela mostra quais papéis tem acesso a quais funcionalidades. O par Funcionalidade-Papel (*feature-role*) é único.
**Users_Roles**|A entidade **Users_Roles** une usuários aos papéis (*roles*).Ela mostra que usuários tem associação com quais papéis. O par Usuário-Papel (*user-role*) é único.

## Diagrama de Entidade Relacionamento (DER)
![](entity_relationship_diagram.png)
##### Diagrama feito com a biblioteca Mermaid
- [A basic mermaid User-Guide for Beginners](https://mermaid-js.github.io/mermaid/#/n00b-gettingStarted)
- [Entity Relationship Diagrams](https://mermaid-js.github.io/mermaid/#/entityRelationshipDiagram?id=entity-relationship-diagrams)

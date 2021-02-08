# Entity Documentation

## Entities

Entity |Description
:-------|:-----------
**Clients**|The Clients entity represents a client which can contract a product. Client name is an unique attribute, therefore it is possible to reference to a client uniquely by its name.
**Products**|The Products entity represents a digital product or service which can be to offer ro one or more clients. Product name is an unique attribute, therefore it is possible to reference to a product uniquely by its name.
**Contracts**|The Contracts entity represents business relation between Clients and Products, like a signature. Each contract is associated to many user roles, which has access to this contract.
**Features**|The Features entity represents each all product's functionalities. Functionality can have many interpretations: a system module, a little system function, a system task, and so on. So, use them as you prefer. Feature name is unique by a product.
**Users**|The Users entity represents system users who requires grant access to use product's features (or funcionalities). Login attribute is unique.
**Roles**|The Roles entity represents roles that users can operate. Some people like to refer them like a definition of a users group. Role name is unique by a contract.
**Features_Roles**|The Features_Roles join roles to features. It shows us which are roles have access to which features. The feature-role pair is an unique pair.
**Users_Roles**|The Users_roles join users to roles. It shows us which are users have which roles. The user-role pair is an unique pair.

## Entity Relationship Diagram (ERD)
<!DOCTYPE html>
<html>
  <body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid/dist/mermaid.min.js"></script>
    <script>mermaid.initialize({startOnLoad:true});</script>
    <div class="mermaid">
      erDiagram
      CLIENTS ||--o{ CONTRACTS : ""
      PRODUCTS ||--o{ CONTRACTS : ""
      PRODUCTS ||--o{ FEATURES : ""
      CONTRACTS ||--o{ ROLES : ""
      ROLES ||--o{ FEATURES_ROLES : ""
      FEATURES ||--o{ FEATURES_ROLES : ""
      USERS ||--o{ USERS_ROLES : ""
      ROLES ||--o{ USERS_ROLES : ""

      CLIENTS {
        int id
        string name
        timestamp created_at
        timestamp updated_at
      }

      PRODUCTS {
        int id
        string name
        string description
        timestamp created_at
        timestamp updated_at
      }

      CONTRACTS {
        int id
        int client_id
        int product_id
        boolean enabled
        timestamp created_at
        timestamp updated_at
      }

      ROLES {
        int id
        int contract_id
        string name
        boolean enabled
        timestamp created_at
        timestamp updated_at
      }

      FEATURES {
        int id
        int product_id
        string name
        boolean enabled
        boolean read_only
        timestamp created_at
        timestamp updated_at
      }

      FEATURES_ROLES {
        int id
        int feature_id
        int role_id
        timestamp created_at
        timestamp updated_at
      }

      USERS {
        int id
        string login
        string name
        timestamp created_at
        timestamp updated_at
      }

      USERS_ROLES {
        int id
        int user_id
        int role_id
        timestamp created_at
        timestamp updated_at
      }
    </div>

    <h5>Diagram build with Mermaid library</h5>
    <ul>
      <li><a href="https://mermaid-js.github.io/mermaid/#/n00b-gettingStarted">A basic mermaid User-Guide for Beginners</a></li>
      <li><a href="https://mermaid-js.github.io/mermaid/#/entityRelationshipDiagram?id=entity-relationship-diagrams">Entity Relationship Diagrams</a></li>
    </ul>
  </body>
</html>

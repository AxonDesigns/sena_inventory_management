/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("q09cdeamt5nygxm");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "q09cdeamt5nygxm",
    "created": "2024-06-12 21:53:45.962Z",
    "updated": "2024-06-14 13:53:16.473Z",
    "name": "plain_products",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "yxijtrpl",
        "name": "name",
        "type": "text",
        "required": true,
        "presentable": true,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "guge3jq2",
        "name": "description",
        "type": "text",
        "required": false,
        "presentable": true,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "aqyl5ofi",
        "name": "state",
        "type": "text",
        "required": true,
        "presentable": true,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "bgum6udh",
        "name": "type",
        "type": "text",
        "required": true,
        "presentable": true,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      },
      {
        "system": false,
        "id": "oscni5dg",
        "name": "price",
        "type": "number",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "min": 1,
          "max": null,
          "noDecimal": false
        }
      },
      {
        "system": false,
        "id": "eelvgttl",
        "name": "unit",
        "type": "text",
        "required": true,
        "presentable": true,
        "unique": false,
        "options": {
          "min": null,
          "max": null,
          "pattern": ""
        }
      }
    ],
    "indexes": [],
    "listRule": "@request.auth.id != \"\" && @request.auth.role.privilege > 0",
    "viewRule": "@request.auth.id != \"\" && @request.auth.role.privilege > 0",
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT p.id, p.name, p.description, ps.name as state, pt.name as type, p.price, u.symbol as unit, p.created, p.updated\nFROM product p\nINNER JOIN unit u ON p.unit = u.id\nINNER JOIN product_type pt ON p.type = pt.id\nINNER JOIN product_state ps ON p.state = ps.id\n;"
    }
  });

  return Dao(db).saveCollection(collection);
})

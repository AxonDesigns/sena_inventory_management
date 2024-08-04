/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const collection = new Collection({
    "id": "4jlebyvohnwio8h",
    "created": "2024-08-04 01:44:19.108Z",
    "updated": "2024-08-04 01:44:19.108Z",
    "name": "product_stock",
    "type": "view",
    "system": false,
    "schema": [
      {
        "system": false,
        "id": "cd55cray",
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
        "id": "tmqyfn2g",
        "name": "unit_price",
        "type": "number",
        "required": true,
        "presentable": false,
        "unique": false,
        "options": {
          "min": 1,
          "max": null,
          "noDecimal": false
        }
      }
    ],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT p.id as id, p.name, p.price as unit_price\nFROM products p\nINNER JOIN product_transactions pt ON pt.product = p.id\nINNER JOIN transactions t ON t.id = pt.\"transaction\";"
    }
  });

  return Dao(db).saveCollection(collection);
}, (db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h");

  return dao.deleteCollection(collection);
})

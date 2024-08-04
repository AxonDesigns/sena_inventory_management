/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db);
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq");

  return dao.deleteCollection(collection);
}, (db) => {
  const collection = new Collection({
    "id": "mf2kpu9ecrymeuq",
    "created": "2024-06-14 13:52:05.971Z",
    "updated": "2024-08-04 02:49:42.219Z",
    "name": "stock",
    "type": "view",
    "system": false,
    "schema": [],
    "indexes": [],
    "listRule": null,
    "viewRule": null,
    "createRule": null,
    "updateRule": null,
    "deleteRule": null,
    "options": {
      "query": "SELECT p.id FROM products p;"
    }
  });

  return Dao(db).saveCollection(collection);
})

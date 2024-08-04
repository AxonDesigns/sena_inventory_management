/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price\nFROM products p\nINNER JOIN product_transactions pt ON pt.product = p.id\nINNER JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id;"
  }

  // remove
  collection.schema.removeField("wbyjk0y7")

  // remove
  collection.schema.removeField("equoo1ga")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "qch6qfxt",
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
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "xvdszgst",
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
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price\nFROM products p\nINNER JOIN product_transactions pt ON pt.product = p.id\nINNER JOIN transactions t ON t.id = pt.\"transaction\";"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "wbyjk0y7",
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
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "equoo1ga",
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
  }))

  // remove
  collection.schema.removeField("qch6qfxt")

  // remove
  collection.schema.removeField("xvdszgst")

  return dao.saveCollection(collection)
})

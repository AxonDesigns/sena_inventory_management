/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price,\n  SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) AS units_available\nFROM products p\nINNER JOIN units u ON u.id = p.unit\nLEFT JOIN product_transactions pt ON pt.product = p.id\nLEFT JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id, p.name, p.price, u.name;"
  }

  // remove
  collection.schema.removeField("pcogmpgo")

  // remove
  collection.schema.removeField("tpkggdpx")

  // remove
  collection.schema.removeField("lpvzp3bd")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "bowiefx5",
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
    "id": "qpcmu1wk",
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

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "wleyxzsl",
    "name": "units_available",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price,\n  SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) AS units_available\nFROM products p\nLEFT JOIN product_transactions pt ON pt.product = p.id\nLEFT JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "pcogmpgo",
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
    "id": "tpkggdpx",
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

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "lpvzp3bd",
    "name": "units_available",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("bowiefx5")

  // remove
  collection.schema.removeField("qpcmu1wk")

  // remove
  collection.schema.removeField("wleyxzsl")

  return dao.saveCollection(collection)
})

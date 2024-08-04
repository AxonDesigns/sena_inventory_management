/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, u.name as unit, p.price as unit_price,\n  SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) AS units_available\nFROM products p\nINNER JOIN units u ON u.id = p.unit\nLEFT JOIN product_transactions pt ON pt.product = p.id\nLEFT JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id, p.name, p.price, u.name;"
  }

  // remove
  collection.schema.removeField("bowiefx5")

  // remove
  collection.schema.removeField("qpcmu1wk")

  // remove
  collection.schema.removeField("wleyxzsl")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "4uw9hisk",
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
    "id": "blpwt0wc",
    "name": "unit",
    "type": "text",
    "required": true,
    "presentable": false,
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
    "id": "nsdgv6ry",
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
    "id": "jebhbdjt",
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
    "query": "SELECT p.id as id, p.name, p.price as unit_price,\n  SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) AS units_available\nFROM products p\nINNER JOIN units u ON u.id = p.unit\nLEFT JOIN product_transactions pt ON pt.product = p.id\nLEFT JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id, p.name, p.price, u.name;"
  }

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

  // remove
  collection.schema.removeField("4uw9hisk")

  // remove
  collection.schema.removeField("blpwt0wc")

  // remove
  collection.schema.removeField("nsdgv6ry")

  // remove
  collection.schema.removeField("jebhbdjt")

  return dao.saveCollection(collection)
})

/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price,\n  SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) AS available\nFROM products p\nLEFT JOIN product_transactions pt ON pt.product = p.id\nLEFT JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id;"
  }

  // remove
  collection.schema.removeField("oxrfqj0k")

  // remove
  collection.schema.removeField("g8a2deb1")

  // remove
  collection.schema.removeField("n8iozzjo")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ra7iyufd",
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
    "id": "elvv3nqj",
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
    "id": "ok7oxzlw",
    "name": "available",
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
    "query": "SELECT p.id as id, p.name, p.price as unit_price,\n  SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) AS stock\nFROM products p\nLEFT JOIN product_transactions pt ON pt.product = p.id\nLEFT JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "oxrfqj0k",
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
    "id": "g8a2deb1",
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
    "id": "n8iozzjo",
    "name": "stock",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("ra7iyufd")

  // remove
  collection.schema.removeField("elvv3nqj")

  // remove
  collection.schema.removeField("ok7oxzlw")

  return dao.saveCollection(collection)
})

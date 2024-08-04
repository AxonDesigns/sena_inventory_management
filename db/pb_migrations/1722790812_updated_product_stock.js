/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price,\n  SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) AS units_available, u.name as unit\nFROM products p\nINNER JOIN units u ON u.id = p.unit\nLEFT JOIN product_transactions pt ON pt.product = p.id\nLEFT JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id;"
  }

  // remove
  collection.schema.removeField("vtdvl5sr")

  // remove
  collection.schema.removeField("5gwbbiou")

  // remove
  collection.schema.removeField("mfvsigzp")

  // remove
  collection.schema.removeField("mij9zlbe")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "oelksv7m",
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
    "id": "esu5b8po",
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
    "id": "j4c9iclj",
    "name": "units_available",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "vvyhfa9c",
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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price,\n  SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) AS units_available, u.name as unit\nFROM products p\nINNER JOIN units u ON u.id = p.unit\nLEFT JOIN product_transactions pt ON pt.product = p.id\nLEFT JOIN transactions t ON t.id = pt.\"transaction\"\nGROUP BY p.id, p.name, p.price, u.name;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "vtdvl5sr",
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
    "id": "5gwbbiou",
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
    "id": "mfvsigzp",
    "name": "units_available",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "mij9zlbe",
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

  // remove
  collection.schema.removeField("oelksv7m")

  // remove
  collection.schema.removeField("esu5b8po")

  // remove
  collection.schema.removeField("j4c9iclj")

  // remove
  collection.schema.removeField("vvyhfa9c")

  return dao.saveCollection(collection)
})

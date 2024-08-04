/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price, \n        SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        )\n     AS stock\nFROM\n    product_transactions pt\n    JOIN products p ON pt.product = p.id\n    JOIN transactions t ON pt.\"transaction\" = t.id;"
  }

  // remove
  collection.schema.removeField("9x3ujdy9")

  // remove
  collection.schema.removeField("9mu6og9t")

  // remove
  collection.schema.removeField("jefcjymo")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "mbxmvcuq",
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
    "id": "dkonuuio",
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
    "id": "by8m1xhd",
    "name": "stock",
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
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "SELECT pt.product as id, p.name, p.price as unit_price, \n        SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        )\n     AS stock\nFROM\n    product_transactions pt\n    JOIN products p ON pt.product = p.id\n    JOIN transactions t ON pt.\"transaction\" = t.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "9x3ujdy9",
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
    "id": "9mu6og9t",
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
    "id": "jefcjymo",
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
  collection.schema.removeField("mbxmvcuq")

  // remove
  collection.schema.removeField("dkonuuio")

  // remove
  collection.schema.removeField("by8m1xhd")

  return dao.saveCollection(collection)
})

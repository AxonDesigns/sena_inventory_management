/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "SELECT p.id FROM products p;"
  }

  // remove
  collection.schema.removeField("xzwlzsll")

  // remove
  collection.schema.removeField("rlgakipu")

  // remove
  collection.schema.removeField("wln4yhje")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price, \n        SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN -pt.amount\n                ELSE 0\n            END\n        )\n     AS stock\nFROM\n    product_transactions pt\n    JOIN products p ON pt.product = p.id\n    JOIN transactions t ON pt.\"transaction\" = t.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "xzwlzsll",
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
    "id": "rlgakipu",
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
    "id": "wln4yhje",
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
})

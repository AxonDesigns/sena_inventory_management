/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "SELECT pt.product as id, p.name, (\n        SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) * p.price\n    ) AS stock\nFROM\n    product_transactions pt\n    JOIN products p ON pt.product = p.id\n    JOIN transactions t ON pt.\"transaction\" = t.id;"
  }

  // remove
  collection.schema.removeField("6elhnhor")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "lgch8vbe",
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
    "id": "7zfrtbpq",
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
    "query": "SELECT pt.product as id, (\n        SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) * p.price\n    ) AS stock\nFROM\n    product_transactions pt\n    JOIN products p ON pt.product = p.id\n    JOIN transactions t ON pt.\"transaction\" = t.id;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "6elhnhor",
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
  collection.schema.removeField("lgch8vbe")

  // remove
  collection.schema.removeField("7zfrtbpq")

  return dao.saveCollection(collection)
})

/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "SELECT pt.product as id, (\n        SUM(\n            CASE\n                WHEN t.type = 'Income' THEN pt.amount\n                WHEN t.type = 'Expense' THEN - pt.amount\n                ELSE 0\n            END\n        ) * p.price\n    ) AS stock\nFROM\n    product_transactions pt\n    JOIN products p ON pt.product = p.id\n    JOIN transactions t ON pt.\"transaction\" = t.id;"
  }

  // remove
  collection.schema.removeField("6myh22fo")

  // remove
  collection.schema.removeField("bdhajreu")

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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "WITH earnings as (\n  SELECT t.id, p.name, (pt.amount * p.price) as total\n  FROM transactions t\n  INNER JOIN product_transactions pt ON pt.\"transaction\" = t.id\n  INNER JOIN products p ON pt.product = p.id\n  WHERE t.type == \"Income\"\n),\ndispense as (\n  SELECT t.id, p.name, (pt.amount * p.price) as total\n  FROM transactions t\n  INNER JOIN product_transactions pt ON pt.\"transaction\" = t.id\n  INNER JOIN products p ON pt.product = p.id\n  WHERE t.type == \"Outcome\"\n)\nSELECT e.id, e.name, e.total\nFROM earnings e;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "6myh22fo",
    "name": "name",
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
    "id": "bdhajreu",
    "name": "total",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("6elhnhor")

  return dao.saveCollection(collection)
})

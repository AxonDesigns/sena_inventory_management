/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "WITH earnings as (\n  SELECT t.id, p.name, (pt.amount * p.price) as total\n  FROM transactions t\n  INNER JOIN product_transactions pt ON pt.\"transaction\" = t.id\n  INNER JOIN products p ON pt.product = p.id\n  WHERE t.type == \"Income\"\n),\ndispense as (\n  SELECT t.id, p.name, (pt.amount * p.price) as total\n  FROM transactions t\n  INNER JOIN product_transactions pt ON pt.\"transaction\" = t.id\n  INNER JOIN products p ON pt.product = p.id\n  WHERE t.type == \"Outcome\"\n)\nSELECT e.id, e.name, e.total\nFROM earnings e;"
  }

  // remove
  collection.schema.removeField("7cef6nns")

  // remove
  collection.schema.removeField("jeoosrgb")

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

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "WITH earnings as (\n  SELECT t.id, p.name, (pt.amount * p.price) as total\n  FROM transactions t\n  INNER JOIN product_transactions pt ON pt.\"transaction\" = t.id\n  INNER JOIN products p ON pt.product = p.id\n  WHERE t.type == \"Income\"\n)\nSELECT e.id, e.name, e.total\nFROM earnings e;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "7cef6nns",
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
    "id": "jeoosrgb",
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
  collection.schema.removeField("6myh22fo")

  // remove
  collection.schema.removeField("bdhajreu")

  return dao.saveCollection(collection)
})

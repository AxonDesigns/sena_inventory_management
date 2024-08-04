/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("mf2kpu9ecrymeuq")

  collection.options = {
    "query": "WITH earnings as (\n  SELECT t.id, p.name, (pt.amount * p.price) as total\n  FROM transactions t\n  INNER JOIN product_transactions pt ON pt.\"transaction\" = t.id\n  INNER JOIN products p ON pt.product = p.id\n)\nSELECT e.id, e.name, e.total\nFROM earnings e;"
  }

  // remove
  collection.schema.removeField("aghxnq07")

  // remove
  collection.schema.removeField("1ebe8hgr")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "cytuuy0w",
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
    "id": "wdskvgu3",
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
    "query": "SELECT t.id, p.name, (pt.amount * p.price) as total\nFROM transactions t\nINNER JOIN product_transactions pt ON pt.\"transaction\" = t.id\nINNER JOIN products p ON pt.product = p.id\n;"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "aghxnq07",
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
    "id": "1ebe8hgr",
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
  collection.schema.removeField("cytuuy0w")

  // remove
  collection.schema.removeField("wdskvgu3")

  return dao.saveCollection(collection)
})

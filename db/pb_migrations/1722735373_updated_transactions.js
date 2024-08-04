/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("s3s1w7yzel0ehh0")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "kazgrb7i",
    "name": "type",
    "type": "select",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSelect": 1,
      "values": [
        "Income",
        "Expense"
      ]
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("s3s1w7yzel0ehh0")

  // update
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "kazgrb7i",
    "name": "type",
    "type": "select",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSelect": 1,
      "values": [
        "Income",
        "Outcome",
        "Neutral"
      ]
    }
  }))

  return dao.saveCollection(collection)
})

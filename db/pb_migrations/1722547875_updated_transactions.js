/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("s3s1w7yzel0ehh0")

  // add
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
        "income",
        "outcome",
        "neutral"
      ]
    }
  }))

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("s3s1w7yzel0ehh0")

  // remove
  collection.schema.removeField("kazgrb7i")

  return dao.saveCollection(collection)
})

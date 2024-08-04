/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("s3s1w7yzel0ehh0")

  // remove
  collection.schema.removeField("jkjldlnf")

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("s3s1w7yzel0ehh0")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "jkjldlnf",
    "name": "type",
    "type": "relation",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "collectionId": "5wmb2wxop34ehu5",
      "cascadeDelete": false,
      "minSelect": null,
      "maxSelect": 1,
      "displayFields": null
    }
  }))

  return dao.saveCollection(collection)
})

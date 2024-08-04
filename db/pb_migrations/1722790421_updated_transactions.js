/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("s3s1w7yzel0ehh0")

  collection.listRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.viewRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.createRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.updateRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.deleteRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("s3s1w7yzel0ehh0")

  collection.listRule = null
  collection.viewRule = null
  collection.createRule = "@request.data.description != null"
  collection.updateRule = null
  collection.deleteRule = null

  return dao.saveCollection(collection)
})

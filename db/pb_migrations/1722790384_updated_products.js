/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("f70bvfzlpjqe5v0")

  collection.listRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.viewRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.createRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.updateRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.deleteRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"

  return dao.saveCollection(collection)
}, (db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("f70bvfzlpjqe5v0")

  collection.listRule = "@request.auth.role.privilege = 3"
  collection.viewRule = "@request.auth.role.privilege = 3"
  collection.createRule = "@request.auth.role.privilege = 3"
  collection.updateRule = "@request.auth.role.privilege = 3"
  collection.deleteRule = "@request.auth.role.privilege = 3"

  return dao.saveCollection(collection)
})

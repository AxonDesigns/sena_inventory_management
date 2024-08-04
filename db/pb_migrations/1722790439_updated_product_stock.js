/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.listRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"
  collection.viewRule = "@request.auth.id != \"\" && @request.auth.role.privilege > 0"

  // remove
  collection.schema.removeField("ra7iyufd")

  // remove
  collection.schema.removeField("elvv3nqj")

  // remove
  collection.schema.removeField("ok7oxzlw")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "7w6bpwbr",
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
    "id": "of5aleel",
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
    "id": "he30wvhp",
    "name": "available",
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
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.listRule = null
  collection.viewRule = null

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "ra7iyufd",
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
    "id": "elvv3nqj",
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
    "id": "ok7oxzlw",
    "name": "available",
    "type": "json",
    "required": false,
    "presentable": false,
    "unique": false,
    "options": {
      "maxSize": 1
    }
  }))

  // remove
  collection.schema.removeField("7w6bpwbr")

  // remove
  collection.schema.removeField("of5aleel")

  // remove
  collection.schema.removeField("he30wvhp")

  return dao.saveCollection(collection)
})

/// <reference path="../pb_data/types.d.ts" />
migrate((db) => {
  const dao = new Dao(db)
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price, \n  SUM(\n  CASE WHEN t.type == \"Income\" THEN pt.amount\n  WHEN t.type == \"Expense\" THEN -pt.amount\n  ELSE 0\n  END\n  ) as stock\nFROM products p\nINNER JOIN product_transactions pt ON pt.product = p.id\nINNER JOIN transactions t ON t.id = pt.\"transaction\";"
  }

  // remove
  collection.schema.removeField("cd55cray")

  // remove
  collection.schema.removeField("tmqyfn2g")

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "3lb2mbp3",
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
    "id": "y4ae2i4j",
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
    "id": "bfxy2i6l",
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
  const collection = dao.findCollectionByNameOrId("4jlebyvohnwio8h")

  collection.options = {
    "query": "SELECT p.id as id, p.name, p.price as unit_price\nFROM products p\nINNER JOIN product_transactions pt ON pt.product = p.id\nINNER JOIN transactions t ON t.id = pt.\"transaction\";"
  }

  // add
  collection.schema.addField(new SchemaField({
    "system": false,
    "id": "cd55cray",
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
    "id": "tmqyfn2g",
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

  // remove
  collection.schema.removeField("3lb2mbp3")

  // remove
  collection.schema.removeField("y4ae2i4j")

  // remove
  collection.schema.removeField("bfxy2i6l")

  return dao.saveCollection(collection)
})

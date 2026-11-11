@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_SPAC109_STOCK provider contract transactional_query as projection on ZR_SPAC109_STOCK
{
  @EndUserText.label: 'Warehouse'
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZVH_SPAC109_WH',
      element: 'WarehouseId'
    }
  }]  
  key WarehouseId,
  
  @EndUserText.label: 'Product'
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZVH_SPAC109_PRODUCT',
      element: 'ProductId'
    }
  }]
  key ProductId,
  
  @EndUserText.label: 'Amount'
  Amount,
  
  @EndUserText.label: 'Product Name'
  ProductName,
  
  @EndUserText.label: 'Product Description'
  ProductDescription,
  
  @EndUserText.label: 'Product Category'
  ProductCategory,
  
  @EndUserText.label: 'Warehouse Name'
  WarehouseName,
  
  @EndUserText.label: 'Warehouse Adress'
  WarehouseAddress,
  
  @EndUserText.label: 'Warehouse City'
  WarehouseCity,
  
  @EndUserText.label: 'Postal Code'
  PostalCode,
  
  _Product,
  _Warehouse
}

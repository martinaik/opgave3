@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Category value help'
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZVH_SPAC109_CATEG as select from zspac109_categ
{
  key category    as Category,
      description as Description
}

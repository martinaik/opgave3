@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product status value help'
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZVH_SPAC109_PSTAT
  as select from zspac109_pstat
{
  key status      as Status,
      description as Description
}

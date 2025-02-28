@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'drop do'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity znm_class_dom as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZNM_CLASS1' )
{
   key value_low as Value
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for class'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity znm_class_cds as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( p_domain_name: 'ZNM_CLSSEC' )
{
@UI.textArrangement: #TEXT_ONLY
//@ObjectModel.text.association: '_Text' 
   --@Semantics.language: true
   -- key value_position,
   -- key domain_name,
    --key language,
    key value_low as Value
    --text as Text
   
    
    
    
    
}

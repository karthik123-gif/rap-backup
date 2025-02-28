@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zstudent_fu_i as select from zstudent_fu
composition[1..*] of ZATTACHMENT_FU_i as _Attachments 
{
    @EndUserText.label: 'Student ID'
    key id as Id,
    @EndUserText.label: 'First Name'
    firstname as Firstname,
    @EndUserText.label: 'Last Name'
   lastname as Lastname,
    @EndUserText.label: 'Age'
    age as Age,
    @EndUserText.label: 'Course'
   course as Course,
    @EndUserText.label: 'Course Duration'
   courseduration as Courseduration,
    @EndUserText.label: 'Status'
   status as Status,
    @EndUserText.label: 'Gender'
    gender as Gender,
    @EndUserText.label: 'DOB'
    
   dob as Dob,
    lastchangedat as Lastchangedat,
   locallastchangedat as Locallastchangedat,
   _Attachments
}

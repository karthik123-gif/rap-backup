@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'INTERFACE ENTITY VIEW FOR STUDENT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.semanticKey: [ 'Id' ]
@Metadata.allowExtensions: true
define root view entity ZI_STUDENT_RAP as select from zmpack_rap
composition[0..*] of ZI_AR_RAP as _academicres 
association[0..1] to ZI_GENDER_RAP as _gender on $projection.Gender = _gender.Value
association[1..1] to ZI_COURSE_RAP as _course on $projection.Course = _course.Value
{
 @ObjectModel.text.element: [ 'Genderdesc' ]
  key id             as Id,
      firstname      as Firstname,
      lastname       as Lastname,
      age            as Age,
      course         as Course,
      courseduration as Courseduration,
      
      status         as Status,
     
      case gender
      when 'F' then 3
      when 'M' then 2
      else 0
      end as overallcriticality,
      gender         as Gender,
      dob            as Dob,
      _gender,
      _course,
      
      _academicres,
      _gender.Description as Genderdesc,
      lastchangedat as LastChangedAt,
      locallastchangedat as LocalLastChangedAt
      
}

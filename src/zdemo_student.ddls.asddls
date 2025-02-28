@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'student value help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zdemo_student as select from znm_student1
{

    key student_id as StudentId,
    student_name as StudentName,
    class as Class,
    class_section as ClassSection,
    avg_marks as AvgMarks,
    attend_percent as AttendPercent,
    status as Status,
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat
}

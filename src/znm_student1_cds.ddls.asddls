@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for student'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define root view entity znm_student1_cds as select from znm_student1
composition[1..*] of znm_exam1_cds as _exams 
composition[1..*] of znm_lib_records_cds as _library
composition[1..*] of znm1_attendance_cds as _attendance

{
    key student_id as StudentId,
    student_name as StudentName,
    class as Class,
    class_section as ClassSection,

    avg_marks as AvgMarks,
    attend_percent as AttendPercent,
    status as Status,
     lastchangedat as LastChangedAt,
      locallastchangedat as LocalLastChangedAt,
    _exams,
    _library,
    _attendance
   
}

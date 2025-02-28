@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for  student'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity znm_student_cds as select from znm_student as student
composition[1..*] of znm_exams_cds as _exams 
association[1..1] to znm_class_cds as _class on $projection.ClassSection =  _class.Value
 // Association to Exams (Child)
  --  association [0..*] to znm_exams_cds as _Exams_f on $projection.StudentId = _Exams_f.StudentId

//composition[1..*] of znm_marks_cds as _marks 
{
    key student_id as StudentId,
    student_name as StudentName,
    class as Class,
    class_section as ClassSection,
    avg_marks as AvgMarks,
    _exams,
    _class
  --  _Exams_f
   -- _marks
}

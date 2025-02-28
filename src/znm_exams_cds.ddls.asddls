@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for exams'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
@Metadata.allowExtensions: true
define view entity znm_exams_cds as select from znm_exams

composition[1..*] of znm_marks_cds as _marks

association to parent znm_student_cds as _student
    on $projection.StudentId = _student.StudentId
     

association to znm_scl_exams as _scl_exams 
 on $projection.ExamNo = _scl_exams.exam_no
 
  // Association to Student (Parent)
  --  association [1] to znm_student_cds as _Student_f on  $projection.StudentId = _Student_f.StudentId

    // Association to Marks (Child)
   -- association [0..*] to znm_marks_cds as _Marks_f on  $projection.ExamNo =  _Marks_f.ExamNo
 
{
    key student_id as StudentId,
    key exam_no as ExamNo,
    _scl_exams.exam_name,
    _scl_exams,
    _student,
    _marks
    --_Student_f,
   -- _Marks_f
}

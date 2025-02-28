@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for marks'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity znm_marks_cds as select from znm_marks

association to parent znm_exams_cds as _exams
    on $projection.StudentId = _exams.StudentId
    and $projection.ExamNo = _exams.ExamNo 
    
/*association to parent znm_student_cds as _students
    on $projection.StudentId = _students.StudentId */
    

association to znm_scl_sub as _scl_sub 
 on $projection.SubNo = _scl_sub.sub_no
 
 association to znm_student_cds as _students 
 on $projection.StudentId = _students.StudentId 
 
 // Association to Exams (Parent)
    --association [1] to znm_exams_cds as _Exam_f on $projection.ExamNo = _Exam_f.ExamNo  
 
{
    key student_id as StudentId,
    key exam_no as ExamNo,
    key sub_no as SubNo,
    marks as Marks,
    _scl_sub.sub_name,
    _exams,
    _students
    --_Exam_f
}

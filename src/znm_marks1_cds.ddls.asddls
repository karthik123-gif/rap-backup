
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'marks cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define view entity znm_marks1_cds as select from znm_marks1

 association to znm_student1_cds as _student 
 on $projection.StudentId = _student.StudentId 
    
association to parent znm_exam1_cds as _exams
    on $projection.StudentId = _exams.StudentId
    and $projection.ExamNo = _exams.ExamNo 
  
association to znm_scl_sub as _scl_sub 
 on $projection.SubNo = _scl_sub.sub_no
{
    key student_id as StudentId,
    key exam_no as ExamNo,
    key sub_no as SubNo,
    marks as Marks,
    _student,
    _exams,
    _scl_sub.sub_name
}


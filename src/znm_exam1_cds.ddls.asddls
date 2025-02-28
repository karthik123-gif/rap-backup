@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for exams'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
@ObjectModel.resultSet.sizeCategory: #XS
@ObjectModel.dataCategory:#HIERARCHY
define view entity znm_exam1_cds as select from znm_exam1
association to parent znm_student1_cds as _student
    on $projection.StudentId = _student.StudentId
 
 association to znm_scl_exams as _scl_exams 
 on $projection.ExamNo = _scl_exams.exam_no

 composition[1..*] of znm_marks1_cds as _marks   
{
    key student_id as StudentId,
    key exam_no as ExamNo,
    _student,
    _marks,
    _scl_exams.exam_name
}

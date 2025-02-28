@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'exams table'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zdemo1_v4 as select from znm_exam1
association to parent zdemo_v4 as _student
    on $projection.StudentId = _student.StudentId
 
{
@UI.facet: [{id: 'Exams',
                 purpose: #STANDARD,
                 type: #IDENTIFICATION_REFERENCE,
                 label: 'Exams',
                 position: 10
                 }   
                 ] 

    key student_id as StudentId,
    @EndUserText.label: 'ExamNo'
 @UI:{ lineItem: [{position:20, label:'ExamNo' } ],
            identification: [ { position:20, label:'ExamNo' } ],
            selectionField: [{ position:20  }]  
            }
    key exam_no as ExamNo,
    _student
    
}

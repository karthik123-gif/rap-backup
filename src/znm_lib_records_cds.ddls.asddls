@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for library'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true

define view entity znm_lib_records_cds as select from znm_lib_records
association to parent znm_student1_cds as _student
    on $projection.StudentId = _student.StudentId
{
    key lib_mem_id as LibMemId,
    key book_id as BookId,
    book_title as BookTitle,
    
    borrow_date as BorrowDate,
    
    due_date as DueDate,
    
    return_date as ReturnDate,
    
    
    
     @Semantics.amount.currencyCode: 'CukyField'
    fine_amount as FineAmount,
    cuky_field as CukyField,
    --@ObjectModel.foreignKey.association: '_student'
    student_id as StudentId,
    _student
}

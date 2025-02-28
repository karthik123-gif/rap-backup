@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Attachment Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZATTACHMENT_FU_i as select from zattachment_fu
   association to parent zstudent_fu_i as _Student
    on $projection.Id = _Student.Id 
{
    key attach_id as AttachId,
    id as Id,

    @EndUserText.label: 'Comments'
    @UI.lineItem: [{position: 10, label: 'Comments'}]
    comments as Comments,

    @EndUserText.label: 'Attachments' 
    @UI.lineItem: [{position: 20, label: 'Attachment'}]
    @Semantics.largeObject:{
        mimeType: 'Mimetype',
        fileName: 'Filename',
        contentDispositionPreference: #INLINE
    }
    attachment as Attachment,

    @EndUserText.label: 'File Type'
    @UI.lineItem: [{position: 30, label: 'File Type'}]
    mimetype as Mimetype,

    @EndUserText.label: 'File Name'
    @UI.lineItem: [{position: 40, label: 'File Name'}]
    filename as Filename,

    _Student.Lastchangedat as LastChangedat,
    _Student 
}

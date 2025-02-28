@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZATTACHMENT_FU_p as projection on ZATTACHMENT_FU_i
{

      @UI.facet: [{
             id: 'StudentData',
             purpose: #STANDARD,
             label: 'Attachment Information',
             type: #IDENTIFICATION_REFERENCE,
             position: 10
         }]

      @UI: {
            lineItem: [{ position: 10 , label: 'AttachId' }],
            identification: [{ position: 10 , label: 'AttachId'}]
        }

  key AttachId,
      @UI: {
        lineItem: [{ position: 20 , label: 'Id'}],
        identification: [{ position: 20 , label: 'Id' }]
      }
      Id,
      @UI: {
        lineItem: [{ position: 30 , label: 'Comments'}],
        identification: [{ position: 30 , label: 'Comments'}]
      }
      Comments,
      @UI: {
        lineItem: [{ position: 40 , label: 'Attachment'}],
        identification: [{ position: 40 , label: 'Attachment'}]
      }
      Attachment,
       @UI: {
        lineItem: [{ position: 50 , label: 'Mimetype'}],
        identification: [{ position: 50 , label: 'Mimetype'}]
      }
      Mimetype,
      @UI: {
        lineItem: [{ position: 50 , label: 'Filename'}],
        identification: [{ position: 50 , label: 'Filename'}]
      }
      Filename,
      LastChangedat,
      /* Associations */
      _Student : redirected to parent ZSTUDENT_FU_p
}

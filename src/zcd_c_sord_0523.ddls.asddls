@EndUserText.label: 'Consuption Sales Order Header'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity  ZCD_C_SORD_0523 provider contract transactional_query
as projection on ZCD_I_SORD_0523
{
    key Idsales as Idsales,
    Email as Email,
    Firstname as Firstname,
    Lastname as Lastname,
    Country as Country,
    Createon as Createon,
    Deliverydate as Deliverydate ,
    Orderstatus as  Orderstatus,
    Imagenurl as Imagenurl,
    /* Associations */
    _item :  redirected to composition child ZCD_C_ITSORD_0523 
}

@EndUserText.label: 'Consuption Sales Order Items'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZCD_C_ITSORD_0523  
as projection on ZCD_I_ITSORD_0523
{
    key Idsales as Idsales,
    key Iditsord as Iditsord,
    Name as Name,
    Description as Description,
    Releasedate as Releasedate ,
    Discontinueddate as  Discontinueddate ,
    Price as  Price,
    Height as Height,
    Width as Width,
    Depth as Depth ,
    Quantity as Quantity,
    Unitofmeasure as Unitofmeasure,
    /* Associations */
    _header : redirected to parent ZCD_C_SORD_0523
}

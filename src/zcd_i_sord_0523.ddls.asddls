@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order - Interfaz'
define root view entity ZCD_I_SORD_0523 as select from ztb_sord_0523 as header
composition [0..*] of ZCD_I_ITSORD_0523 as _item
{
    
key idsales as Idsales,
email as Email,
firstname as Firstname,
lastname as Lastname,
country as Country,
createon as Createon,
deliverydate as Deliverydate,
orderstatus as Orderstatus,
imagenurl as Imagenurl,
_item 
}

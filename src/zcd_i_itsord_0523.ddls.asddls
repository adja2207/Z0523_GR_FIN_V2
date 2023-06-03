@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Order - Items'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCD_I_ITSORD_0523 as select from ztb_itsord_0523 as item 
association to parent  ZCD_I_SORD_0523 as _header on $projection.Idsales = _header.Idsales
{
    key idsales as Idsales,
    key iditsord as Iditsord,
    name as Name,
    description as Description,
    releasedate as Releasedate,
    discontinueddate as Discontinueddate,
    price as Price,
    @Semantics.quantity.unitOfMeasure: 'unitofmeasure'    
    height as Height,
    @Semantics.quantity.unitOfMeasure: 'unitofmeasure'
    width as Width,
    depth as Depth,
    quantity as Quantity,
    unitofmeasure as Unitofmeasure, 
    _header
}

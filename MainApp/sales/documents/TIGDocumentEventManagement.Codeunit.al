namespace Tigunia.Sales.Documents;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Tigunia.Sales;

codeunit 50101 "TIG Document Event Management"
{

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to Address', false, false)]
    local procedure Customer_OnAfterValidateEventAddress(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsSalesHeaderShipToAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateSalesHeaderSelltoAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to Address 2', false, false)]
    local procedure Customer_OnAfterValidateEventAddress2(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsSalesHeaderShipToAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateSalesHeaderSelltoAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to City', false, false)]
    local procedure Customer_OnAfterValidateEventCity(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsSalesHeaderShipToAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateSalesHeaderSelltoAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to Country/Region Code', false, false)]
    local procedure Customer_OnAfterValidateEventCountryRegionCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsSalesHeaderShipToAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateSalesHeaderSelltoAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to County', false, false)]
    local procedure Customer_OnAfterValidateEventCounty(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsSalesHeaderShipToAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateSalesHeaderSelltoAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Ship-to Post Code', false, false)]
    local procedure Customer_OnAfterValidateEventPostCode(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsSalesHeaderShipToAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateSalesHeaderSelltoAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure ReleaseSalesDocument_OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; SkipCheckReleaseRestrictions: Boolean)
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if SkipCheckReleaseRestrictions then
            exit;

        UntitledManagement.SalesRelease(SalesHeader);
        UntitledManagement.CheckSalesReleaseRestrictions(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCopyShipToCustomerAddressFieldsFromCustOnAfterAssignAddressFromSellToCustomer', '', false, false)]
    local procedure OnCopyShipToCustomerAddressFieldsFromCustOnAfterAssignAddressFromSellToCustomer(var SalesHeader: Record "Sales Header"; SellToCustomer: Record Customer)
    begin
        SalesHeader.Validate("TIG Address Validated", SellToCustomer."TIG Address Validated");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCopySellToCustomerAddressFieldsFromCustomerOnAfterAssignSellToCustomerAddress', '', false, false)]
    local procedure OnCopySellToCustomerAddressFieldsFromCustomerOnAfterAssignSellToCustomerAddress(var SalesHeader: Record "Sales Header"; Customer: Record Customer)
    begin
        //SalesHeader.Validate("TIG Address Validated", Customer."TIG Address Validated");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCheckSalesReleaseRestrictions', '', false, false)]
    local procedure SalesHeader_OnCheckSalesReleaseRestrictions(sender: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        UntitledManagement.CheckSalesReleaseRestrictions(sender);
    end;
}

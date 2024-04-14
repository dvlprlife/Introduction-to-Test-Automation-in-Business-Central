namespace Tigunia.Sales.Customer;

using Microsoft.Sales.Customer;
using Tigunia.Sales;

codeunit 50102 "TIG Customer Event Management"
{
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Address', false, false)]
    local procedure Customer_OnAfterValidateEventAddress(var Rec: Record Customer; var xRec: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsCustomerAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateCustomerAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Address 2', false, false)]
    local procedure Customer_OnAfterValidateEventAddress2(var Rec: Record Customer; var xRec: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsCustomerAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateCustomerAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'City', false, false)]
    local procedure Customer_OnAfterValidateEventCity(var Rec: Record Customer; var xRec: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsCustomerAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateCustomerAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Country/Region Code', false, false)]
    local procedure Customer_OnAfterValidateEventCountryRegionCode(var Rec: Record Customer; var xRec: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsCustomerAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateCustomerAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'County', false, false)]
    local procedure Customer_OnAfterValidateEventCounty(var Rec: Record Customer; var xRec: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsCustomerAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateCustomerAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Post Code', false, false)]
    local procedure Customer_OnAfterValidateEventPostCode(var Rec: Record Customer; var xRec: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        if UntitledManagement.IsCustomerAddressChanged(Rec, xRec) then
            UntitledManagement.InValidateCustomerAddress(Rec);
    end;
}
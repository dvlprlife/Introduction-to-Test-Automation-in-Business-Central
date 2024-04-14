namespace Tigunia.Sales;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;

codeunit 50100 "TIG Sales Management"
{
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesReceivablesSetupRead: Boolean;
        ConfirmMsg: Label 'Are you sure that you want to do this?';
        YesMsg: Label 'Confirmed Yes';
        NoMsg: Label 'Confirmed No';

    procedure CheckSalesReleaseRestrictions(var SalesHeader: Record "Sales Header")
    begin
        ReadSetup();

        if SalesReceivablesSetup."TIG Req Validate on Release" and SalesReceivablesSetup."TIG Enabled" then
            SalesHeader.TestField("TIG Address Validated", true);
    end;

    procedure GetConfirmMsg(): Text
    begin
        exit(ConfirmMsg);
    end;

    procedure GetYesMsg(): Text
    begin
        exit(YesMsg);
    end;

    procedure GetNoMsg(): Text
    begin
        exit(NoMsg);
    end;

    procedure AskConfirmMessage()
    begin
        if Confirm(ConfirmMsg, false) then
            Message(YesMsg)
        else
            Message(NoMsg);
    end;

    procedure InValidateCustomerAddress(var Customer: Record Customer)
    begin
        ReadSetup();

        if SalesReceivablesSetup."TIG Enabled" then
            Customer."TIG Address Validated" := false;
    end;

    procedure InValidateSalesHeaderSelltoAddress(var SalesHeader: Record "Sales Header")
    begin
        ReadSetup();

        if SalesReceivablesSetup."TIG Enabled" then
            SalesHeader."TIG Address Validated" := false;
    end;

    procedure IsCustomerAddressChanged(var Customer: Record Customer; xCustomer: Record Customer): Boolean
    var
        IsChanged: Boolean;
        IsHandled: Boolean;
    begin
        OnBeforeIsCustomerAddressChanged(Customer, xCustomer, IsChanged, IsHandled);
        if IsHandled then
            exit(IsChanged);

        if (Customer.Address <> xCustomer.Address) then
            exit(true);
        if (Customer."Address 2" <> xCustomer."Address 2") then
            exit(true);
        if (Customer.City <> xCustomer.City) then
            exit(true);
        if (Customer."Post Code" <> xCustomer."Post Code") then
            exit(true);
        if Customer."Country/Region Code" <> xCustomer."Country/Region Code" then
            exit(true);
        if Customer."County" <> xCustomer."County" then
            exit(true);

        exit(IsChanged);
    end;

    procedure IsSalesHeaderShipToAddressChanged(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"): Boolean
    var
        IsChanged: Boolean;
        IsHandled: Boolean;
    begin
        OnBeforeIsSalesHeaderShipToAddressChanged(SalesHeader, xSalesHeader, IsChanged, IsHandled);
        if IsHandled then
            exit(IsChanged);

        if (SalesHeader."Ship-to Address" <> xSalesHeader."Ship-to Address") then
            exit(true);
        if (SalesHeader."Ship-to Address 2" <> xSalesHeader."Ship-to Address 2") then
            exit(true);
        if (SalesHeader."Ship-to City" <> xSalesHeader."Ship-to City") then
            exit(true);
        if (SalesHeader."Ship-to Post Code" <> xSalesHeader."Ship-to Post Code") then
            exit(true);
        if SalesHeader."Ship-to Country/Region Code" <> xSalesHeader."Ship-to Country/Region Code" then
            exit(true);
        if SalesHeader."Ship-to County" <> xSalesHeader."Ship-to County" then
            exit(true);
        exit(IsChanged);
    end;

    procedure SalesRelease(var SalesHeader: Record "Sales Header")
    begin
        ReadSetup();

        if SalesReceivablesSetup."TIG Validate on Release" and not SalesHeader."TIG Address Validated" and SalesReceivablesSetup."TIG Enabled" then
            SetSalesHeaderValidated(SalesHeader, true);
    end;

    procedure SetCustomerValidated(var Customer: Record Customer; Valid: Boolean)
    var
        IsHandled: Boolean;

    begin
        OnBeforeSetCustomerValidated(Customer, Valid, IsHandled);
        if IsHandled then
            exit;

        Customer."TIG Address Validated" := Valid;
        Customer.Modify();
    end;

    procedure SetSalesHeaderValidated(var SalesHeader: Record "Sales Header"; Valid: Boolean)
    var
        IsHandled: Boolean;

    begin
        OnBeforeSetSalesHeaderValidated(SalesHeader, Valid, IsHandled);
        if IsHandled then
            exit;

        SalesHeader."TIG Address Validated" := Valid;
        SalesHeader.Modify();
    end;

    local procedure ReadSetup()
    begin
        if SalesReceivablesSetupRead then
            exit;

        SalesReceivablesSetup.Get();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeIsCustomerAddressChanged(var Customer: Record Customer; xCustomer: Record Customer; var Changed: Boolean; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeIsSalesHeaderShipToAddressChanged(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var Changed: Boolean; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetCustomerValidated(var Customer: Record Customer; var Valid: Boolean; var Handled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetSalesHeaderValidated(var SalesHeader: Record "Sales Header"; var Valid: Boolean; var Handled: Boolean)
    begin
    end;
}

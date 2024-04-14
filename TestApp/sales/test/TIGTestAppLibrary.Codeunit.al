namespace Tigunia.Sales.TestApp;

using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using Microsoft.Sales.Setup;
using Tigunia.Sales;

codeunit 80001 "TIG TestApp Library"
{

    procedure AskConfirmMessage()
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        UntitledManagement.AskConfirmMessage();
    end;

    procedure EnableValidation(Enabled: Boolean; ReqValidateonRelease: Boolean; ValidateonRelease: Boolean)
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
    begin

        if not SalesReceivablesSetup.FindFirst() then
            SalesReceivablesSetup.Init();

        SalesReceivablesSetup."TIG Enabled" := Enabled;
        SalesReceivablesSetup."TIG Req Validate on Release" := ReqValidateonRelease;
        SalesReceivablesSetup."TIG Validate on Release" := ValidateonRelease;
        if not SalesReceivablesSetup.Insert() then
            SalesReceivablesSetup.Modify();
    end;

    procedure ReleaseSalesDocumentCheckSkip(var SalesHeader: Record "Sales Header"; SkipCheckReleaseRestrictions: Boolean; Commit: Boolean): Boolean
    var
        ReleaseSalesDocument: Codeunit "Release Sales Document";
    begin
        if SkipCheckReleaseRestrictions then
            ReleaseSalesDocument.SetSkipCheckReleaseRestrictions();

        if Commit then
            Commit();

        exit(ReleaseSalesDocument.Run(SalesHeader));
    end;

    procedure ValidateCustomer(var Customer: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        UntitledManagement.SetCustomerValidated(Customer, true);
    end;

    procedure ValidateSalesHeader(var SalesHeader: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Sales Management";
    begin
        UntitledManagement.SetSalesHeaderValidated(SalesHeader, true);
    end;
}

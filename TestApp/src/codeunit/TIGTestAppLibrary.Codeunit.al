
codeunit 80001 "TIG TestApp Library"
{
    procedure ValidateCustomer(var Customer: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Untitled Management";
    begin
        UntitledManagement.ValidateCustomer(Customer, true);
    end;

    procedure ValidateSalesHeader(var SalesHeader: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Untitled Management";
    begin
        UntitledManagement.ValidateSalesHeader(SalesHeader, true);
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
        if not SalesReceivablesSetup.insert() then
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

    procedure ConfirmHandler()
    var
        UntitledManagement: Codeunit "TIG Untitled Management";
    begin
        UntitledManagement.ConfirmMessage();
    end;
}

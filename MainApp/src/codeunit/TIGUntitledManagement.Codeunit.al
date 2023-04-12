codeunit 50100 "TIG Untitled Management"
{
    var
        SalesReceivablesSetup: Record "Sales & Receivables Setup";
        SalesReceivablesSetupRead: Boolean;

    procedure CheckSalesReleaseRestrictions(var SalesHeader: Record "Sales Header")
    begin
        ReadSetup();

        if SalesReceivablesSetup."TIG Req Validate on Release" and SalesReceivablesSetup."TIG Enabled" then
            SalesHeader.TestField("TIG Validated", true);
    end;

    procedure CustomerModifyAddress(var Customer: Record Customer)
    begin
        ReadSetup();

        if SalesReceivablesSetup."TIG Enabled" then
            Customer."TIG Validated" := false;
    end;

    procedure SalesHeaderSelltoAddress(var SalesHeader: Record "Sales Header")
    begin
        ReadSetup();

        if SalesReceivablesSetup."TIG Enabled" then
            SalesHeader."TIG Validated" := false;
    end;

    procedure SalesRelease(var SalesHeader: Record "Sales Header")
    begin
        ReadSetup();

        if SalesReceivablesSetup."TIG Validate on Release" and not SalesHeader."TIG Validated" and SalesReceivablesSetup."TIG Enabled" then
            ValidateSalesHeader(SalesHeader, true);
    end;

    procedure ValidateCustomer(var Customer: Record Customer; Valid: Boolean)
    begin
        Customer."TIG Validated" := Valid;
        Customer.Modify();
    end;

    procedure ValidateSalesHeader(var SalesHeader: Record "Sales Header"; Valid: Boolean)
    begin
        SalesHeader."TIG Validated" := Valid;
        SalesHeader.Modify();
    end;

    procedure ConfirmMessage()
    var
        ConfirmMsg: Label 'Are you sure that you want to do this?';
        DoneMsg: Label 'This is done.';
        NotDoneMsg: Label 'This is not done.';

    begin
        if Confirm(ConfirmMsg, false) then
            Message(DoneMsg)
        else
            Message(NotDoneMsg);
    end;

    local procedure ReadSetup()
    begin
        if SalesReceivablesSetupRead then
            exit;

        SalesReceivablesSetup.Get();
    end;
}

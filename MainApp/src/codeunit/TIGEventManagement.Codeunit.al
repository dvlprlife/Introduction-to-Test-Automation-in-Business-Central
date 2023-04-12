codeunit 50101 "TIG Event Management"
{

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Address', false, false)]
    local procedure Customer_OnAfterValidateEventAddress(var Rec: Record Customer; var xRec: Record Customer)
    var
        UntitledManagement: Codeunit "TIG Untitled Management";
    begin
        UntitledManagement.CustomerModifyAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnBeforeReleaseSalesDoc', '', false, false)]
    local procedure ReleaseSalesDocument_OnBeforeReleaseSalesDoc(var SalesHeader: Record "Sales Header"; SkipCheckReleaseRestrictions: Boolean)
    var
        UntitledManagement: Codeunit "TIG Untitled Management";
    begin
        if SkipCheckReleaseRestrictions then
            exit;

        UntitledManagement.CheckSalesReleaseRestrictions(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterCheckSellToCust', '', false, false)]
    local procedure SalesHeader_OnAfterCheckSellToCust(var SalesHeader: Record "Sales Header"; Customer: Record Customer)
    begin
        SalesHeader.Validate("TIG Validated", Customer."TIG Validated");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Address', false, false)]
    local procedure SalesHeader_OnAfterValidateEventAddress(var Rec: Record "Sales Header"; var xRec: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Untitled Management";
    begin
        UntitledManagement.SalesHeaderSelltoAddress(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnCheckSalesReleaseRestrictions', '', false, false)]
    local procedure SalesHeader_OnCheckSalesReleaseRestrictions(sender: Record "Sales Header")
    var
        UntitledManagement: Codeunit "TIG Untitled Management";
    begin
        UntitledManagement.CheckSalesReleaseRestrictions(sender);
    end;
}

pageextension 50102 "TIG Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field(TIGValidated; Rec."TIG Validated")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Indicates the validation status of the customer.';
            }
        }
    }
}

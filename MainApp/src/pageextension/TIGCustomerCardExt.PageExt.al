pageextension 50101 "TIG Customer Card Ext" extends "Customer Card"
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

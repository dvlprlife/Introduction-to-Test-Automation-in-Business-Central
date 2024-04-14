namespace Tigunia.Sales.Setup;

using Microsoft.Sales.Setup;

pageextension 50103 "TIG SR Setup Ext" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(content)
        {
            group(TIGValidate)
            {
                Caption = 'Address Validate';
                field(TIGEnabled; Rec."TIG Enabled")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the validate function is enabled.';
                }
                field(TIGReqValidateonRelease; Rec."TIG Req Validate on Release")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the validate is required when and sales document is released.';
                }
                field(TIGValidateonRelease; Rec."TIG Validate on Release")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies if the sales document is validated on released.';
                }
            }
        }
    }
}

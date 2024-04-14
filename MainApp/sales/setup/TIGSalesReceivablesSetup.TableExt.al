namespace Tigunia.Sales.Setup;

using Microsoft.Sales.Setup;

tableextension 50102 "TIG Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "TIG Req Validate on Release"; Boolean)
        {
            Caption = 'Require Validate on Release';
            DataClassification = CustomerContent;
        }
        field(50101; "TIG Validate on Release"; Boolean)
        {
            Caption = 'Validate on Release';
            DataClassification = CustomerContent;
        }
        field(50102; "TIG Enabled"; Boolean)
        {
            Caption = 'Enabled';
            DataClassification = CustomerContent;
        }
    }
}

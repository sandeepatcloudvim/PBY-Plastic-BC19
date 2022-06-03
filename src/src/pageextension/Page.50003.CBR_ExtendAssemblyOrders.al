pageextension 50003 CBR_ExtendAssemblyOrders extends "Assembly Orders"
{
    layout
    {
        addafter(Description)
        {
            field("Sales Order No."; Rec."Sales Order No.")
            {
                ApplicationArea = All;
                Caption = 'Sales Order No.';

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    trigger OnOpenPage()
    var
    begin
        Rec.CalcFields("Sales Order No.");
    end;

    trigger OnAfterGetRecord()
    var
    begin
        Rec.CalcFields("Sales Order No.");
    end;
}
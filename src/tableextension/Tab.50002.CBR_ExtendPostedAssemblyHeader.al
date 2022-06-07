tableextension 50002 Extend_PostedAssemblyHeader extends "Posted Assembly Header"
{
    fields
    {
        field(50000; "Sales Order No."; Code[20])
        {

            Caption = 'Sales Order No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Posted Assemble-to-Order Link"."Order No." WHERE("Assembly Document No." = FIELD("No.")));
        }
    }

    var
        myInt: Integer;
}
tableextension 50001 Extend_AssemblyHeader extends "Assembly Header"
{
    fields
    {
        field(50000; "Sales Order No."; Code[20])
        {

            Caption = 'Sales Order No.';
            FieldClass = FlowField;
            CalcFormula = Lookup("Assemble-to-Order Link"."Document No." WHERE("Assembly Document No." = FIELD("No.")));
        }
    }

    var
        myInt: Integer;
}
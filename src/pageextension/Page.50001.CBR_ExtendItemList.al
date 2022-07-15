pageextension 50001 CBR_ExtendItemList extends "Item List"
{
    layout
    {
        addafter(InventoryField)
        {

            field("Qty. on Asm. Component"; Rec."Qty. on Asm. Component")
            {
                ApplicationArea = All;
            }
            field("Qty. on Purch. Order"; Rec."Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Order"; Rec."Qty. on Sales Order")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    trigger OnAfterGetRecord()
    var
    begin
        Rec.UpdateDescriptionValue(Rec."No.");
    end;
}
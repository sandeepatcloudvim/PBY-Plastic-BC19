pageextension 50000 CBR_ExtendItemCard extends "Item Card"
{
    layout
    {
        // Add changes to page layout here
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
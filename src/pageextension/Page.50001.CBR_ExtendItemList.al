pageextension 50001 CBR_ExtendItemList extends "Item List"
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
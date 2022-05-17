pageextension 50007 CBR_ExtendPurchaseOrderList extends "Purchase Order List"
{
    layout
    {
        addafter(Amount)
        {
            field("Promised Receipt Date"; Rec."Promised Receipt Date")
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
}
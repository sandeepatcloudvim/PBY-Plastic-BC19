pageextension 50002 ExtendSalesOrderCBR extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        modify("Work Order")
        {
            Caption = 'Packing Slip';
            ApplicationArea = All;
            Promoted = true;
            PromotedCategory = Category11;
            Visible = true;
        }
    }

    var
        myInt: Integer;
}
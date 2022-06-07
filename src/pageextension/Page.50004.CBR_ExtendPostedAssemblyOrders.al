pageextension 50004 CBR_ExtendPostedAssemblyOrders extends "Posted Assembly Orders"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Print)
        {
            action("Assembly Variance")
            {
                ApplicationArea = all;
                Caption = 'Assembly Variance';
                RunObject = page "Assembly Variance";
                Promoted = true;
                PromotedIsBig = true;
                Image = AssemblyOrder;
                PromotedCategory = Process;
            }
        }
    }

    var
        myInt: Integer;
}
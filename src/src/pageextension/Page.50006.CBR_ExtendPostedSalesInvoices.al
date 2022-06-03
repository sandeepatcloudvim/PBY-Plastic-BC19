pageextension 50006 CBR_ExtPostedSalesInvoices extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter(Invoice)
        {
            action("Sales Invoice Detail Page")
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice Detail Page';
                Image = Invoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "CBR Sales Invoice Detail Page";
            }

            action("Sales by Customer Part No.")
            {
                ApplicationArea = All;
                Caption = 'Sales by Customer Part No.';
                Image = Invoice;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = report "Sales by Customer Part No.";
            }
        }
    }

    var
        myInt: Integer;
}
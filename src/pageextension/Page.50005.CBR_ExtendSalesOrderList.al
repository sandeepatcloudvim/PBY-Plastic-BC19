pageextension 50041 CBRExtSalesOrderList extends "Sales Order List"
{
    layout
    {

    }

    actions
    {
        addafter("S&hipments")
        {
            action("Order Detail")
            {
                ApplicationArea = Basic, Suite;
                CaptionML = ENU = 'Open Sales Order Detail Page',
                                ESM = 'Facturas',
                                FRC = 'Factures',
                                ENC = 'Invoices';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "CBROpen SalesOrder Detail Page";
                ToolTipML = ENU = 'View the history of Sales Orders line that have been posted for the document.',
                                ESM = 'Permite ver el historial de facturas de venta registradas que se han registrado para el documento.',
                                FRC = 'Affichez l''historique des factures de vente qui ont été reportées pour le document.',
                                ENC = 'View the history of Sales Orders line that have been posted for the document.';
            }
        }
        addlast(reporting)
        {
            action("Master Sales")
            {
                ApplicationArea = All;
                Caption = 'Master Sales';
                Image = "Report";
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                RunObject = Report "Customer Wise Sales Report";
            }
        }

    }

    var
        myInt: Integer;
}
page 50001 "CBROpen SalesOrder Detail Page"
{
    // version CBR_SS

    Caption = 'Open Sales Order Detail Page';
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = WHERE("Outstanding Quantity" = FILTER(<> 0), "Line Amount" = filter(> 0),
                            "Document Type" = FILTER(Order | "Blanket Order"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Sales Order',
                                ESM = 'Nº documento',
                                FRC = 'N° de document',
                                ENC = 'Document No.';
                    TableRelation = "Sales Header"."No." WHERE("No." = FIELD("Document No."));
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Line No."; LineNo)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order Line';
                    Editable = false;
                }
                field("Order Date"; RecSalesHead."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Order Date';
                }
                field("Customer ID"; RecSalesHead."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Customer No',
                                ESM = 'Venta a-Nº cliente',
                                FRC = 'N° client (débiteur)',
                                ENC = 'Sell-to Customer No.';
                }
                field("Customer Name"; RecCust.Name)
                {
                    ApplicationArea = All;
                }
                field(Country; RecSalesHead."Ship-to City")
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }
                field(State; RecSalesHead."Sell-to County")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Industry',
                                ESM = 'Cód. dim. acceso dir. 1',
                                FRC = 'Code raccourci de dimension 1',
                                ENC = 'Shortcut Dimension 1 Code';
                }
                field(Item; RecItem."No.")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Item No',
                                ESM = 'Nº',
                                FRC = 'N°',
                                ENC = 'No.';
                }
                field(Variant; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    CaptionML = ENU = 'Revision',
                                ESM = 'Cód. variante',
                                FRC = 'Code variante',
                                ENC = 'Variant Code';
                }
                field("Item Description"; RecItem.Description)
                {
                    ApplicationArea = All;
                }
                field("Item Variant Descrition"; RecVariant.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Revision Desc';
                }
                field("Customer PO"; RecSalesHead."External Document No.")
                {
                    ApplicationArea = All;
                }
                field(Unit; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field(Qty; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Qty';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Total Value"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }

                field("Sales Rep"; RecSalesHead."Salesperson Code")
                {
                    ApplicationArea = All;
                }

                field("Shipped Qty"; Rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Remaining Qty to be Shipped"; Rec."Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Remaining Value"; RemValue)
                {
                    ApplicationArea = All;
                }
                field("Requested Shipping Date"; Rec."Requested Delivery Date")
                {
                    ApplicationArea = All;
                }
                field("Promised Ship Date"; RecSalesHead."Promised Delivery Date")
                {
                    ApplicationArea = All;
                    Caption = 'Promised Date';
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    CaptionML = ENU = 'Plnd Delivery Date',
                                ESM = 'Fecha entrega planificada',
                                FRC = 'Date livraison planifiée',
                                ENC = 'Planned Delivery Date';
                }
                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    CaptionML = ENU = 'Pland Ship Date',
                                ESM = 'Fecha envío planificada',
                                FRC = 'Date de livraison planifiée',
                                ENC = 'Planned Shipment Date';
                }
                field(TotalCost; TotalCost)
                {
                    ApplicationArea = All;
                    Caption = 'Total Cost';
                }
                field(TotalProfit; TotalProfit)
                {
                    ApplicationArea = All;
                    Caption = 'Total Profit';
                }
                field(Margin; Margin)
                {
                    ApplicationArea = All;
                    Caption = 'Gross Margin';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {

            action("CBR Open Order")
            {
                Caption = 'Open Order';
                Image = "Order";
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction();
                begin
                    OpenSalesOrder
                end;
            }
            action(CBROpenSalesOrder)
            {
                Caption = 'Open Sales Order';
                ShortCutKey = 'Return';
                Visible = false;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    //CBR_SS>>
                    CLEAR(SalesOrderPage);
                    RecSalesHead.SETRANGE("No.", Rec."Document No.");
                    SalesOrderPage.SETTABLEVIEW(RecSalesHead);
                    SalesOrderPage.RUNMODAL;
                    //CBR_SS<<
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if RecSalesHead.GET(Rec."Document Type", Rec."Document No.") then;
        if RecItem.GET(Rec."No.") then;
        LineNo := Rec."Line No." div 1000;
        //RemQtytoship := Quantity-"Quantity Shipped";
        RemValue := Rec."Qty. to Ship" * Rec."Unit Price";
        if RecVariant.GET(Rec."No.", Rec."Variant Code") then;
        if RecCust.GET(Rec."Sell-to Customer No.") then;

        if Rec.Quantity > 0 then
            TotalCost := (Rec.Quantity * Rec."Unit Cost");
        TotalProfit := (Rec."Line Amount" - TotalCost);
        if TotalCost > 0 then
            Margin := (TotalProfit / TotalCost) * 100;
    end;

    trigger OnOpenPage();
    begin
        ExportToExcelForWindows;
    end;

    var
        RecCust: Record Customer;
        RecSalesHead: Record "Sales Header";
        RecItem: Record Item;
        LineNo: Integer;
        RecVariant: Record "Item Variant";
        RemQtytoship: Decimal;
        RemValue: Decimal;
        SalesOrderPage: Page "Sales Order";
        // WshShell: Automation "'{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}' 1.0:'{72C24DD5-D70A-438B-8A42-98424B88AFB8}':''{F935DC20-1CF0-11D0-ADB9-00C04FD58A0B}' 1.0'.WshShell";


        RecActiveSession: Record "Active Session";
        ForWindow: Boolean;

        TotalCost: Decimal;
        TotalProfit: Decimal;
        Margin: Decimal;

    // local procedure UpdateStatus();
    // var
    //     RecSalesLine: Record "Sales Line";
    //     SalesHeadRec: Record "Sales Header";
    // begin
    //     //CBR_SS_15032018..>>
    //     if CONFIRM('Are you sure you want to updated existing Sales Order Line status as well ?', false) then begin
    //         SalesHeadRec.SETRANGE("Document Type", Rec."Document Type"::Order);
    //         if SalesHeadRec.FINDSET then
    //             repeat
    //                 RecSalesLine.RESET;
    //                 RecSalesLine.SETRANGE("Document Type", SalesHeadRec."Document Type");
    //                 RecSalesLine.SETRANGE("Document No.", SalesHeadRec."No.");
    //                 if RecSalesLine.FINDSET then
    //                     RecSalesLine.MODIFYALL(CBR_Status, SalesHeadRec.Status);
    //             until SalesHeadRec.NEXT = 0;
    //         MESSAGE('Process completed sucessfully');
    //     end;

    //     //CBR_SS_15032018..<<
    // end;

    local procedure ExportToExcelForWindows();
    begin
        //CBR_SS_13042018..>>
        RecActiveSession.RESET;
        RecActiveSession.SETRANGE("User ID", USERID);
        RecActiveSession.SETRANGE("Session ID", SESSIONID);
        if RecActiveSession.FINDFIRST then begin
            if RecActiveSession."Client Type" = RecActiveSession."Client Type"::"Windows Client" then
                ForWindow := true
            else
                ForWindow := false;
        end;
        //CBR_SS_13042018..<<
    end;

    local procedure OpenSalesOrder();
    begin
        CLEAR(SalesOrderPage);
        RecSalesHead.SETRANGE("No.", Rec."Document No.");
        SalesOrderPage.SETTABLEVIEW(RecSalesHead);
        SalesOrderPage.RUNMODAL;
    end;
}

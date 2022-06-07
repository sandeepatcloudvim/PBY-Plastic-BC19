page 50001 "CBROpen SalesOrder Detail Page"
{
    // version CBR_SS

    Caption = 'Open Sales Order Detail Page';
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sales Line";
    SourceTableView = ORDER(Descending) WHERE("Outstanding Quantity" = FILTER(<> 0), "Line Amount" = filter(> 0),
                            "Document Type" = FILTER(Order | "Blanket Order"));
    UsageCategory = Administration;
    ApplicationArea = All;
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
                //AGT_DS++
                // field("Line No."; LineNo)
                // {
                //     ApplicationArea = All;
                //     Caption = 'Sales Order Line';
                //     Editable = false;
                // }AGT_DS--
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
                //AGT_DS++
                // field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                // {
                //     ApplicationArea = All;
                //     CaptionML = ENU = 'Industry',
                //                 ESM = 'Cód. dim. acceso dir. 1',
                //                 FRC = 'Code raccourci de dimension 1',
                //                 ENC = 'Shortcut Dimension 1 Code';
                // }AGT_DS--
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
                field("Location Code"; Rec."Location Code")
                {
                    ToolTip = 'Specifies the inventory location from which the items sold should be picked and where the inventory decrease is registered.';
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
                field("Remaining Qty to be Shipped"; Rec.Quantity - REC."Quantity Shipped")//AGT_ds
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

                field("Planned Shipment Date"; Rec."Planned Shipment Date")
                {
                    ApplicationArea = All;
                    AccessByPermission = TableData "Sales Shipment Header" = R;
                    CaptionML = ENU = 'Pland Ship Date',
                                ESM = 'Fecha envío planificada',
                                FRC = 'Date de livraison planifiée',
                                ENC = 'Planned Shipment Date';
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ToolTip = 'Specifies the planned date that the shipment will be delivered at the customer''s address.';
                    ApplicationArea = All;
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


            action(Excel)
            {
                ApplicationArea = all;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Export To Excel';
                trigger OnAction()
                var

                begin
                    //Xmlport.Run(50000, true, false, Rec);
                    ExportSalesOrderDetail;
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
        RemValue := (Rec.Quantity - Rec."Quantity Shipped") * Rec."Unit Price";//AGT_DS
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
    //AGT_DS++
    local procedure ExportSalesOrderDetail()
    Var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        SL_L: Record "Sales Line";
        OpenSalesOrderDetailLbl: Label 'Open Sales Order Detail'; //Sheet Name
        ExcelFileName: Label 'Open_Sales_Order_Detail_%1_%2'; //Excel File Name

    Begin
        TempExcelBuffer.Reset();
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.AddColumn('Sales Order', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Document Type', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //TempExcelBuffer.AddColumn('Sales Order Line', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Order Date', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Customer No', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Customer Name', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('City', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('State', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        //TempExcelBuffer.AddColumn('Department Code', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Item No', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Revision', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Item Description', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Location Code', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Revision Desc', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Customer PO', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Unit of Measure', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Qty', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Unit Price Excl. Tax', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Line Amount Excl. Tax', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Sales Rep', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Quantity Shipped', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Qty. to Ship', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Remaining Value', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Requested Delivery Date', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Promised Date', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Pland Ship Date', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Planned Delivery Date', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Cost', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Total Profit', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);
        TempExcelBuffer.AddColumn('Gross Margin', false, '', True, false, false, '', TempExcelBuffer."Cell Type"::Text);

        SL_L.SetFilter("Outstanding Quantity", '<>%1', 0);
        SL_L.SetFilter("Line Amount", '>%1', 0);
        IF SL_L.FindSet() then
            repeat
                IF (SL_L."Document Type" = SL_L."Document Type"::"Blanket Order") Or (SL_L."Document Type" = SL_L."Document Type"::Order) then Begin
                    TotalCost := 0;
                    TotalProfit := 0;
                    RemValue := 0;
                    LineNo := 0;
                    TempExcelBuffer.NewRow();
                    If RecSalesHead.Get(SL_L."Document Type", SL_L."Document No.") then begin
                        TempExcelBuffer.AddColumn(SL_L."Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L."Document Type", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        //LineNo := SL_L."Line No." div 1000;
                        //TempExcelBuffer.AddColumn(LineNo, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(RecSalesHead."Order Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(RecSalesHead."Bill-to Customer No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        If RecCust.get(SL_L."Sell-to Customer No.") then
                            TempExcelBuffer.AddColumn(RecCust.Name, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                        else
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecSalesHead."Ship-to City", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecSalesHead."Sell-to County", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        //TempExcelBuffer.AddColumn(SL_L."Shortcut Dimension 1 Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L."No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L."Variant Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        If RecItem.get(SL_L."No.") then
                            TempExcelBuffer.AddColumn(RecItem.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                        else
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L."Location Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        if RecVariant.GET(Rec."No.", Rec."Variant Code") then
                            TempExcelBuffer.AddColumn(RecVariant.Description, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text)
                        else
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecSalesHead."External Document No.", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L."Unit of Measure", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L.Quantity, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L."Unit Price", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L."Line Amount", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(RecSalesHead."Salesperson Code", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L."Quantity Shipped", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        TempExcelBuffer.AddColumn(SL_L.Quantity - SL_L."Quantity Shipped", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Text);
                        RemValue := (SL_L.Quantity - SL_L."Quantity Shipped") * SL_L."Unit Price";//AGT_DS
                        TempExcelBuffer.AddColumn(RemValue, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(SL_L."Requested Delivery Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::date);
                        TempExcelBuffer.AddColumn(RecSalesHead."Promised Delivery Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TempExcelBuffer.AddColumn(SL_L."Planned Shipment Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::date);
                        TempExcelBuffer.AddColumn(SL_L."Planned Delivery Date", false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Date);
                        TotalCost := (SL_L.Quantity * SL_L."Unit Cost");
                        TotalProfit := (SL_L."Line Amount" - TotalCost);
                        if SL_L.Quantity > 0 then
                            TempExcelBuffer.AddColumn(TotalCost, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number)
                        Else
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        TempExcelBuffer.AddColumn(TotalProfit, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                        if TotalCost > 0 then
                            TempExcelBuffer.AddColumn((TotalProfit / TotalCost) * 100, false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number)
                        Else
                            TempExcelBuffer.AddColumn('', false, '', false, false, false, '', TempExcelBuffer."Cell Type"::Number);
                    end;
                End
            until SL_L.Next() = 0;
        TempExcelBuffer.CreateNewBook(OpenSalesOrderDetailLbl);
        TempExcelBuffer.WriteSheet(OpenSalesOrderDetailLbl, CompanyName, UserId);
        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(StrSubstNo(ExcelFileName, CurrentDateTime, UserId));
        TempExcelBuffer.OpenExcel();


    End;
    //AGT_DS--



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

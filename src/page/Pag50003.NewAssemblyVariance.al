page 50003 "NewAssembly Variance"
{
    PageType = List;
    Caption = 'New Assembly Variance';
    SourceTable = "Item Ledger Entry";
    SourceTableTemporary = true;
    SourceTableView = ORDER(descending)
                      WHERE("Entry Type" = FILTER("Assembly Consumption"));
    ApplicationArea = Basic, Suite;
    DataCaptionFields = "Item No.";
    Editable = false;
    PromotedActionCategories = 'New,Process,Report,Entry';
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Assembly No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'RAW Item No';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';
                }

                field("Finished Item No."; Rec.PAO_ItemNo)//ds
                {
                    ApplicationArea = All;
                    Caption = 'Finished Item No.';
                }
                field("Finished Item Desc"; Rec.PAO_Description)//ds
                {
                    ApplicationArea = All;
                    Caption = 'Finished Item Desc';
                }
                field("Unit of Measure"; Rec.PAO_UOM)//ds
                {
                    ApplicationArea = All;
                    Caption = 'Unit of Measure';
                }
                field("Sales Order No."; Rec.PAO_SalesOrderNo)//ds
                {
                    ApplicationArea = All;
                    Caption = 'Sales Order No.';
                }
                field("Customer No"; Rec.PAO_CustomerNo)//ds
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                }
                field("Customer Name"; Rec.PAO_CustomerName)//ds
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field(OriginalQty; rec.AssembleVari_OriginalQty)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Caption = 'BOM Qty';

                }
                field(RawQtyPlanned; rec.AssembleVari_RawQtyPlanned)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Caption = 'BOM RAW LBS';
                }
                field(RawCostPlanned; Rec.AssembleVari_RawCostPlanned)
                {
                    ApplicationArea = All;
                    Caption = 'BOM RAW $';
                }
                field("Qty Assembled"; Rec.PAO_Quantity)//ds
                {
                    ApplicationArea = All;
                    Caption = 'FINISHED QTY';
                }
                field(Quantity; Abs(Rec.Quantity))
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 5;
                    Caption = 'RAW LBS CONS';
                }
                field("Total Cost"; Rec.AssembleVari_CostAmountActual)
                {
                    ApplicationArea = All;
                    Caption = 'RAW $ CONS';
                }
                field("Qty Variance"; Abs(Rec.AssembleVari_RawQtyPlanned - Abs(Rec.Quantity)))
                {
                    ApplicationArea = All;
                    Caption = 'RAW LBS VARIANCE';
                }
                field("Cost Variance"; (Rec.AssembleVari_RawCostPlanned - Rec.AssembleVari_CostAmountActual))
                {
                    ApplicationArea = All;
                    Caption = 'RAW $ VARIANCE';
                }
                field(QtyVariancePer; rec.AssembleVari_QtyVariancePer)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 2;
                    Caption = 'RAW LBS % VARIANCE';
                }
                field(CostVariancePer; Rec.AssembleVari_CostVariancePer)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0 : 2;
                    Caption = 'COST VARIANCE %';
                }
                field(TotalRevenue; Rec.AssembleVari_TotalRevenue)
                {
                    ApplicationArea = All;
                    Caption = 'Revenue';
                }
                field(Profit; rec.AssembleVari_Profit)
                {
                    ApplicationArea = All;
                    Caption = 'Profit';
                }
                field(ProfitMargin; rec.AssembleVari_ProfitMargin)
                {
                    ApplicationArea = All;
                    Caption = 'Profit Margin %';
                }


            }
        }
    }

    actions
    {
    }
    var
        PostedAssemblyOrder: Record "Posted Assembly Header";
        recItem: Record Item;
        ValueEntry: Record "Value Entry";
        ValueEntry1: Record "Value Entry";
        BOMComponent: Record "BOM Component";
        Qty1: Decimal;
        recSalesHeader: Record "Sales Header";
        SalesHeaderArchive: Record "Sales Header Archive";
        recPostedSalesInvLine: Record "Sales Invoice Line";
        TotalCost: Decimal;
        XDocNo: Code[20];
        ILE_Rec: Record "Item Ledger Entry";
        QtyVariance: Decimal;


    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Document No.");
        CopyRecord;
    end;

    trigger OnAfterGetRecord()
    var
        ILE_L: Record "Item Ledger Entry";
    begin
    end;

    local procedure GetUnitCost(ItemNo: Code[20]): Decimal
    var
        Itemrec: Record Item;
    begin
        if Itemrec.Get(ItemNo) then
            exit(Itemrec."Unit Cost");
    end;

    local procedure CopyRecord()
    var
        XdocumentNo: Code[20];
        xItemNo: Code[20];
    begin
        Clear(XdocumentNo);
        Clear(xItemNo);
        ILE_Rec.RESET;
        ILE_Rec.SetCurrentKey("Document No.", "Item No.");
        ILE_Rec.SetRange("Entry Type", ILE_Rec."Entry Type"::"Assembly Consumption");
        IF ILE_Rec.FINDSET THEN
            REPEAT
                IF (ILE_Rec."Document No." <> XdocumentNo) OR (ILE_Rec."Item No." <> xItemNo) THEN BEGIN
                    XdocumentNo := ILE_Rec."Document No.";
                    xItemNo := ILE_Rec."Item No.";
                    Rec.INIT;
                    Rec.TRANSFERFIELDS(ILE_Rec);
                    Rec.INSERT;

                    ILE_Rec.CalcFields("Cost Amount (Actual)");
                    ValueEntry.Reset();
                    ValueEntry.SetCurrentKey("Item Ledger Entry No.");
                    ValueEntry.SetRange("Item Ledger Entry No.", ILE_Rec."Entry No.");
                    ValueEntry.SetFilter(Adjustment, '%1', false);
                    if ValueEntry.FindFirst() then
                        Rec.AssembleVari_CostAmountActual := Abs(ValueEntry."Cost Amount (Actual)");

                    Clear(TotalCost);
                    ValueEntry1.Reset();
                    ValueEntry1.SetCurrentKey("Document No.");
                    ValueEntry1.SetFilter("Item Ledger Entry Type", '%1', ValueEntry1."Item Ledger Entry Type"::"Assembly Consumption");
                    ValueEntry1.SetFilter(Adjustment, '%1', false);
                    ValueEntry1.SetRange("Document No.", ILE_Rec."Document No.");
                    ValueEntry1.CalcSums("Cost Amount (Actual)");
                    TotalCost := Abs(ValueEntry1."Cost Amount (Actual)");
                    PostedAssemblyOrder.Reset();
                    if PostedAssemblyOrder.Get(ILE_Rec."Document No.") then begin
                        PostedAssemblyOrder.CalcFields("Sales Order No.");
                        Rec.PAO_Description := PostedAssemblyOrder.Description;
                        Rec.PAO_ItemNo := PostedAssemblyOrder."Item No.";
                        Rec.PAO_Quantity := PostedAssemblyOrder.Quantity;
                        Rec.PAO_UOM := PostedAssemblyOrder."Unit of Measure Code";
                        Rec.PAO_SalesOrderNo := PostedAssemblyOrder."Sales Order No.";

                        SalesHeaderArchive.Reset();
                        SalesHeaderArchive.SetRange("Document Type", SalesHeaderArchive."Document Type"::Order);
                        SalesHeaderArchive.SetRange("No.", PostedAssemblyOrder."Sales Order No.");
                        if SalesHeaderArchive.FindFirst() then begin
                            Rec.PAO_CustomerNo := SalesHeaderArchive."Sell-to Customer No.";
                            Rec.PAO_CustomerName := SalesHeaderArchive."Sell-to Customer Name";
                        end;

                        if recSalesHeader.Get(recSalesHeader."Document Type"::Order, PostedAssemblyOrder."Sales Order No.") then;

                        if ILE_Rec."Document No." <> XDocNo then begin
                            recPostedSalesInvLine.Reset();
                            recPostedSalesInvLine.SetCurrentKey("Order No.", "No.");
                            recPostedSalesInvLine.SetRange("Order No.", PostedAssemblyOrder."Sales Order No.");
                            recPostedSalesInvLine.SetRange("No.", PostedAssemblyOrder."Item No.");
                            if recPostedSalesInvLine.FindFirst() then begin
                                if TotalCost > 0 then begin
                                    rec.AssembleVari_Profit := recPostedSalesInvLine."Line Amount" - TotalCost;
                                    if recPostedSalesInvLine."Line Amount" > 0 then
                                        rec.AssembleVari_ProfitMargin := (rec.AssembleVari_Profit / recPostedSalesInvLine."Line Amount") * 100;
                                    rec.AssembleVari_TotalRevenue := recPostedSalesInvLine."Line Amount";
                                end;
                            end;
                            XDocNo := Rec."Document No."
                        end;

                        if recItem.Get(PostedAssemblyOrder."Item No.") then begin
                            recItem.CalcFields("Assembly BOM");
                            if recItem."Assembly BOM" then begin
                                BOMComponent.Reset();
                                BOMComponent.SetCurrentKey("Parent Item No.", "No.");
                                BOMComponent.SetRange(Type, BOMComponent.Type::Item);
                                BOMComponent.SetRange("Parent Item No.", recItem."No.");
                                BOMComponent.SetRange("No.", ILE_Rec."Item No.");
                                if BOMComponent.FindFirst() then begin
                                    Rec.AssembleVari_OriginalQty := BOMComponent."Quantity per";
                                    Rec.AssembleVari_RawQtyPlanned := BOMComponent."Quantity per" * PostedAssemblyOrder.Quantity;
                                    Rec.AssembleVari_RawCostPlanned := (BOMComponent."Quantity per" * PostedAssemblyOrder.Quantity) * GetUnitCost(BOMComponent."No.");
                                    Rec.Modify();

                                    if (Abs(Rec.AssembleVari_RawQtyPlanned - Abs(ILE_Rec.Quantity)) = 0) then begin
                                        Rec.AssembleVari_QtyVariancePer := 0.00;
                                    end else begin
                                        if Rec.AssembleVari_RawQtyPlanned <> 0 then
                                            Rec.AssembleVari_QtyVariancePer := ((Abs(rec.AssembleVari_RawQtyPlanned - Abs(ILE_Rec.Quantity))) / rec.AssembleVari_RawQtyPlanned) * 100;
                                    end;

                                    if Rec.AssembleVari_RawCostPlanned <> 0 then
                                        rec.AssembleVari_CostVariancePer := (Rec.AssembleVari_CostAmountActual) / Rec.AssembleVari_RawCostPlanned;
                                end;
                            end;
                        end;
                    end;
                    Rec.Modify();
                END ELSE BEGIN
                    Rec.RESET;
                    Rec.SETRANGE("Document No.", ILE_Rec."Document No.");
                    Rec.SETRANGE("Item No.", ILE_Rec."Item No.");
                    IF Rec.FINDFIRST THEN BEGIN
                        Rec.Quantity += ILE_Rec.Quantity;
                        Rec.MODIFY;
                    END;
                    ILE_Rec.CalcFields("Cost Amount (Actual)");
                    ValueEntry.Reset();
                    ValueEntry.SetCurrentKey("Item Ledger Entry No.");
                    ValueEntry.SetRange("Item Ledger Entry No.", ILE_Rec."Entry No.");
                    ValueEntry.SetFilter(Adjustment, '%1', false);
                    if ValueEntry.FindFirst() then
                        Rec.AssembleVari_CostAmountActual += Abs(ValueEntry."Cost Amount (Actual)");


                    Clear(TotalCost);
                    ValueEntry1.Reset();
                    ValueEntry1.SetCurrentKey("Document No.");
                    ValueEntry1.SetFilter("Item Ledger Entry Type", '%1', ValueEntry1."Item Ledger Entry Type"::"Assembly Consumption");
                    ValueEntry1.SetFilter(Adjustment, '%1', false);
                    ValueEntry1.SetRange("Document No.", ILE_Rec."Document No.");
                    ValueEntry1.CalcSums("Cost Amount (Actual)");
                    TotalCost += Abs(ValueEntry1."Cost Amount (Actual)");

                    if PostedAssemblyOrder.Get(ILE_Rec."Document No.") then begin
                        PostedAssemblyOrder.CalcFields("Sales Order No.");

                        if recSalesHeader.Get(recSalesHeader."Document Type"::Order, PostedAssemblyOrder."Sales Order No.") then;

                        if ILE_Rec."Document No." <> XDocNo then begin
                            recPostedSalesInvLine.Reset();
                            recPostedSalesInvLine.SetCurrentKey("Order No.", "No.");
                            recPostedSalesInvLine.SetRange("Order No.", PostedAssemblyOrder."Sales Order No.");
                            recPostedSalesInvLine.SetRange("No.", PostedAssemblyOrder."Item No.");
                            if recPostedSalesInvLine.FindFirst() then begin
                                if TotalCost > 0 then begin
                                    Rec.AssembleVari_Profit += recPostedSalesInvLine."Line Amount" - TotalCost;
                                    if recPostedSalesInvLine."Line Amount" > 0 then
                                        Rec.AssembleVari_ProfitMargin += (Rec.AssembleVari_Profit / recPostedSalesInvLine."Line Amount") * 100;
                                    rec.AssembleVari_TotalRevenue += recPostedSalesInvLine."Line Amount";
                                end;
                            end;
                            XDocNo := Rec."Document No."
                        end;


                        if recItem.Get(PostedAssemblyOrder."Item No.") then begin
                            recItem.CalcFields("Assembly BOM");
                            if recItem."Assembly BOM" then begin
                                BOMComponent.Reset();
                                BOMComponent.SetCurrentKey("No.", "Parent Item No.");
                                BOMComponent.SetRange(Type, BOMComponent.Type::Item);
                                BOMComponent.SetRange("Parent Item No.", recItem."No.");
                                BOMComponent.SetRange("No.", ILE_Rec."Item No.");
                                if BOMComponent.FindFirst() then begin
                                    if (Abs(rec.AssembleVari_RawQtyPlanned - Abs(ILE_Rec.Quantity)) = 0) then begin
                                        rec.AssembleVari_QtyVariancePer := 0.00;
                                    end else begin
                                        if Rec.AssembleVari_RawQtyPlanned <> 0 then
                                            rec.AssembleVari_QtyVariancePer := ((Abs(Rec.AssembleVari_RawQtyPlanned - Abs(Rec.Quantity))) / Rec.AssembleVari_RawQtyPlanned) * 100;
                                    end;


                                    if Rec.AssembleVari_RawCostPlanned <> 0 then
                                        rec.AssembleVari_CostVariancePer := (Rec.AssembleVari_CostAmountActual) / Rec.AssembleVari_RawCostPlanned;
                                end;
                            end;
                        end;
                    end;
                    Rec.Modify();
                END;
            UNTIL ILE_Rec.NEXT = 0;

        Rec.RESET;
        IF Rec.FINDSET THEN;
    end;

}


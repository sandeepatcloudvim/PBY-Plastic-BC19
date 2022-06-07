tableextension 50003 "CBRExtItemLedgerEntry" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; PAO_ItemNo; Code[20])
        { }
        field(50001; PAO_Description; Text[100])
        { }
        field(50002; PAO_UOM; Code[10])
        { }
        field(50003; PAO_SalesOrderNo; Code[20])
        { }
        field(50004; PAO_Quantity; Decimal)
        { }
        field(50005; PAO_CustomerNo; Code[20])
        { }
        field(50006; PAO_CustomerName; text[100])
        { }
        field(50007; AssembleVari_OriginalQty; Decimal)
        { }
        field(50008; AssembleVari_RawQtyPlanned; Decimal)
        { }
        field(50009; AssembleVari_RawCostPlanned; Decimal)
        { }
        field(50010; AssembleVari_QtyVariancePer; Decimal)
        { }
        field(50011; AssembleVari_CostVariancePer; Decimal)
        { }
        field(50012; AssembleVari_TotalRevenue; Decimal)
        { }
        field(50013; AssembleVari_Profit; Decimal)
        { }
        field(50014; AssembleVari_ProfitMargin; Decimal)
        { }
        field(50015; AssembleVari_CostAmountActual; Decimal)
        { }



    }

    var
        myInt: Integer;
}
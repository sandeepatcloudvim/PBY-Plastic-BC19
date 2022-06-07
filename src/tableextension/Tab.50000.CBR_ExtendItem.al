tableextension 50000 CBR_ExtendItem extends Item
{
    fields
    {

    }

    var
        myInt: Integer;


    procedure UpdateDescriptionValue(recItem: Code[20])
    var
    begin
        if ItemDescription(recItem) AND AssemblyItem(recItem) then begin
            UpdateDescription(recItem);
        end;
    end;


    local procedure UpdateDescription(Item: Code[20])
    var
        recItem2: Record Item;
        String2: Text[100];
        recBOMComp: Record "BOM Component";
        recSalesLine: Record "Sales Line";

    begin
        if recItem2.Get(Item) then begin
            String2 := DelChr(recItem2.Description, '=', 'ZZZ');

            recBOMComp.Reset();
            recBOMComp.SetRange("Parent Item No.", Item);
            recBOMComp.SetRange(Type, recBOMComp.Type::Item);
            if recBOMComp.FindFirst() then begin
                recItem2.Description := copystr((recBOMComp."No." + String2), 1, 100);
                recItem2.Modify();
            end;

            recSalesLine.Reset();
            recSalesLine.SetRange("Document Type", recSalesLine."Document Type"::Order);
            recSalesLine.SetRange(Type, recSalesLine.Type::Item);
            recSalesLine.SetRange("No.", recItem2."No.");
            if recSalesLine.FindSet() then
                repeat
                    recSalesLine.Description := copystr(recItem2.Description, 1, 100);
                    recSalesLine.Modify();
                until recSalesLine.Next() = 0;

        end;
    end;

    local procedure ItemDescription(ItemNo: Code[20]): Boolean
    var
        recItem: Record Item;
        String1: Text[100];
        String3: Text[10];
    begin
        if recItem.Get(ItemNo) then begin
            String3 := 'ZZZ';
            String1 := CopyStr(recItem.Description, 1, 3);
            if String3 = String1 then
                exit(true)
            else
                exit(false);
        end;
    end;

    local procedure AssemblyItem(Item1: Code[20]): Boolean
    var
        recItem1: Record Item;
    begin
        if recItem1.get(Item1) then begin
            recItem1.CalcFields("Assembly BOM");
            if recItem1."Assembly BOM" then
                exit(true)
            else
                exit(false);
        end;
    end;

}
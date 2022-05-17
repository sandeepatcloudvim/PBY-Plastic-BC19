page 50002 "CBR Sales Invoice Detail Page"
{
    Editable = false;
    Caption = 'Sales Invoice Detail Page';
    PageType = List;
    SourceTable = "Sales Invoice Line";
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
                    Caption = 'Sales Order No.';
                }

                field("Customer ID"; RecSalesInvHead."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                    Caption = 'Customer No.';
                }
                field("Customer Name"; RecCust.Name)
                {
                    ApplicationArea = All;
                    Caption = 'Customer Name';
                }
                field("Order Date"; RecSalesInvHead."Order Date")
                {
                    ApplicationArea = All;
                    Caption = 'Order Date';
                }
                field(Address; RecSalesInvHead."Ship-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Address';
                }
                field(City; RecSalesInvHead."Ship-to City")
                {
                    ApplicationArea = All;
                    Caption = 'City';
                }
                field(State; RecSalesInvHead."Ship-to County")
                {
                    ApplicationArea = All;
                    Caption = 'State';
                }
                field(Postcode; RecSalesInvHead."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Post Code';
                }
                field(CountryRegionCode; RecSalesInvHead."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Country/Region Code';
                }
                field(ExternalDocumentNo; RecSalesInvHead."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'External Document No.';
                }
                field(RequestedDeliveryDate; RecSalesInvHead."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                }
                field(Item; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Item No';
                }
                field("Item Description"; Rec.Description)
                {
                    ApplicationArea = All;
                    Caption = 'Item Description';
                }
                field(Item_Category; RecItem."Item Category Code")
                {
                    ApplicationArea = All;
                    Caption = 'Item Category Code';
                }

                field(Qty; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Qty of Order';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Cost';
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Price';
                }
                field("Total Value"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Extended Price';
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

    }

    trigger OnAfterGetRecord()
    begin
        Clear(TotalCost);
        Clear(TotalProfit);
        Clear(Margin);

        if RecSalesInvHead.Get(Rec."Document No.") then;
        if RecItem.Get(Rec."No.") then;
        if RecCust.Get(Rec."Sell-to Customer No.") then;

        if Rec.Quantity > 0 then
            TotalCost := (Rec.Quantity * Rec."Unit Cost");
        TotalProfit := (Rec."Line Amount" - TotalCost);
        if TotalCost > 0 then
            Margin := (TotalProfit / TotalCost) * 100;

    end;

    var
        RecCust: Record Customer;
        RecSalesInvHead: Record "Sales Invoice Header";
        RecItem: Record Item;
        LineNo: Integer;
        RecVariant: Record "Item Variant";
        RemQtytoship: Decimal;
        RemValue: Decimal;
        TotalCost: Decimal;
        TotalProfit: Decimal;
        Margin: Decimal;


}


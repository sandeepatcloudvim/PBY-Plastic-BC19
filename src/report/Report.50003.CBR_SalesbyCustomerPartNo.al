report 50003 "Sales by Customer Part No."
{
    Caption = 'Sales by Customer Part No.';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './SalesbyCustomer.rdl';

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(No_Customer; Customer."No.")
            {
            }
            column(Name_Customer; Customer.Name)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Source No." = FIELD("No.");
                DataItemTableView = SORTING("Entry No.") ORDER(Ascending) WHERE("Entry Type" = FILTER(Sale));
                RequestFilterFields = "Posting Date";
                column(SalesLabel; SalesLabel)
                {
                }
                column(ItemFilter; ItemFilter)
                {

                }
                column(CustomerFilter; CustomerFilter)
                {

                }
                column(COGSLabel; COGSLabel)
                {
                }
                column(ProfitLabel; ProfitLabel)
                {
                }
                column(ProfitLabel1; ProfitLabel1)
                {
                }
                column(SumAmntLabel; SumAmntLabel)
                {
                }
                column(CustomerItemLabel; CustomerItemLabel)
                {
                }
                column(ItemNo_ILE; "Item Ledger Entry"."Item No.")
                {
                }
                column(PostingDate_ILE; "Item Ledger Entry"."Posting Date")
                {
                }
                column(SourceNo_ILE; "Item Ledger Entry"."Source No.")
                {
                }
                column(SalesAmnt_ILE; "Item Ledger Entry"."Sales Amount (Actual)")
                {
                }
                column(CostAmount_ILE; "Item Ledger Entry"."Cost Amount (Actual)")
                {
                }
                column(SumAmount; SumAmount)
                {

                }

                trigger OnAfterGetRecord();
                begin
                    if xItemNo <> "Item Ledger Entry"."Item No." then
                        CLEAR(SumAmount);
                    xItemNo := "Item Ledger Entry"."Item No.";
                    recVL.RESET;
                    recVL.SETRANGE("Item Ledger Entry No.", "Entry No.");
                    if recVL.FINDFIRST then begin
                        if SalesInvoiceHeader.GET(recVL."Document No.") then begin
                            SalesInvoiceHeader.CALCFIELDS(Amount);
                            SumAmount := SumAmount + SalesInvoiceHeader.Amount
                        end;
                    end;
                end;

                trigger OnPreDataItem();
                begin
                    ItemFilter := "Item Ledger Entry".GetFilters;
                    "Item Ledger Entry".SETCURRENTKEY("Item Ledger Entry"."Posting Date", "Item Ledger Entry"."Source No.", "Item Ledger Entry"."Item No.");
                end;
            }
            trigger OnPreDataItem()
            begin
                CustomerFilter := Customer.GetFilters;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SalesLabel: Label 'Sales ($)';
        COGSLabel: Label 'COGS ($)';
        ProfitLabel: Label 'Profit';
        ProfitLabel1: Label 'Profit %';
        SumAmntLabel: Label 'Sum of Amount';
        CustomerItemLabel: Label 'Customer/Item';
        recVL: Record "Value Entry";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SumAmount: Decimal;
        xItemNo: Code[30];
        ItemFilter: Text[150];
        CustomerFilter: Text[150];
}


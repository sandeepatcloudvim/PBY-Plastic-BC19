report 50004 "Customer Wise Sales Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './MasterSales.rdl';
    Caption = 'Master Sales';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Sales Data"; "Sales Data Buffer")
        {
            UseTemporary = true;
            DataItemTableView = SORTING("Sell-to Customer No.", "No.")
                                WHERE(Type = FILTER(Item));
            column(ReportTitle; ReportTitle)
            {
            }
            column(Year_; Year_)
            {
            }
            column(SH_CustomerNo; Customer."No.")
            {
            }
            column(SH_Name; Customer.Name)
            {
            }
            column(Customer_Salesperson; Customer."Salesperson Code")
            { }
            column(Country_Region; Customer."Territory Code")
            {
            }
            column(CategoryCode; Category)
            {
            }
            column(ItemNo; ItemNo)
            {
            }
            column(ItemDesc; Desc)
            {
            }
            column(Amount; SalesData.Amount)
            {
            }

            column(TotalLbl; TotalLbl)
            {
            }
            column(TerritoryLbl; TerritoryLbl)
            {
            }
            column(Jan; AmtMonthWise[1])
            {
            }
            column(Feb; AmtMonthWise[2])
            {
            }
            column(Mar; AmtMonthWise[3])
            {
            }
            column(Apr; AmtMonthWise[4])
            {
            }
            column(May; AmtMonthWise[5])
            {
            }
            column(Jun; AmtMonthWise[6])
            {
            }
            column(Jul; AmtMonthWise[7])
            {
            }
            column(Aug; AmtMonthWise[8])
            {
            }
            column(Sep; AmtMonthWise[9])
            {
            }
            column(Oct; AmtMonthWise[10])
            {
            }
            column(Nov; AmtMonthWise[11])
            {
            }
            column(Dec; AmtMonthWise[12])
            {
            }
            column(Jan1; AmtMonthWise[13])
            {
            }
            column(Feb1; AmtMonthWise[14])
            {
            }
            column(Mar1; AmtMonthWise[15])
            {
            }
            column(Apr1; AmtMonthWise[16])
            {
            }
            column(May1; AmtMonthWise[17])
            {
            }
            column(Jun1; AmtMonthWise[18])
            {
            }
            column(Jul1; AmtMonthWise[19])
            {
            }
            column(Aug1; AmtMonthWise[20])
            {
            }
            column(Sep1; AmtMonthWise[21])
            {
            }
            column(Oct1; AmtMonthWise[22])
            {
            }
            column(Nov1; AmtMonthWise[23])
            {
            }
            column(Dec1; AmtMonthWise[24])
            {
            }
            column(Jan2; AmtMonthWise[25])
            {
            }
            column(Feb2; AmtMonthWise[26])
            {
            }
            column(Mar2; AmtMonthWise[27])
            {
            }
            column(Apr2; AmtMonthWise[28])
            {
            }
            column(May2; AmtMonthWise[29])
            {
            }
            column(Jun2; AmtMonthWise[30])
            {
            }
            column(Jul2; AmtMonthWise[31])
            {
            }
            column(Aug2; AmtMonthWise[32])
            {
            }
            column(Sep2; AmtMonthWise[33])
            {
            }
            column(Oct2; AmtMonthWise[34])
            {
            }
            column(Nov2; AmtMonthWise[35])
            {
            }
            column(Dec2; AmtMonthWise[36])
            {
            }
            column(RowTotal; AmtMonthWise[37])
            {
            }
            column(RowTotal1; AmtMonthWise[38])
            {
            }
            column(RowTotal2; AmtMonthWise[39])
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(ReportHeader1; ReportHeader[1])
            {
            }
            column(ReportHeader2; ReportHeader[2])
            {
            }
            column(ReportHeader3; ReportHeader[3])
            {
            }
            column(ReportHeader4; ReportHeader[4])
            {
            }
            column(ReportHeader5; ReportHeader[5])
            {
            }
            column(ReportHeader6; ReportHeader[6])
            {
            }
            column(ReportHeader7; ReportHeader[7])
            {
            }
            column(ReportHeader8; ReportHeader[8])
            {
            }
            column(ReportHeader9; ReportHeader[9])
            {
            }
            column(ReportHeader10; ReportHeader[10])
            {
            }
            column(ReportHeader11; ReportHeader[11])
            {
            }
            column(ReportHeader12; ReportHeader[12])
            {
            }
            column(ReportHeader13; ReportHeader[13])
            {
            }
            column(ReportHeader14; ReportHeader[14])
            {
            }
            column(ReportHeader15; ReportHeader[15])
            {
            }
            column(ReportHeader16; ReportHeader[16])
            {
            }
            column(ReportHeader17; ReportHeader[17])
            {
            }
            column(ReportHeader18; ReportHeader[18])
            {
            }
            column(ReportHeader19; ReportHeader[19])
            {
            }
            column(ReportHeader20; ReportHeader[20])
            {
            }
            column(ReportHeader21; ReportHeader[21])
            {
            }
            column(ReportHeader22; ReportHeader[22])
            {
            }
            column(ReportHeader23; ReportHeader[23])
            {
            }
            column(ReportHeader24; ReportHeader[24])
            {
            }
            column(ReportHeader25; ReportHeader[25])
            {
            }
            column(ReportHeader26; ReportHeader[26])
            {
            }
            column(ReportHeader27; ReportHeader[27])
            {
            }
            column(ReportHeader28; ReportHeader[28])
            {
            }
            column(ReportHeader29; ReportHeader[29])
            {
            }
            column(ReportHeader30; ReportHeader[30])
            {
            }
            column(ReportHeader31; ReportHeader[31])
            {
            }
            column(ReportHeader32; ReportHeader[32])
            {
            }
            column(ReportHeader33; ReportHeader[33])
            {
            }
            column(ReportHeader34; ReportHeader[34])
            {
            }
            column(ReportHeader35; ReportHeader[35])
            {
            }
            column(ReportHeader36; ReportHeader[36])
            {
            }
            column(NoofMonth; NoofMonth)
            {
            }
            column(YearFirst; YearFirst)
            {
            }
            column(YearSecond; YearSecond)
            {
            }
            column(TotalAmtMonthWise; TotalAmtMonthWise)
            { }
            trigger OnAfterGetRecord()
            var

            begin
                IF "Sales Data"."Sell-to Customer No." = xcustomerNo THEN
                    CurrReport.SKIP
                ELSE BEGIN
                    xcustomerNo := "Sales Data"."Sell-to Customer No.";
                    ClearArray;
                    FOR I := 1 TO NoofMonth DO BEGIN
                        IF (FirstDateYear <> 0D) AND (LastDateYear <> 0D) THEN
                            CalculateDateFromFilter(I);

                        SalesData.RESET;
                        SalesData.SETRANGE("Sell-to Customer No.", "Sales Data"."Sell-to Customer No.");
                        SalesData.SETFILTER("Posting Date", '%1..%2', StDateFilter, EnDateFilter);
                        SalesData.CALCSUMS(Amount);

                        AmtMonthWise[I] += SalesData.Amount;
                        IF I <= 12 THEN
                            AmtMonthWise[37] += SalesData.Amount;
                        IF (I > 12) AND (I <= 24) THEN
                            AmtMonthWise[38] += SalesData.Amount;

                    END;
                    TotalAmtMonthWise := AmtMonthWise[37] + AmtMonthWise[38];

                    Customer.GET("Sales Data"."Sell-to Customer No.");
                END;
            end;

            trigger OnPostDataItem()
            begin
            end;

            trigger OnPreDataItem()
            begin
                StartMonth_G := Date2DMY(FirstDateYear, 2);
                "Sales Data".SETCURRENTKEY("Sales Data"."Sell-to Customer No.", "Sales Data"."No.");

                ReportFilters := "Sales Data".GETFILTERS;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Filters)
                {
                    Caption = 'Filters';
                    field(LastDateYear; LastDateYear)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = all;
                    }
                    field(SalesPerson; SPersonCode)
                    {

                        Caption = 'Sales Person';
                        ApplicationArea = all;
                        TableRelation = "Salesperson/Purchaser";
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
        CustomerName = 'Customer Name';
        CurrencySymbol = '$ ';
    }

    trigger OnPreReport()
    var
        Customer_L: Text;
        Customer_L1: Text;
    begin
        IF (lastDateYear = 0D) THEN //BEGIN
            IF GUIALLOWED THEN
                ERROR('Start Date should not be blank');
        FirstDateYear := CALCDATE('-CY', CALCDATE('-1Y', LastDateYear));//AGT_DS-Always start from january month

        LastDateYear := CALCDATE('CM', LastDateYear);
        StartMonth := DATE2DMY(FirstDateYear, 2);
        NoofMonth := 1 + DATE2DMY(LastDateYear, 2) - DATE2DMY(FirstDateYear, 2) + 12 * (DATE2DMY(LastDateYear, 3) - DATE2DMY(FirstDateYear, 3));
        IF NoofMonth > 24 THEN
            IF GUIALLOWED THEN
                ERROR('Date filter should be maximum 24 month of period.');
        CalculateReportHeader(NoofMonth, FirstDateYear, LastDateYear);
        CopyRecords();//ds

    end;

    trigger OnInitReport()
    begin
        CLEAR(SPersonCode);
    end;

    var

        JanLbl: Label 'January';
        FebLbl: Label 'February';
        MarLbl: Label 'March';
        AprLbl: Label 'April';
        MayLbl: Label 'May';
        JunLbl: Label 'June';
        JulLbl: Label 'July';
        AugLbl: Label 'August';
        SepLbl: Label 'September';
        OctLbl: Label 'October';
        NovLbl: Label 'November';
        DecLbl: Label 'December';
        TotalLbl: Label 'Total';
        TotalAmtMonthWise: Decimal;
        Year_: Text;
        TerritoryLbl: Label 'Territory';
        Country_Region: Text[50];
        StartDate: Date;
        StartDateTxt: Text[10];
        EndDate: Date;
        StDateFilter: Date;
        EnDateFilter: Date;
        AmtMonthWise: array[40] of Decimal;
        CreMemoAmtMonthWise: array[60] of Decimal;
        xNo: Code[20];
        xcustomerNo: Code[20];
        SaInvLine: Record 113;
        SalesCrememoLine: Record 115;
        I: Integer;
        Desc: Text[50];
        Item: Record 27;
        ReportTitle: Label 'Master Sales';
        ReportFilters: Text[250];
        Customer: Record 18;
        SPersonCode: Code[20];
        SalesInvoiceHeader: Record 112;
        RegionalManger: Code[20];
        FirstDateYear: Date;
        LastDateYear: Date;
        SalesData: Record 50000 temporary;
        Category: Code[20];
        EntryNo: Integer;
        Customer_: Code[20];
        Item_: Code[20];
        YearFirst: Text[10];
        YearSecond: Text[10];
        NoofMonth: Integer;
        GLAccount: Record 15;
        ItemNo: Code[20];
        StartMonth: Integer;
        ReportHeader: array[36] of Text[20];
        J: Integer;
        DistricMgr: Code[20];
        AreaMgr: Code[20];
        StartMonth_G: Integer;

    local procedure ClearArray()
    begin
        CLEAR(AmtMonthWise);
        CLEAR(CreMemoAmtMonthWise);
    end;

    local procedure CalculateDateFromFilter(I: Integer)
    var
        CalcFormat: Text[10];
    begin

        IF I > 1 THEN
            CalcFormat := FORMAT(I) + 'M-1D';

        StDateFilter := CALCDATE('-CM', CALCDATE(CalcFormat, FirstDateYear));
        EnDateFilter := CALCDATE('CM', StDateFilter);
    end;

    local procedure CopyRecords()
    begin

        SalesData.RESET;
        IF SalesData.FINDFIRST THEN
            SalesData.DELETEALL;

        EntryNo := 1;
        //ds
        Customer.Reset();//ds
        If SPersonCode <> '' then
            Customer.SetRange("Salesperson Code", SPersonCode);
        If Customer.FindSet() then
            repeat
                SalesDataInsert(SalesData, Customer);
            until Customer.Next() = 0;
    End;

    local procedure SalesDataInsert(var SalesData: Record "Sales Data Buffer"; Customer: Record Customer)
    begin
        SaInvLine.RESET;
        SaInvLine.SETCURRENTKEY("Sell-to Customer No.");
        SaInvLine.SETFILTER("Posting Date", '%1..%2', FirstDateYear, LastDateYear);
        SaInvLine.SetFilter("Sell-to Customer No.", Customer."No.");
        IF SaInvLine.FINDSET THEN
            REPEAT
                SalesData.INIT;
                SalesData.TRANSFERFIELDS(SaInvLine);
                SalesData."Entry No." := EntryNo;
                SalesData."Document Type" := SalesData."Document Type"::Invoice;
                IF SaInvLine.Amount <> 0 THEN BEGIN
                    IF SaInvLine.Type = SaInvLine.Type::Item THEN BEGIN
                        SalesData.INSERT;
                        EntryNo += 1;

                        "Sales Data".INIT;
                        "Sales Data".TRANSFERFIELDS(SalesData);
                        IF "Sales Data".INSERT THEN;
                    END;
                END;
            UNTIL SaInvLine.NEXT = 0;


        SalesCrememoLine.RESET;
        SalesCrememoLine.SETCURRENTKEY("Sell-to Customer No.");
        SalesCrememoLine.SETFILTER("Posting Date", '%1..%2', FirstDateYear, LastDateYear);
        SalesCrememoLine.SETFILTER("Sell-to Customer No.", Customer."No.");
        IF SalesCrememoLine.FINDSET THEN
            REPEAT
                SalesData.INIT;
                SalesData.TRANSFERFIELDS(SalesCrememoLine);
                SalesData."Document Type" := SalesData."Document Type"::"Credit Memo";
                IF SalesCrememoLine.Amount <> 0 THEN BEGIN
                    SalesData."Entry No." := EntryNo;
                    IF SalesCrememoLine.Type = SalesCrememoLine.Type::Item THEN BEGIN
                        SalesData.Amount *= -1;
                        SalesData.INSERT;
                        EntryNo += 1;

                        "Sales Data".INIT;
                        "Sales Data".TRANSFERFIELDS(SalesData);
                        IF "Sales Data".INSERT THEN;
                    END;
                END;
            UNTIL SalesCrememoLine.NEXT = 0;
    end;


    local procedure CalculateReportHeader(NoofMonth: Integer; StartDate_L: Date; EndDate_L: Date)
    var
        StartDateTxt_L: Text[10];
        CalcFormat: Text[10];
    begin
        FOR J := 1 TO NoofMonth DO BEGIN
            IF J > 1 THEN
                CalcFormat := FORMAT(J) + 'M-1D';


            EnDateFilter := CALCDATE(CalcFormat, StartDate_L);
            ReportHeader[J] := FORMAT(EnDateFilter, 0, '<Month Text,3> ') + FORMAT(DATE2DMY(EnDateFilter, 3));
            if J <= 12 then
                YearFirst := Format(DATE2DMY(EnDateFilter, 3));
            if (J > 12) and (J <= 24) then
                YearSecond := Format(DATE2DMY(EnDateFilter, 3));
        END;
    end;
}


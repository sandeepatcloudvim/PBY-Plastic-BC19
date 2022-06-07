report 50002 "Pick Instruction CBR"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PickInstructionReports.rdl';
    Caption = 'Pick Instruction';

    dataset
    {
        dataitem(CopyLoop; Integer)
        {
            DataItemTableView = SORTING(Number);
            column(Number; Number)
            {
            }
            column(CompanyNameText; CompNameText)
            {
            }
            column(DateText; DateTxt)
            {
            }
            dataitem("Sales Header"; "Sales Header")
            {
                DataItemTableView = SORTING("Document Type", "No.") WHERE("Document Type" = CONST(Order));
                RequestFilterFields = "No.";
                column(No_SalesHeader; "No.")
                {
                    IncludeCaption = true;
                }
                column(CustomerNo_SalesHeader; "Sell-to Customer No.")
                {
                    IncludeCaption = true;
                }
                column(CustomerName_SalesHeader; "Sell-to Customer Name")
                {
                    IncludeCaption = true;
                }
                column(BillToAddress1; BillToAddress[1])
                {
                }
                column(BillToAddress2; BillToAddress[2])
                {
                }
                column(BillToAddress3; BillToAddress[3])
                {
                }
                column(BillToAddress4; BillToAddress[4])
                {
                }
                column(BillToAddress5; BillToAddress[5])
                {
                }
                column(BillToAddress6; BillToAddress[6])
                {
                }
                column(BillToAddress7; BillToAddress[7])
                {
                }
                column(ShipToAddress1; ShipToAddress[1])
                {
                }
                column(ShipToAddress2; ShipToAddress[2])
                {
                }
                column(ShipToAddress3; ShipToAddress[3])
                {
                }
                column(ShipToAddress4; ShipToAddress[4])
                {
                }
                column(ShipToAddress5; ShipToAddress[5])
                {
                }
                column(ShipToAddress6; ShipToAddress[6])
                {
                }
                column(ShipToAddress7; ShipToAddress[7])
                {
                }
                column(OrderDate_SalesHeader; "Sales Header"."Order Date")
                {
                }
                column(PaymentTermsCode_SalesHeader; "Sales Header"."Payment Terms Code")
                {
                }
                column(DueDate_SalesHeader; "Sales Header"."Due Date")
                {
                }
                column(YourReference_SalesHeader; "Sales Header"."Your Reference")
                {
                }
                column(PaymentMethodCode_SalesHeader; "Sales Header"."Payment Method Code")
                {
                }
                column(ExternalDocumentNo_SalesHeader; "Sales Header"."External Document No.")
                {
                }
                column(PackageTrackingNo_SalesHeader; "Sales Header"."Package Tracking No.")
                {
                }
                column(ShipmentDate_SalesHeader; "Sales Header"."Shipment Date")
                {
                }
                column(Shipment_Method_Code; Rec_Shipment_Method.Description)
                {

                }
                column(Payment_terms_description; Rec_Payment_terms.Description)
                {

                }
                column(Shipping_Agent_Name; Rec_Shipping_Agent.Name)
                {

                }

                dataitem("Sales Line"; "Sales Line")
                {
                    DataItemLink = "Document Type" = FIELD("Document Type"),
                                   "Document No." = FIELD("No.");
                    DataItemTableView = SORTING("Document Type", "Document No.", "Line No.")
                                        WHERE(Type = CONST(Item));
                    column(LineNo_SalesLine; "Line No.")
                    {
                    }
                    column(ItemNo_SalesLine; "No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_SalesLine; Description)
                    {
                        IncludeCaption = true;
                    }
                    column(VariantCode_SalesLine; "Variant Code")
                    {
                        IncludeCaption = true;
                    }
                    column(LocationCode_SalesLine; "Location Code")
                    {
                        IncludeCaption = true;
                    }
                    column(BinCode_SalesLine; "Bin Code")
                    {
                        IncludeCaption = true;
                    }
                    column(ShipmentDate_SalesLine; "Shipment Date")
                    {

                    }
                    column(Quantity_SalesLine; Quantity)
                    {
                        IncludeCaption = true;
                    }
                    column(UnitOfMeasure_SalesLine; "Unit of Measure")
                    {
                        IncludeCaption = true;
                    }
                    column(QuantityToShip_SalesLine; "Qty. to Ship")
                    {
                        IncludeCaption = true;
                    }
                    column(QuantityShipped_SalesLine; "Quantity Shipped")
                    {
                        IncludeCaption = true;
                    }
                    column(QtyToAsm; QtyToAsm)
                    {
                    }
                    dataitem("Assembly Line"; "Assembly Line")
                    {
                        DataItemTableView = SORTING("Document Type", "Document No.", "Line No.");
                        column(No_AssemblyLine; "No.")
                        {
                            IncludeCaption = true;
                        }
                        column(Description_AssemblyLine; Description)
                        {
                            IncludeCaption = true;
                        }
                        column(VariantCode_AssemblyLine; "Variant Code")
                        {
                            IncludeCaption = true;
                        }
                        column(Quantity_AssemblyLine; Quantity)
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityPer_AssemblyLine; "Quantity per")
                        {
                            IncludeCaption = true;
                        }
                        column(UnitOfMeasure_AssemblyLine; GetUOM("Unit of Measure Code"))
                        {
                        }
                        column(LocationCode_AssemblyLine; "Location Code")
                        {
                            IncludeCaption = true;
                        }
                        column(BinCode_AssemblyLine; "Bin Code")
                        {
                            IncludeCaption = true;
                        }
                        column(QuantityToConsume_AssemblyLine; "Quantity to Consume")
                        {
                            IncludeCaption = true;
                        }

                        trigger OnPreDataItem()
                        begin
                            IF NOT AsmExists THEN
                                CurrReport.BREAK;
                            SETRANGE("Document Type", AsmHeader."Document Type");
                            SETRANGE("Document No.", AsmHeader."No.");
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        AssembleToOrderLink: Record "Assemble-to-Order Link";
                    begin
                        AssembleToOrderLink.RESET;
                        AssembleToOrderLink.SETCURRENTKEY(Type, "Document Type", "Document No.", "Document Line No.");
                        AssembleToOrderLink.SETRANGE(Type, AssembleToOrderLink.Type::Sale);
                        AssembleToOrderLink.SETRANGE("Document Type", "Document Type");
                        AssembleToOrderLink.SETRANGE("Document No.", "Document No.");
                        AssembleToOrderLink.SETRANGE("Document Line No.", "Line No.");
                        AsmExists := AssembleToOrderLink.FINDFIRST;
                        QtyToAsm := 0;
                        IF AsmExists THEN
                            IF AsmHeader.GET(AssembleToOrderLink."Assembly Document Type", AssembleToOrderLink."Assembly Document No.") THEN
                                QtyToAsm := AsmHeader."Quantity to Assemble"
                            ELSE
                                AsmExists := FALSE;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    FormatAddress.SalesHeaderShipTo(ShipToAddress, ShipToAddress, "Sales Header");
                    FormatAddress.SalesHeaderSellTo(BillToAddress, "Sales Header");

                    if Rec_Shipping_Agent.Get("Sales Header"."Shipping Agent Code") then;

                    if Rec_Shipment_Method.Get("Sales Header"."Shipment Method Code") then;

                    if Rec_Payment_terms.Get("Sales Header"."Payment Terms Code") then;



                end;
            }

            trigger OnPreDataItem()
            begin
                SETRANGE(Number, 1, NoOfCopies + 1);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field("No of Copies"; NoOfCopies)
                    {
                        ApplicationArea = Planning;
                        Caption = 'No of Copies';
                        ToolTip = 'Specifies how many copies of the document to print.';
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
        OrderPickingListCaption = 'Pick Instruction';
        PageCaption = 'Page';
        ItemNoCaption = 'Item  No.';
        OrderNoCaption = 'Order No.';
        CustomerNoCaption = 'Customer No.';
        CustomerNameCaption = 'Customer Name';
        QtyToAssembleCaption = 'Quantity to Assemble';
        QtyAssembledCaption = 'Quantity Assembled';
        ShipmentDateCaption = 'Shipment Date';
        QtyPickedCaption = 'Quantity Picked';
        UOMCaption = 'Unit of Measure';
        QtyConsumedCaption = 'Quantity Consumed';
        CopyCaption = 'Copy';
    }

    trigger OnPreReport()
    begin
        DateTxt := FORMAT(TODAY);
        CompNameText := COMPANYNAME;
    end;

    var
        AsmHeader: Record "Assembly Header";
        NoOfCopies: Integer;
        DateTxt: Text;
        CompNameText: Text;
        QtyToAsm: Decimal;
        AsmExists: Boolean;
        BillToAddress: array[8] of Text[100];
        FormatAddress: Codeunit "Format Address";
        ShipToAddress: array[8] of Text[100];

        Rec_Shipment_Method: Record "Shipment Method";

        Shipment_Method_Code: Text[100];

        Rec_Payment_terms: Record "Payment Terms";

        Payment_terms_description: Text[100];

        Rec_Shipping_Agent: Record "Shipping Agent";

        Shipping_Agent_Name: Text[100];

    local procedure GetUOM(UOMCode: Code[10]): Text
    var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        IF UnitOfMeasure.GET(UOMCode) THEN
            EXIT(UnitOfMeasure.Description);
        EXIT(UOMCode);
    end;

    procedure InitializeRequest(NewNoOfCopies: Integer)
    begin
        NoOfCopies := NewNoOfCopies;
    end;
}


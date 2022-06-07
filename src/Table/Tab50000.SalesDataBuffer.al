table 50000 "Sales Data Buffer"
{
    Caption = 'Sales Temp Data';
    //TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Sales Invoice Header";
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(5; Type; Option)
        {
            Caption = 'Type';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            Caption = 'No.';
        }
        // field(7; "Location Code"; Code[10])
        // {
        //     Caption = 'Location Code';
        //     TableRelation = Location WHERE(Use As In-Transit=CONST(No));
        // }
        field(9; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Invoice,Credit Memo';
            OptionMembers = ,Invoice,"Credit Memo";
        }
        field(11; Description; Text[150])
        {
            Caption = 'Description';
        }
        field(13; "Unit of Measure"; Text[10])
        {
            Caption = 'Unit of Measure';
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(29; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount Including Tax';
        }
        field(131; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        // field(50000; "Sales Person Code"; Code[20])
        // {
        // }
        field(50001; "Regional Manager"; Code[10])
        {
            Caption = 'Regional Manager';
            Enabled = false;
        }
        field(50002; "Regional Manager2"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Sales Person Code2"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "District Manager"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'AGT_YK-010422';
        }
        field(50005; "Area Manager"; Code[10])
        {
            DataClassification = ToBeClassified;
            Description = 'AGT_YK-010422';
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Document No.", "Line No.")
        {
            Clustered = true;
            MaintainSIFTIndex = false;
        }
        key(Key3; "Sell-to Customer No.", "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    var
        SalesDocLineComments: Record 44;
        PostedDeferralHeader: Record 1704;
    begin
    end;
}


codeunit 50000 EventSubscriber
{
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Page, Page::"Sales Order Subform", 'OnInsertRecordEvent', '', false, false)]
    local procedure UpdateDescription(VAR Rec: Record "Sales Line"; BelowxRec: Boolean; VAR xRec: Record "Sales Line"; VAR AllowInsert: Boolean)
    begin
        if Rec."No." = '' then
            exit;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', false, false)]
    local procedure UpdateItemDescription(VAR Rec: Record Item; RunTrigger: Boolean)
    begin
    end;


}
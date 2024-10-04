codeunit 50002 "Page Management Ext(hr)"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef);
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin
        // case RecordRef.Number of
        //     DATABASE::"FIN-Payments Header":
        //         exit(page::"FIN-Payment Header");
        //     DATABASE::"FIN-Imprest Header":
        //         exit(page::"FIN-Travel Advance Req. UP");


        // end;
    end;

    procedure RunWorkflowEntriesPage(RecordIDInput: RecordID; TableId: Integer; DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","Payment Voucher",Imprest,"Staff Claim","Store Req","Inter Bank"; DocumentNo: Code[20])
    var
        ApprovalEntry: Record "Approval Entry";
        WorkflowWebhookEntry: Record "Workflow Webhook Entry";
        Approvals: Page Approvals;
        WorkflowWebhookEntries: Page "Workflow Webhook Entries";
        ApprovalEntries: Page "Approval Entries";
    begin
        // if we are looking at a particular record, we want to see only record related workflow entries
        if DocumentNo <> '' then begin
            ApprovalEntry.SetRange("Record ID to Approve", RecordIDInput);
            WorkflowWebhookEntry.SetRange("Record ID", RecordIDInput);
            // if we have flows created by multiple applications, start generic page filtered for this RecordID
            if ApprovalEntry.FindFirst and WorkflowWebhookEntry.FindFirst then begin
                Approvals.Setfilters(RecordIDInput);
                Approvals.Run;
            end else begin
                // otherwise, open the page filtered for this record that corresponds to the type of the flow
                if WorkflowWebhookEntry.FindFirst then begin
                    WorkflowWebhookEntries.Setfilters(RecordIDInput);
                    WorkflowWebhookEntries.Run;
                    exit;
                end;

                if ApprovalEntry.FindFirst then begin
                    ApprovalEntries.Setfilters(TableId, DocumentType, DocumentNo);
                    ApprovalEntries.Run;
                    exit;
                end;

                // if no workflow exist, show (empty) joint workflows page
                Approvals.Setfilters(RecordIDInput);
                Approvals.Run;
            end
        end else
            // otherwise, open the page with all workflow entries
            Approvals.Run;
    end;
}
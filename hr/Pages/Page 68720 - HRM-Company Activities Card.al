page 68720 "HRM-Company Activities Card"
{
    DeleteAllowed = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Document;
    PromotedActionCategories = 'New,Process,Report,Functions';
    SaveValues = true;
    SourceTable = "HRM-Company Activities";

    layout
    {
        area(content)
        {
            group("Activity Details")
            {
                Caption = 'Activity Details';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Employee Responsible"; Rec."Employee Responsible")
                {
                    ApplicationArea = all;
                    Importance = Promoted;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field("Email Message"; Rec."Email Message")
                {
                    ApplicationArea = all;
                }
                field(Costs; Rec.Costs)
                {
                    ApplicationArea = all;
                }
                field("Contribution Amount (If Any)"; Rec."Contribution Amount (If Any)")
                {
                    ApplicationArea = all;
                }
                field(Directorate; Rec.Directorate)
                {
                    ApplicationArea = all;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = all;
                }
                field(Station; Rec.Station)
                {
                    ApplicationArea = all;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = all;
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field("Activity Status"; Rec."Activity Status")
                {
                    ApplicationArea = all;
                }
            }
            part(Control1102755011; "HRM-Activity Participants SF")
            {
                ApplicationArea = all;
                SubPageLink = "Document No." = FIELD(Code);
            }
        }
        area(factboxes)
        {
            part(Control1102755024; "HRM-Company Activities Factbox")
            {
                ApplicationArea = all;
                SubPageLink = Code = FIELD(Code);
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Functions)
            {
                action("Get Participants")
                {
                    ApplicationArea = all;
                    Image = SalesPurchaseTeam;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(Closed, false);
                        //TESTFIELD(Status,Status::New);

                        //DELETE ANY PREVIOS RECORDS RELATED TO THIS ACTIVITY
                        HRActivityApprovalEntry.SetRange(HRActivityApprovalEntry."Document No.", Rec.Code);
                        if HRActivityApprovalEntry.Find('-') then
                            HRActivityApprovalEntry.DeleteAll;

                        //GET ONLY ACTIVE EMPLOYEES
                        HREmp.Reset;
                        HREmp.SetRange(HREmp.Status, HREmp.Status::Active);
                        HREmp.SetFilter(HREmp."User ID", '<>%1', '');
                        HREmp.FindFirst;
                        begin
                            HRActivityApprovalEntry.Reset;
                            repeat
                                HRActivityApprovalEntry.Init;
                                HREmp.TestField(HREmp."User ID");
                                HRActivityApprovalEntry.Participant := HREmp."No.";
                                HRActivityApprovalEntry."Partipant Name" := HREmp."First Name" + ' ' + HREmp."Middle Name" + ' ' + HREmp."Last Name";
                                HRActivityApprovalEntry."Document No." := Rec.Code;
                                HRActivityApprovalEntry.Validate(HRActivityApprovalEntry.Participant);
                                HRActivityApprovalEntry.Insert();
                            until HREmp.Next = 0;
                        end;
                    end;
                }
                action("Notify Participants")
                {
                    ApplicationArea = all;
                    Image = SendMail;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin

                        Rec.TestField(Closed, false);

                        HRActivityApprovalEntry.Reset;
                        HRActivityApprovalEntry.SetRange(HRActivityApprovalEntry."Document No.", Rec.Code);

                        //IF NO PARTICIPANTS ARE IMPORTED
                        if HRActivityApprovalEntry.Count = 0 then
                            Error('You must get participants to notify before using this function');

                        //ELSE
                        Rec.Get(Rec.Code);
                        HRActivityApprovalEntry.Reset;

                        DocType := DocType::"Company Activity";


                        HRActivityApprovalEntry.SetRange("Table ID", DATABASE::"HRM-Activity Participants");
                        HRActivityApprovalEntry.SetRange("Document Type", DocType);
                        HRActivityApprovalEntry.SetRange("Document No.", Rec.Code);
                        HRActivityApprovalEntry.SetRange("Activity Status", HRActivityApprovalEntry."Activity Status"::Created);
                        if HRActivityApprovalEntry.FindSet(true, false) then begin

                            repeat

                                //ApprovalsMgtNotification.SendActivityNotificationMail(Rec,HRActivityApprovalEntry);

                                HRActivityApprovalEntry.Notified := true;
                                HRActivityApprovalEntry.Modify;

                            until HRActivityApprovalEntry.Next = 0;
                            Message('%1', Text001)
                        end
                    end;
                }
                action(Close)
                {
                    ApplicationArea = all;
                    Image = Close;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.Closed := true;
                        Rec.Modify;
                        Message('Event :: %1 :: has been marked as Closed', Rec.Description);
                        CurrPage.Close;
                    end;
                }
                action("Re-Open")
                {
                    ApplicationArea = all;
                    Image = Open;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.Closed := false;
                        Rec.Modify;
                        Message('Event :: %1 :: has been Re-Opened', Rec.Description);
                        CurrPage.Close;
                    end;
                }
                /* action(Print)
                {
                    ApplicationArea = all;
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HRCompanyActivities.Reset;
                        HRCompanyActivities.SetRange(HRCompanyActivities.Code, Rec.Code);
                        if HRCompanyActivities.Find('-') then
                            REPORT.Run(39005492, true, true, HRCompanyActivities);
                    end;
                } */
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                action(Action1102755030)
                {
                    ApplicationArea = all;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Activity Approval";
                        ApprovalEntries: Page "Approval Entries";
                    begin

                        DocumentType := DocumentType::"Activity Approval";
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Company Activities", DocumentType, Rec.Code);
                        ApprovalEntries.Run;
                    end;
                }
                action("Send Approval Request")
                {
                    ApplicationArea = all;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Send this Company Activity for Approval?', true) = false then exit;
                        //AppMgmt.CancelJVApprovalRequest(Rec);
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = all;
                    Caption = 'Cancel Approval Request';
                    Image = CancelAllLines;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        if Confirm('Cancel Approval Request for this Company Activity?', true) = false then exit;
                        //AppMgmt.FinishExitApprovalReq(Rec,TRUE,TRUE);
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        // UpdateControls;
    end;

    trigger OnInit()
    begin
        //UpdateControls;
    end;

    trigger OnOpenPage()
    begin
        //UpdateControls;
    end;

    var
        D: Date;
        SMTP: Codeunit "Mail Management";
        CTEXTURL: Text[500];
        HREmp: Record "HRM-Employee (D)";
        //ApprovalSetup: Record "Approval Setup";
        //ApprovalsMgtNotification: Codeunit "Approvals Mgt Notification";
        HRCompanyActivities: Record "HRM-Company Activities";
        HRActivityApprovalEntry: Record "HRM-Activity Participants";
        DocType: Option "Company Activity";
        Text001: Label 'All Participants have been notified via E-Mail';
        GenJournal: Record "Gen. Journal Line";
        LineNo: Integer;
    //AppMgmt: Codeunit "Approvals Management";

    procedure UpdateControls()
    begin
        if Rec.Closed then begin
            CurrPage.Editable := false;
        end else begin
            CurrPage.Editable := true;
        end;
    end;
}


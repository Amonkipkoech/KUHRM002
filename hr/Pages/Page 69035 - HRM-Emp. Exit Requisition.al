page 69035 "HRM-Emp. Exit Requisition"
{
    Caption = 'Employee Separation Card';
    PageType = Document;
    PromotedActionCategories = 'New,Process,Reports,Exit Interview';
    SourceTable = "HRM-Employee Exit Interviews";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Exit Clearance No"; Rec."Exit Clearance No")
                {
                    ApplicationArea = all;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field("Appointment Date"; Rec."Appointment Date")
                {
                    ToolTip = 'Specifies the value of the Date of Appointment field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Of Leaving"; Rec."Date Of Leaving")
                {
                    ToolTip = 'Specifies the value of the Date Of Leaving field.';
                    ApplicationArea = All;
                }
                field("Reason For Exit"; Rec."Reason For Exit")
                {
                    ToolTip = 'Specifies the value of the Reason For Exit field.';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."Reason For Exit" = Rec."Reason For Exit"::Death then
                            enable := True
                        ELSE
                            enable := false;

                        CurrPage.Update();

                    end;
                }
                field("Employee Clearance"; Rec."Employee Clearance")
                {
                    ToolTip = 'Specifies the value of the Employee Clearance field.';
                    ApplicationArea = All;
                }
                field("Final Dues Paid"; Rec."Final Dues Paid")
                {
                    ToolTip = 'Specifies the value of the Final Dues Paid field.';
                    ApplicationArea = All;
                }
                field("Date Final Dues Paid"; Rec."Date Final Dues Paid")
                {
                    ToolTip = 'Specifies the value of the Date Final Dues Paid field.';
                    ApplicationArea = All;
                }
                field("Part Time Arrears Paid"; Rec."Part Time Arrears Paid")
                {
                    ToolTip = 'Specifies the value of the Part Time Arrears Paid field.';
                    ApplicationArea = All;
                }
                field("Part time paid Date"; Rec."Part time paid Date")
                {
                    ToolTip = 'Specifies the value of the Date Part TIme arrears was Paid field.';
                    ApplicationArea = All;
                }
                field("Date Last Salary Paid"; Rec."Date Last Salary Paid")
                {
                    ToolTip = 'Specifies the value of the Date of Last Month Salary Paid field.';
                    ApplicationArea = All;
                }
                field("Date Life Ins. Paid"; Rec."Date Life Ins. Paid")
                {
                    ToolTip = 'Specifies the value of the Date group Life Insurance was Paid field.';
                    ApplicationArea = All;
                    Editable = enable;
                }
                field("Group Life Ins. Paid"; Rec."Group Life Ins. Paid")
                {
                    ToolTip = 'Specifies the value of the Group life insurance cover paid field.';
                    ApplicationArea = All;
                    Editable = enable;
                }
                field("Last Month Salary Paid"; Rec."Last Month Salary Paid")
                {
                    ToolTip = 'Specifies the value of the Last Month Salary Paid field.';
                    ApplicationArea = All;
                }
                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = All;
                }

            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
                ApplicationArea = all;
            }
            systempart(Control1102755010; Notes)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Exit Employee")
            {
                Caption = '&Exit Employee';
            }
            action("&Approvals")
            {
                Caption = '&Approvals';
                Enabled = true;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ApprovalEntries.Setfilters(DATABASE::"Misc. Article Information", DocumentType, ExitCl."Exit Clearance No");
                    ApprovalEntries.Run;
                end;
            }
            action("&Send Approval Request")
            {
                Caption = '&Send Approval Request';
                Enabled = true;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;
                ApplicationArea = All;

                // trigger OnAction()
                //         var
                //         approvalMang: Codeunit "Approval Mgmnt. Ext(hr)";
                //         begin
                //             approvalMang.CheckEmployeeRequisitionApprovalPossible(Rec);
                //             approvalMang.OnSendEmployeeRequisitionForApproval(Rec);

                //         //Rec."Job ID" := USERID;
                //         Rec."Requisition Date" := TODAY;
                //         Rec.Status := Rec.Status::Approved;
                //         Rec."Requisition Status" := Rec."Requisition Status" :: " "
                //         end;


                trigger OnAction()
                var
                    approvalMang: Codeunit "Approval Mgmnt. Ext(hr)";
                begin
                    approvalMang.OnSendExtiInterviewsForApproval(Rec);

                    if Confirm('Send this Exit Request for Approval?', true) = false then exit;

                    //ApprovalMgt.SendExitApprovalReq(Rec);
                    Rec."Approval Status" := Rec."Approval Status"::Approved
                end;
            }
            action("&Cancel Approval Request")
            {
                Caption = '&Cancel Approval Request';
                Enabled = true;
                Image = Cancel;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // IF CONFIRM('Cancel this Exit request Approval',TRUE)=FALSE THEN EXIT;
                    //ApprovalMgt.CancelExitAppRequest(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if HREmp.Get(Rec."Employee No.") then begin
            JobTitle := HREmp."Job Title";
            sUserID := HREmp."User ID";
        end else begin
            JobTitle := '';
            sUserID := '';
        end;


        Rec.SetRange("Employee No.");
        DAge := '';
        DService := '';
        DPension := '';
        DMedical := '';

        RecalcDates;
    end;

    var
        JobTitle: Text[30];
        Supervisor: Text[60];
        HREmp: Record "HRM-Employee (D)";
        Dates: Codeunit "HR Dates";
        DAge: Text[100];
        DService: Text[100];
        DPension: Text[100];
        DMedical: Text[100];
        HREmpForm: Page "HRM-Employee (C)";
        sUserID: Code[30];
        DoclLink: Record "HRM-Employee Attachments";
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        D: Date;
        enable: Boolean;
        ExitCl: Record "HRM-Employee Exit Interviews";
        Text19062217: Label 'Misc Articles';
        DepartmentName: Text[40];
        sDate: Date;
        Number: Integer;
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Budget Transfer","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Medical Claims";
        ApprovalEntries: Page "Approval Entries";
        //todo  ApprovalMgt: Codeunit "Approvals Management";
        Department: Record "Dimension Value";

    procedure RecalcDates()
    begin
        //Recalculate Important Dates
        if (HREmp."Date Of Leaving" = 0D) then begin
            if (HREmp."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(HREmp."Date Of Birth", Today);
            if (HREmp."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(HREmp."Date Of Join", Today);
            /* IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
             DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",TODAY);
             IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
             DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",TODAY);  */
            //MODIFY;
        end else begin
            if (HREmp."Date Of Birth" <> 0D) then
                DAge := Dates.DetermineAge(HREmp."Date Of Birth", HREmp."Date Of Leaving");
            if (HREmp."Date Of Join" <> 0D) then
                DService := Dates.DetermineAge(HREmp."Date Of Join", HREmp."Date Of Leaving");
            /* IF  (HREmp."Pension Scheme Join Date" <> 0D) THEN
             DPension:= Dates.DetermineAge(HREmp."Pension Scheme Join Date",HREmp."Date Of Leaving");
             IF  (HREmp."Medical Scheme Join Date" <> 0D) THEN
             DMedical:= Dates.DetermineAge(HREmp."Medical Scheme Join Date",HREmp."Date Of Leaving");*/
            //MODIFY;
        end;

    end;

    local procedure EmployeeNoOnAfterValidate()
    begin
        CurrPage.SaveRecord;
        Rec.FilterGroup := 2;
        ExitCl.SetRange(ExitCl."Employee No.", Rec."Employee No.");
        Rec.FilterGroup := 0;
        if ExitCl.Find('-') then;
        CurrPage.Update(false);
    end;
}


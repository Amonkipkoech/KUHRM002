page 68106 "HRM-Leave Requisition"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "HRM-Leave Requisition";
    PromotedActionCategories = 'New,Action,Navigation,Process,Request Approval,Approval,Post,Report,Print/send';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    Editable = NoEditable;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                    Editable = DateEditable;
                }
                field("Employee No"; Rec."Employee No")
                {
                    caption = 'Payroll No';
                    ApplicationArea = all;
                    Editable = DepartmentCodeEditable;
                    // trigger OnValidate()
                    // begin
                    //     HREmp.Reset();
                    //     HREmp.SetRange("No.", Rec."Employee No");

                    //     if HREmp.FindFirst() then begin
                    //         
                    //     end;

                    // end;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                    Editable = EmpNameEditable;
                }
                field("Reliever No."; Rec."Reliever No.")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Editable = RelNoEditable;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    Visible = false;
                    ApplicationArea = all;
                    Editable = RelNameEditable;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    ApplicationArea = all;
                    Editable = DepartmentCodeEditable;

                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                    Editable = DepartmentCodeEditable;
                }
                field(JobGrade; Rec.JobGrade)
                {
                    ApplicationArea = All;
                    Caption = 'Job Cadre';
                }
                field(Gender; Rec.Gender)
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Gender field.';
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    ApplicationArea = All;
                    Editable = PurposeEditable;
                }

                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = all;
                    Editable = LeaveTypeEditable;

                    trigger OnValidate()
                    var
                        leaveType: Record "HRM-Leave Types";
                    begin
                        leaveType.Reset();
                        leaveType.SetRange(Code, Rec."Leave Type");
                        leaveType.SetRange(IsAnnual, false);
                        if leaveType.FindFirst() then begin
                            EditLeaveDays := false;
                        end
                        else
                            EditLeaveDays := true;
                    end;

                }
                field("Applied Days"; Rec."Applied Days")
                {
                    ApplicationArea = all;
                    Editable = PurposeEditable;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                    Editable = PurposeEditable;

                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Purpose; Rec.Purpose)
                {
                    //Visible = false;
                    ApplicationArea = all;
                    Editable = PurposeEditable;
                }
                field("Availlable Days"; Rec."Availlable Days")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Leave Balance field.';
                    Editable = false;
                }
                // field("Leave Balance"; Rec."Leave Balance")
                // {

                //     ApplicationArea = All;
                // }
                field("Process Leave Allowance"; Rec."Process Leave Allowance")
                {

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("&Functions")
            {
                Caption = '&Functions';

                // action(sendApproval)
                // {
                //     Caption = 'Send A&pproval Request';
                //     Image = SendApprovalRequest;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     var
                //         ApprovalMangt: Codeunit "Approval Mgmnt. Ext(hr)";
                //     begin
                //         ApprovalMangt.CheckLeaveApplicationApprovalPossible(Rec);
                //         ApprovalMangt.OnSendLeaveApplicationForApproval(Rec);
                //     end;
                // }
                // action(cancellsApproval)
                // {
                //     Caption = 'Cancel Approval Re&quest';
                //     Image = Cancel;
                //     Promoted = true;
                //     PromotedCategory = Category5;
                //     PromotedIsBig = true;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     var
                //         ApprovalMangt: Codeunit "Approval Mgmnt. Ext(hr)";
                //     begin
                //         ApprovalMangt.OnCancelLeaveApplicationForApproval(Rec);
                //     end;
                // }
                // action(Approvals)
                // {
                //     Caption = 'Approvals';
                //     Image = Approvals;
                //     Promoted = true;
                //     PromotedCategory = Category6;
                //     PromotedIsBig = true;
                //     ApplicationArea = All;

                //     trigger OnAction()
                //     begin
                //         DocumentType := DocumentType::"Leave Application";
                //         ApprovalEntries.Setfilters(DATABASE::"HRM-Leave Requisition", DocumentType, Rec."No.");
                //         ApprovalEntries.Run;
                //     end;
                // }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;
                    RunObject = Page "Fin-Approval Entries";
                    RunPageLink = "Document No." = field("No.");
                }
                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction()
                    var
                        approvalmgt: Codeunit IntCodeunit;
                    begin
                        if Rec.Status = Rec.Status::Open then
                            approvalmgt.OnSendLeavesforApproval(Rec)
                        else
                            Error('Status is not open');
                    end;
                }
                action(cancellsApproval)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit IntCodeunit;
                        showmessage: Boolean;

                    begin

                        showmessage := true;
                        if Rec.Status = Rec.Status::"Pending Approval" then
                            ApprovalMgt.OnCancelLeaveforApproval(Rec)
                        else
                            error('Status must be pending approval');

                    end;
                }
                action(" Approvals")
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Leave Requisition", 6, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }

                separator(Separator15)
                {
                }
                action("Print/Preview")
                {
                    ApplicationArea = all;
                    Caption = 'Print/Preview';
                    Image = PrintReport;
                    Promoted = true;
                    PromotedCategory = Category9;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(51720, true, true, Rec);
                        Rec.Reset;
                    end;
                }
                separator(Separator24)
                {
                }
                action("Post Leave Application")
                {
                    ApplicationArea = all;
                    Caption = 'Post Leave Application';
                    Image = Post;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Released then Error('The Document Approval is not Complete');

                        Rec.TestField("Employee No");
                        Rec.TestField("Applied Days");
                        Rec.TestField("Starting Date");

                        LeaveEntry.Init;
                        LeaveEntry."Document No" := Rec."No.";
                        LeaveEntry."Leave Period" := Date2DWY(Today, 3);
                        LeaveEntry."Transaction Date" := Rec.Date;
                        LeaveEntry."Employee No" := Rec."Employee No";
                        LeaveEntry."Leave Type" := Rec."Leave Type";
                        LeaveEntry."No. of Days" := -Rec."Applied Days";
                        LeaveEntry."Transaction Description" := Rec.Purpose;
                        LeaveEntry."Entry Type" := LeaveEntry."Entry Type"::Application;
                        LeaveEntry."Created By" := UserId;
                        LeaveEntry."Transaction Type" := LeaveEntry."Transaction Type"::Application;
                        LeaveEntry.Insert(true);

                        Rec.Posted := true;
                        Rec."Posted By" := UserId;
                        Rec."Posting Date" := Today;
                        Rec.Modify;

                        if HREmp.Get(Rec."Employee No") then begin
                            HREmp."On Leave" := true;
                            HREmp."Current Leave No" := Rec."No.";
                            HREmp.Modify;
                        end;
                        Message('Leave Posted Successfully');
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        UpdateControls;
    end;

    trigger OnInit()
    begin
        /*PurposeEditable := TRUE;
        "Starting DateEditable" := TRUE;
        "Applied DaysEditable" := TRUE;
        "Department CodeEditable" := TRUE;
        "Campus CodeEditable" := TRUE;
        "Employee NoEditable" := TRUE;
        DateEditable := TRUE;
        "No.Editable" := TRUE;
        UpdateControls;

    end;

    trigger OnOpenPage()
    begin
        /*
        IF UserMgt.GetPurchasesFilter() <> '' THEN BEGIN
          FILTERGROUP(2);
          SETRANGE("Responsibility Center" ,UserMgt.GetPurchasesFilter());
          FILTERGROUP(0);
        END;
        */
        //SETFILTER("User ID",USERID);

    end;

    var
        UserMgt: Codeunit "User Setup Management";
        //todo  ApprovalMgt: Codeunit "Approvals Management";
        ReqLine: Record "HMS-Setup Blood Group";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        //   JournlPosted: Codeunit "Journal Post Successful";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        FixedAsset: Record "Fixed Asset";
        //MinorAssetsIssue: Record "HMS-Patient";
        LeaveEntry: Record "HRM-Leave Ledger";
        [InDataSet]
        NoEditable: Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        EmployeeNoEditable: Boolean;
        [InDataSet]
        CampusCodeEditable: Boolean;
        [InDataSet]
        DepartmentCodeEditable: Boolean;
        [InDataSet]
        AppliedDaysEditable: Boolean;
        [InDataSet]
        StartingDateEditable: Boolean;
        [InDataSet]
        PurposeEditable: Boolean;
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        HREmp: Record "HRM-Employee (D)";
        RelNoEditable: Boolean;
        RelNameEditable: Boolean;
        EmpNameEditable: Boolean;
        LeaveTypeEditable: Boolean;
        JobCadre: Text[30];
        EditLeaveDays: Boolean;

    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Open then begin
            NoEditable := false;
            DateEditable := false;
            //EmployeeNoEditable:=FALSE;
            CampusCodeEditable := false;
            DepartmentCodeEditable := false;
            AppliedDaysEditable := false;
            StartingDateEditable := false;
            PurposeEditable := false;
            RelNoEditable := false;
            RelNameEditable := false;
            EmpNameEditable := false;
            LeaveTypeEditable := false;


            //  CurrForm."Process Leave Allowance".EDITABLE:=FALSE;
        end else begin
            NoEditable := false;
            DateEditable := true;
            //EmployeeNoEditable:=FALSE;
            CampusCodeEditable := false;
            DepartmentCodeEditable := true;
            AppliedDaysEditable := true;
            StartingDateEditable := true;
            PurposeEditable := true;
            RelNoEditable := true;
            RelNameEditable := false;
            EmpNameEditable := false;
            LeaveTypeEditable := true;
            // CurrForm."Process Leave Allowance".EDITABLE:=TRUE;

        end;
    end;
}


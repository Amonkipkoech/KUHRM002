page 85041 "HRM-LeavesRejected"
{
    CardPageID = "HRM-Leave Requisition";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "HRM-Leave Requisition";
    SourceTableView = WHERE(Status = FILTER(Cancelled));
    PromotedActionCategories = 'New,Action,Navigation,Process,Request Approval,Approval,Post,Report,Print/send';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = all;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                
                field("Applied Days"; Rec."Applied Days")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = all;
                }
                field("Campus Code"; Rec."Campus Code")
                {
                    Caption = 'Cost Center Code';
                    ApplicationArea = all;
                }
                field("Department Code"; Rec."Department Code")
                {
                    Caption = 'Region Code';
                    ApplicationArea = all;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = all;
                }
                field("Leave Balance"; Rec."Leave Balance")
                {
                    ApplicationArea = all;
                }
                field("Availlable Days"; Rec."Availlable Days")
                {
                    ApplicationArea = all;
                }
                field("Return Date"; Rec."Return Date")
                {
                    ApplicationArea = all;
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

                action(sendApproval)
                {
                    Caption = 'Send A&pproval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        ApprovalMangt: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin
                        ApprovalMangt.CheckLeaveApplicationApprovalPossible(Rec);
                        ApprovalMangt.OnSendLeaveApplicationForApproval(Rec);
                    end;
                }
                action(cancellsApproval)
            {
                Caption = 'Cancel Approval Request';
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
                action(Approvals)
                {
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    begin
                        DocumentType := DocumentType::"Leave Application";
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Leave Requisition", DocumentType, Rec."No.");
                        ApprovalEntries.Run;
                    end;
                }
                separator(Separator1000000003)
                {
                }
                action("Print/Preview")
                {
                    Caption = 'Print/Preview';
                    Image = PrintReport;
                    Promoted = true;
                    ApplicationArea = All;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        Rec.Reset;
                        Rec.SetFilter("No.", Rec."No.");
                        REPORT.Run(51720, true, true, Rec);
                        Rec.Reset;
                    end;
                }
                separator(Separator1000000001)
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
        PurposeEditable := true;
        "Starting DateEditable" := true;
        "Applied DaysEditable" := true;
        "Department CodeEditable" := true;
        "Campus CodeEditable" := true;
        "Employee NoEditable" := true;
        DateEditable := true;
        "No.Editable" := true;
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
        //Rec.SetFilter("User ID", UserId);
        UpdateControls;

    end;

    var
        UserMgt: Codeunit "User Setup Management";
        //todo ApprovalMgt: Codeunit "Approvals Management";
        ReqLine: Record "HMS-Setup Blood Group";
        InventorySetup: Record "Inventory Setup";
        GenJnline: Record "Item Journal Line";
        LineNo: Integer;
        Post: Boolean;
        //JournlPosted: Codeunit "Journal Post Successful";
        HasLines: Boolean;
        AllKeyFieldsEntered: Boolean;
        FixedAsset: Record "Fixed Asset";
        //MinorAssetsIssue: Record "HMS-Patient";
        LeaveEntry: Record "HRM-Leave Ledger";
        [InDataSet]
        "No.Editable": Boolean;
        [InDataSet]
        DateEditable: Boolean;
        [InDataSet]
        "Employee NoEditable": Boolean;
        [InDataSet]
        "Campus CodeEditable": Boolean;
        [InDataSet]
        "Department CodeEditable": Boolean;
        [InDataSet]
        "Applied DaysEditable": Boolean;
        [InDataSet]
        "Starting DateEditable": Boolean;
        [InDataSet]
        PurposeEditable: Boolean;
        ApprovalEntries: Page "Approval Entries";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,TransportRequest,Maintenance,Fuel,ImporterExporter,"Import Permit","Export Permit",TR,"Safari Notice","Student Applications","Water Research","Consultancy Requests","Consultancy Proposals","Meals Bookings","General Journal","Student Admissions","Staff Claim",KitchenStoreRequisition,"Leave Application";
        HREmp: Record "HRM-Employee (D)";

    procedure UpdateControls()
    begin
        if Rec.Status <> Rec.Status::Open then begin
            "No.Editable" := false;
            DateEditable := false;
            "Employee NoEditable" := false;
            "Campus CodeEditable" := false;
            "Department CodeEditable" := false;
            "Applied DaysEditable" := false;
            "Starting DateEditable" := false;
            PurposeEditable := false;
            //  CurrForm."Process Leave Allowance".EDITABLE:=FALSE;
        end else begin
            "No.Editable" := true;
            DateEditable := true;
            "Employee NoEditable" := true;
            "Campus CodeEditable" := true;
            "Department CodeEditable" := true;
            "Applied DaysEditable" := true;
            "Starting DateEditable" := true;
            PurposeEditable := true;
            // CurrForm."Process Leave Allowance".EDITABLE:=TRUE;

        end;
    end;
}


page 68982 "HRM-TNA Card"
{
    DeleteAllowed = true;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Functions,Show';
    SourceTable = "HRM-Training Needs Analysis";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Rec.Code)
                {
                    ApplicationArea = all;
                    Editable = "Application NoEditable";
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
                field("Training category"; Rec."Training category")
                {
                    ApplicationArea = all;
                }
                field("Quarter Offered"; Rec."Quarter Offered")
                {
                    ApplicationArea = all;
                    Editable = "Employee No.Editable";
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field(Directorate; Rec.Directorate)
                {
                    ApplicationArea = all;
                    Editable = "Employee DepartmentEditable";
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    ApplicationArea = all;
                }

                field(Department; Rec.Department)
                {
                    ApplicationArea = all;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = all;
                }
                field("Need Source"; Rec."Need Source")
                {
                    ApplicationArea = all;
                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Editable = "Course TitleEditable";
                }
                field("Course Version"; Rec."Course Version")
                {
                    ApplicationArea = all;
                }
                field("Course Version Description"; Rec."Course Version Description")
                {
                    ApplicationArea = all;
                }
                field("Individual Course"; Rec."Individual Course")
                {
                    ApplicationArea = all;
                    MultiLine = false;
                }
                field("Proposed Start Date"; Rec."Proposed Start Date")
                {
                    ApplicationArea = all;
                }
                field("Proposed End Date"; Rec."Proposed End Date")
                {
                    ApplicationArea = all;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = all;
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    ApplicationArea = all;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = all;
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ApplicationArea = all;
                }
                field("No of Participants"; Rec."No of Participants")
                {
                    ApplicationArea = all;
                }
                field("No of Required Participants"; Rec."No of Required Participants")
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Show")
            {
                Caption = '&Show';
                action(Comments)
                {
                    ApplicationArea = all;
                    Caption = 'Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs";
                    begin
                        DocumentType := DocumentType::"Training Needs";

                        //ApprovalComments.Setfilters(DATABASE::"HR Training Needs Analysis",DocumentType,Code);
                        //ApprovalComments.SetUpLine(DATABASE::"HR Training Needs Analysis",DocumentType,Code);
                        //ApprovalComments.RUN;
                    end;
                }
            }
            group("F&unctions")
            {
                Caption = 'F&unctions';
                action("Training Participants")
                {
                    ApplicationArea = all;
                    Caption = 'Training Participants';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HRM-Training Partcipants";
                    RunPageLink = "Training Code" = FIELD(Code);
                }
                action("Training Cost Elements")
                {
                    ApplicationArea = all;
                    Caption = 'Training Cost Elements';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HRM-Training Cost";
                    RunPageLink = "Training Id" = FIELD(Code);
                }
                action("&Approvals")
                {
                    ApplicationArea = all;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval","Induction Approval","Disciplinary Approvals","Activity Approval","Exit Approval","Medical Claim Approval",Jv,"BackToOffice ","Training Needs";
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::"Training Needs";
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Training Needs Analysis", DocumentType, Rec.Code);
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval &Request")
                {
                    ApplicationArea = all;
                    Caption = '&Send Approval &Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMangt: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin
                        ApprovalMangt.CheckTrainingNeedsApprovalPossible(rec);
                        ApprovalMangt.OnSendTrainingNeedsForApproval(Rec);
                    end;
                }
                action("&Cancel Approval request")
                {
                    ApplicationArea = all;
                    Caption = '&Cancel Approval request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    var
                        ApprovalMangt: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin
                        ApprovalMangt.OnCancelTrainingNeedsForApproval(Rec);
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);
                        HRTNA.SetRange(HRTNA.Code, Rec.Code);
                        if HRTNA.Find('-') then
                            REPORT.Run(39005484, true, true, HRTNA);
                    end;
                }
                action("<A ction1102755042>")
                {
                    ApplicationArea = all;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.Status := Rec.Status::New;
                        Rec.Modify;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Responsibility CenterEditable" := true;
            "Application NoEditable" := true;
            "Employee No.Editable" := true;
            "Employee NameEditable" := true;
            "Employee DepartmentEditable" := true;
            "Purpose of TrainingEditable" := true;
            "Course TitleEditable" := true;
        end else begin
            "Responsibility CenterEditable" := false;
            "Application NoEditable" := false;
            "Employee No.Editable" := false;
            "Employee NameEditable" := false;
            "Employee DepartmentEditable" := false;
            "Purpose of TrainingEditable" := false;
            "Course TitleEditable" := false;
        end;

        if Rec."Training category" = Rec."Training category"::Group then begin
            "Course TitleEditable" := true;
        end else begin
            "Course TitleEditable" := false;
        end;
    end;

    trigger OnInit()
    begin
        "Course TitleEditable" := true;
        "Purpose of TrainingEditable" := true;
        "Employee DepartmentEditable" := true;
        "Employee NameEditable" := true;
        "Employee No.Editable" := true;
        "Application NoEditable" := true;
        "Responsibility CenterEditable" := true;
        "Course DescriptionEditable" := true;
        "Course TitleEditable" := true;
    end;

    var
        HREmp: Record "HRM-Employee (D)";
        EmpNames: Text[40];
        sDate: Date;
        HRTNA: Record "HRM-Training Needs Analysis";
        //todo ApprovalMgt: Codeunit "Approvals Management";
        ApprovalComments: Page "Approval Comments";
        [InDataSet]
        "Responsibility CenterEditable": Boolean;
        [InDataSet]
        "Application NoEditable": Boolean;
        [InDataSet]
        "Employee No.Editable": Boolean;
        [InDataSet]
        "Employee NameEditable": Boolean;
        [InDataSet]
        "Employee DepartmentEditable": Boolean;
        [InDataSet]
        "Purpose of TrainingEditable": Boolean;
        [InDataSet]
        "Course TitleEditable": Boolean;
        "Course DescriptionEditable": Boolean;

    procedure TESTFIELDS()
    begin
        Rec.TestField(Description);
        Rec.TestField("Proposed Start Date");
        Rec.TestField("Proposed End Date");
        //TESTFIELD("Duration Units");
        Rec.TestField(Duration);
        Rec.TestField("Cost Of Training");
        Rec.TestField(Location);
        Rec.TestField("Course Version Description");
        //TESTFIELD("Individual Course");
        Rec.TestField("Need Source")
    end;

    procedure UpdateControls()
    begin

        /*IF "Training category"="Training category"::Group THEN BEGIN
        CurrPage.Description.EDITABLE:=TRUE;
        END ELSE BEGIN
        CurrPage.Description.EDITABLE:=FALSE;
        END;
   */

    end;
}


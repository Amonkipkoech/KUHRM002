page 68867 "HRM-Training Application List"
{
    CardPageID = "HRM-Training Application Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Action,Navigation,Training,Request Approval,Approvals,Print.Preview';

    SourceTable = "HRM-Training Applications";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;
                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = all;
                    Editable = "Application NoEditable";
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = all;
                }

                field(Directorate; Rec.Directorate)
                {
                    ApplicationArea = all;
                    Editable = "Employee DepartmentEditable";
                }
                field(Department; Rec.Department)
                {

                    ApplicationArea = all;
                }

                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = all;
                    Editable = "Course TitleEditable";
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Individual Course Code"; Rec."Individual Course Code")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Individual Course Description"; Rec."Individual Course Description")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("No of Required Participants"; Rec."No of Required Participants")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Purpose of Training"; Rec."Purpose of Training")
                {
                    visible = false;
                    ApplicationArea = all;
                    MultiLine = false;
                }
                field("From Date"; Rec."From Date")
                {
                    ApplicationArea = all;
                }
                field("To Date"; Rec."To Date")
                {
                    ApplicationArea = all;
                }
                field(Duration; Rec.Duration)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Duration Units"; Rec."Duration Units")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Sponsor; Rec.Sponsor)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Specify; Rec.Specify)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Location; Rec.Location)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(Country; Rec.Country)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field(County; Rec.County)
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Cost Of Training"; Rec."Cost Of Training")
                {
                    ApplicationArea = all;
                }
                field(Trainer; Rec.Trainer)
                {
                    ApplicationArea = all;
                }
                field("Training Institution"; Rec."Training Institution")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("No of Participants"; Rec."No of Participants")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Training Status"; Rec."Training Status")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
                field("Training Evaluation Results"; Rec."Training Evaluation Results")
                {
                    Visible = false;
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            part(Control1102755002; "HRM-Trainings Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Application No" = FIELD("Application No");
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
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Bank Slip",Grant,"Grant Surrender","Employee Requisition","Leave Application","Training Application","Transport Requisition";
                    begin
                        DocumentType := DocumentType::"Training Application";

                        //ApprovalComments.Setfilters(DATABASE::"HR Training Applications",DocumentType,"Application No");
                        //ApprovalComments.SetUpLine(DATABASE::"HR Training Applications",DocumentType,"Application No");
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
                    RunPageLink = "Training Code" = FIELD("Application No");
                }
                action("Training Cost Elements")
                {
                    ApplicationArea = all;
                    Caption = 'Training Cost Elements';
                    Image = CalculateCost;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "HRM-Training Cost";
                    RunPageLink = "Training Id" = FIELD("Application No");
                }
                action("&Approvals")
                {
                    ApplicationArea = all;
                    Caption = '&Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Category6;

                    trigger OnAction()
                    var
                        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,ImprestSurrender,Interbank,Receipt,"Staff Claim","Staff Advance",AdvanceSurrender,"Store Requisition","Employee Requisition","Leave Application","Transport Requisition","Training Requisition","Job Approval";
                        ApprovalEntries: Page "Approval Entries";
                    begin
                        DocumentType := DocumentType::"Training Requisition";
                        ApprovalEntries.Setfilters(DATABASE::"HRM-Training Applications", DocumentType, Rec."Application No");
                        ApprovalEntries.Run;
                    end;
                }
                action("&Send Approval &Request")
                {
                    ApplicationArea = all;
                    Caption = '&Send Approval &Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        approvalmgt: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin
                        approvalmgt.CheckTrainingApplicationApprovalPossible(Rec);
                        approvalmgt.OnSendTrainingApplicationForApproval(Rec);
                    end;

                }
                action("&Cancel Approval request")
                {
                    ApplicationArea = all;
                    Caption = '&Cancel Approval request';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Category5;

                    trigger OnAction()
                    var
                        approvalmgt: Codeunit "Approval Mgmnt. Ext(hr)";
                    begin
                        approvalmgt.OnSendTrainingApplicationForApproval(Rec);
                    end;
                }
                action("&Print")
                {
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = PrintForm;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Approved);

                        HRTrainingApplications.SetRange(HRTrainingApplications."Application No", Rec."Application No");
                        if HRTrainingApplications.Find('-') then
                            REPORT.Run(39005484, true, true, HRTrainingApplications);
                    end;
                }
                action("<A ction1102755042>")
                {
                    ApplicationArea = all;
                    Caption = 'Re-Open';
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Process;
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

    var
        HREmp: Record "HRM-Employee (D)";
        EmpNames: Text[40];
        sDate: Date;
        HRTrainingApplications: Record "HRM-Training Applications";
        //  ApprovalMgt: Codeunit "Approvals Management";
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
        Rec.TestField("Course Title");
        Rec.TestField("From Date");
        Rec.TestField("To Date");
        Rec.TestField("Duration Units");
        Rec.TestField(Duration);
        Rec.TestField("Cost Of Training");
        Rec.TestField(Location);
        Rec.TestField(Trainer);
        Rec.TestField("Purpose of Training");
        Rec.TestField(Description)
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


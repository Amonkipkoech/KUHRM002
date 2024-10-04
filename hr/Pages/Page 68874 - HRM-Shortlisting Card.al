page 68874 "HRM-Shortlisting Card"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'New,Process,Reports,Shortlist';
    SourceTable = "HRM-Employee Requisitions";
    //SourceTableView = WHERE(Status = CONST(Approved));


    layout
    {
        area(content)
        {
            group("Job Details")
            {
                Caption = 'Job Details';
                Editable = true;
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = all;
                    Editable = false;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = all;
                    Editable = "Requisition DateEditable";
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = all;
                    Editable = PriorityEditable;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Vacant Positions"; Rec."Vacant Positions")
                {
                    ApplicationArea = all;
                    Enabled = false;
                    Importance = Promoted;
                }
                field("Required Positions"; Rec."Required Positions")
                {
                    ApplicationArea = all;
                    Editable = "Required PositionsEditable";
                    Enabled = false;
                    Importance = Promoted;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Enabled = false;
                    Importance = Promoted;
                    Style = StrongAccent;
                    StyleExpr = TRUE;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = all;
                    Editable = true;
                    Enabled = true;
                }
            }
            part(Shortlisted; "HRM-Shortlisting Lines")
            {
                ApplicationArea = all;
                Editable = ShortlistedEditable;
                SubPageLink = "Employee Requisition No" = FIELD("Requisition No.");
            }
        }
        area(factboxes)
        {
            part(Control1102755003; "HRM-Jobs Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "Job ID" = FIELD("Job ID");
            }
            systempart(Control1102755001; Outlook)
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Applicants)
            {
                Caption = 'Applicants';
                action("&ShortList Applicants By Job Requirements")
                {
                    ApplicationArea = all;
                    Caption = '&ShortList Applicants By Job Requirements';
                    Image = SelectField;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = true;

                    trigger OnAction()
                    var
                        HRJobRequirements: Record "HRM-Job Requirements";
                        HRShortlistedApplicants: Record "HRM-Shortlisted Applicants";
                        HRJobApplications: Record "HRM-Job Applications (B)";
                        StageScore: Integer;
                        AppQualifications: Record "HRM-Applicant Qualifications";
                        RecCount: Integer;
                        MyCount: Integer;
                    begin
                        HRJobRequirements.RESET;
                        HRJobRequirements.SETRANGE(HRJobRequirements."Job Id", Rec."Job ID");
                        HRJobRequirements.SetRange(HRJobRequirements.Mandatory, true);
                        IF HRJobRequirements.COUNT = 0 THEN BEGIN
                            MESSAGE('Job Requirements for the job ' + Rec."Job ID" + ' have not been setup');
                            EXIT;
                        END ELSE BEGIN

                            //GET JOB REQUIREMENTS
                            HRJobRequirements.RESET;
                            HRJobRequirements.SETRANGE(HRJobRequirements."Job Id", Rec."Job ID");
                            HRJobRequirements.SetRange(HRJobRequirements.Mandatory, true);

                            //DELETE ALL RECORDS FROM THE SHORTLISTED APPLICANTS TABLE
                            HRShortlistedApplicants.RESET;
                            HRShortlistedApplicants.SETRANGE(HRShortlistedApplicants."Employee Requisition No", Rec."Requisition No.");
                            HRShortlistedApplicants.DELETEALL;

                            //GET JOB APPLICANTS
                            HRJobApplications.RESET;
                            HRJobApplications.SETRANGE(HRJobApplications."Employee Requisition No", Rec."Requisition No.");
                            IF HRJobApplications.FIND('-') THEN BEGIN
                                REPEAT
                                    //Rec.Qualified := TRUE;
                                    IF HRJobRequirements.FIND('-') THEN BEGIN
                                        //StageScore := 0;
                                        //Rec.Score := 0;
                                        REPEAT
                                            //GET THE APPLICANTS QUALIFICATIONS AND COMPARE THEM WITH THE JOB REQUIREMENTS
                                            AppQualifications.RESET;
                                            AppQualifications.SETRANGE(AppQualifications."Application No", HRJobApplications."Application No");
                                            AppQualifications.SETRANGE(AppQualifications."Qualification Code", HRJobRequirements."Qualification Code");
                                            IF AppQualifications.FIND('-') THEN BEGIN
                                                AppQualifications.meetQualification := true;
                                                //Rec.Score := Rec.Score + AppQualifications."Score ID";
                                                //IF AppQualifications."Score ID" < HRJobRequirements."Desired Score" THEN
                                                Rec.Qualified := true;
                                            END ELSE BEGIN
                                                Rec.Qualified := false;
                                            END;

                                        UNTIL HRJobRequirements.NEXT = 0;
                                    END;

                                    HRShortlistedApplicants."Employee Requisition No" := Rec."Requisition No.";
                                    HRShortlistedApplicants."Job Application No" := HRJobApplications."Application No";
                                    HRShortlistedApplicants."Stage Score" := Rec.Score;
                                    HRShortlistedApplicants.Qualified := Rec.Qualified;
                                    HRShortlistedApplicants."First Name" := HRJobApplications."First Name";
                                    HRShortlistedApplicants."Middle Name" := HRJobApplications."Middle Name";
                                    HRShortlistedApplicants."Last Name" := HRJobApplications."Last Name";
                                    HRShortlistedApplicants."ID No" := HRJobApplications."ID Number";
                                    HRShortlistedApplicants.Gender := HRJobApplications.Gender;
                                    HRShortlistedApplicants."Marital Status" := HRJobApplications."Marital Status";
                                    HRShortlistedApplicants.INSERT;

                                UNTIL HRJobApplications.NEXT = 0;
                            END;
                            //MARK QUALIFIED APPLICANTS AS QUALIFIED
                            HRShortlistedApplicants.SETRANGE(HRShortlistedApplicants.Qualified, TRUE);
                            IF HRShortlistedApplicants.FIND('-') THEN
                                REPEAT
                                    HRJobApplications.GET(HRShortlistedApplicants."Job Application No");
                                    HRJobApplications.Sifted := HRJobApplications.Sifted::shortlisted;
                                    HRJobApplications.Qualified := TRUE;
                                    HRJobApplications.MODIFY;
                                UNTIL HRShortlistedApplicants.NEXT = 0;
                            /* 
                            RecCount := 0;
                                MyCount := 0;
                                StageShortlist.RESET;
                                StageShortlist.SETRANGE(StageShortlist."Need Code", "Need Code");
                                StageShortlist.SETRANGE(StageShortlist."Stage Code", "Stage Code");

                                IF StageShortlist.FIND('-') THEN BEGIN
                                    RecCount := StageShortlist.COUNT;
                                    StageShortlist.SETCURRENTKEY(StageShortlist."Stage Score");
                                    StageShortlist.ASCENDING;
                                    REPEAT
                                        MyCount := MyCount + 1;
                                        StageShortlist.Position := RecCount - MyCount;
                                        StageShortlist.MODIFY;
                                    UNTIL StageShortlist.NEXT = 0;
                                END;
                             */
                            MESSAGE('%1', 'Shortlisting Competed Successfully.');

                        END;
                        //END ELSE
                        //MESSAGE('%1','You must select the stage you would like to shortlist.');

                    end;
                }
                action("&Print")
                {
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = PrintReport;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Category4;

                    trigger OnAction()
                    begin
                        HREmpReq.Reset;
                        HREmpReq.SetRange(HREmpReq."Requisition No.", Rec."Requisition No.");
                        if HREmpReq.Find('-') then
                            REPORT.Run(39005576, true, true, HREmpReq);
                    end;
                }
                action("&ShortList Applicants By Criteria")
                {
                    ApplicationArea = all;
                    Visible = false;
                    Caption = '&ShortList Applicants By Criteria';
                    Image = SelectField;
                    Promoted = true;
                    PromotedCategory = Category4;
                    //Visible = False;

                    trigger OnAction()
                    begin
                        "HRJobShortList Criteria".Reset;
                        "HRJobShortList Criteria".SetRange("HRJobShortList Criteria"."Job Id", Rec."Job ID");
                        if "HRJobShortList Criteria".Count = 0 then begin
                            Message('Job Requirements for the job ' + Rec."Job ID" + ' have not been setup');
                            exit;
                        end else begin

                            //GET JOB REQUIREMENTS
                            "HRJobShortList Criteria".Reset;
                            "HRJobShortList Criteria".SetRange("HRJobShortList Criteria"."Job Id", Rec."Job ID");

                            //DELETE ALL RECORDS FROM THE SHORTLISTED APPLICANTS TABLE
                            HRShortlistedApplicants.Reset;
                            HRShortlistedApplicants.SetRange(HRShortlistedApplicants."Employee Requisition No", Rec."Requisition No.");
                            HRShortlistedApplicants.DeleteAll;

                            //GET JOB APPLICANTS
                            HRJobApplications.Reset;
                            HRJobApplications.SetRange(HRJobApplications."Employee Requisition No", Rec."Requisition No.");
                            if HRJobApplications.Find('-') then begin
                                repeat
                                    Rec.Qualified := true;
                                    if HRJobRequirements.Find('-') then begin
                                        StageScore := 0;
                                        Rec.Score := 0;
                                        repeat
                                            //GET THE APPLICANTS QUALIFICATIONS AND COMPARE THEM WITH THE JOB REQUIREMENTS
                                            AppQualifications.Reset;
                                            AppQualifications.SetRange(AppQualifications."Application No", HRJobApplications."Application No");
                                            AppQualifications.SetRange(AppQualifications."Qualification Code", "HRJobShortList Criteria"."ShortList Code");
                                            if AppQualifications.Find('-') then begin
                                                Rec.Score := Rec.Score + AppQualifications."Score ID";
                                                if AppQualifications."Score ID" < "HRJobShortList Criteria"."Desired Score" then
                                                    Rec.Qualified := false;
                                            end else begin
                                                Rec.Qualified := false;
                                            end;

                                        until "HRJobShortList Criteria".Next = 0;
                                    end;

                                    HRShortlistedApplicants."Employee Requisition No" := Rec."Requisition No.";
                                    HRShortlistedApplicants."Job Application No" := HRJobApplications."Application No";
                                    HRShortlistedApplicants."Stage Score" := Rec.Score;
                                    HRShortlistedApplicants.Qualified := Rec.Qualified;
                                    HRShortlistedApplicants."First Name" := HRJobApplications."First Name";
                                    HRShortlistedApplicants."Middle Name" := HRJobApplications."Middle Name";
                                    HRShortlistedApplicants."Last Name" := HRJobApplications."Last Name";
                                    HRShortlistedApplicants."ID No" := HRJobApplications."ID Number";
                                    HRShortlistedApplicants.Gender := HRJobApplications.Gender;
                                    HRShortlistedApplicants."Marital Status" := HRJobApplications."Marital Status";
                                    HRShortlistedApplicants.Insert;

                                until HRJobApplications.Next = 0;
                            end;
                            //MARK QUALIFIED APPLICANTS AS QUALIFIED
                            HRShortlistedApplicants.SetRange(HRShortlistedApplicants.Qualified, true);
                            if HRShortlistedApplicants.Find('-') then
                                repeat
                                    HRJobApplications.Get(HRShortlistedApplicants."Job Application No");
                                    HRJobApplications.Qualified := true;
                                    HRJobApplications.Modify;
                                until HRShortlistedApplicants.Next = 0;
                            /*
                            RecCount:= 0;
                            MyCount:=0;
                            StageShortlist.RESET;
                            StageShortlist.SETRANGE(StageShortlist."Need Code","Need Code");
                            StageShortlist.SETRANGE(StageShortlist."Stage Code","Stage Code");

                            IF StageShortlist.FIND('-') THEN BEGIN
                            RecCount:=StageShortlist.COUNT ;
                            StageShortlist.SETCURRENTKEY(StageShortlist."Stage Score");
                            StageShortlist.ASCENDING;
                            REPEAT
                            MyCount:=MyCount + 1;
                            StageShortlist.Position:=RecCount - MyCount;
                            StageShortlist.MODIFY;
                            UNTIL StageShortlist.NEXT = 0;
                            END;
                            */
                            Message('%1', 'Shortlisting Competed Successfully.');

                        end;
                        //END ELSE
                        //MESSAGE('%1','You must select the stage you would like to shortlist.');

                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        //  OnAfterGetCurrRecord;
    end;

    trigger OnInit()
    begin
        "Required PositionsEditable" := true;
        PriorityEditable := true;
        ShortlistedEditable := true;
        "Requisition DateEditable" := true;
        "Job IDEditable" := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        // OnAfterGetCurrRecord;
    end;

    var
        HRJobRequirements: Record "HRM-Job Requirements";
        AppQualifications: Record "HRM-Applicant Qualifications";
        HRJobApplications: Record "HRM-Job Applications (B)";
        Qualified: Boolean;
        StageScore: Decimal;
        HRShortlistedApplicants: Record "HRM-Shortlisted Applicants";
        MyCount: Integer;
        RecCount: Integer;
        HREmpReq: Record "HRM-Employee Requisitions";
        [InDataSet]
        "Job IDEditable": Boolean;
        [InDataSet]
        "Requisition DateEditable": Boolean;
        [InDataSet]
        ShortlistedEditable: Boolean;
        [InDataSet]
        PriorityEditable: Boolean;
        [InDataSet]
        "Required PositionsEditable": Boolean;
        Text19057439: Label 'Short Listed Candidates';
        "HRJobShortList Criteria": Record "HRM-ShortList Requirements";
        "Applicant Criteria Score": Text;

    procedure UpdateControls()
    begin

        if Rec.Status = Rec.Status::New then begin
            "Job IDEditable" := true;
            "Requisition DateEditable" := true;
            ShortlistedEditable := true;
            PriorityEditable := true;
            "Required PositionsEditable" := true;
        end else begin
            "Job IDEditable" := false;
            "Requisition DateEditable" := false;
            ShortlistedEditable := false;
            PriorityEditable := false;
            "Required PositionsEditable" := false;

        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        xRec := Rec;

        UpdateControls;
    end;
}


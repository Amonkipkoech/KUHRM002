page 69097 "HRM-Emp. Categories"
{
    Caption = 'Employee Categories';
    DataCaptionFields = "Code";
    PageType = List;
    SourceTable = "HRM-Employee Categories";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                    Caption = 'Job Cadre Code';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                    Caption = 'Job Cadre';
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(SalGrades)
            {
                ApplicationArea = all;
                Caption = 'Salary Grades';
                Image = StepInto;
                Promoted = true;
                RunObject = Page "HRM-Job_Salary Grade/Steps";
                RunPageLink = "Employee Category" = FIELD(Code);
            }
        }
        area(processing)
        {
            group(Functions)
            {
                Caption = 'Increament';
                action("Increament")
                {
                    ApplicationArea = all;
                    //Caption = 'Increament Register';
                    Image = Registered;
                    Promoted = true;
                    trigger OnAction()
                    begin
                        IncreamentSalary();
                    end;
                }
                action("Increament Register")
                {
                    ApplicationArea = all;
                    Caption = 'Increament Register';
                    Image = Registered;
                    Promoted = true;
                    RunObject = Page "HRM-Salary Increament Register";
                }
                action("Un-Affected Employees")
                {
                    ApplicationArea = all;
                    Caption = 'Un-Affected Employees';
                    Image = History;
                    Promoted = true;
                    RunObject = Page "HRM-Unaffected Sal. Increament";
                }
                separator(History)
                {
                    Caption = 'History';
                }
                action(PostIncreament)
                {
                    ApplicationArea = all;
                    Caption = 'Post Salary Increaments';
                    Image = PostDocument;
                    Promoted = true;

                    trigger OnAction()
                    begin

                        Message('Please go through the Increment register \and ensure that the increments are right before posting.');
                        if Confirm('Are you sure you want to post salary increments?', false) = false then exit;
                        //postReverse.postRegister();
                    end;
                }
                action(ReverseIncreament)
                {
                    ApplicationArea = all;
                    Caption = 'Reverse Salary Increments';
                    Image = ReverseRegister;
                    Promoted = true;

                    trigger OnAction()
                    begin

                        if Confirm('Reverse salary Increment postings?', false) = false then exit;
                        //postReverse.ReverseInrementPosting();
                    end;
                }
                separator(Setup)
                {
                    Caption = 'Setup';
                }
                action("Salary Grade Setup")
                {
                    Caption = 'Salary Grade Setup';
                    Image = SetupList;
                    Promoted = true;
                    ApplicationArea = All;
                    //   RunObject = Page "HRM-Salary Grades List";
                }
            }
        }
        area(reporting)
        {
            action(Register)
            {
                Caption = 'Register';
                Image = Register;
                Promoted = true;
                ApplicationArea = All;
                // RunObject = Report "HRM-Salary Increament Register";
            }
        }
    }

    var
        salGrades: Record "HRM-Job_Salary grade/steps";
        salGrades2: Record "HRM-Job_Salary grade/steps";
        salincregister: Record "HRM-Salary Increament Register";
        salincUnaffected: Record "HRM-UnAffected Sal. Increament";
        employees: Record "HRM-Employee (D)";
        salaryCate: Record "HRM-Employee Categories";
        EmplMonth: Integer;
        salaStepsAmount: Record "HRM-Auto Inreament Sal. Steps";
        salaStepsAmount2: Record "HRM-Auto Inreament Sal. Steps";
        empSalaryCard: Record "PRL-Salary Card";
        unaffectedEmployees: Record "HRM-UnAffected Sal. Increament";
        salbasic: Decimal;
        salgrade: Code[20];
        salcat: Code[50];
        empcat: Record "HRM-Employee Categories";
        basic: Record "HRM-Auto Inreament Sal. Steps";
    // empgrade: Record "HRM-Job Sal. grade/steps";
    //postReverse: Codeunit "Post Salary Increments";
    procedure IncreamentSalary()
    begin
        basic.Reset();
        basic.SetRange("Employee Category", Rec.Code);
        if basic.Find('-') then begin
            repeat
                basic."Basic Salary" := basic."Basic Salary" + basic."Basic Salary" * 0.1;
                basic.Modify();
            until basic.Next() = 0;
        end;

    end;
}


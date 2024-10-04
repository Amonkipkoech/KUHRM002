page 50021 "Trainning Needs Application"
{
    Caption = 'Trainning Needs Application';
    PageType = Card;
    SourceTable = "hrmTrainningNeeds.al";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(payrollNo; Rec.payrollNo)
                {
                    ApplicationArea = All;
                }
                field(employeeName; Rec.employeeName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the employeeName field.';
                }
                field(department; Rec.department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the department field.';
                }
                field(designation; Rec.designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the designation field.';
                }

                field(jobGrade; Rec.jobGrade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the jobGrade field.';
                }
            }
            group("Training Programs")
            {
                part(pg; "HRM-Trainning Programs")
                {
                    SubPageLink = PayrollNo = field(payrollNo);
                    ApplicationArea = All;
                }
            }
            group("Academic Qualifications")
            {
                part("Employee Qualifications"; "HRM-Emp. Qualifications (B)")
                {
                    ApplicationArea = all;
                    Caption = 'Academic Qualifications';
                    SubPageLink = "Employee No." = field(payrollNo);

                }
            }
            group("Workshops Attended")
            {
                part(pg2; "WorkShop Seminars Attended")
                {
                    ApplicationArea = all;
                    SubPageLink = payrollNo = field(payrollNo);


                }
            }

        }
    }
}

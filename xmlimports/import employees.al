xmlport 50021 "Employee Upload"
{
    Caption = 'employee upload';

    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF16;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(employee; "HRM-Employee (D)")
            {


                fieldelement(No; employee."Branch Name")
                {
                }
                fieldelement(FirstName; employee."Last Name")
                {
                }
                fieldelement(MiddleName; employee."Middle Name")
                {
                }
                fieldelement(LastName; employee."First Name")
                {
                }
                fieldelement(empCategory; employee."Employee Category")
                {
                }
                fieldelement(Gender; employee.Gender)
                {
                }
                fieldelement(DateofAppointment; employee."PIN Number")
                {
                }
                fieldelement(PostingGroup; employee."NSSF No.")
                {
                }
                fieldelement(NHIFNo; employee."NHIF No.")
                {
                }
                fieldelement(IDNumber; employee."ID Number")
                {
                }
                fieldelement(MainBank; employee."Main Bank")
                {
                }
                fieldelement(BranchBank; employee."Branch Bank")
                {
                }
                fieldelement(BankAccountNumber; employee."Bank Account Number")
                {
                }
                fieldelement(PaymentMode; employee."Payment Mode")
                {
                }
                fieldelement(DateOfJoin; employee."Date Of Join")
                {
                }
                fieldelement(DateOfBirth; employee."Date Of Birth")
                {
                }
                fieldelement(DepartmentCode; employee."Department Code")
                {
                }
                fieldelement(JobTitle; employee."Job Title")
                {
                }
                fieldelement(SalaryCategory; employee."Salary Category")
                {
                }
                fieldelement(SalaryGrade; employee."Salary Grade")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ContractStartDate; employee."Contract Start Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ContractEndDate; employee."Contract End Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(BasicSalary; employee."Basic Salary")
                {
                }
                fieldelement(HouseAllowance; employee."House Allowance")
                {
                }



            }
        }
    }



    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    trigger OnInitXmlPort()
    begin
        I := 0;
    end;

    var
        I: Integer;
}


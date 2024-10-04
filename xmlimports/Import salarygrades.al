xmlport 50020 "Salary Grades"
{
    Caption = 'Import salary Grades';

    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF16;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(employee; "PRL-Employee Transactions")
            {

                fieldelement(No; employee."Employee Code")
                {
                }
                fieldelement(firts; employee."Transaction Code")
                {
                }

                fieldelement(middle; employee."Payroll Period")
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


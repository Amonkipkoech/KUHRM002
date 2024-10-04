xmlport 50041 "Basic Salary"
{
    Caption = 'Import Basic Salary';

    Direction = Both;

    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF16;
    UseRequestPage = true;

    schema
    {
        textelement(Root)
        {
            tableelement(employee; "PRL-Salary Card")
            {
                AutoUpdate = true;

                fieldelement(No; employee."Employee Code")
                {
                }
                fieldelement(firts; employee."Basic Pay")
                {
                }
                fieldelement(pperiod; employee."Payroll Period")
                {

                }
                fieldelement(PaysNSSF; employee."Pays NSSF")
                {
                }
                fieldelement(PaysPAYE; employee."Pays PAYE")
                {
                }
                fieldelement(PaysPension; employee."Pays Pension")
                {
                }
                fieldelement(paysnhif; employee."Pays NHIF")
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


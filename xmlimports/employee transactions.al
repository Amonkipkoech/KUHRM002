xmlport 50022 "Employee Transactions"
{
    Caption = 'upload employee transactions';

    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF16;
    UseRequestPage = false;


    schema
    {
        textelement(Root)
        {
            tableelement(Item; "PRL-Employee Transactions")
            {
                AutoUpdate = true;
                XmlName = 'ImportED';
                fieldelement(a; Item."Employee Code")
                {
                }
                fieldelement(b; Item."Transaction Code")
                {
                }

                fieldelement(e; Item.Amount)
                {
                }
                fieldelement(f; Item.Balance)
                {
                }
                fieldelement(fc; item."No of Units")
                {

                }
                fieldelement(g; Item."Payroll Period")
                {
                }

                fieldelement(h; Item."Period Month")
                {
                }
                fieldelement(i; Item."Period Year")
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


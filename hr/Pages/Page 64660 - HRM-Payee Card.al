page 64660 "HRM-Payee Card"
{
    PageType = Card;
    SourceTable = 77797;

    layout
    {
        area(content)
        {
            group("General Information")
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Employee Terms Of Service"; Rec."Employee Terms Of Service")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
            }
            group("Contact Information")
            {
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
            }
            group("Payment Information")
            {
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = All;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = All;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = All;
                }
                field("Main Bank"; Rec."Main Bank")
                {
                    ApplicationArea = All;
                }
                field("Branch Bank"; Rec."Branch Bank")
                {
                    ApplicationArea = All;
                }
                field("Branch Bank Name"; Rec."Branch Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Main Bank Name"; Rec."Main Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    NotBlank = true;
                    ApplicationArea = All;
                }
            }
            group("Credential Manager")
            {
                part(Page; 50081)
                {
                    SubPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Update Payee Memo")
            {
                Image = User;
                Promoted = true;
                PromotedCategory = Category4;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Customer: Record 18;
                begin
                    IF CONFIRM('Update Employee', TRUE) = FALSE THEN BEGIN
                        ERROR('Operation Cancelled');
                        EXIT;
                    END;

                    Customer.RESET;
                    Customer.SETFILTER("No.", '%1', Rec."No.");


                    IF Customer.FINDFIRST THEN BEGIN
                        MESSAGE('Already Updated');
                        EXIT;
                    END;

                    IF NOT Customer.FINDFIRST THEN BEGIN

                        Customer.INIT;
                        Customer."No." := Rec."No.";
                        Customer.Name := Rec."First Name" + ' ' + Rec."Last Name";
                        Customer."Customer Posting Group" := 'IMPREST';
                        Customer."Phone No." := Rec."Cellular Phone Number";
                        Customer."Gen. Bus. Posting Group" := 'LOCAL';
                        Customer."E-Mail" := Rec."E-Mail";
                        Rec.VALIDATE("No.");
                        Customer.INSERT(TRUE);
                        MESSAGE('Updated Successfully');
                    END;
                end;
            }
        }
    }
}


page 68326 "HRM-Employee (C)"
{
    PageType = Card;
    SourceTable = "HRM-Employee (D)";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = all;
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = all;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = all;
                }
                field("Changed Password"; Rec."Changed Password")
                {
                    ApplicationArea = all;
                    Editable = true;
                }
                field(Initials; Rec.Initials)
                {
                    ApplicationArea = all;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = all;
                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = all;
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = all;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = all;
                }
                field(DateOfBirth; Rec.DateOfBirth)
                {
                    ApplicationArea = all;
                }
                field("Date Of Join"; Rec."Date Of Join")
                {
                    ApplicationArea = all;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = all;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = all;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = all;
                }
            }
            group(Contacts)
            {
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = all;
                }
                field("Residential Address"; Rec."Residential Address")
                {
                    ApplicationArea = all;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = all;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = all;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = all;
                }
                field("Home Phone Number"; Rec."Home Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Cellular Phone Number"; Rec."Cellular Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Work Phone Number"; Rec."Work Phone Number")
                {
                    ApplicationArea = all;
                }
                field("Ext."; Rec."Ext.")
                {
                    ApplicationArea = all;
                }
                field("Fax Number"; Rec."Fax Number")
                {
                    ApplicationArea = all;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = all;
                }
                field("Company E-Mail"; Rec."Company E-Mail")
                {
                    ApplicationArea = all;
                }
            }
            group("Job Information")
            {
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = all;
                }
                field("Job Specification"; Rec."Job Specification")
                {
                    ApplicationArea = all;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = all;
                }
                field("Full / Part Time"; Rec."Full / Part Time")
                {
                    ApplicationArea = all;
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = all;
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = all;
                }
                field("Notice Period"; Rec."Notice Period")
                {
                    ApplicationArea = all;
                }
                field("Name Of Manager"; Rec."Name Of Manager")
                {
                    ApplicationArea = all;
                }
            }
            group("Payment Information")
            {
                field("Union Code"; Rec."Union Code")
                {
                    ApplicationArea = all;
                }
                field("UIF Number"; Rec."UIF Number")
                {
                    ApplicationArea = all;
                }
                field("PAYE Number"; Rec."PAYE Number")
                {
                    ApplicationArea = all;
                }
                field("UIF Contributor?"; Rec."UIF Contributor?")
                {
                    ApplicationArea = all;
                }
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = all;
                }
                field("NSSF No."; Rec."NSSF No.")
                {
                    ApplicationArea = all;
                }
                field("NHIF No."; Rec."NHIF No.")
                {
                    ApplicationArea = all;
                }
            }
            group(Separation)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field("Termination Category"; Rec."Termination Category")
                {
                    ApplicationArea = all;
                }
                field("Served Notice Period"; Rec."Served Notice Period")
                {
                    ApplicationArea = all;
                }
                field("Exit Interview Date"; Rec."Exit Interview Date")
                {
                    ApplicationArea = all;
                }
                field("Exit Interview Done by"; Rec."Exit Interview Done by")
                {
                    ApplicationArea = all;
                }
                field("Allow Re-Employment In Future"; Rec."Allow Re-Employment In Future")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}


report 51829 "Employee Details Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './hr/Reports/SSR/EmployeeDetailsSummary.rdl';

    dataset
    {
        dataitem(DataItem1000000001; 61188)
        {
            RequestFilterFields = "No.";
            column(logo; info.Picture)
            {
            }
            column(CoName; info.Name)
            {
            }
            column(CoAddress; info.Address)
            {
            }
            column(CoCity; info.City)
            {
            }
            column(CoPhone; info."Phone No.")
            {
            }
            column(CoEmail; info."E-Mail")
            {
            }
            column(HomePage; info."Home Page")
            {
            }
            column(Pf_No; "No.")
            {
            }
            column(Title; Title)
            {
            }
            column(FName; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(EmpTelephone; "Cellular Phone Number")
            {
            }
            column(Status; Status)
            {
            }
            column(IdNo; "ID Number")
            {
            }
            column(Gender; Gender)
            {
            }
            column(Tribe; Tribe)
            {
            }
            column(Disabled; Disabled)
            {
            }
            column(DOB; "Date Of Birth")
            {
            }
            column(DOJ; "Date Of Join")
            {
            }
            column(EmpAge; Age)
            {
            }
            column(LOS; "Length Of Service")
            {
            }
            column(Telephone; "Home Phone Number")
            {
            }
            column(Cell; "Cellular Phone Number")
            {
            }
            column(Extension; "Ext.")
            {
            }
            column(Address; "Postal Address")
            {
            }
            column(Email; "E-Mail")
            {
            }
            column(EMail2; "Company E-Mail")
            {
            }
            column(Department; "Department Code")
            {
            }
            column(Section; "Section Code")
            {
            }
            column(PIN; "PIN Number")
            {
            }
            column(NSSF; "NSSF No.")
            {
            }
            column(NHIF; "NHIF No.")
            {
            }
            column(HELB; "HELB No")
            {
            }
            column(CooperateNo; "Co-Operative No")
            {
            }
            column(PayrollNo; "PAYROLL NO")
            {
            }
            dataitem(NxtOfKin; 61323)
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER("Next of Kin"));
                PrintOnlyIfDetail = false;
                column(shownextofkin; shownextofkin)
                {
                }
                column(KinRelationship; NxtOfKin.Relationship)
                {
                }
                column(KinSurName; NxtOfKin.SurName)
                {
                }
                column(KinOtherNames; NxtOfKin."Other Names")
                {
                }
                column(KinId; NxtOfKin."ID No/Passport No")
                {
                }
                column(KinPhone; NxtOfKin."Home Tel No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    shownextofkin := TRUE;
                    IF NxtOfKin.Relationship = '' THEN shownextofkin := FALSE;
                end;
            }
            dataitem(Beneficiaries; 61324)
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(showBeneficiery; showBeneficiery)
                {
                }
                column(BenRelationship; Beneficiaries.Relationship)
                {
                }
                column(BenSurname; Beneficiaries.SurName)
                {
                }
                column(BenOtherNames; Beneficiaries."Other Names")
                {
                }
                column(BenID; Beneficiaries."ID No/Passport No")
                {
                }
                column(BenPhone; Beneficiaries."Home Tel No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    showBeneficiery := TRUE;
                    IF Beneficiaries.Relationship = '' THEN showBeneficiery := FALSE;
                end;
            }
            dataitem(Dependants; 61323)
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                DataItemTableView = WHERE(Type = FILTER(Dependant));
                column(showDependants; showDependants)
                {
                }
                column(DependantsRela; Dependants.Relationship)
                {
                }
                column(DependantsSurname; Dependants.SurName)
                {
                }
                column(DependantsOtherNames; Dependants."Other Names")
                {
                }
                column(DependantsID; Dependants."ID No/Passport No")
                {
                }
                column(DependantsPhone; Dependants."Home Tel No")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    showDependants := TRUE;
                    IF Dependants.Relationship = '' THEN showDependants := FALSE;
                end;
            }
            dataitem(EmpQualifications; "Employee Qualification")
            {
                DataItemLink = "Employee No." = FIELD("No.");
                column(showQualif; showQualif)
                {
                }
                column(qualific; EmpQualifications."Qualification Code")
                {
                }
                column(QualType; EmpQualifications.Type)
                {
                }
                column(QualFrom; EmpQualifications."From Date")
                {
                }
                column(QualTo; EmpQualifications."To Date")
                {
                }
                column(QualInst; EmpQualifications."Institution/Company")
                {
                }
                column(QualDesc; Description)
                {

                }

                trigger OnAfterGetRecord()
                begin
                    showQualif := TRUE;
                    IF EmpQualifications.Description = '' THEN showQualif := FALSE;
                end;
            }
            dataitem(EmploymentHistory; 61214)
            {
                DataItemLink = "Employee No." = FIELD("No.");
                column(showEmployHist; showEmployHist)
                {
                }
                column(EmpHistCompany; EmploymentHistory."Company Name")
                {
                }
                column(EmpHistFrom; EmploymentHistory.From)
                {
                }
                column(EmpHistTo; EmploymentHistory."To Date")
                {
                }
                column(EmpHistTitle; EmploymentHistory."Job Title")
                {
                }
                column(EmpHistSalary; EmploymentHistory."Salary On Leaving")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    showEmployHist := TRUE;
                    IF EmploymentHistory."Company Name" = '' THEN showEmployHist := FALSE;
                end;
            }
            dataitem(ProfMembership; "HRM-Proffessional Membership")
            {
                DataItemLink = "Employee Code" = FIELD("No.");
                column(showProfMemberShip; showProfMemberShip)
                {
                }
                column(MembershipNo; ProfMembership."Membership No")
                {
                }
                column(MembershipNameOfBody; ProfMembership."Name of Body")
                {
                }
                column(MembershipDate; ProfMembership."Date of Membership")
                {
                }
                column(MembershipStatus; ProfMembership."Membership Status")
                {
                }
                column(MembershipRemarks; ProfMembership.Remarks)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    showProfMemberShip := TRUE;
                    IF ProfMembership."Membership No" = '' THEN showProfMemberShip := FALSE;
                end;
            }
            dataitem(TrainingHistory; 61216)
            {
                DataItemLink = "Employee No." = FIELD("No.");
                column(showTrainHist; showTrainHist)
                {
                }
                column(TrainAppcationNo; TrainingHistory."Application No")
                {
                }
                column(TrainCourseTitle; TrainingHistory."Course Title")
                {
                }
                column(TrainFromDate; TrainingHistory."From Date")
                {
                }
                column(TrainToDate; TrainingHistory."To Date")
                {
                }
                column(TrainingDuration; TrainingHistory.Duration)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    showTrainHist := TRUE;
                    IF TrainingHistory."Application No" = '' THEN showTrainHist := FALSE;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                seq := seq + 1;
            end;
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

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF info.GET() THEN BEGIN
            info.CALCFIELDS(info.Picture);
        END;
    end;

    var
        info: Record 79;
        seq: Integer;
        shownextofkin: Boolean;
        showBeneficiery: Boolean;
        showDependants: Boolean;
        showQualif: Boolean;
        showEmployHist: Boolean;
        showProfMemberShip: Boolean;
        showTrainHist: Boolean;
}


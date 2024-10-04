xmlport 50042 "Import TimeSheet"
{
    Caption = 'Import Time Sheet';

    Direction = Both;
    Format = VariableText;
    FormatEvaluate = Legacy;
    TextEncoding = UTF16;
    UseRequestPage = false;

    schema
    {
        textelement(Root)
        {
            tableelement(employee; "HRM-Time Register")
            {


                AutoUpdate = true;


                fieldelement(RegistrationType; employee."Registration Type")
                {
                }
                fieldelement(AbsenceType; employee."Absence Type")
                {
                }
                fieldelement(EmployeeNo; employee."Employee No.")
                {
                }
                fieldelement(ShiftCode; employee."Shift Code")
                {
                }
                fieldelement(FromDate; employee."From Date")
                {
                    FieldValidate = Yes;
                }
                fieldelement(DayType; employee."Day Type")
                {
                }
                fieldelement(TimeClockedIn; employee."Time Clocked In")
                {
                }
                fieldelement(FromTime; employee."From Time")
                {
                }
                fieldelement(TimeClockedOut; employee."Time Clocked Out")
                {
                }
                fieldelement(ToTime; employee."To Time")
                {
                }
                fieldelement(ChargeDate; employee."Charge Date")
                {
                }
                fieldelement(Description; employee.Description)
                {
                }
                fieldelement(Quantity; employee.Quantity)
                {
                }
                fieldelement(PendingOff; employee."Pending Off")
                {
                }
                fieldelement(UnitofMeasureCode; employee."Unit of Measure Code")
                {
                }
                fieldelement(DayHour; employee."Day/Hour")
                {
                }
                fieldelement(ApprovalStatus; employee."Approval Status")
                {
                }
                fieldelement(DeptCode; employee."Dept Code")
                {
                }
                fieldelement(CropCode; employee."Crop Code")
                {
                }
                fieldelement(ReasonCode; employee."Reason Code")
                {
                }
                fieldelement(ProductionCost; employee."Production Cost")
                {
                }
                fieldelement(CreatedBy; employee."Created By")
                {
                }
                fieldelement(DateTimeCreated; employee."Date/Time Created")
                {
                }
                fieldelement(LastModifiedBy; employee."Last Modified By")
                {
                }
                fieldelement(DateTimeLastModified; employee."Date/Time Last Modified")
                {
                }
                fieldelement(ApprovedBy; employee."Approved By")
                {
                }
                fieldelement(DateTimeApproved; employee."Date/Time Approved")
                {
                }
                fieldelement(OpenedBy; employee."Opened By")
                {
                }
                fieldelement(DateTimeOpened; employee."Date/Time Opened")
                {
                }
                fieldelement(OverTime; employee."Over Time")
                {
                }
                fieldelement(LostTime; employee."Lost Time")
                {
                }
                fieldelement(Comment; employee.Comment)
                {
                }
                fieldelement(PeriodYear; employee."Period Year")
                {
                }
                fieldelement(PeriodMonth; employee."Period Month")
                {
                }
                fieldelement(PaymentPeriod; employee."Payment Period")
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


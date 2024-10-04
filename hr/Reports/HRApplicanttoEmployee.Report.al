report 51177 "HR Applicant to Employee"
{
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem(DataItem3952; "HRM-Job Applications (B)")
        {
            RequestFilterFields = "Application No", Qualified;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(CurrReport_PAGENO; CurrReport.PAGENO)
#pragma warning restore AL0667
            {
            }
            column(USERID; USERID)
            {
            }
            column(HR_Job_Applications__Application_No_; "Application No")
            {
            }
            column(HR_Job_Applications__FullName; "HRM-Job Applications (B)".FullName)
            {
            }
            column(HR_Job_Applications__Postal_Address_; "Postal Address")
            {
            }
            column(HR_Job_Applications_City; City)
            {
            }
            column(HR_Job_Applications__Post_Code_; "Post Code")
            {
            }
            column(HR_Job_ApplicationsCaption; HR_Job_ApplicationsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(HR_Job_Applications__Application_No_Caption; FIELDCAPTION("Application No"))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(HR_Job_Applications__Postal_Address_Caption; FIELDCAPTION("Postal Address"))
            {
            }
            column(HR_Job_Applications_CityCaption; FIELDCAPTION(City))
            {
            }
            column(HR_Job_Applications__Post_Code_Caption; FIELDCAPTION("Post Code"))
            {
            }

            trigger OnPostDataItem()
            begin


                IF "HRM-Job Applications (B)".FIND('-') THEN BEGIN
                    HREmp.Reset();
                    HREmp.SetRange("Job Application No", "Application No");
                     if HREmp.Find('-') then
                         Error('Employee exist');
                    if Qualified = false then
                        Error('The employee did qualify for upload');

                    IF CONFIRM('Are you sure you want to upload qualified applicants information to the Employee card?', TRUE) = FALSE THEN EXIT;
                    BEGIN

                        //    REPEAT

                        IF "Employee No" = '' THEN
                            HRSetup.GET();
                        HRSetup.TESTFIELD("Employee Nos.");

                        NoSeriesMgt.InitSeries(HRSetup."Employee Nos.", "HRM-Job Applications (B)"."No. Series", 0D, "Employee No", "No. Series");


                        HREmp.INIT;
                        HREmp."No." := "Employee No";


                        HREmp."First Name" := "First Name";
                        HREmp."Middle Name" := "Middle Name";
                        HREmp."Last Name" := "Last Name";
                        HREmp."Search Name" := "Search Name";
                        HREmp."Postal Address" := "Postal Address";
                        HREmp."Residential Address" := "Residential Address";
                        HREmp.City := City;
                        HREmp."Post Code" := "Post Code";
                        HREmp.County := County;
                        HREmp."Home Phone Number" := "Home Phone Number";
                        HREmp."Cellular Phone Number" := "Cell Phone Number";
                        HREmp."Work Phone Number" := "Work Phone Number";
                        HREmp."Ext." := "Ext.";
                        HREmp."E-Mail" := "E-Mail";
                        HREmp."ID Number" := "ID Number";
                        HREmp.Gender := Gender;
                        HREmp.Citizenship := "Country Code";
                        HREmp."Fax Number" := "Fax Number";
                        HREmp."Marital Status" := "Marital Status";
                        HREmp."Ethnic Origin" := "Ethnic Origin";
                        HREmp."First Language (R/W/S)" := "First Language (R/W/S)";
                        //HREmp."Has Driving Licence":=HREmp."Has Driving Licence"::"Driving Licence";
                        HREmp.Disabled := Disabled;
                        //HREmp."Health Assesment?:="Health Assesment?";
                        HREmp."Health Assesment Date" := "Health Assesment Date";
                        HREmp."Date Of Birth" := "Date Of Birth";
                        HREmp.Age := Age;
                        HREmp."Second Language (R/W/S)" := "Second Language (R/W/S)";
                        HREmp."Additional Language" := "Additional Language";
                        HREmp."Postal Address2" := "Postal Address2";
                        HREmp."Postal Address3" := "Postal Address3";
                        HREmp."Residential Address2" := "Residential Address2";
                        HREmp."Residential Address3" := "Residential Address3";
                        HREmp."Post Code2" := "Post Code2";
                        HREmp.Citizenship := Citizenship;
                        HREmp."Passport Number" := "Passport Number";
                        HREmp."First Language Read" := "First Language Read";
                        HREmp."First Language Write" := "First Language Write";
                        HREmp."First Language Speak" := "First Language Speak";
                        HREmp."Second Language Read" := "Second Language Read";
                        HREmp."Second Language Write" := "Second Language Write";
                        HREmp."Second Language Speak" := "Second Language Speak";
                        HREmp."PIN Number" := "PIN Number";
                        HREmp."Job Application No" := "Application No";
                        /*"HRM-Job Applications (B)".MODIFY; */
                        HREmp.INSERT;
                        // UNTIL "HRM-Job Applications (B)".NEXT = 0;
                        MESSAGE('Applicants Information succesfully uploaded.');
                    END;
                end;
            end;


            // IF "HRM-Job Applications (B)".FIND('-') THEN BEGIN
            //     /* HREmp.Reset();
            //     HREmp.SetRange("Job Application No", "Application No");
            //     if HREmp.Find('-') then
            //         Error('Employee exist'); */

            //     IF CONFIRM('Are you sure you want to upload qualified applicants information to the Employee card?', TRUE) = FALSE THEN EXIT;
            //     BEGIN

            //         REPEAT

            //             IF "Employee No" = '' THEN
            //                 HRSetup.GET();
            //             HRSetup.TESTFIELD("Employee Nos.");
            //             NoSeriesMgt.InitSeries(HRSetup."Employee Nos.", "HRM-Job Applications (B)"."No. Series", 0D, "Employee No", "No. Series");
            //             HREmp.INIT;
            //             //HREmp."No." := "HRM-Job Applications (B)"."Employee No";
            //             HREmp."No." := "Employee No";
            //             HREmp."First Name" := "First Name";
            //             HREmp."Middle Name" := "Middle Name";
            //             HREmp."Last Name" := "Last Name";
            //             HREmp."Search Name" := "Search Name";
            //             HREmp."Postal Address" := "Postal Address";
            //             HREmp."Residential Address" := "Residential Address";
            //             HREmp.City := City;
            //             HREmp."Post Code" := "Post Code";
            //             HREmp.County := County;
            //             HREmp."Home Phone Number" := "Home Phone Number";
            //             HREmp."Cellular Phone Number" := "Cell Phone Number";
            //             HREmp."Work Phone Number" := "Work Phone Number";
            //             HREmp."Ext." := "Ext.";
            //             HREmp."E-Mail" := "E-Mail";
            //             HREmp."ID Number" := "ID Number";
            //             HREmp.Gender := Gender;
            //             HREmp.Citizenship := "Country Code";
            //             HREmp."Fax Number" := "Fax Number";
            //             HREmp."Marital Status" := "Marital Status";
            //             HREmp."Ethnic Origin" := "Ethnic Origin";
            //             HREmp."First Language (R/W/S)" := "First Language (R/W/S)";
            //             //HREmp."Has Driving Licence":=HREmp."Has Driving Licence"::"Driving Licence";
            //             HREmp.Disabled := Disabled;
            //             //HREmp."Health Assesment?:="Health Assesment?";
            //             HREmp."Health Assesment Date" := "Health Assesment Date";
            //             HREmp."Date Of Birth" := "Date Of Birth";
            //             HREmp.Age := Age;
            //             HREmp."Second Language (R/W/S)" := "Second Language (R/W/S)";
            //             HREmp."Additional Language" := "Additional Language";
            //             HREmp."Postal Address2" := "Postal Address2";
            //             HREmp."Postal Address3" := "Postal Address3";
            //             HREmp."Residential Address2" := "Residential Address2";
            //             HREmp."Residential Address3" := "Residential Address3";
            //             HREmp."Post Code2" := "Post Code2";
            //             HREmp.Citizenship := Citizenship;
            //             HREmp."Passport Number" := "Passport Number";
            //             HREmp."First Language Read" := "First Language Read";
            //             HREmp."First Language Write" := "First Language Write";
            //             HREmp."First Language Speak" := "First Language Speak";
            //             HREmp."Second Language Read" := "Second Language Read";
            //             HREmp."Second Language Write" := "Second Language Write";
            //             HREmp."Second Language Speak" := "Second Language Speak";
            //             HREmp."PIN Number" := "PIN Number";
            //             HREmp."Job Application No" := "Application No";
            //             "HRM-Job Applications (B)".MODIFY;
            //             HREmp.INSERT;
            //         UNTIL "HRM-Job Applications (B)".NEXT = 0;
            //         MESSAGE('Applicants Information succesfully uploaded.');
            //     END;

            // END ELSE BEGIN
            //     MESSAGE('No qualified applicants were found');

            // end;

            //end;

            trigger OnPreDataItem()
            begin
                IF JopAppNo = '' THEN BEGIN
                    //UPLOAD ALL QUALIFIED APPLICANTS WHO HAVE NOT ALREADY BEEN EMPLOYED
                    "HRM-Job Applications (B)".RESET;
                    "HRM-Job Applications (B)".SETRANGE("HRM-Job Applications (B)".Qualified, TRUE);
                    //"HR Job Applications".SETRANGE("HR Job Applications"."Employee No",'<>%1','');

                END ELSE BEGIN
                    //UPLOAD THE SELECTED APPLICANT
                    "HRM-Job Applications (B)".RESET;
                    "HRM-Job Applications (B)".SETRANGE("HRM-Job Applications (B)"."Application No", JopAppNo);
                END;
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

    trigger OnPreReport()
    begin
        JopAppNo := "HRM-Job Applications (B)".GETFILTER("HRM-Job Applications (B)"."Application No");
    end;

    var
        HREmp: Record 61188;
        HRSetup: Record 61675;
        NoSeriesMgt: Codeunit 396;
        JopAppNo: Code[10];
        HR_Job_ApplicationsCaptionLbl: Label 'HR Job Applications';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        "HRM-Job Applications (B)": Record "HRM-Job Applications (B)";
}


table 61794 "HRM-Salary Steps Mnt"
{

    fields
    {
        field(1; "Increament Month"; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(2; "Employment Month From"; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(3; "Employment Month To"; Option)
        {
            OptionCaption = ' ,January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = " ",January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(4; "Employee Category"; Code[50])
        {
        }
    }

    keys
    {
        key(Key1; "Employee Category", "Increament Month")
        {
        }
    }

    fieldgroups
    {
    }
}


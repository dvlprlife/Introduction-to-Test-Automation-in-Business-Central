codeunit 80000 "TIG TestApp Event Unit"
{
    Subtype = Test;

    var
        Assert: Codeunit Assert;
        LibraryRandom: Codeunit "Library - Random";
        LibrarySales: Codeunit "Library - Sales";
        LibraryERM: Codeunit "Library - ERM";
        TestAppLibrary: Codeunit "TIG TestApp Library";
        FieldValueErr: label '%1 must be %2.', Comment = '%1 Field Caption %2 Field Value';
        DoneMsg: Label 'This is done.';

    [Test]
    procedure ModifyCustomer()
    var
        Customer: Record Customer;
    begin
        // [SCENARIO] A validated customer is modified
        // [GIVEN] Validation is enabled
        // [GIVEN] Validated customer exits
        TestAppLibrary.EnableValidation(true, false, false);

        LibrarySales.CreateCustomerWithAddress(Customer);

        TestAppLibrary.ValidateCustomer(Customer);

        Assert.IsTrue(Customer."TIG Validated", StrSubstNo(FieldValueErr, Customer.FieldCaption("TIG Validated"), true));

        // [WHEN] Customer is modified
        Customer.Validate(Address, LibraryRandom.RandText(MaxStrLen(Customer.Address)));

        // [THEN] Customer is not validated
        Assert.Equal(Customer."TIG Validated", false);
    end;

    [Test]
    procedure ModifySalesHeader()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        CustomerNo: Code[20];
    begin
        // [SCENARIO] A validated sales header is modified
        // [GIVEN] Validation is enabled
        // [GIVEN] Validated sales header exists
        TestAppLibrary.EnableValidation(true, false, false);

        LibrarySales.CreateCustomerWithAddress(Customer);
        CustomerNo := Customer."No.";

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, CustomerNo);

        TestAppLibrary.ValidateSalesHeader(SalesHeader);

        Assert.IsTrue(SalesHeader."TIG Validated", StrSubstNo(FieldValueErr, SalesHeader.FieldCaption("TIG Validated"), true));

        // [WHEN] Sales header is modified
        SalesHeader.Validate("Sell-to Address", LibraryRandom.RandText(MaxStrLen(SalesHeader."Sell-to Address")));

        // [THEN] Sales header is not validated
        Assert.IsFalse(SalesHeader."TIG Validated", StrSubstNo(FieldValueErr, SalesHeader.FieldCaption("TIG Validated"), false));
    end;

    [Test]
    procedure ReleaseSalesHeaderAddress_NotRequired()
    var
        SalesHeader: Record "Sales Header";

    begin
        // [SCENARIO] User releases sales order that is not validated and validation on release is enabled
        // [GIVEN] Validation is enabled and required on release
        // [GIVEN] Sales order exists and is not validated
        TestAppLibrary.EnableValidation(true, false, false);

        LibrarySales.CreateSalesOrder(SalesHeader);
        SalesHeader.Modify();

        Assert.IsFalse(SalesHeader."TIG Validated", StrSubstNo(FieldValueErr, SalesHeader.FieldCaption("TIG Validated"), false));

        // [WHEN] Sales Header released
        TestAppLibrary.ReleaseSalesDocumentCheckSkip(SalesHeader, false, true);

        // [THEN] Sales Header is relesed
        Assert.Equal(SalesHeader.Status, "Sales Document Status"::Released);
    end;

    [Test]
    procedure ReleaseSalesHeaderAddress_Required()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        CustomerNo: Code[20];
        GLAccNo: Code[20];

    begin
        // [SCENARIO] User releases sales order that is not validated and validation on release is enabled
        // [GIVEN] Validation is enabled and required on release
        // [GIVEN] Sales order exists and is not validated
        TestAppLibrary.EnableValidation(true, true, true);

        LibrarySales.CreateCustomerWithAddress(Customer);
        CustomerNo := Customer."No.";

        GLAccNo := LibraryERM.CreateGLAccountWithSalesSetup();

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, CustomerNo);
        SalesHeader.Modify();

        LibrarySales.CreateSalesLine(SalesLine, SalesHeader, "Sales Line Type"::"G/L Account", GLAccNo, LibraryRandom.RandInt(5));
        SalesLine.Modify();

        Assert.IsFalse(SalesHeader."TIG Validated", StrSubstNo(FieldValueErr, SalesHeader.FieldCaption("TIG Validated"), false));

        // [WHEN] Sales Header released
        TestAppLibrary.ReleaseSalesDocumentCheckSkip(SalesHeader, false, true);

        // [THEN] Sales Header is not relesed
        Assert.Equal(SalesHeader.Status, "Sales Document Status"::Open);
    end;

    [Test]
    procedure ValidateCustomer()
    var
        Customer: Record Customer;
    begin
        // [SCENARIO] A customer is validated
        // [GIVEN] Validation is enabled
        // [GIVEN] Customer exists
        TestAppLibrary.EnableValidation(true, false, false);

        LibrarySales.CreateCustomerWithAddress(Customer);

        Assert.IsFalse(Customer."TIG Validated", StrSubstNo(FieldValueErr, Customer.FieldCaption("TIG Validated"), false));

        // [WHEN] Customer is validated
        TestAppLibrary.ValidateCustomer(Customer);
        Customer.Modify();

        // [THEN] Customer is validated
        Assert.IsTrue(Customer."TIG Validated", StrSubstNo(FieldValueErr, Customer.FieldCaption("TIG Validated"), true));
    end;

    [Test]
    procedure ValidatedCustomerSalesOrderCreated()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        CustomerNo: Code[20];
    begin
        // [SCENARIO] A validated customer exists and a sales order is created
        // [GIVEN] Validation is enabled
        // [GIVEN] Validated customer exists
        TestAppLibrary.EnableValidation(true, false, false);

        LibrarySales.CreateCustomerWithAddress(Customer);

        TestAppLibrary.ValidateCustomer(Customer);

        CustomerNo := Customer."No.";
        Customer.Modify();

        Assert.IsTrue(Customer."TIG Validated", StrSubstNo(FieldValueErr, Customer.FieldCaption("TIG Validated"), true));

        // [WHEN] Sales header is created for the validated customer
        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, CustomerNo);

        // [THEN] Sales header is validated
        Assert.IsTrue(SalesHeader."TIG Validated", StrSubstNo(FieldValueErr, SalesHeader.FieldCaption("TIG Validated"), true));

    end;

    [Test]
    procedure ValidateSalesHeader()
    var
        Customer: Record Customer;
        SalesHeader: Record "Sales Header";
        CustomerNo: Code[20];
    begin
        // [SCENARIO] A sales header is validated
        // [GIVEN] Validation is enabled
        // [GIVEN] Sales header exists
        TestAppLibrary.EnableValidation(true, false, false);

        LibrarySales.CreateCustomerWithAddress(Customer);
        CustomerNo := Customer."No.";

        LibrarySales.CreateSalesHeader(SalesHeader, "Sales Document Type"::Order, CustomerNo);

        Assert.IsFalse(SalesHeader."TIG Validated", StrSubstNo(FieldValueErr, SalesHeader.FieldCaption("TIG Validated"), false));

        // [WHEN] Sales header is validated
        TestAppLibrary.ValidateSalesHeader(SalesHeader);

        // [THEN] Sales header is validated
        Assert.IsTrue(SalesHeader."TIG Validated", StrSubstNo(FieldValueErr, SalesHeader.FieldCaption("TIG Validated"), true));
    end;

    [Test]
    [HandlerFunctions('MessageHandler,ConfirmHandler')]
    procedure HandlerMethod()
    begin
        // [SCENARIO] Demonstrate handler methonds
        // [GIVEN] Handlers assigned
        // [WHEN] Test performance with confirm and messaege
        TestAppLibrary.ConfirmHandler();
        // [THEN] No Assert
    end;

    [ConfirmHandler]
    procedure ConfirmHandler(Question: Text[1024]; var Reply: Boolean);
    begin
        Reply := true;
    end;

    [MessageHandler]
    procedure MessageHandler(Message: Text[1024])
    begin
        Assert.IsTrue(StrPos(Message, DoneMsg) > 0, Message);
    end;
}
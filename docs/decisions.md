# artist_name
Name = NULL
Decision: Replace NULL with "Unknown"
Reason: Every song has its own artist; rename as unknown if not artist name is not identified.`
Consequence: Any exact-match filter or join on Name should account for "Unknown" as a real value — don't treat it as a missing/null artist, and don't assume all "Unknown" rows refer to the same actual artist.

# customer_id
CustomerId = NULL
Decision: Drop
Reason: CustomerId is the primary key. Without it, we cannot reliably connect the customer to invoices or sales.
Consequence: Any invoice referencing a dropped CustomerId will fail to join in Silver/Gold; verify no valid invoices are lost.

# phone/fax
Phone / Fax = Inconsistent formatting
Decision: Remove special characters and spaces
Reason: Standardize contact number format across all records.
Consequence: Downstream matching/lookup on phone numbers should use the cleaned format only, not the raw source format.

# employee
EmployeeId = NULL
Decision: Drop
Reason: Primary key — required to identify the employee record.
Consequence: Any table referencing a dropped EmployeeId will fail to join.

# genreid
GenreId = NULL
Decision: Drop
Reason: Primary key — required to identify the genre.
Consequence: Tracks referencing a dropped GenreId will show as ungenred

# invoiceid
InvoiceId = NULL
Decision: Drop
Reason: Primary key is required to identify the transaction.
Consequence: No invoice lines can be reliably tied to a dropped InvoiceId; verify none are orphaned.

# invoice total
Total = Inconsistent decimal places
Decision: Round to 2 decimal places
Reason: Maintain consistency and present readable float values.
Consequence: Any pre-rounding totals used elsewhere should be recalculated from InvoiceLine, not compared directly to this rounded value.

# invoicelineid
InvoiceLineId = NULL
Decision: Drop
Reason: Primary key — required to identify the line item.
Consequence: None; these rows carry no reliable transaction detail.

# invoiceline unit price
UnitPrice = Inconsistent decimal places
Decision: Round to 2 decimal places
Reason: Maintain consistency and present readable float values.
Consequence: Same as Invoice.Total 

# invoiceline quantity
Quantity = Zero, negative, or NULL
Decision: Drop
Reason: No valid transaction exists for these rows.
Consequence: Revenue totals will be lower than raw source data.



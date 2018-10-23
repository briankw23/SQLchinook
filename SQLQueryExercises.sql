-- non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

select FirstName + ' ' + LastName, CustomerId, Country

 from Customer

 Where Country != 'USA'

 -- brazil_customers.sql: Provide a query only showing the Customers from Brazil.

 select * from Customer
 where Country = 'Brazil'

 -- brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil.
 -- The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

 select FirstName + ' ' + LastName, InvoiceId, InvoiceDate
	from Customer
	inner join Invoice on Customer.CustomerId = Invoice.CustomerId
 where Country = 'Brazil'

 --sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

 Select * From Employee
 Where Title = 'Sales Support Agent'

 -- unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries
 
 -- from the Invoice table.

 select distinct BillingCountry from Invoice

 -- sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. 
 -- The resultant table should include the Sales Agent's full name.

 Select EmployeeName = Employee.FirstName + ' ' + Employee.LastName, CustomerName = Customer.FirstName + ' ' + Customer.LastName,
 InvoiceId
 from  Customer
 join Invoice on Customer.CustomerId = Invoice.InvoiceId
 join Employee on Customer.SupportRepId = Employee.EmployeeId

 -- invoice_totals.sql: Provide a query that shows
 -- the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

 Select Invoice.Total, CustomerName = Customer.FirstName + ' ' + Customer.LastName,
 Invoice.BillingCountry, EmployeeName = Employee.FirstName + ' ' + Employee.LastName
 from Invoice
 Join Customer on Invoice.CustomerId = Customer.CustomerId
 join Employee on Customer.SupportRepId = Employee.EmployeeId

 -- total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?

 select COUNT(Invoice.InvoiceId) 
 from Invoice
 where YEAR(InvoiceDate) = 2009
 OR Year(InvoiceDate) = 2011

 -- total_sales_{year}.sql: What are the respective total sales for each of those years?

 select Year(InvoiceDate), SUM(Total) 
 from Invoice
 group by Year(InvoiceDate)

 --invoice_37_line_item_count.sql: 
 -- Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

 select count(InvoiceLineId) from InvoiceLine where InvoiceId = 37

 -- line_items_per_invoice.sql: Looking at the InvoiceLine table,
 -- provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

  select invoiceid, NumberofLines = count(InvoiceLineId) from InvoiceLine group by InvoiceId

  -- line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

  select InvoiceLine.TrackId, Track.Name from InvoiceLine
  join Track on InvoiceLine.TrackId = Track.TrackId

  -- line_item_track_artist.sql: Provide a query that includes the purchased track name AND
  -- artist name with each invoice line item.

  select InvoiceLine.TrackId, Track.Name, Artist.Name  from InvoiceLine
  join Track on InvoiceLine.TrackId = Track.TrackId
  join Album on Track.AlbumId = Album.AlbumId
  join Artist on Album.ArtistId = Artist.ArtistId

  -- country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY

  select BillingCountry, count(BillingCountry) from Invoice group by BillingCountry

  -- playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist.
  -- The Playlist name should be include on the resulant table.

  select Playlist.Name, NumberOfSongs = count(PlaylistTrack.PlaylistId) from Playlist
  join PlaylistTrack on Playlist.PlaylistId = PlaylistTrack.PlaylistId
  group by Playlist.Name

 -- tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs.
 -- The result should include the Album name, Media type and Genre.

 select TrackName = Track.Name, AblumTitle = Album.Title,MediaTypeName = MediaType.Name, GenreName = Genre.Name from Track
 join Album on Track.AlbumId = Album.AlbumId
 join MediaType on Track.MediaTypeId = MediaType.MediaTypeId
 join Genre on Track.GenreId = Genre.GenreId


 -- invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

select Invoice.InvoiceId, Invoice.InvoiceDate, Invoice.Total, LineItems = count(InvoiceLine.InvoiceLineId)
from InvoiceLine
join Invoice on InvoiceLine.InvoiceId = Invoice.InvoiceId
group by Invoice.InvoiceId, Invoice.InvoiceId, Invoice.InvoiceDate, Invoice.Total

-- sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.
select EmployeeName = Employee.FirstName + ' ' + Employee.LastName, TotalSales = sum(Invoice.Total) from Employee
right join Customer on Employee.EmployeeId = Customer.SupportRepId
Right Join Invoice on Customer.CustomerId = Invoice.InvoiceId
group by Employee.FirstName + ' ' + Employee.LastName


--top_2009_agent.sql: Which sales agent made the most in sales in 2009?

select EmployeeName = Employee.FirstName + ' ' + Employee.LastName, TotalSales = sum(Invoice.Total), SalesYear = YEAR(Invoice.InvoiceDate)
from Employee
right join Customer on Employee.EmployeeId = Customer.SupportRepId
right Join Invoice on Customer.CustomerId = Invoice.InvoiceId
where year(Invoice.InvoiceDate) = 2009
group by Employee.FirstName + ' ' + Employee.LastName, InvoiceDate

-- Which sales agent made the most in sales over all?

select EmployeeName = Employee.FirstName + ' ' + Employee.LastName, TotalSalesCount = count(Invoice.Total) from Employee
right join Customer on Employee.EmployeeId = Customer.SupportRepId
Right Join Invoice on Customer.CustomerId = Invoice.InvoiceId
group by Employee.FirstName + ' ' + Employee.LastName

-- Provide a query that shows the count of customers assigned to each sales agent.
select EmployeeName = Employee.FirstName + ' ' + Employee.LastName, sum(Customer.CustomerId)from Employee
right join Customer on Employee.EmployeeId = Customer.SupportRepId
Right Join Invoice on Customer.CustomerId = Invoice.InvoiceId
group by Employee.FirstName + ' ' + Employee.LastName

-- sales_per_country.sql: Provide a query that shows the total sales per country.

select Invoice.BillingCountry, TotalSales = sum(Invoice.Total)from invoice
group by Invoice.BillingCountry

-- top_country.sql: Which country's customers spent the most?

select Customer.Country, TotalSales = sum(Invoice.Total) from Customer
join Invoice on Customer.CustomerId = Invoice.InvoiceId
group by Customer.Country


--top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

select Track.Name, InvoiceLine.TrackId, Quantity = Sum(InvoiceLine.Quantity), InvoiceYear = Year(Invoice.InvoiceDate)  from InvoiceLine
join Track on InvoiceLine.TrackId = Track.TrackId
join Invoice on InvoiceLine.InvoiceId = Invoice.InvoiceId
where Year(Invoice.InvoiceDate) = 2013
group by Track.Name, InvoiceLine.TrackId, Invoice.InvoiceDate
order by Quantity desc 

-- top_3_artists.sql: Provide a query that shows the top 3 best selling artists.

select count(*) from artist

select Track.Name, Artist.Name from Customer
left join Invoice on Customer.CustomerId = Invoice.InvoiceId
join InvoiceLine on Invoice.InvoiceId = InvoiceLine.InvoiceId
join Track on InvoiceLine.TrackId = Track.TrackId
join Album on Track.TrackId = Album.AlbumId
Join Artist on Album.ArtistId = Artist.ArtistId
group by Track.Name, Artist.Name



USE NIKHIL_ANALYTICS1

--Creating Table employeeID
Create table employee(
Empid int Primary key,
Salary Float,
ManagerId int)

Insert into employee
Select '1','10000',Null
Union Select '2','8000','1'
Union Select '3','12000','1'
Union Select '4','5000','2'
Union Select '5','7000','2'
Union Select '6','10000','5'
Union Select '7','3000','5'

Select *
from employee

--1.Extract those employeeID where employee salary is greater than manager salary
Select E1.Empid as Employee_id, E2.Empid as Mgr_id,E1.Salary as Emp_sal, E2.Salary as Mgr_sal
From Employee As E1
Inner Join Employee As E2
On E1.Managerid = E2.Empid
Where E1.Salary>E2.Salary

--2.Select Customers who have done net positive shopping in the last 2 years starting from today.
--year starting from today

Create Table Customer_new(
CUSTID Int,
Sales Int,
Date Date)

Alter Table Customer_new
ALter Column CUSTID Varchar(10) Not null

Alter Table Customer_new
Alter Column SALES Float


INSERT INTO Customer_new
Select '1011', '1000','12-22-2018'
Union Select '1012', '1011','05-16-2018'
Union Select '1033', '1081','01-11-2018'
Union Select '1043', '1056','09-25-2017'
Union Select '1087', '11111','09-28-2016'
Union Select '10I9', '1789','10-08-2015'
Union Select '11I6', '1590','06-17-2017'
Union Select '1043', '1056','09-25-2017'
Union Select '1011', '-11111','12-22-2018'
Union Select '1012', '1011','05-16-2018'
Union Select '1033', '1081','01-11-2018'
Union Select '1043', '-11056','09-25-2017'
Union Select '1087', '11111','09-28-2016'
Union Select '10I9', '1789','10-08-2015'
Union Select '11I6', '1590','06-17-2017'

Select *
From Customer_new

Select CUSTID
From Customer_new
Where (DATEDIFF(YEAR,DATE,'01-01-2019'))<=2
Group by CUSTID
Having SUM(SALES)>0

--To get other columns along with CUSTID
--For that we will use Derived Table concept

SELECT S.CUSTID, SALES, DATE, Total_Sales
From (Select CUSTID, SUM(SALES) As Total_Sales
FROM Customer_new
Group by Custid) As S
inner join Customer_new AS C
ON S.CUSTID=C.CUSTID
Where (DATEDIFF(YEAR,DATE,'01-01-2019'))<=2 AND Total_Sales>0

--3. Append CUST_INFO_TABLE1 and CUST_INFO_TABLE2 TO FORM CUSTINFO TABLE
--We will use the concept of the vertical joins-Union all

Create table CUST_INFO_TABLE1(
CUSTID Varchar(10),
City Varchar(30),
ADDRESS Varchar(20))

Insert INTO CUST_INFO_TABLE1
Select '1011','BANGALORE','MARATHALLI'
Union Select '1012','MUMBAI','           BANDRA'
Union Select '1033','CHENNAI','ADYAR'
Union Select '1043','KOLKATA','JADAVPUR'
Union Select '1087','BUBNESHWAR','ASHOK NAGAR'
Union Select '10I9','BANGALORE','VIJAYNAGAR'
Union Select '11I6','MUMBAI','ALTAMOUNT ROAD'

Select *
From CUST_INFO_TABLE1
Create Table CUST_INFO_TABLE2(
CUSTID Varchar(10),
CITY Varchar(30),
ADDRESS Varchar(30))

Insert INTO CUST_INFO_TABLE2
Select '1043','CHENNAI','BESANT NAGAR'
Union Select '1011','KOLKATA','PARK STREET'
Union Select '1012','BUBNESHWAR','BAPUJI NAGAR'
Union Select '1033','HYDERABAD','JUBLIEE HILLS'
Union Select '1043','THIRUVANANTHAPURAM','VARKALA'
Union Select '1087','CHENNAI','ANNA NAGAR'
Union Select '10I9','BANGALORE','MALLESHWARAM'
Union Select '11I6','DELHI','VASANT KUNJ'

Select *
From CUST_INFO_TABLE2

Select *
INTO CUSTINFO
FROM CUST_INFO_TABLE1
UNION ALL
SELECT * From CUST_INFO_TABLE2

Select *
from CUSTINFO

--4. Select customerid, address fields along with city who have done shopping in last one year starting from today. 
Select *
from CUSTINFO

Select *
From Customer_new

--METHOD-1
Select C.CUSTID as CID,ADDRESS,CITY
From Customer_new AS C
Inner Join CUSTINFO As Cn
ON C.CUSTID = Cn.CUSTID 
where SALES>0 AND (DATEDIFF(YEAR, DATE, '01-01-2019'))<=1

--METHOD-2
SELECT C.CUSTID as CID,City,Address
From(
Select Custid,City,Address
From CUST_INFO_TABLE1
UNION ALL
Select Custid,CITY, Address
From CUST_INFO_TABLE2) As A
Inner Join Customer_new As C
ON C.CUSTID=A.CUSTID
where SALES>0 AND (DATEDIFF(YEAR, DATE, '01-01-2019'))<=1

--5. Create 3 groups with 5 customers in each group with decreasing order of sales

with group_1 as
(
SELECT *,RANK() over(Order by sales desc) as Rank
from Customer_new
)
Select *
from group_1
where rank<=5

with group_2 as
(
SELECT *,RANK() over(Order by sales desc) as Rank
from Customer_new
)
Select *
from group_2
where rank between 6 and 10

with group_3 as
(
SELECT *,RANK() over(Order by sales desc) as Rank
from Customer_new
)
Select *
from group_3
where rank between 11 and 15



Create table Country(
State Varchar(30),
City Varchar(50),
Population Varchar(10))


Insert Into Country
Select 'ANDHRA PRADESH','Greater Hyderabad (M Corp.)','6809970'
Union Select 'ANDHRA PRADESH','GVMC (MC)','1730320'
Union Select 'ANDHRA PRADESH','Vijayawada (M Corp.)','1048240'
Union Select 'ANDHRA PRADESH','Guntur (M Corp.)','651382'
Union Select 'ANDHRA PRADESH','Warangal (M Corp.)','620116'
Union Select 'ANDHRA PRADESH','Nellore (M Corp.)','505258'
Union Select 'ANDHRA PRADESH','Kurnool (M Corp.)','424920'
Union Select 'ANDHRA PRADESH','Rajahmundry (M Corp.)','343903'
Union Select 'ANDHRA PRADESH','Kadapa (M Corp.)','341823'
Union Select 'ANDHRA PRADESH','Kakinada (M Corp.)','312255'
Union Select 'ANDHRA PRADESH','Nizamabad (M Corp.)','310467'
Union Select 'ANDHRA PRADESH','Tirupati (M Corp.)','287035'
Union Select 'ANDHRA PRADESH','Anantapur (M Corp.)','262340'
Union Select 'ANDHRA PRADESH','Karimnagar (M Corp.)','260899'
Union Select 'ANDHRA PRADESH','Ramagundam (M)','229632'
Union Select 'ANDHRA PRADESH','Vizianagaram (M)','227533'
Union Select 'ANDHRA PRADESH','Eluru (M Corp.)','214414'
Union Select 'ANDHRA PRADESH','Secunderabad (CB)','213698'
Union Select 'ANDHRA PRADESH','Ongole (M)','202826'
Union Select 'ANDHRA PRADESH','Nandyal (M)','200746'
Union Select 'ANDHRA PRADESH','Khammam (M)','184252'
Union Select 'ANDHRA PRADESH','Machilipatnam (M)','170008'
Union Select 'ANDHRA PRADESH','Adoni (M)','166537'
Union Select 'ANDHRA PRADESH','Tenali (M)','164649'
Union Select 'ANDHRA PRADESH','Proddatur (M)','162816'
Union Select 'ANDHRA PRADESH','Mahbubnagar (M)','157902'
Union Select 'ANDHRA PRADESH','Chittoor (M)','153766'
Union Select 'ANDHRA PRADESH','Hindupur (M)','151835'
Union Select 'ANDHRA PRADESH','Bhimavaram (M)','142280'
Union Select 'ANDHRA PRADESH','Madanapalle (M)','135669'
Union Select 'ANDHRA PRADESH','Nalgonda (M)','135163'
Union Select 'ANDHRA PRADESH','Guntakal (M)','126479'
Union Select 'ANDHRA PRADESH','Srikakulam (M)','126003'
Union Select 'ANDHRA PRADESH','Dharmavaram (M)','121992'
Union Select 'ANDHRA PRADESH','Gudivada (M)','118289'
Union Select 'ANDHRA PRADESH','Adilabad (M)','117388'
Union Select 'ANDHRA PRADESH','Narasaraopet (M)','116329'
Union Select 'ANDHRA PRADESH','Tadpatri (M)','108249'
Union Select 'ANDHRA PRADESH','Suryapet (M)','105250'
Union Select 'ANDHRA PRADESH','Miryalaguda (M)','103855'
Union Select 'ANDHRA PRADESH','Tadepalligudem (M)','103577'
Union Select 'ANDHRA PRADESH','Chilakaluripet (M)','101550'
Union Select 'BIHAR','Patna (M Corp.)','1683200'
Union Select 'BIHAR','Gaya (M Corp.)','463454'
Union Select 'BIHAR','Bhagalpur (M Corp.)','398138'
Union Select 'BIHAR','Muzaffarpur (M Corp.)','351838'
Union Select 'BIHAR','Biharsharif (M Corp.)','296889'
Union Select 'BIHAR','Darbhanga (M Corp.)','294116'
Union Select 'BIHAR','Purnia (M Corp.)','280547'
Union Select 'BIHAR','Arrah (M Corp.)','261099'
Union Select 'BIHAR','Begusarai (M Corp.)','251136'
Union Select 'BIHAR','Katihar (M Corp.)','225982'
Union Select 'BIHAR','Munger (M Corp.)','213101'
Union Select 'BIHAR','Chapra (NP)','201597'
Union Select 'BIHAR','Dinapur Nizamat (NP)','182241'
Union Select 'BIHAR','Saharsa (NP)','155175'
Union Select 'BIHAR','Sasaram (NP)','147396'
Union Select 'BIHAR','Hajipur (NP)','147126'
Union Select 'BIHAR','Dehri (NP)','137068'
Union Select 'BIHAR','Siwan (NP)','134458'
Union Select 'BIHAR','Bettiah (NP)','132896'
Union Select 'BIHAR','Motihari (NP)','125183'
Union Select 'BIHAR','Bagaha (NP)','113012'
Union Select 'BIHAR','Kishanganj (NP)','107076'
Union Select 'BIHAR','Jamalpur (NP)','105221'
Union Select 'BIHAR','Buxar (NP)','102591'
Union Select 'BIHAR','Jehanabad (NP)','102456'
Union Select 'BIHAR','Aurangabad (NP)','101520'
Union Select 'GUJARAT','Ahmadabad (M Corp.)','5570585'
Union Select 'GUJARAT','Surat (M Corp.)','4462002'
Union Select 'GUJARAT','Vadodara (M Corp.)','1666703'
Union Select 'GUJARAT','Rajkot (M. Corp)','1286995'
Union Select 'GUJARAT','Bhavnagar (M Corp.)','593768'
Union Select 'GUJARAT','Jamnagar (M Corp.)','529308'
Union Select 'GUJARAT','Junagadh (M Corp.)','320250'
Union Select 'GUJARAT','Gandhidham (M)','248705'
Union Select 'GUJARAT','Nadiad (M)','218150'
Union Select 'GUJARAT','Gandhinagar (NA)','208299'
Union Select 'GUJARAT','Anand (M)','197351'
Union Select 'GUJARAT','Morvi (M)','188278'
Union Select 'GUJARAT','Mahesana (M)','184133'
Union Select 'GUJARAT','Surendranagar Dudhrej (M)','177827'
Union Select 'GUJARAT','Bharuch (M)','168729'
Union Select 'GUJARAT','Navsari (M)','160100'
Union Select 'GUJARAT','Veraval (M)','153696'
Union Select 'GUJARAT','Porbandar (M)','152136'
Union Select 'GUJARAT','Bhuj (M)','147123'
Union Select 'GUJARAT','Godhra (M)','143126'
Union Select 'GUJARAT','Botad (M)','130302'
Union Select 'GUJARAT','Palanpur (M)','127125'
Union Select 'GUJARAT','Patan (M)','125502'
Union Select 'GUJARAT','Jetpur Navagadh (M)','118550'
Union Select 'GUJARAT','Valsad (M)','114987'
Union Select 'GUJARAT','Kalol (M)','112126'
Union Select 'GUJARAT','Gondal (M)','112064'
Union Select 'GUJARAT','Deesa (M)','111149'
Union Select 'GUJARAT','Amreli (M)','105980'
Union Select 'HARYANA','Faridabad (M Corp.)','1404653'
Union Select 'HARYANA','Gurgaon (M Corp.)','876824'
Union Select 'HARYANA','Rohtak (M Cl)','373133'
Union Select 'HARYANA','Hisar (M Cl)','301249'
Union Select 'HARYANA','Panipat (M Cl)','294150'
Union Select 'HARYANA','Karnal (M Cl)','286974'
Union Select 'HARYANA','Sonipat (M Cl)','277053'
Union Select 'HARYANA','Yamunanagar (M Cl)','216628'
Union Select 'HARYANA','Panchkula (M Cl) (incl.spl)','210175'
Union Select 'HARYANA','Bhiwani (M Cl)','197662'
Union Select 'HARYANA','Ambala (M Cl)','196216'
Union Select 'HARYANA','Sirsa (M Cl)','183282'
Union Select 'HARYANA','Bahadurgarh (M Cl)','170426'
Union Select 'HARYANA','Jind (M Cl)','166225'
Union Select 'HARYANA','Thanesar (M Cl)','154962'
Union Select 'HARYANA','Kaithal (M Cl)','144633'
Union Select 'HARYANA','Rewari (M Cl)','140864'
Union Select 'HARYANA','Palwal (M Cl)','127931'
Union Select 'HARYANA','Jagadhri (M Cl)','124915'
Union Select 'HARYANA','Ambala Sadar (M CL)','104268'
Union Select 'JHARKHAND','Dhanbad (M Corp.)','1161561'
Union Select 'JHARKHAND','Ranchi (M Corp.)','1073440'
Union Select 'JHARKHAND','Jamshedpur (NAC)','629659'
Union Select 'JHARKHAND','Bokaro Steel City (CT)','413934'
Union Select 'JHARKHAND','Mango (NAC)','224002'
Union Select 'JHARKHAND','Deoghar (M Corp.)','203116'
Union Select 'JHARKHAND','Aditya (NP)','173988'
Union Select 'JHARKHAND','Hazaribag (NP)','142494'
Union Select 'JHARKHAND','Chas (NP)','141618'
Union Select 'JHARKHAND','Giridih (NP)','114447'
Union Select 'KARNATAKA','BBMP (M Corp.)','8425970'
Union Select 'KARNATAKA','Hubli-Dharwad *(M Corp.)','943857'
Union Select 'KARNATAKA','Mysore (M Corp.)','887446'
Union Select 'KARNATAKA','Gulbarga (M Corp.)','532031'
Union Select 'KARNATAKA','Belgaum (M Corp.)','488292'
Union Select 'KARNATAKA','Mangalore (M Corp.)','484785'
Union Select 'KARNATAKA','Davanagere (M Corp.)','435128'
Union Select 'KARNATAKA','Bellary (M Corp.)','409644'
Union Select 'KARNATAKA','Bijapur (CMC)','326360'
Union Select 'KARNATAKA','Shimoga (CMC)','322428'
Union Select 'KARNATAKA','Tumkur (CMC)','305821'
Union Select 'KARNATAKA','Raichur (CMC)','232456'
Union Select 'KARNATAKA','Bidar (CMC)','211944'
Union Select 'KARNATAKA','Hospet (CMC)','206159'
Union Select 'KARNATAKA','Gadag-Betigeri (CMC)','172813'
Union Select 'KARNATAKA','Bhadravati (CMC)','150776'
Union Select 'KARNATAKA','Robertson Pet (CMC)','146428'
Union Select 'KARNATAKA','Chitradurga (CMC)','139914'
Union Select 'KARNATAKA','Kolar (CMC)','138553'
Union Select 'KARNATAKA','Mandya (CMC)','137735'
Union Select 'KARNATAKA','Hassan (CMC)','133723'
Union Select 'KARNATAKA','Udupi (CMC)','125350'
Union Select 'KARNATAKA','Chikmagalur (CMC)','118496'
Union Select 'KARNATAKA','Bagalkot (CMC)','112068'
Union Select 'KARNATAKA','Ranibennur (CMC)','106365'
Union Select 'KARNATAKA','Gangawati (CMC)','105354'
Union Select 'MADHYA PRADESH','Indore (M Corp.)','1960631'
Union Select 'MADHYA PRADESH','Bhopal (M Corp.)','1795648'
Union Select 'MADHYA PRADESH','Jabalpur (M Corp.)','1054336'
Union Select 'MADHYA PRADESH','Gwalior (M Corp.)','1053505'
Union Select 'MADHYA PRADESH','Ujjain (M Corp.)','515215'
Union Select 'MADHYA PRADESH','Dewas (M Corp.)','289438'
Union Select 'MADHYA PRADESH','Satna (M Corp.)','280248'
Union Select 'MADHYA PRADESH','Sagar (M Corp.)','273357'
Union Select 'MADHYA PRADESH','Ratlam (M Corp.)','264810'
Union Select 'MADHYA PRADESH','Rewa (M Corp.)','235422'
Union Select 'MADHYA PRADESH','Murwara (Katni) (M Corp.)','221875'
Union Select 'MADHYA PRADESH','Singrauli (M Corp.)','220295'
Union Select 'MADHYA PRADESH','Burhanpur (M Corp.)','210891'
Union Select 'MADHYA PRADESH','Khandwa (M Corp.)','200681'
Union Select 'MADHYA PRADESH','Morena (M)','200506'
Union Select 'MADHYA PRADESH','Bhind (M)','197332'
Union Select 'MADHYA PRADESH','Guna (M)','180978'
Union Select 'MADHYA PRADESH','Shivpuri (M)','179972'
Union Select 'MADHYA PRADESH','Vidisha (M)','155959'
Union Select 'MADHYA PRADESH','Mandsaur (M)','141468'
Union Select 'MADHYA PRADESH','Chhindwara (M)','138266'
Union Select 'MADHYA PRADESH','Chhattarpur (M)','133626'
Union Select 'MADHYA PRADESH','Neemuch (M)','128108'
Union Select 'MADHYA PRADESH','Pithampur (M)','126099'
Union Select 'MADHYA PRADESH','Damoh (M)','124979'
Union Select 'MADHYA PRADESH','Hoshangabad (M)','117956'
Union Select 'MADHYA PRADESH','Sehore (M)','108818'
Union Select 'MADHYA PRADESH','Khargone (M)','106452'
Union Select 'MADHYA PRADESH','Betul (M)','103341'
Union Select 'MADHYA PRADESH','Seoni (M)','102377'
Union Select 'MADHYA PRADESH','Datia (M)','100466'
Union Select 'MADHYA PRADESH','Nagda (M)','100036'
Union Select 'MAHARASHTRA','Greater Mumbai (M Corp.)','12478447'
Union Select 'MAHARASHTRA','Pune (M Corp.)','3115431'
Union Select 'MAHARASHTRA','Nagpur (M Corp.)','2405421'
Union Select 'MAHARASHTRA','Thane (M Corp.)','1818872'
Union Select 'MAHARASHTRA','Pimpri-Chinchwad (M Corp.)','1729359'
Union Select 'MAHARASHTRA','Nashik (M Corp.)','1486973'
Union Select 'MAHARASHTRA','Kalyan-Dombivali (M Corp.)','1246381'
Union Select 'MAHARASHTRA','Vasai Virar City (M Corp.)','1221233'
Union Select 'MAHARASHTRA','Aurangabad (M Corp.)','1171330'
Union Select 'MAHARASHTRA','Navi Mumbai (M Corp.)','1119477'
Union Select 'MAHARASHTRA','Solapur (M Corp.)','951118'
Union Select 'MAHARASHTRA','Mira-Bhayander (M Corp.)','814655'
Union Select 'MAHARASHTRA','Bhiwandi (M Corp.)','711329'
Union Select 'MAHARASHTRA','Amravati (M Corp.)','646801'
Union Select 'MAHARASHTRA','Nanded Waghala (M Corp.)','550564'
Union Select 'MAHARASHTRA','Kolapur (M Corp.)','549283'
Union Select 'MAHARASHTRA','Ulhasnagar (M Corp.)','506937'
Union Select 'MAHARASHTRA','Sangli Miraj Kupwad (M Corp.)','502697'
Union Select 'MAHARASHTRA','Malegoan (M Corp.)','471006'
Union Select 'MAHARASHTRA','Jalgaon (M Corp.)','460468'
Union Select 'MAHARASHTRA','Akola (M Corp.)','427146'
Union Select 'MAHARASHTRA','Latur (M Cl)','382754'
Union Select 'MAHARASHTRA','Dhule (M Corp.)','376093'
Union Select 'MAHARASHTRA','Ahmadnagar (M Corp.)','350905'
Union Select 'MAHARASHTRA','Chandrapur (M Cl)','321036'
Union Select 'MAHARASHTRA','Parbhani (M Cl)','307191'
Union Select 'MAHARASHTRA','Ichalkaranji (M Cl)','287570'
Union Select 'MAHARASHTRA','Jalna (M Cl)','285349'
Union Select 'MAHARASHTRA','Ambernath (M Cl)','254003'
Union Select 'MAHARASHTRA','Navi Mumbai Panvel Raigad (CT)','194999'
Union Select 'MAHARASHTRA','Bhusawal (M Cl)','187750'
Union Select 'MAHARASHTRA','Panvel (M Cl)','180464'
Union Select 'MAHARASHTRA','Badalapur (M Cl)','175516'
Union Select 'MAHARASHTRA','Bid (M Cl)','146237'
Union Select 'MAHARASHTRA','Gondiya (M Cl)','132889'
Union Select 'MAHARASHTRA','Satara (M Cl)','120079'
Union Select 'MAHARASHTRA','Barshi (M Cl)','118573'
Union Select 'MAHARASHTRA','Yavatmal (M Cl)','116714'
Union Select 'MAHARASHTRA','Achalpur (M Cl)','112293'
Union Select 'MAHARASHTRA','Osmanabad (M Cl)','112085'
Union Select 'MAHARASHTRA','Nandurbar (M Cl)','111067'
Union Select 'MAHARASHTRA','Wardha (M Cl)','105543'
Union Select 'MAHARASHTRA','Udgir (M Cl)','104063'
Union Select 'MAHARASHTRA','Hinganghat (M Cl)','100416'
Union Select 'NCT OF DELHI','DMC (U) (M Corp.)','11007835'
Union Select 'NCT OF DELHI','Kirari Suleman Nagar (CT)','282598'
Union Select 'NCT OF DELHI','NDMC (M Cl) Total','249998'
Union Select 'NCT OF DELHI','Karawal Nagar (CT)','224666'
Union Select 'NCT OF DELHI','Nangloi Jat (CT)','205497'
Union Select 'NCT OF DELHI','Bhalswa Jahangir Pur (CT)','197150'
Union Select 'NCT OF DELHI','Sultan Pur Majra (CT)','181624'
Union Select 'NCT OF DELHI','Hastsal (CT)','177033'
Union Select 'NCT OF DELHI','Deoli (CT)','169410'
Union Select 'NCT OF DELHI','Dallo Pura (CT)','154955'
Union Select 'NCT OF DELHI','Burari (CT)','145584'
Union Select 'NCT OF DELHI','Mustafabad (CT)','127012'
Union Select 'NCT OF DELHI','Gokal Pur (CT)','121938'
Union Select 'NCT OF DELHI','Mandoli (CT)','120345'
Union Select 'NCT OF DELHI','Delhi Cantonment (CB)','116352'
Union Select 'ORISSA','Bhubaneswar Town (M Corp.)','837737'
Union Select 'ORISSA','Cuttack (M Corp.)','606007'
Union Select 'ORISSA','Brahmapur Town (M Corp.)','355823'
Union Select 'ORISSA','Raurkela Town (M)','273217'
Union Select 'ORISSA','Raurkela Industrial Township (IT)','210412'
Union Select 'ORISSA','Puri Town (M)','201026'
Union Select 'ORISSA','Sambalpur Town (M)','183383'
Union Select 'ORISSA','Baleshwar Town (M)','118202'
Union Select 'ORISSA','Baripada Town (M)','110058'
Union Select 'ORISSA','Bhadrak (M)','107369'
Union Select 'PUNJAB','Ludhiana (M Corp.)','1613878'
Union Select 'PUNJAB','Amritsar (M Corp.)','1132761'
Union Select 'PUNJAB','Jalandhar (M Corp.)','862196'
Union Select 'PUNJAB','Patiala (M Corp.)','405164'
Union Select 'PUNJAB','Bathinda (M Corp.)','285813'
Union Select 'PUNJAB','Hoshiarpur (M Cl)','168443'
Union Select 'PUNJAB','Batala (M Cl)','156400'
Union Select 'PUNJAB','Moga (M Cl)','150432'
Union Select 'PUNJAB','Pathankot (M Cl)','148357'
Union Select 'PUNJAB','S.A.S. Nagar (M Cl)','146104'
Union Select 'PUNJAB','Abohar (M Cl)','145238'
Union Select 'PUNJAB','Malerkotla (M Cl)','135330'
Union Select 'PUNJAB','Khanna (M Cl)','128130'
Union Select 'PUNJAB','Muktsar (M Cl)','117085'
Union Select 'PUNJAB','Barnala (M Cl)','116454'
Union Select 'PUNJAB','Firozpur (M Cl)','110091'
Union Select 'PUNJAB','Kapurthala (M Cl)','101654'
Union Select 'RAJASTHAN','Jaipur (M Corp.)','3073350'
Union Select 'RAJASTHAN','Jodhpur (M Corp.)','1033918'
Union Select 'RAJASTHAN','Kota (M Corp.)','1001365'
Union Select 'RAJASTHAN','Bikaner (M Corp.)','647804'
Union Select 'RAJASTHAN','Ajmer (M Corp.)','542580'
Union Select 'RAJASTHAN','Udaipur (M Cl)','451735'
Union Select 'RAJASTHAN','Bhilwara (M Cl)','360009'
Union Select 'RAJASTHAN','Alwar (M Cl)','315310'
Union Select 'RAJASTHAN','Bharatpur (M Cl)','252109'
Union Select 'RAJASTHAN','Sikar (M Cl)','237579'
Union Select 'RAJASTHAN','Pali (M Cl)','229956'
Union Select 'RAJASTHAN','Ganganagar (M Cl)','224773'
Union Select 'RAJASTHAN','Tonk (M Cl)','165363'
Union Select 'RAJASTHAN','Kishangarh (M Cl)','155019'
Union Select 'RAJASTHAN','Hanumangarh (M Cl)','151104'
Union Select 'RAJASTHAN','Beawar (M Cl)','145809'
Union Select 'RAJASTHAN','Dhaulpur (M)','126142'
Union Select 'RAJASTHAN','Sawai Madhopur (M)','120998'
Union Select 'RAJASTHAN','Churu (M Cl)','119846'
Union Select 'RAJASTHAN','Gangapur City (M)','119045'
Union Select 'RAJASTHAN','Jhunjhunun (M Cl)','118966'
Union Select 'RAJASTHAN','Baran (M)','118157'
Union Select 'RAJASTHAN','Chittaurgarh (M)','116409'
Union Select 'RAJASTHAN','Hindaun (M)','105690'
Union Select 'RAJASTHAN','Bhiwadi (M)','104883'
Union Select 'RAJASTHAN','Bundi (M)','102823'
Union Select 'RAJASTHAN','Sujangarh (M)','101528'
Union Select 'RAJASTHAN','Nagaur (M)','100618'
Union Select 'RAJASTHAN','Banswara (M)','100128'
Union Select 'TAMIL NADU','Chennai (M Corp.)','4681087'
Union Select 'TAMIL NADU','Coimbatore (M Corp.)','1061447'
Union Select 'TAMIL NADU','Madurai (M Corp.)','1016885'
Union Select 'TAMIL NADU','Tiruchirappalli (M Corp.)','846915'
Union Select 'TAMIL NADU','Salem (M Corp.)','831038'
Union Select 'TAMIL NADU','Ambattur (M)','478134'
Union Select 'TAMIL NADU','Tirunelveli (M Corp.)','474838'
Union Select 'TAMIL NADU','Tiruppur (M Corp.)','444543'
Union Select 'TAMIL NADU','Avadi (M)','344701'
Union Select 'TAMIL NADU','Tiruvottiyur (M)','248059'
Union Select 'TAMIL NADU','Thoothukkudi (M Corp.)','237374'
Union Select 'TAMIL NADU','Nagercoil (M)','224329'
Union Select 'TAMIL NADU','Thanjavur (M)','222619'
Union Select 'TAMIL NADU','Pallavaram (M)','216308'
Union Select 'TAMIL NADU','Dindigul (M)','207225'
Union Select 'TAMIL NADU','Vellore (M Corp.)','185895'
Union Select 'TAMIL NADU','Tambaram (M)','176807'
Union Select 'TAMIL NADU','Cuddalore (M)','173361'
Union Select 'TAMIL NADU','Kancheepuram (M)','164265'
Union Select 'TAMIL NADU','Alandur (M)','164162'
Union Select 'TAMIL NADU','Erode (M Corp.)','156953'
Union Select 'TAMIL NADU','Tiruvannamalai (M)','144683'
Union Select 'TAMIL NADU','Kumbakonam (M)','140113'
Union Select 'TAMIL NADU','Rajapalayam (M)','130119'
Union Select 'TAMIL NADU','Kurichi (M)','125800'
Union Select 'TAMIL NADU','Madavaram (M)','118525'
Union Select 'TAMIL NADU','Pudukkottai (M)','117215'
Union Select 'TAMIL NADU','Hosur (M)','116821'
Union Select 'TAMIL NADU','Ambur (M)','113856'
Union Select 'TAMIL NADU','Karaikkudi (M)','106793'
Union Select 'TAMIL NADU','Neyveli (TS) (CT)','105687'
Union Select 'TAMIL NADU','Nagapattinam (M)','102838'
Union Select 'UTTAR PRADESH','Lucknow (M Corp.)','2815601'
Union Select 'UTTAR PRADESH','Kanpur (M Corp.)','2767031'
Union Select 'UTTAR PRADESH','Agra (M Corp.)','1574542'
Union Select 'UTTAR PRADESH','Meerut (M Corp.)','1309023'
Union Select 'UTTAR PRADESH','Varanasi (M Corp.)','1201815'
Union Select 'UTTAR PRADESH','Allahabad (M Corp.)','1117094'
Union Select 'UTTAR PRADESH','Bareilly (M Corp.)','898167'
Union Select 'UTTAR PRADESH','Moradabad (M Corp.)','889810'
Union Select 'UTTAR PRADESH','Aligarh (M Corp.)','872575'
Union Select 'UTTAR PRADESH','Saharanpur (M Corp.)','703345'
Union Select 'UTTAR PRADESH','Gorakhpur (M Corp.)','671048'
Union Select 'UTTAR PRADESH','Noida (CT)','642381'
Union Select 'UTTAR PRADESH','Firozabad (NPP)','603797'
Union Select 'UTTAR PRADESH','Loni (NPP)','512296'
Union Select 'UTTAR PRADESH','Jhansi (M Corp.)','507293'
Union Select 'UTTAR PRADESH','Muzaffarnagar (NPP)','392451'
Union Select 'UTTAR PRADESH','Mathura (NPP)','349336'
Union Select 'UTTAR PRADESH','Shahjahanpur (NPP)','327975'
Union Select 'UTTAR PRADESH','Rampur (NPP)','325248'
Union Select 'UTTAR PRADESH','Maunath Bhanjan (NPP)','279060'
Union Select 'UTTAR PRADESH','Farrukhabad-cum-Fatehgarh (NPP)','275754'
Union Select 'UTTAR PRADESH','Hapur (NPP)','262801'
Union Select 'UTTAR PRADESH','Etawah (NPP)','256790'
Union Select 'UTTAR PRADESH','Mirzapur-cum-Vindhyachal (NPP)','233691'
Union Select 'UTTAR PRADESH','Bulandshahr (NPP)','222826'
Union Select 'UTTAR PRADESH','Sambhal (NPP)','221334'
Union Select 'UTTAR PRADESH','Amroha (NPP)','197135'
Union Select 'UTTAR PRADESH','Fatehpur (NPP)','193801'
Union Select 'UTTAR PRADESH','Rae Bareli (NPP)','191056'
Union Select 'UTTAR PRADESH','Khora (CT)','189410'
Union Select 'UTTAR PRADESH','Orai (NPP)','187185'
Union Select 'UTTAR PRADESH','Bahraich (NPP)','186241'
Union Select 'UTTAR PRADESH','Unnao (NPP)','178681'
Union Select 'UTTAR PRADESH','Sitapur (NPP)','177351'
Union Select 'UTTAR PRADESH','Jaunpur (NPP)','168128'
Union Select 'UTTAR PRADESH','Faizabad (NPP)','167544'
Union Select 'UTTAR PRADESH','Budaun (NPP)','159221'
Union Select 'UTTAR PRADESH','Banda (NPP)','154388'
Union Select 'UTTAR PRADESH','Lakhimpur (NPP)','152010'
Union Select 'UTTAR PRADESH','Hathras (NPP)','137509'
Union Select 'UTTAR PRADESH','Lalitpur (NPP)','133041'
Union Select 'UTTAR PRADESH','Pilibhit (NPP)','130428'
Union Select 'UTTAR PRADESH','Modinagar (NPP)','130161'
Union Select 'UTTAR PRADESH','Deoria (NPP)','129570'
Union Select 'UTTAR PRADESH','Hardoi (NPP)','126890'
Union Select 'UTTAR PRADESH','Etah (NPP)','118632'
Union Select 'UTTAR PRADESH','Mainpuri (NPP)','117327'
Union Select 'UTTAR PRADESH','Basti (NPP)','114651'
Union Select 'UTTAR PRADESH','Gonda (NPP)','114353'
Union Select 'UTTAR PRADESH','Chandausi (NPP)','114254'
Union Select 'UTTAR PRADESH','Akbarpur (NPP)','111594'
Union Select 'UTTAR PRADESH','Khurja (NPP)','111089'
Union Select 'UTTAR PRADESH','Azamgarh (NPP)','110980'
Union Select 'UTTAR PRADESH','Ghazipur (NPP)','110698'
Union Select 'UTTAR PRADESH','Mughalsarai (NPP)','110110'
Union Select 'UTTAR PRADESH','Kanpur (C','108035'
Union Select 'UTTAR PRADESH','Sultanpur (NPP)','107914'
Union Select 'UTTAR PRADESH','Greater Noida (CT)','107676'
Union Select 'UTTAR PRADESH','Shikohabad (NPP)','107300'
Union Select 'UTTAR PRADESH','Shamli (NPP)','107233'
Union Select 'UTTAR PRADESH','Ballia (NPP)','104271'
Union Select 'UTTAR PRADESH','Baraut (NPP)','102733'
Union Select 'UTTAR PRADESH','Kasganj (NPP)','101241'
Union Select 'WEST BENGAL','Kolkata (M Corp.)','4486679'
Union Select 'WEST BENGAL','Haora (M Corp.)','1072161'
Union Select 'WEST BENGAL','Durgapur (M Corp.)','566937'
Union Select 'WEST BENGAL','Asansol (M Corp.)','564491'
Union Select 'WEST BENGAL','Siliguri (M Corp.)','509709'
Union Select 'WEST BENGAL','Maheshtala (M)','449423'
Union Select 'WEST BENGAL','Rajpur Sonarpur (M)','423806'
Union Select 'WEST BENGAL','South Dum Dum (M)','410524'
Union Select 'WEST BENGAL','Rajarhat Gopalpur (M)','404991'
Union Select 'WEST BENGAL','Bhatpara (M)','390467'
Union Select 'WEST BENGAL','Panihati (M)','383522'
Union Select 'WEST BENGAL','Kamarhati (M)','336579'
Union Select 'WEST BENGAL','Barddhaman (M)','314638'
Union Select 'WEST BENGAL','Kulti (M)','313977'
Union Select 'WEST BENGAL','Bally (M)','291972'
Union Select 'WEST BENGAL','Barasat (M)','283443'
Union Select 'WEST BENGAL','North Dum Dum (M)','253625'
Union Select 'WEST BENGAL','Baranagar (M)','248466'
Union Select 'WEST BENGAL','Uluberia (M)','222175'
Union Select 'WEST BENGAL','Naihati (M)','221762'
Union Select 'WEST BENGAL','Bidhan Nagar (M)','218323'
Union Select 'WEST BENGAL','English Bazar (M)','216083'
Union Select 'WEST BENGAL','Kharagpur (M)','206923'
Union Select 'WEST BENGAL','Haldia (M)','200762'
Union Select 'WEST BENGAL','Madhyamgram (M)','198964'
Union Select 'WEST BENGAL','Baharampur (M)','195363'
Union Select 'WEST BENGAL','Raiganj (M)','183682'
Union Select 'WEST BENGAL','Serampore (M)','183339'
Union Select 'WEST BENGAL','Hugli-Chinsurah (M)','177209'
Union Select 'WEST BENGAL','Medinipur (M)','169127'
Union Select 'WEST BENGAL','Chandannagar (M Corp.)','166949'
Union Select 'WEST BENGAL','Uttarpara Kotrung (M)','162386'
Union Select 'WEST BENGAL','Barrackpur (M)','154475'
Union Select 'WEST BENGAL','Krishnanagar (M)','152203'
Union Select 'WEST BENGAL','Santipur (M)','151774'
Union Select 'WEST BENGAL','Balurghat (M)','151183'
Union Select 'WEST BENGAL','Habra (M)','149675'
Union Select 'WEST BENGAL','Jamuria (M)','144971'
Union Select 'WEST BENGAL','Bankura (M)','138036'
Union Select 'WEST BENGAL','North Barrackpur (M)','134825'
Union Select 'WEST BENGAL','Raniganj (M)','128624'
Union Select 'WEST BENGAL','Basirhat (M)','127135'
Union Select 'WEST BENGAL','Halisahar (M)','126893'
Union Select 'WEST BENGAL','Nabadwip (M)','125528'
Union Select 'WEST BENGAL','Rishra (M)','124585'
Union Select 'WEST BENGAL','Ashokenagar Kalyangarh (M)','123906'
Union Select 'WEST BENGAL','Kanchrapara (M)','122181'
Union Select 'WEST BENGAL','Puruliya (M)','121436'
Union Select 'WEST BENGAL','Baidyabati (M)','121081'
Union Select 'WEST BENGAL','Darjiling (M)','120414'
Union Select 'WEST BENGAL','Dabgram (P) (CT)','118464'
Union Select 'WEST BENGAL','Titagarh (M)','118426'
Union Select 'WEST BENGAL','Dum Dum (M)','117637'
Union Select 'WEST BENGAL','Bally (CT)','115715'
Union Select 'WEST BENGAL','Khardaha (M)','111130'
Union Select 'WEST BENGAL','Champdani (M)','110983'
Union Select 'WEST BENGAL','Bongaon (M)','110668'
Union Select 'WEST BENGAL','Jalpaiguri (M)','107351'
Union Select 'WEST BENGAL','Bansberia (M)','103799'
Union Select 'WEST BENGAL','Bhadreswar (M)','101334'
Union Select 'WEST BENGAL','Kalyani (M)','100620'

--6.update the Address to ‘INDIRANAGR’ where the city is BANGALORE
UPDATE CUSTINFO
SET ADDRESS='INDIRANAGAR'
where City='BANGALORE'

Select *
from CUSTINFO

--7.update CUSTOMER_TABLE with city from CUST_INFO_TABLE

--We don't have city column in Customer_new table so first we need to add the column and then we can perform the step to include city from CUST_info table

ALTER Table Customer_new
Add City varchar(30)

Select *
from Customer_new

Begin Transaction

update Customer_new
set City=CI.city
from CUSTINFO as CI
where Customer_new.CUSTID=CI.CUSTID

COMMIT

--8. find cumulative sum of SALES for each custid
SELECT DISTINCT CUSTID,SALES,
SUM(SALES) Over(Partition by CUSTID Order by Sales) As Cummulative_sales
From Customer_new

--9.  Write a query to get top 1 customer with highest SALES amount per day

Select *
from Customer_new

Select *
from (Select *, DENSE_RANK() Over(Partition by Date Order by sales DESC) AS Top_Sales
From Customer_new) as A
Where Top_Sales=1




--10.There is a CITIES table which contains population for some of the cities of India. 
--All you need to do is extract 5th most populated city of every state using SQL query. 

Select *
from Country

with Top5city as
(
Select *,ROW_NUMBER() OVER(Partition by State Order by Population Desc) as RK
From Country
)
Select *
from Top5city 
where rk<=5

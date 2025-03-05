CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    CreatedAt DATETIME2 DEFAULT CURRENT_TIMESTAMP, 
    CONSTRAINT CHK_Role CHECK (Role IN ('Admin', 'LibraryOwner', 'Customer'))
);


CREATE TABLE Libraries (
    Id INT PRIMARY KEY identity,
    Name VARCHAR(150) NOT NULL,
    OwnerId INT NOT NULL,
    Location TEXT NOT NULL,
    Description TEXT,
    CreatedAt DATETIME2  DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (OwnerId) REFERENCES Users(Id) ON DELETE CASCADE
);

CREATE TABLE Products (
    Id INT PRIMARY KEY identity,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    ImagePath VARCHAR(255) DEFAULT NULL,  -- مسار الصورة
    LibraryId INT NOT NULL,
    CreatedAt DATETIME2  DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (LibraryId) REFERENCES Libraries(Id) ON DELETE CASCADE
);
CREATE TABLE Orders (
    Id INT PRIMARY KEY IDENTITY,
    CustomerId INT NOT NULL,
    LibraryId INT NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    Status VARCHAR(20) DEFAULT 'Pending',
    CreatedAt DATETIME2 DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerId) REFERENCES Users(Id) ON DELETE NO ACTION,
    FOREIGN KEY (LibraryId) REFERENCES Libraries(Id) ON DELETE NO ACTION,
    CONSTRAINT CHK_Status CHECK (Status IN ('Pending', 'Completed', 'Cancelled'))
);


CREATE TABLE OrderDetails (
    Id INT PRIMARY KEY identity,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE
);
CREATE TABLE Reviews (
    Id INT PRIMARY KEY IDENTITY,
    UserId INT NOT NULL,
    LibraryId INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    CreatedAt DATETIME2 DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE NO ACTION,  
    FOREIGN KEY (LibraryId) REFERENCES Libraries(Id) ON DELETE NO ACTION  
);



CREATE TABLE PrintRequests (
    Id INT PRIMARY KEY IDENTITY,
    CustomerId INT NOT NULL,
    LibraryId INT NOT NULL,
    DocumentPath VARCHAR(255) NOT NULL,
    Copies INT NOT NULL DEFAULT 1,
    Color VARCHAR(20) CHECK (Color IN ('Black & White', 'Color')) NOT NULL,
    PrintSide VARCHAR(20) CHECK (PrintSide IN ('Single-Sided', 'Double-Sided')) NOT NULL, 
    Message TEXT NULL,  -- ملاحظات إضافية من المستخدم
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Completed', 'Cancelled')) DEFAULT 'Pending', 
    CreatedAt DATETIME2 DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerId) REFERENCES Users(Id) ON DELETE NO ACTION,  
    FOREIGN KEY (LibraryId) REFERENCES Libraries(Id) ON DELETE NO ACTION  
);


CREATE TABLE ContactUs (
    Id INT PRIMARY KEY IDENTITY,
    SenderId INT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL, 
    Message TEXT NOT NULL,  
    TargetType VARCHAR(20) CHECK (TargetType IN ('Admin', 'Library')) NOT NULL,  
    TargetId INT NULL,  
    CreatedAt DATETIME2 DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (SenderId) REFERENCES Users(Id) ON DELETE SET NULL,
    FOREIGN KEY (TargetId) REFERENCES Libraries(Id) ON DELETE NO ACTION  
);


CREATE TABLE LibraryRegistrationRequests (
    Id INT PRIMARY KEY IDENTITY,
    LibraryName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Location TEXT NOT NULL,
    Services TEXT NOT NULL,  
    Phone VARCHAR(15) NOT NULL,
    LogoPath VARCHAR(255) NULL, 
    WorkingHours VARCHAR(100) NULL,  
    WebsiteURL VARCHAR(255) NULL, 
    Description TEXT NULL,  
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Approved', 'Rejected')) DEFAULT 'Pending',  
    CreatedAt DATETIME2 DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Services (
    Id INT PRIMARY KEY IDENTITY,
    LibraryId INT NOT NULL,  
    Name VARCHAR(255) NOT NULL, 
    Description TEXT,  
    Price DECIMAL(10,2) NOT NULL,  
    CreatedAt DATETIME2 DEFAULT CURRENT_TIMESTAMP, 
    FOREIGN KEY (LibraryId) REFERENCES Libraries(Id) ON DELETE CASCADE
);

CREATE TABLE FAQs (
    Id INT PRIMARY KEY IDENTITY,
    Question VARCHAR(255) NOT NULL,  
    Answer TEXT NOT NULL,  
    CreatedAt DATETIME2 DEFAULT CURRENT_TIMESTAMP  
);

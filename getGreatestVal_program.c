function Main() return integer
{ 
    var A : integer;
    var B : integer;
    var C : integer;
    var greatestVal : integer;
        A = 1;
        B = 2;
        C = 3;
        greatestVal = 0;
  
    if (A >= B && A >= C) 
        {greatestVal = A;}
  
    if (B >= A && B >= C) 
        {greatestVal = B;}
  
    if (C >= A && C >= B) 
        {greatestVal = C;}
  
    return 0; 
} 

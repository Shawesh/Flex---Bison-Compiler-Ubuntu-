function foo() return integer
{
    var x : integer;
    { 
        var y : integer;
        x = 1;
        y = 2;
        {
            x = 2;
        }
        y = 3;
     }
    return 0;
}


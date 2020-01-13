function foo() return integer
{
    var l : integer;
    if(true) { j = 3; }
	else { k = 4; }

	while(true) { l = 2; }
    return 0;
}

function Main() return integer
{
    var a : integer;
    a = foo();
    return 0;
}

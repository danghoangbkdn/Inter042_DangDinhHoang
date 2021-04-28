function funcCalTax(){
    let s = parseInt(document.getElementById("b1.1").value);
    let incomeTax, salary;
    if (s >= 15000000){
        incomeTax = s * 0.2;
        salary = s - incomeTax;
    } else if (s <= 7000000){
        incomeTax = s * 0.1;
        salary = s - incomeTax;
    } else {
        incomeTax = s * 0.05;
        salary = s - incomeTax;
    }
    document.getElementById("b1.2").innerHTML = incomeTax;
    document.getElementById("b1.3").innerHTML = salary;
}

function funcCheckVowAndCon(){
    let s = document.getElementById("b2.1").value;
    switch(s){
        case 'a':
        case 'e':
        case 'i':
        case 'o':
        case 'u':
        case 'A':
        case 'E':
        case 'I':
        case 'O':
        case 'U':
            document.getElementById("b2.2").innerHTML = "This is a Consonant!!!";
            break;
        default:
            document.getElementById("b2.2").innerHTML = "This is a Vowel!!!";
            break;
    }
}
function funcBai1(){
    let l = document.getElementById("b1.1").value + "";
    let result = l.substring(0, 1).toLocaleUpperCase();
    for(let i = 1; i < l.length; i++){
        if(l.substring(i, i + 1) == " " && l.substring(i + 1, i + 2) != " "){
            result += " " + l.substring(i + 1, i + 2).toLocaleUpperCase();
            i++;
        } else if(l.substring(i, i + 1) != " "){
            result += l.substring(i, i + 1).toLocaleLowerCase();
        }
    }
    console.log(result);
    document.getElementById("b1.2").innerHTML = "Result : " + result;
}
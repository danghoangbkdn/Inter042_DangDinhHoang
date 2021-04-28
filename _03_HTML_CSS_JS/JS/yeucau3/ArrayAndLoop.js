function funcPrefixSums(){
    let s = document.getElementById("b1.1").value + "";
    let arrs = s.split("");
    let sums = [arrs[0]];
    for(let i = 1; i < arrs.length; i++){
        sums[i] = parseInt(sums[i - 1]) + parseInt(arrs[i]);
    }
    document.getElementById("b1.2").innerHTML = "Prefix Sums Arrays &nbsp&nbsp&nbsp&nbsp&nbsp" + sums;
}

function isElementDuplicate(arr, element){
    for(let j = 0; j < arr.length; j++){
        if(arr[j] == element){
            return true;
        }
    }
    return false;
}

function funcBai2(){
    let a = (document.getElementById("b2.1").value + "").split("");
    let b = (document.getElementById("b2.2").value + "").split("");
    let result = [], n = 0;
    for(let i = 0; i < b.length; i++){
        if(!isElementDuplicate(a, b[i])){
            result[n++] = b[i];
        }
    }
    document.getElementById("b2.3").innerHTML = "Result : " + result;
}

function funcBai3(){
    let a = (document.getElementById("b3.1").value + "").split("");
    let b = (document.getElementById("b3.2").value + "").split("");
    let x = 0, max = a[x] / b[x];
    for(let i = 1; i < a.length; i++){
        if(a[i] / b[i] > max){
            max = a[i] / b[i];
            x = i;
        }
    }
    document.getElementById("b3.3").innerHTML = a[x] + "/" + 
        b[x] + " là phân số lớn nhất có chỉ số là " + max;
}

function funcBai4(){
    let result = "Corresponding to the letters: ";
    let a = (document.getElementById("b4.1").value + "").split("");
    let letter = ["không", "một", "hai", "ba", "bốn", "năm", "sáu",
                    "bảy", "tám", "chín"];
    for(let i = 0; i < a.length; i++){
        result += letter[parseInt(a[i])] + " ";
    }
    document.getElementById("b4.2").innerHTML = result;
}

function funcBai5(){
    let sum = 0, mul = 1;
    let cf = document.getElementById("m1").value;
    let ce = document.getElementById("m2").value;
    let cr = document.getElementById("m3").value;
    let cc = document.getElementById("m4").value;
    let nl = document.getElementById("m5").value;
    let nd = document.getElementById("m6").value;
    let menu = [[cf, 20000], [ce, 25000], [cr, 30000], [cc, 32000], [nl, 7000], [nd, 35000]];
    for(let i = 0; i < menu.length; i++){
        mul = 1;
        for(let j = 0; j < menu[i].length; j++){
            mul *= menu[i][j];
        }
        sum += mul;
    }
    document.getElementById("b5.1").innerHTML = "Total Money: " + sum + "VNĐ";
}
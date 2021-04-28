let m, n;

function funcDrawRectangle(){
    n = parseInt(document.getElementById("n").value);
    m = parseInt(document.getElementById("m").value);
    for(let i = 1; i <= n; i++){
        for(let j = 1; j <= m; j++){
            if(i == 1 || i == n || j == 1 || j == m){
                document.write("*&nbsp&nbsp");
            } else {
                document.write("&nbsp&nbsp&nbsp&nbsp");
            }
        }
        document.writeln("<br>");
    }
}

function funcDrawTriangle(){
    n = parseInt(document.getElementById("h1").value);
    for(let i = 1; i <= n; i++){
        for(let j = 1; j <= n; j++){
            if(j == 1 || i == n || j == i){
                document.write("*&nbsp&nbsp");
            } else {
                document.write("&nbsp&nbsp&nbsp&nbsp");
            }
        }
        document.write("<br>");
    }
}

function funcDrawTriangleIsosceles(){
    n = parseInt(document.getElementById("h2").value);
    for(let i = 1; i <= n; i++){
        for(let j = 1; j <= n * 2 - 1; j++){
            if(j <= n + i - 1 && j >= n - i + 1){
                document.write("*&nbsp&nbsp");
            } else{
                document.write("&nbsp&nbsp&nbsp&nbsp");
            }
        }
        document.write("<br>");
    }
}

function funcDrawTriangleEmpty(){
    n = parseInt(document.getElementById("h3").value);
    for(let i = 1; i <= n; i++){
        for(let j = 1; j <= n * 2 - 1; j++){
            if(j == n + i - 1 || j == n - i + 1 || i == n){
                document.write("*&nbsp&nbsp");
            } else{
                document.write("&nbsp&nbsp&nbsp&nbsp");
            }
        }
        document.write("<br>");
    }
}
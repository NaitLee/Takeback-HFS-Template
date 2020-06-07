
[sym-errorpagecss]
<style>
@keyframes fadein {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}
/* Starry Night by Lea Verou */
/* https://leaverou.github.io/css3patterns/ */
body {
width: 100%;
height: 100%;
position: fixed;
margin: 0px;
z-index: -2;
background-color:black;
background-image:
radial-gradient(white, rgba(255,255,255,.2) 2px, transparent 40px),
radial-gradient(white, rgba(255,255,255,.15) 1px, transparent 30px),
radial-gradient(white, rgba(255,255,255,.1) 2px, transparent 40px),
radial-gradient(white, rgba(255,255,255,.08) 3px, transparent 60px),
radial-gradient(rgba(255,255,255,.4),
rgba(255,255,255,.1) 2px, transparent 30px);
background-size: 550px 550px, 350px 350px, 250px 250px, 950px 950px, 150px 150px;
background-position: 0 0, 40px 60px, 130px 270px, 640px 240px, 70px 100px;
font-size: 1.2em;
/*transform: scale(1.08);*/
font-family: sans-serif; background-color: black; color: white; text-align: center;
}
a, a:link, a:hover, a:active, a:visited { color: white; text-decoration: none; transition: all 0.6s; }
a:hover { color: black; background-color: white; }
</style>

[not found]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="1;url=../">
%sym-errorpagecss%
<title>404</title>
</head>
<body>
<h2><br />{.!You have found a 404 page.}</h2>{.!Redirecting to the previous page....}
</body></html>

[overload]
{.if|!%user%|{:{.if|{.%url% = /.}|{:{.disconnect.}:}.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="3;url=./">
<title>Overload</title>
%sym-errorpagecss%
</head>
<body>
    <h2><br />{.!There are more people than on a worktime bus station.}</h2>
    {.!Returning to previous page after traffic afford has gone lower....}
</body>
</html>
{.disconnect|{.current downloads|ip|file=this.}.}
{.if|{.{.current downloads|ip=%ip%|file=this.}> 1.}|
    {: {.disconnection reason|knackered.}
:}/if.}

[max contemp downloads]
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="refresh" content="3;url=./">
<title>Downloads</title>
%sym-errorpagecss%
</head>
<body style="background-color: black; text-align: center;" text="white" alink="white" link="white" vlink="white">
    <h2><br />{.!There are ongoing downloads.}</h2>
    {.!More available after current downloads finish.}
</body>
</html>
{.disconnect|{.current downloads|ip|file=this.}.}

[box login]
<fieldset id='login'>
<legend>{.!User & Login.}</legend>
{.if| {.length|%user%.} |{:
    %user% <button onclick='logout()'>{.!Logout.}</button>
    {.if|{.can change pwd.} | <button onclick='areanewpass.style.display = "block";'>{.!Change Password.}</button> .}
    <br /><span id="sid" style="display: none;"></span>
    <div id='areanewpass' style="display: none;">
    <input id="newpwd" type='password' name='newpwd' maxlength="32"
        size="25" placeholder="{.!Input new password....}" /><br />
    <input id="newpwd2" type='password' name='newpwd2' maxlength="32"
        size="25" placeholder="{.!Input again....}" /><br />
    <input type="button" onclick="checkpassword()" value="{.!Okay.}" />
    </div>
    <script>
    function checkpassword() {     // Also changes password if no problem
        if (newpwd.value!=newpwd2.value) {
            alert('{.!Passwords not match, please re-input..}');
        } else if (newpwd.value=='') {
            alert('{.!Password cannot be empty!.}')
        } else {
            changePwd(newpwd.value);
            beforeRedirect();
        }
    }
    </script>
    <script>
    function logout() {fetch("/?mode=logout");/*.then(res => location.reload());*/beforeRedirect(); return false;}
    function changePwd(newpass) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', '?mode=section&id=ajax.changepwd');
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            console.log(xhr.responseText);
            var code = ( xhr.responseText.split('(')[1] == undefined ? -1 : xhr.responseText.split('(')[1].split(')')[0] );
            if (code == "1") {
                alert('{.!Complete! Use your new password next time!.}');
                beforeRedirect();
            } else {
                if (code == "0") {
                    alert("{.!You cannot change your password!.}");
                } else if (xhr.responseText.trim() == "bad session") {
                    alert("{.!Bad session. Try to refresh the page..}");
                } else {
                    alert('Unknown error: \n'+xhr.responseText.trim());
                }
            }
        }
        };
        xhr.send("token={.cookie|HFS_SID_.}"+"&new="+newpass);
    }
    </script>
    :}
|
    <input id='user' size='16' placeholder="{.!Username.}" /><br />
    <input type='password' id='pw' size='16' placeholder="{.!Password.}" /><br />
    <input type='hidden' id='sid' size='16' />
    <input type="checkbox" title='{.!By checking this you also agree to use Cookies.}' style="transform: scale(1.6);" /> {.!Keep me loggedin.}
    <input type='button' style="width: 8em;" onclick='login()' value='{.!Login.}' />
    <script src='/~sha256.js'></script>
    <script>
    var sha256 = function(s) { return SHA256.hash(s); }
    function login() {
        var sid = "{.cookie|HFS_SID_.}"  //getCookie('HFS_SID');
	    // if (sid="") // the session was just deleted
		    // return location.reload() // but it's necessary for login
        if (!sid) return;  //let the form act normally
        var usr = user.value;
        var pwd = pw.value;
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "/?mode=login");  // /~login
        var formData = new FormData();
        formData.append("user",usr)
        typeof SHA256 == 'undefined' ? formData.append("password",pwd) : formData.append("passwordSHA256",sha256(sha256(pwd).toLowerCase()+sid).toLowerCase()) ;
        xhr.onload=function(){
        if(xhr.response=='ok') {
            if(document.querySelector("input[type=checkbox]").checked) localStorage.login=JSON.stringify([usr,pwd]); else localStorage.removeItem('login');
            beforeRedirect();
        } else {
            console.log(xhr.responseText);
            if (xhr.responseText === "bad password") {
                alert("{.!The password you entered is incorrect!.}");
            } else if (xhr.responseText === "username not found") {
                alert("{.!The user account you entered doesn't exist!.}");
            }
        }
        // document.querySelector("form").reset()
        }
        xhr.send(formData);
    }
    if(localStorage.login) document.querySelector("input[type=checkbox]").checked=true  //stop keep loggedin: call /~login (or /~signin) and disable "Keep me loggedin"
    document.querySelector("input[type=checkbox]").onchange=function(){if(!this.checked) localStorage.removeItem('login')}
    if(localStorage.login) {
    var tmp=JSON.parse(localStorage.login);
    user.value=tmp[0];
    pw.value=tmp[1];
    login();
    }
    </script>
.}
<script>
function beforeRedirect() {
    var inputs = ['user', 'pw', 'newpwd', 'newpwd2'];
    for (var i in inputs) {
        var inpt = document.getElementById(inputs[i]);
        if (inpt!=null) inpt.value = '';
    }
    // With a delay it will be more stable
    setTimeout(function() {
        window.location.href = '/~signin';
    }, 800);
};
</script>
</fieldset>

[signin]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>{.!Login.}</title>
%sym-errorpagecss%
<style>
#login {
    max-width: 50%;
    margin: auto;
    line-height: 1.8em;
    font-size: 1.4em;
    font-family: monospace;
}
@media (max-width: 760px) { #login { max-width: 80%; } }
</style>
</head>
<body style="background-color: black; text-align: center;" text="white" alink="white" link="white" vlink="white">
{.if| {.length|%user%.} |{:
    <br />
    <h2>{.!Welcome back.}, %user%!</h2>
    {.!You are already logged in, you need to log out before logging in as different user..}
    <!-- If not in login/signin page, it means no permission -->
    {.if|{.or|{.count substring|/~signin|%url%.}|{.count substring|/~login|%url%.}.}||
        <br /><br />{.!If you are here accidentally, you may lack the permission to access this file/folder..}
    .}
:}|{:
    <h2><br />{.!Please login to your account.}</h2>
    {.!Please login to access to your account, and check you have the correct permissions to continue.}
:}.}
<br /><br />
{.$box login.}
<br /><br /><a href="javascript: history.back()" style="font-size: 1.2em;">&lt;&lt; {.!Tap to Back.} </a>
</body>

[login]
{.$signin.}

[unauth]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta http-equiv="refresh" content="16;url=../">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>{.!Unauthorized.}</title>
%sym-errorpagecss%
</head>
<body>
    <h2>{.!Unauthorized.}</h2>
    {.!Currently you have no right to access this resource. Please login if possible..}
    <br /><br /><a href="/~signin" style="font-size: 1.2em;">{.!Login.} &gt;&gt;</a>
    <br /><br /><a href="javascript: history.back()" style="font-size: 1.2em;">&lt;&lt; {.!Tap to Back.} </a>
</body>
</html>


[deny]
{.if|{.match|*.php*;*.js;*.py;*.vbs*;*.exe|%url%.}|{:{.disconnect.}:}.}
{.add header|Cache-Control: no-cache, max-age=0.}
<!doctype html>
<html>
<head>
<meta http-equiv="refresh" content="1;url=../">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>Denied</title>
%sym-errorpagecss%
</head>
<body>
    <h1>{.!Access Denied.}</h1><br /><br />{.!Nope.}
</body>
</html>

[ban]
{.disconnect.}

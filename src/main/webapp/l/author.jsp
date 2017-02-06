<%@ page import="com.book.bean.*,com.book.util.*,com.book.dao.*,java.util.*" %>
<%@ page import="com.book.service.MessageService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf8"%>
<%
    String Path = request.getContextPath();
    MessageService messageService = (MessageService)SpringContext.getBean("messageService");

    List messagesList = null;
    String sexName="";
    long id = 1L;
    Author author = (Author) session.getAttribute("author");
    if(author==null) {
        response.sendRedirect(Path+"/l/login.jsp");
    }else{
        id=author.getAuthor_id();
        if(author.getSex()==1) sexName ="男";
        else  if(author.getSex()==0)sexName="女";
        else sexName="*";
        messagesList = messageService.getNowMessages(id);
    }

%>
<html>
<head>
    <title>作家管理中心</title>
    <link rel="icon" href="<%=Path%>/image/ico/book.ico">
    <link href="<%=Path%>/js/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=Path%>/css/dashboard.css" rel="stylesheet">
    <link href="<%=Path%>/css/grid.css" rel="stylesheet">
    <link href="<%=Path%>/css/author.css" rel="stylesheet">
    <script src="<%=Path%>/js/jquery-3.0.0.min.js"></script>
<%--
    <script src="<%=Path%>/js/me/signup.js"></script>
--%>
    <script>
        $(function(){
            init();
        });
        //原生js的ajax实现，jquery的不兼容也是日了狗了
        var ajax = {
            get:function(url,fn){
                var obj = new XMLHttpRequest();
                obj.open('GET',url,true);
                obj.onreadystatechange=function(){
                    if(obj.readyState==4&&obj.status==200||obj.status==304){
                        fn.call(this,obj.responseText);
                    }
                };
                obj.send(null);
            },
            post:function(url,data,fn){
                var obj = new XMLHttpRequest();
                obj.open('POST',url,true);
                obj.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                obj.onreadystatechange=function () {
                    if(obj.readyState==4&&obj.status==200||obj.status==304){
                        fn.call(this,obj.responseText);
                    }
                };
                obj.send(data);
            }
        }
        function checkUsername(){
            //console.log('username');
            ajax.post("","",function(data){

            });
            if(true){
                $('#submitting').removeAttr('disabled');
                $('#OUT_name').html('');
            }else{
                $('#submitting').attr('disabled','disabled');
                $('#OUT_name').html('<span style="color:red">用户名已存在</span>');
            }
        }
        function show_update(){
            $("#show_info").attr('class','invisible')
            $("#update_Info").attr('class','');
        }
        function update() {
            var email = $("#inputEmail").val();
            var id = <%=id%>;
            var name = $("#name").val();
            var true_name = $("#true_name").val();
            var phone = $("#phone").val();
            var qq = $("#qq").val();
            var id_card=$("#id_card").val();
            var sex=$('sex').val();
            ajax.post("<%=Path%>/user/update_author","author_id="+id+"&name="+name+"&true_name="+true_name+"&phone="+phone+"&id_card="+id_card+"&qq="+qq+"&email="+email/*+"&sex="+sex*/,function(data){
                if(data=='1'){
                    alert("修改成功");
                }else{
                    alert("修改失败");
                }
            });
        }

    </script>
</head>
<body>
<%--<%
 String email = request.getParameter("email");
 System.out.println(email);
%>
<%=email%>--%>
<nav class="navbar navbar-toggleable-md navbar-inverse fixed-top bg-inverse">
    <button class="navbar-toggler navbar-toggler-right hidden-lg-up" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand title_font" href="<%=Path%>/" >Myth</a>
    <a class="navbar-brand title_font" href="<%=Path%>/l/author.jsp" >·作家专区</a>

    <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
        </ul>
        <%if(author!=null){%>
        <ul class="navbar-nav" style="margin-right: 50px;">
            <li class="nav-item">
                <a class="nav-link user_font" onclick="item_tran('6')">
                    <img src="<%=Path%>/image/author/messages.png" width="28px" height="28px">
                    <span style="color:orangered;" id="MessageNums"></span>
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle user_font" href="http://example.com" id="dropdown03"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=author.getName()%></a>
                <div class="dropdown-menu" aria-labelledby="dropdown01">
                    <a class="dropdown-item" href="#" onclick="item_tran('0')">个人中心</a>
                    <a class="dropdown-item" href="#">文档帮助</a>
                    <a class="dropdown-item" href="<%=Path%>/user/logout">注销登录</a>
                </div>
            </li>
        </ul>
        <%}%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">

        <%--导航栏--%>
        <nav class="col-sm-3 col-md-2 hidden-xs-down bg-faded sidebar" style="width:140px;">
            <ul class="nav nav-pills flex-column">
                <li class="nav-item">
                    <a class="nav-link" href="#" id="item_1" onclick="item_tran('1')"><img src="../image/author/newspapel.png" width="26px" height="26px">  作家资讯</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="item_2" onclick="item_tran('2')"><img src="../image/author/book.png" width="30px" height="30px"> 作品管理</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="item_3" onclick="item_tran('3')"><img src="../image/author/credit-card.png" width="30px" height="30px"> 稿酬收入</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="item_4" onclick="item_tran('4')"><img src="../image/author/gift.png" width="30px" height="30px"> 奖金收入</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" id="item_5" onclick="item_tran('5')"><img src="../image/author/info-large-outline.png" width="30px" height="30px"> 作家帮助</a>
                </li>
            </ul>
        </nav>

        <%--
            页面内容
        --%>
    <%if(author!=null){%>
        <main class="col-sm-9 offset-sm-3 col-md-11 offset-md-2 pt-3" id="main_0" style="margin-left: 140px;">
            <h2>个人资料</h2>

            <div id="show_info">
                昵称 : <%=author.getName()%><br/>
                性别 : <%=sexName%><br/>
                身份证号 : <%=author.getId_card()%><br/>
                真实姓名 : <%=author.getTrue_name()%><br/>
                常用QQ : <%=author.getQq()%><br/>
                电话号码 : <%=author.getPhone()%><br/>
                邮件地址 : <%=author.getEmail()%><br/>
                <button type="button" class="btn btn-primary" onclick="show_update()">更改资料</button>
            </div>

            <div id="update_Info" class="invisible">
                <form class="form-signin" action="<%=Path%>/user/update_author">
                    <h2 class="form-signin-heading"></h2>
                    <input type="hidden" name="author_id" value=<%=author.getAuthor_id()%>/>
                    <input type="text" id="name" class="form-control" name="name" placeholder="昵称" onblur="checkUsername()" value=<%=author.getName()%> required autofocus/>
                    <div id="OUT_name"></div>

                    <input type="text" id="true_name" class="form-control" name="true_name" placeholder="真实姓名" value=<%=author.getTrue_name()%> required/>
                    <input type="text" id="id_card" class="form-control" name="id_card" placeholder="身份证号码" onblur="checkIdCard()" value=<%=author.getId_card()%> required/>
                    <label for="inputEmail" class="sr-only">Email</label>
                    <input type="email" id="inputEmail" class="form-control" name="email" placeholder="邮件" value=<%=author.getEmail()%> required  />
                    <input type="text" id="phone" class="form-control" name="phone" placeholder="联系电话" value=<%=author.getPhone()%> required/>
                    <div id="OUT_pass"></div>

                    <div>
                        <input type="text" class="form-control form-code" id="qq" name="qq" placeholder="QQ" value=<%=author.getQq()%> required>
                        <!--性别按钮-->
                        <span class="btn-group" data-toggle="buttons" style="margin:4px 0 0 5px;">
                            <%if(author.getSex()==1){%>
                                <label class="btn btn-primary active">
                                <input type="radio" name="sex"  value="1" autocomplete="off" checked/>男</label>
                                <label class="btn btn-primary">
                                <input type="radio" name="sex"  value="0" autocomplete="off"/>女</label>
                            <%}else{%>
                                <label class="btn btn-primary ">
                                <input type="radio" name="sex"  value="1" autocomplete="off" />男</label>
                                <label class="btn btn-primary active">
                                <input type="radio" name="sex"  value="0" autocomplete="off" checked/>女</label>
                            <%}%>
                        </span>
                    </div>
                    <br/>
                    <button class="btn btn-lg btn-primary btn-block" type="button" id="submitting" onclick="update()">更新资料</button>
                </form>
            </div>
        </main>

        <main class="col-sm-9 offset-sm-3 col-md-11 offset-md-2 pt-3" id="main_1" style="margin-left: 140px;">
            <h1>11</h1>

        </main>

        <main class="col-sm-9 offset-sm-3 col-md-11 offset-md-2 pt-3" id="main_2" style="margin-left: 140px;">
            <h1>222</h1>

        </main>
        <main class="col-sm-9 offset-sm-3 col-md-11 offset-md-2 pt-3" id="main_3" style="margin-left: 140px;">
            <h1>333</h1>

        </main>
        <main class="col-sm-9 offset-sm-3 col-md-11 offset-md-2 pt-3" id="main_4" style="margin-left: 140px;">
            <h1>444</h1>

        </main>

        <main class="col-sm-9 offset-sm-3 col-md-11 offset-md-2 pt-3" id="main_5" style="margin-left: 140px;">
            <h1>55</h1>

        </main>
        <main class="col-sm-9 offset-sm-3 col-md-11 offset-md-2 pt-3" id="main_6" style="margin-left: 140px;">
            <button type="button" class="btn btn-primary" onclick="back()">返回</button>
            <button type="button" class="btn btn-primary">历史消息</button>
            <span style="margin-left:380px;font: 20px bold;color: blue;" id="message_title">消息查看</span>
            <button type="button" class="btn btn-primary" style="margin-left: 450px;" onclick="new_Message()">+</button>
            <hr>

            <div class="container" id="messageBox">
                <%for (int i=0;i<messagesList.size();i++){ MessagesPlus p = (MessagesPlus) messagesList.get(i);String name = p.getReceive_name();%>
                    <div class="row" onclick="showMessage('<%=name%>')" id="<%=name%>">
                        <div class="col-1"><%=name%></div><div class="col-10">............</div>
                    </div>
                <%}%>
                <%--<div class="row" onclick="showMessage('me_12')" id="me_12">
                    <div class="col-1">me_12</div><div class="col-10">............</div>
                </div>
                <div class="row" onclick="showMessage('me_13')" id="me_13">
                    <div class="col-1">me_13</div><div class="col-10">............</div>
                </div>--%>
            </div>

            <%--查看消息发送消息--%>
            <div class="invisible" id="SendMessage">
                <%for (int i=0;i<messagesList.size();i++){ MessagesPlus p = (MessagesPlus) messagesList.get(i);String name = p.getReceive_name();%>
                    <div id="history_<%=name%>" class="historychat invisible">
                        <div hidden id="<%=name%>_id"><%=id%></div>
                        <div class="row_box">
                            34
                        </div>
                    </div>
                <%}%>
                <%--<div id="history_me_12" class="historychat invisible">
                    <div hidden id="me_12_id">2000000001</div>
                    <div class="row_box me_box">
                        34
                    </div>

                </div>
                <div id="history_me_13" class="historychat invisible">
                    <div hidden id="me_13_id">2000000002</div>
                    <div class="row_box">
                        34
                    </div>

                </div>--%>
                <div id="sendBox" class="inputBox">
                    <input type="text" name="message" id="inputText" style="width: 600px;"/>
                    <button type="button" onclick="send('<%=id%>')" class="btn btn-primary">发送</button>
                </div>


            </div>

            <%--<div style="width: 100px;float: left;" class="message_title">
                <button type="button">34</button>
            </div>
            <div style="float: left;" class="message_box">
                <div></div>
            </div>--%>

        </main>
    <%}%>
    </div>
</div>
<!-- Placed at the end of the document so the pages load faster -->
<script src="<%=Path%>/js/jquery-slim.min.js"></script>
<script src="<%=Path%>/js/tether.min.js"></script>
<script src="<%=Path%>/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="<%=Path%>/js/ie10-viewport-bug-workaround.js"></script>
<script src="<%=Path%>/js/me/author.js"></script>
<script src="<%=Path%>/js/me/socket.js"></script>

</body>
</html>

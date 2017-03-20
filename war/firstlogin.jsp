<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.TimeZone"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%	
			int error = 0;
			// Initial_Servlet から
			// エラーがあれば str に何かしらの値が入る
			String str = request.getParameter("Error");
			if(str != null){
				error = Integer.parseInt(str);
			}
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>個人情報登録</title>
	<style type='text/css'>
		label.rcolor{
			color: #ff1100;
		}
	</style>
</head>
<body>
    <script type="text/javascript">

      /* buttonのdisable属性を書き換える */
      function checkValue(check){
    	   if( check == true ) {
    		      // チェックが入っていたら有効化
    		      document.getElementById("n4").disabled = false;
    		      document.getElementById("n5").disabled = false;
    		      document.getElementById("p2").disabled = false;
    		      document.getElementById("c3").disabled = false;
    		      document.getElementById("c4").disabled = false;
    		   }
    		   else {
    		      // チェックが入っていなかったら無効化
     		      document.getElementById("n4").disabled = true;
    		      document.getElementById("n5").disabled = true;
    		      document.getElementById("p2").disabled = true;
    		      document.getElementById("c3").disabled = true;
    		      document.getElementById("c4").disabled = true;
    		   }
      }
   </script>
	<center>
		<h2>新規登録</h2>
		<!-- アカウントの新規登録を行なう -->
		<form action="/firstlogin" method="post">
			<table border=1>

				<tr>
					<td><label>氏名</label></td>
					<td><input class="left" type="text" name="name" id="ID"></td>
				</tr>
				<%	if((error & 1) == 1){ %>
				<tr>
					<td><label class="rcolor">※氏名が未入力です</label></td>
				</tr>
				<%	} %>

				<%	if((error & 2) == 2){ %>
				<tr>
					<td><label class="rcolor">※適切な氏名を入力してください</label></td>
				</tr>
				<%	} %>

				<tr>
					<td><label>表示名</label></td>
					<td><input class="left" type="text" name="name2" id="ID"></td>
				</tr>
				<%	if((error & 4) == 4){ %>
				<tr>
					<td><label class="rcolor">※表示名が未入力です</label></td>
				</tr>
				<%	} %>
				<%	if((error & 8) == 8){ %>
				<tr>
					<td><label class="rcolor">※適切な表示名を入力してください</label></td>
				</tr>
				<%	} %>
				<tr>
					<td><label>メールアドレス</label></td>
					<td><input class="left" type="text" name="mail" id="ID"></td>
				</tr>
				<%	if((error & 16) == 16){ %>
				<tr>
					<td><label class="rcolor">※メールアドレスが未入力です</label></td>
				</tr>
				<%	} %>
				<%	if((error & 32) == 32){ %>
				<tr>
					<td><label class="rcolor">※適切なメールアドレスを入力してください</label></td>
				</tr>
				<%	} %>
				<%	if((error & (131072*2)) == 131072*2){ %>
				<tr>
					<td><label class="rcolor">※メールアドレスが重複しています</label></td>
				</tr>
				<%	} %>

				<tr>
					<td><label>パスワード(4桁)</label></td>
					<td><input type="password" name="pass"></td>
				</tr>
				<%	if((error & 64) == 64){ %>
				<tr>
					<td><label class="rcolor">※ パスワード欄が未入力です</label></td>
				</tr>
				<%	} %>

				<tr>
					<td><label>パスワード(確認用)</label></td>
					<td><input type="password" name="pass2"></td>
				</tr>
				<%	if((error & 128) == 128){ %>
				<tr>
					<td><label class="rcolor">※ パスワード(確認用)欄が未入力です</label></td>
				</tr>
				<%	} %>
				<%	if((error & 256) == 256){ %>
				<tr>
					<td><label class="rcolor">※ パスワードが一致しません</label></td>
				</tr>
				<%	} %>
				<%	if((error & 512) == 512){ %>
				<tr>
					<td><label class="rcolor">※ 4桁のパスワードを入力してください</label></td>
				</tr>
				<%	} %>
				<%	if((error & 1024) == 1024){ %>
				<tr>
					<td><label class="rcolor">※ パスワードに使用できるのは半角英数字のみです</label></td>
				</tr>
				<%}%>

				<tr>
					<td><label>区画数</label></td>
					<td><input class="left" type="text" name="num" id="ID"></td>
				</tr>
				<%	if((error & 2048) == 2048){ %>
				<tr>
					<td><label class="rcolor">※区画数が未入力です</label></td>
				</tr>
				<%	} %>
				<%	if((error & 4096) == 4096){ %>
				<tr>
					<td><label class="rcolor">※適切な区画数を入力してください</label></td>
				</tr>
				<%	} %>
				<tr>
					<td colspan=2><b>住所</b></td>
				</tr>

				<tr>
					<td><label>郵便番号</label></td>
					<td><input class="left" type="text" name="num2" id="ID"
						size="3"> <label> - </label><input class="left"
						type="text" name="num3" id="ID" size="4"></td>
				</tr>
				<%	if((error & 8192) == 8192){ %>
				<tr>
					<td><label class="rcolor">※郵便番号が未入力です</label></td>
				</tr>
				<%	} %>

				<tr>
					<td><label>都道府県</label></td>
					<td><select name="prefectures" id="ID">
							<option value="1">北海道</option>
							<option value="2">青森</option>
							<option value="3">岩手</option>
							<option value="4">宮城</option>
							<option value="5">秋田</option>
							<option value="6">山形</option>
							<option value="7">福島</option>
							<option value="8">茨城</option>
							<option value="9">栃木</option>
							<option value="10">群馬</option>
							<option value="11">埼玉</option>
							<option value="12">千葉</option>
							<option value="13">東京</option>
							<option value="14">神奈川</option>
							<option value="15">新潟</option>
							<option value="16">富山</option>
							<option value="17">石川</option>
							<option value="18">福井</option>
							<option value="19">山梨</option>
							<option value="20">長野</option>
							<option value="21">岐阜</option>
							<option value="22">静岡</option>
							<option value="23">愛知</option>
							<option value="24">三重</option>
							<option value="25">滋賀</option>
							<option value="26">京都府</option>
							<option value="27">大阪府</option>
							<option value="28">兵庫</option>
							<option value="29">奈良</option>
							<option value="30">和歌山</option>
							<option value="31">鳥取</option>
							<option value="32">島根</option>
							<option value="33">岡山</option>
							<option value="34">広島</option>
							<option value="35">山口</option>
							<option value="36">徳島</option>
							<option value="37">香川</option>
							<option value="38">愛媛</option>
							<option value="39">高知</option>
							<option value="40">福岡</option>
							<option value="41">佐賀</option>
							<option value="42">長崎</option>
							<option value="43">熊本</option>
							<option value="44">大分</option>
							<option value="45">宮崎</option>
							<option value="46">鹿児島</option>
							<option value="47">沖縄</option>
					</select></td>
				</tr>
				<tr>
					<td><label>市町村</label></td>
					<td><input class="left" type="text" name="city" id="ID"></td>
				</tr>
				<%	if((error & 16384) == 16384){ %>
				<tr>
					<td><label class="rcolor">※市町村が未入力です</label></td>
				</tr>
				<%	} %>
				<%	if((error & 32768) == 32768){ %>
				<tr>
					<td><label class="rcolor">※適切な市町村を入力してください</label></td>
				</tr>
				<%} %>
				<tr>
					<td><label>番地以下すべて</label></td>
					<td><input class="left" type="text" name="city2" id="ID"></td>
				</tr>
				<%	if((error & 65536) == 65536){ %>
				<tr>
					<td><label class="rcolor">※番地が未入力です</label></td>
				</tr>
				<%	} %>
				<%	if((error & 131072) == 131072){ %>
				<tr>
					<td><label class="rcolor">※適切な番地を入力してください</label></td>
				</tr>
				<%}%>
				<tr>
					<td><label>住所とビニールハウスの所在地が異なる</label></td>
					<td><input type="checkbox" name="1" value="1" onclick="checkValue(this.checked)"></td>
				</tr>

				<tr>
					<td colspan=2><b>ビニールハウスの所在地</b></td>
				</tr>
				<tr>
					<td><label>郵便番号</label></td>
					<td><input class="left" type="text" name="number4" id="n4"
							size="3" disabled="disabled"> 
							<label> - </label>
							<input class="left" type="text" name="number5" id="n5" 
							size="4" disabled="disabled"></td>
				</tr>
				<tr>
					<td><label>都道府県</label></td>
					<td><select name="prefectures2" id="p2" disabled="disabled">
							<option value="1">北海道</option>
							<option value="2">青森</option>
							<option value="3">岩手</option>
							<option value="4">宮城</option>
							<option value="5">秋田</option>
							<option value="6">山形</option>
							<option value="7">福島</option>
							<option value="8">茨城</option>
							<option value="9">栃木</option>
							<option value="10">群馬</option>
							<option value="11">埼玉</option>
							<option value="12">千葉</option>
							<option value="13">東京</option>
							<option value="14">神奈川</option>
							<option value="15">新潟</option>
							<option value="16">富山</option>
							<option value="17">石川</option>
							<option value="18">福井</option>
							<option value="19">山梨</option>
							<option value="20">長野</option>
							<option value="21">岐阜</option>
							<option value="22">静岡</option>
							<option value="23">愛知</option>
							<option value="24">三重</option>
							<option value="25">滋賀</option>
							<option value="26">京都府</option>
							<option value="27">大阪府</option>
							<option value="28">兵庫</option>
							<option value="29">奈良</option>
							<option value="30">和歌山</option>
							<option value="31">鳥取</option>
							<option value="32">島根</option>
							<option value="33">岡山</option>
							<option value="34">広島</option>
							<option value="35">山口</option>
							<option value="36">徳島</option>
							<option value="37">香川</option>
							<option value="38">愛媛</option>
							<option value="39">高知</option>
							<option value="40">福岡</option>
							<option value="41">佐賀</option>
							<option value="42">長崎</option>
							<option value="43">熊本</option>
							<option value="44">大分</option>
							<option value="45">宮崎</option>
							<option value="46">鹿児島</option>
							<option value="47">沖縄</option>
					</select></td>
				</tr>
				<tr>
					<td><label>市町村</label></td>
					<td><input class="left" type="text" name="city3" id="c3" disabled="disabled"></td>
				</tr>
				<tr>
					<td><label>番地以下すべて</label></td>
					<td><input class="left" type="text" name="city4" id="c4" disabled="disabled"></td>
				</tr>

			</table>
			<input class="submit" type="submit" value="登録" />
		</form>
	</center>
</body>
</html>
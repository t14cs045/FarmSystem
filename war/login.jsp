<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ビニールハウス室内温度管理システム ログイン</title>
</head>
<body>

	<h3>ビニールハウス室内温度管理システム ログイン</h3>

	<div
		style="background: #ffffff; padding: 10px 10px 10px 10px; border: 2px solid #000000; border-radius: 10px; width: 500px; margin-right: auto; margin-left: auto;">


		<form action="/login" method="post">

			<table>
				<tr>
					<td width="150" align="center">メールアドレス</td>
					<td width="300"><input type="text" name="mail" size="20"></input>
				</tr>
				<tr>
					<td width="150" align="center">パスワード</td>
					<td width="300"><input type="password" name="password"
						size="20"></input>
				</tr>
			</table>

			<div align="center">
				<input type="submit" value="ログイン"
					style="width: 100px; height: 50px; font-size: 20px;"></input>
			</div>

		</form>


	</div>

</body>
</html>

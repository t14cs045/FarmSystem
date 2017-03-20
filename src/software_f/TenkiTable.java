package software_f;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

/*int tenkiは次のように定義する
 * 
 * 0 ... 晴れ
 * 1 ... 曇り
 * 2 ... 雨
 * 3 ... 雪
 * 
 * */

//Memoクラスでカインド（テーブル）を定義するための宣言
@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class TenkiTable {

	// メンバ id はエンティティ（タプル）のキーである
	@PrimaryKey
	// メンバ id の値はシステムが自動的に重複しないようつける
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Long ID;

	// メンバ content をデータストアに書き込む
	@Persistent
	private int ondo;

	// メンバ date をデータストアに書き込む
	@Persistent
	private int tenki;

	// メンバ date をデータストアに書き込む
	@Persistent
	private Long userID;

	// メンバ date をデータストアに書き込む
	@Persistent
	private int date;

	public TenkiTable(int ondo, int tenki, Long userID, int date) {
		super();
		this.ondo = ondo;
		this.tenki = tenki;
		this.userID = userID;
		this.date = date;
	}

	public Long getID() {
		return ID;
	}

	public int getOndo() {
		return ondo;
	}

	public void setOndo(int ondo) {
		this.ondo = ondo;
	}

	public int getTenki() {
		return tenki;
	}

	public void setTenki(int tenki) {
		this.tenki = tenki;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public int getDate() {
		return date;
	}

	public void setDate(int date) {
		this.date = date;
	}

}
package software_f;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

//Memoクラスでカインド（テーブル）を定義するための宣言
@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Kozinjouhou {

	// メンバ id はエンティティ（タプル）のキーである
	@PrimaryKey
	// メンバ id の値はシステムが自動的に重複しないようつける
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Long userID;

	// メンバ content をデータストアに書き込む
	@Persistent
	private String simei;

	// メンバ date をデータストアに書き込む
	@Persistent
	private String hyouzimei;

	// メンバ date をデータストアに書き込む
	@Persistent
	private String mailaddress;

	// メンバ date をデータストアに書き込む
	@Persistent
	private String password;

	// メンバ date をデータストアに書き込む
	@Persistent
	private int kukakusuu;

	// メンバ date をデータストアに書き込む
	@Persistent
	private String yuubinbangou;

	// メンバ date をデータストアに書き込む
	@Persistent
	private String todoufuken;

	// メンバ date をデータストアに書き込む
	@Persistent
	private String sityouson;

	// メンバ date をデータストアに書き込む
	@Persistent
	private String banchiika;

	// メンバ date をデータストアに書き込む
	@Persistent
	private String sakumotu;

	public Long getUserID() {
		return userID;
	}

	// 引数付きコンストラクタ
	public Kozinjouhou(String simei, String hyouzimei, String mailaddress, String password, int kukakusuu,
			String yuubinbangou, String todoufuken, String sityouson, String banchiika, String sakumotu) {
		super();
		this.simei = simei;
		this.hyouzimei = hyouzimei;
		this.mailaddress = mailaddress;
		this.password = password;
		this.kukakusuu = kukakusuu;
		this.yuubinbangou = yuubinbangou;
		this.todoufuken = todoufuken;
		this.sityouson = sityouson;
		this.banchiika = banchiika;
		this.sakumotu = sakumotu;
	}

	// ゲッタとセッタ
	public String getSimei() {
		return simei;
	}

	public void setSimei(String simei) {
		this.simei = simei;
	}

	public String getHyouzimei() {
		return hyouzimei;
	}

	public void setHyouzimei(String hyouzimei) {
		this.hyouzimei = hyouzimei;
	}

	public String getMailaddress() {
		return mailaddress;
	}

	public void setMailaddress(String mailaddress) {
		this.mailaddress = mailaddress;
	}

	public void setSakumotu(String sakumotu) {
		this.sakumotu = sakumotu;
	}

	public String getSakumotu() {
		return sakumotu;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getKukakusuu() {
		return kukakusuu;
	}

	public void setKukakusuu(int kukakusuu) {
		this.kukakusuu = kukakusuu;
	}

	public String getYuubinbangou() {
		return yuubinbangou;
	}

	public void setYuubinbangou(String yuubinbangou) {
		this.yuubinbangou = yuubinbangou;
	}

	public String getTodoufuken() {
		return todoufuken;
	}

	public void setTodoufuken(String todoufuken) {
		this.todoufuken = todoufuken;
	}

	public String getSityouson() {
		return sityouson;
	}

	public void setSityouson(String sityouson) {
		this.sityouson = sityouson;
	}

	public String getBanchiika() {
		return banchiika;
	}

	public void setBanchiika(String banchiika) {
		this.banchiika = banchiika;
	}

}
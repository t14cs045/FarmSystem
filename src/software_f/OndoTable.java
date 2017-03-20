package software_f;

import java.util.Date;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

//Memoクラスでカインド（テーブル）を定義するための宣言
@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class OndoTable {

	// メンバ id はエンティティ（タプル）のキーである
	@PrimaryKey
	// メンバ id の値はシステムが自動的に重複しないようつける
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Long id;

	@Persistent
	private Long userID;

	@Persistent
	private Date hiduke;

	@Persistent
	private int jikoku;

	@Persistent
	private int kukakubanngou;

	@Persistent
	private int ondo;

	// 引数付きコンストラクタ
	public OndoTable(Long userID, Date hiduke, int jikoku, int kukakubanngou, int ondo) {
		super();
		this.userID = userID;
		this.hiduke = hiduke;
		this.jikoku = jikoku;
		this.kukakubanngou = kukakubanngou;
		this.ondo = ondo;
	}

	// ゲッタとセッタ
	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public Date getHiduke() {
		return hiduke;
	}

	public int getJikoku() {
		return jikoku;
	}

	public void setKukakubanngou(int kukakubanngou) {
		this.kukakubanngou = kukakubanngou;
	}

	public int getKukakubanngou() {
		return kukakubanngou;
	}

	public Long getId() {
		return id;
	}

	public void setHiduke(Date hiduke) {
		this.hiduke = hiduke;
	}

	public void setJikoku(int jikoku) {
		this.jikoku = jikoku;
	}

	public void setOndo(int ondo) {
		this.ondo = ondo;
	}

	public int getOndo() {
		return ondo;
	}
}
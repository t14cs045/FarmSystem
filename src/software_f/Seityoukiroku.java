package software_f;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

//Memoクラスでカインド（テーブル）を定義するための宣言
@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Seityoukiroku {

	// メンバ id はエンティティ（タプル）のキーである
	@PrimaryKey
	// メンバ id の値はシステムが自動的に重複しないようつける
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Long seityoukirokuId;

	// ユーザーIDをデータストアに書き込む
	@Persistent
	private Long userID;

	// 作物IDをデータストアに書き込む
	@Persistent
	private Long sakumotuID;

	// 生長段階をデータストアに書き込む
	@Persistent
	private int seityoudankaibangou;

	// 作業段階IDをデータストアに書き込む
	@Persistent
	private int sagyoubangou;

	// 日付をデータストアに書き込む
	@Persistent
	private int date;

	// コメントをデータストアに書き込む
	@Persistent
	private String comment;

	public Seityoukiroku(Long userID, Long sakumotuID, int seityoudankaibangou, int sagyoubangou, int date,
			String comment) {
		super();
		this.userID = userID;
		this.sakumotuID = sakumotuID;
		this.seityoudankaibangou = seityoudankaibangou;
		this.sagyoubangou = sagyoubangou;
		this.date = date;
		this.comment = comment;
	}

	public Long getSeityoukirokuId() {
		return seityoukirokuId;
	}

	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}

	public Long getSakumotuID() {
		return sakumotuID;
	}

	public void setSakumotuID(Long sakumotuID) {
		this.sakumotuID = sakumotuID;
	}

	public int getSeityoudankaibangou() {
		return seityoudankaibangou;
	}

	public void setSeityoudankaibangou(int seityoudankaibangou) {
		this.seityoudankaibangou = seityoudankaibangou;
	}

	public int getSagyoubangou() {
		return sagyoubangou;
	}

	public void setSagyoubangou(int sagyoubangou) {
		this.sagyoubangou = sagyoubangou;
	}

	public int getDate() {
		return date;
	}

	public void setDate(int date) {
		this.date = date;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

}

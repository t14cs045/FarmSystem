package software_f;

import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.IdentityType;
import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;

//Memoクラスでカインド（テーブル）を定義するための宣言
@PersistenceCapable(identityType = IdentityType.APPLICATION)
public class Sakumotujyouhou {

	// メンバ id はエンティティ（タプル）のキーである
	@PrimaryKey
	// メンバ id の値はシステムが自動的に重複しないようつける
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Long sakumotuID;

	// メンバ content をデータストアに書き込む
	@Persistent
	private String sakumotumei;

	// メンバ date をデータストアに書き込む
	@Persistent
	private double saitekiondo;

	public Long getSakumotuID() {
		return sakumotuID;
	}

	// 引数付きコンストラクタ
	public Sakumotujyouhou(String sakumotumei, double saitekiondo) {
		this.sakumotumei = sakumotumei;
		this.saitekiondo = saitekiondo;

	}

	public String getSakumotumei() {
		return sakumotumei;
	}

	public void setSakumotumei(String sakumotumei) {
		this.sakumotumei = sakumotumei;
	}

	public double getSaitekiondo() {
		return saitekiondo;
	}

	public void setSaitekiondo(double saitekiondo) {
		this.saitekiondo = saitekiondo;
	}

}

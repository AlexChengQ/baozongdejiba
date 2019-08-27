package com.bylz.quantumCloud.model;

public class QcodeMethRandomEntity {
	/**金额 单位：元*/
	private Double amount;
	/**概率 */
	private Double chance;

	public QcodeMethRandomEntity() {
		super();
	}

	public QcodeMethRandomEntity(Double amount, Double chance) {
		super();
		this.amount = amount;
		this.chance = chance;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public Double getChance() {
		return chance;
	}

	public void setChance(Double chance) {
		this.chance = chance;
	}
	
	
}

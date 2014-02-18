require "rspec"

require_relative "account"

describe Account do

    let(:account_number) {"1234567890"}
    let(:account)  {Account.new(account_number)}

  describe "#initialize" do
    it "should raise error if invalid account num is passed" do
      expect { Account.new("12") }.to raise_error(InvalidAccountNumberError)
    end

    it "starting balance should be zero if no starting balance passed initially" do
      expect(account.balance).to eq(0)
    end
  end

  describe "#transactions" do
    it "should return an array of transaction ammount numbers" do
      account.deposit!(1000)
      account.withdraw!(5)
      account.withdraw!(10)
      account.withdraw!(100)
      expect(account.transactions).to eq([0, 1000, -5, -10, -100])
    end
  end

  describe "#balance" do
    it "should add all transactions" do
      account.deposit!(1000)
      account.withdraw!(5)
      account.withdraw!(10)
      account.withdraw!(100)
      expect(account.balance).to eq 885
    end
  end

  describe "#account_number" do
    it "should return account number with six digits obfuscated" do
      expect(account.acct_number).to eq("******7890")
    end
  end

  describe "deposit!" do
    it "should add to balance" do
      expect(account.deposit!(10)).to eq(10)
    end

    it "should raise error for negative deposit error" do
      expect { account.deposit!(-100)}.to raise_error(NegativeDepositError)
    end
  end

  describe "#withdraw!" do
    it "should decrease balance" do
      account.deposit!(20)
      expect(account.withdraw!(10)).to eq(10)
    end

    it "should raise OverdraftError if withdrawal is greater than balance" do
      expect { account.withdraw!(100) }.to raise_error(OverdraftError)
    end
  end
end

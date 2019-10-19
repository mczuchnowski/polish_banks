# frozen_string_literal: true

require 'spec_helper'
require 'polish_banks'

RSpec.describe PolishBank do
  subject { described_class.new(iban) }

  describe "standard iban check" do
    let(:iban) { "PL9912406999" }

    it "detects bank name" do
      expect(subject.name).to be_a String
      expect(subject.name.length).to be_positive
    end

    it "detects bank branch" do
      expect(subject.branch).to be_a String
      expect(subject.branch.length).to be_positive
    end

    context "with only partial match" do
      let(:iban) { "PL9912406666" }

      it "detects bank name" do
        expect(subject.name).to be_a String
        expect(subject.name.length).to be_positive
      end

      it "detects bank branch" do
        expect(subject.branch).to be_a String
        expect(subject.branch.length).to be_zero
      end
    end

    context "with special characters" do
      let(:iban) { "99-1240 6999" }

      it "detects bank name" do
        expect(subject.name).to be_a String
        expect(subject.name.length).to be_positive
      end

      it "detects bank branch" do
        expect(subject.branch).to be_a String
        expect(subject.branch.length).to be_positive
      end
    end
  end

  describe "account number check" do
    let(:iban) { "9912406999" }

    it "detects bank name" do
      expect(subject.name).to be_a String
      expect(subject.name.length).to be_positive
    end

    it "detects bank branch" do
      expect(subject.branch).to be_a String
      expect(subject.branch.length).to be_positive
    end
  end

  describe "error raising" do
    context "foreign iban" do
      let(:iban) { "DE9912406999" }

      it "raises UnsupportedCountry error" do
        expect { subject }.to raise_error(UnsupportedCountry, "Iban #{iban} is not Polish")
      end
    end

    context "unknown bank" do
      let(:iban) { "PL6666666666" }

      it "raises BankNotFound error" do
        expect { subject }.to raise_error(BankNotFound, "Polish bank not found for #{iban}")
      end
    end
  end
end

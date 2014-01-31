# encoding: UTF-8

# Copyright 2012 Twitter, Inc
# http://www.apache.org/licenses/LICENSE-2.0

require 'spec_helper'

describe TwitterCldr::Normalization do

  describe "#normalize" do
    let(:string) { 'string' }
    let(:normalized_string) { 'normalized' }

    it 'it uses NFD by default' do
      mock(TwitterCldr::Normalization::NFD).normalize(string) { normalized_string }
      TwitterCldr::Normalization.normalize(string).should == normalized_string
    end

    it "uses specified algorithm if there is any" do
      mock(TwitterCldr::Normalization::NFKD).normalize(string) { normalized_string }
      TwitterCldr::Normalization.normalize(string, :using => :NFKD).should == normalized_string
    end

    it "raises an ArgumentError if passed an unsupported normalizer name" do
      lambda do
        TwitterCldr::Normalization.normalize(string, :using => :blarg)
      end.should raise_error(ArgumentError)
    end

    it 'accepts normalizer name in a lower case' do
      mock(TwitterCldr::Normalization::NFKD).normalize(string) { normalized_string }
      TwitterCldr::Normalization.normalize(string, :using => :nfkd).should == normalized_string
    end

    it 'accepts a string' do
      mock(TwitterCldr::Normalization::NFKD).normalize(string) { normalized_string }
      TwitterCldr::Normalization.normalize(string, :using => 'NFKD').should == normalized_string
    end

  end

end
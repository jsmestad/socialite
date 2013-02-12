require 'spec_helper'

class Account; end
class Authentication; end

class User; end
class Identity; end

describe Socialite do
  context "configuration" do
    it 'is configurable through .setup' do
      Socialite.setup do |c|
        c.should be_kind_of(Module)
      end
    end

    describe 'configuring classes' do

      describe 'the default values' do
        before do
          Socialite.setup do |c|
            c.user_class = nil
            c.identity_class = nil
          end
        end

        its(:user_class) { should eql(User) }
        its(:identity_class) { should eql(Identity) }
      end

      describe 'accessors that manipulate default values' do
        before do
          Socialite.setup do |c|
            c.user_class = 'Account'
            c.identity_class = 'Authentication'
          end
        end

        its(:user_class) { should eql(Account) }
        its(:identity_class) { should eql(Authentication) }

        after do
          Socialite.setup do |c|
            c.user_class = nil
            c.identity_class = nil
          end
        end
      end
    end

    describe 'accepting provider information' do
      before do
        Socialite.providers = nil
        Socialite.setup do |c|
          c.provider :facebook, 'xyz', '123'
          c.provider :twitter, 'abc', '789'
        end
      end

      subject { Socialite.providers }

      its(:size) { should == 2 }

      describe 'holds all the provider parameters for OmniAuth' do
        it 'has facebook data' do
          subject.first[0].should == :facebook
          subject.first[1].should == ['xyz', '123']
        end

        it 'has twitter data' do
          subject.last[0].should == :twitter
          subject.last[1].should == ['abc', '789']
        end
      end
    end
  end
end

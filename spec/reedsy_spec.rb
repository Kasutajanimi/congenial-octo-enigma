require 'spec_helper'
require_relative '../reedsy'

describe "Team" do

  describe "Printing Strategy" do
    it "Team sends print message to printer" do
      #printer = double("printer")
      #printer.stub(:print)
      #hero = Hero.new printer

      #printer.should_receive(:print).with(hero.damage, hero.health, hero.skills)
      #hero.print_stats
    end

    it "ProPrinter responds to printer message" do
      1==1
    end
    it "ReversePrinter responds to printer message" do
      #expect(BattleStats.new).to respond_to(:print)
      1==1
    end
    it "PresentationPrinter responds to printer message" do
      #expect(SkillsStats.new).to respond_to(:print)
      1==1
    end
    it "FunnyPrinter responds to printer message" do
      1==1
    end
    it "FunnyPrinter is not implemented yet" do
      1==1
    end
  end

  describe Team do
    describe "Printing members data" do
      it "pro printer prints up to 10 member names starting with capital letter" do
        team = Team.new(ProPrinter.new)
        5.times do
          team << ("rand_name_" + SecureRandom.hex)
        end

        capitalised_names = team.members_names.map{ |name| name.capitalize + "\n" }.join('')
        printer = Proc.new(&proc { team.print })

        expect(team.print).to eq(team.members_names)
        expect(printer).to output(capitalised_names).to_stdout
      end

      it "pro printer cannot print more than 10 member names" do
        team = Team.new(ProPrinter.new)
        15.times do
          team << ("rand_name_" + SecureRandom.hex)
        end

        capitalised_names = team.members_names[0..9].map{ |name| name.capitalize + "\n" }.join('')
        printer = Proc.new(&proc { team.print })

        expect(team.print).to eq(team.members_names[0..9])
        expect(printer).to output(capitalised_names).to_stdout
      end

      it "reverse printer prints member names in reverse order" do
        team = Team.new(ReversePrinter.new)

        15.times do
          team << ("rand_name_" + SecureRandom.hex)
        end
        reversed_names = team.members_names.reverse.map{ |name| name.downcase.reverse + "\n" }.join('')

        printer = Proc.new(&proc { team.print })

        expect(printer).to output(reversed_names).to_stdout
      end

      it "presentation printer accepts shows constant results when shuffle is false" do
        team = Team.new(PresentationPrinter.new)

        15.times do
          team << ("rand_name_" + SecureRandom.hex)
        end
        non_shuffled_names = team.members_names.map{ |name| "* " + name + "\n" }.join('')

        printer = Proc.new(&proc { team.print(false) })

        expect(printer).to output("Members:\n" + non_shuffled_names).to_stdout
      end

      it "presentation printer print member names in random order if param shuffle is true" do
        pending

        team = Team.new(PresentationPrinter.new)

        15.times do
          team << ("rand_name_" + SecureRandom.hex)
        end

        printer1 = Proc.new(&proc { team.print(false) })
        printer2 = Proc.new(&proc { team.print(false) })

        puts "output(printer2.call).to_stdout"

        expect(output(printer1.call).to_stdout).to output(printer2.call).to_stdout
      end

      it "presentation printer print member names in preserver order if param shuffle is false" do
      end

      it "funny printer is not implemented yet and has to print nothing" do
        team = Team.new(FunnyPrinter.new)

        15.times do
          team << ("rand_name_" + SecureRandom.hex)
        end

        printer = Proc.new(&proc { team.print })

        expect(printer).to output("").to_stdout
      end
    end

    describe "members" do
      let(:team) { Team.new }

      before type: :have_no_member do
        team.instance_variable_set(:@members, [])
      end

      before type: :have_one_member do
        team.instance_variable_set(:@members, [Team::Member.new("totally_secret_member_name")])
      end

      before type: :have_less_than_10_members do
        7.times do
          team << ("rand_name_" + SecureRandom.hex)
        end
      end

      before type: :have_more_than_10_members do
        15.times do
          team << ("rand_name_" + SecureRandom.hex)
        end
      end

      it "by default initialized with empty array", :type => :have_no_members do
        expect(team.instance_variable_get(:@members)).to be_empty
      end

      it "can add new member", :type => :have_one_member do
        NEW_MEMBER_NAME = "totally_secret_member_name_2".freeze
        team << (NEW_MEMBER_NAME)
        expect(team.instance_variable_get(:@members).length).to eq(2)
        expect(team.members_names).to include(NEW_MEMBER_NAME)
      end

      it "have a name", :type => :have_one_member do
        expect(team.instance_variable_get(:@members).length).to eq(1)
        expect(team.instance_variable_get(:@members).first.name).to eq("totally_secret_member_name")
      end

      it "can correctly print names of all members", :type => :have_more_than_10_members do
        team.instance_variable_get(:@members).each do |member|
          expect(team.members_names).to include(member.name)
        end
      end
    end
  end
end

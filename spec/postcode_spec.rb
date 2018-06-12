require 'spec_helper'

describe Postcodesio do

  context 'requesting information on a single postcode works correctly' do

    before(:all) do
      @postcodesio = Postcodesio.new('w93pt', ['w93pt','nw88sy'])

    end

    it "should respond with a status message of 200" do
      expect(@postcodesio.get_single_post_status).to eq 200
    end

    it "should have a results hash" do
      expect(@postcodesio.get_single_postcode).to be_kind_of(Hash)
    end

    it "should return a postcode between 5-7 in length"  do
      expect(@postcodesio.remove_space(@postcodesio.get_single_post_attributes("result", "postcode")).length).to be_between(5, 7)
    end
    #
    it "should return an quality key integer between 1-9" do
      expect(@postcodesio.get_single_post_attributes("result", "quality")).to be_between(1, 9)
    end
    #
    it "should return an ordnance survey eastings value as integer" do
      expect(@postcodesio.get_single_post_attributes("result", "eastings")).to be_kind_of(Integer)
    end
    #
    it "should return an ordnance survey northings value as integer" do
      expect(@postcodesio.get_single_post_attributes("result", "northings")).to be_kind_of(Integer)
    end
    #
    it "should return a country which is one of the four constituent countries of the UK" do
      expect(@postcodesio.get_single_post_attributes("result", "country")).to eq 'England'
    end

    it "should return a string value for NHS authority " do
      expect(@postcodesio.get_single_post_attributes("result", "nhs_ha")).to be_kind_of(String)
    end
    #
    it "should return a longitude float value" do
      expect(@postcodesio.get_single_post_attributes("result", "longitude")).to be_kind_of(Float)
    end
    #
    it "should return a latitude float value" do
      expect(@postcodesio.get_single_post_attributes("result", "latitude")).to be_kind_of(Float)
    end

    it "should return a parliamentary constituency string" do
      expect(@postcodesio.get_single_post_attributes("result", "primary_care_trust")).to be_kind_of(String)
    end
    #
    it "should return a european_electoral_region string" do
      expect(@postcodesio.get_single_post_attributes("result", "european_electoral_region")).to be_kind_of(String)
    end
    #
    it "should return a primary_care_trust string" do
      expect(@postcodesio.get_single_post_attributes("result", "primary_care_trust")).to be_kind_of(String)
    end
    #
    it "should return a region string" do
      expect(@postcodesio.get_single_post_attributes("result", "region")).to be_kind_of(String)
    end
    #
    it "should return a parish string" do
      expect(@postcodesio.get_single_post_attributes("result", "parish")).to be_kind_of(String)
    end
    #
    it "should return a lsoa string" do
      expect(@postcodesio.get_single_post_attributes("result", "lsoa")).to be_kind_of(String)
    end
    #
    it "should return a msoa string" do
      expect(@postcodesio.get_single_post_attributes("result", "msoa")).to be_kind_of(String)
    end
    # # admin ward and county are not documented however tested below
    #
    it "should return a admin_district string" do
      expect(@postcodesio.get_single_post_attributes("result", "admin_district")).to be_kind_of(String)
    end
    #
    it "should return a incode string of three characters" do
      expect(@postcodesio.get_single_post_attributes("result", "incode").length).to be 3
    end
    #
    it "should return a incode string of 3-4 characters" do
      expect(@postcodesio.get_single_post_attributes("result", "incode").length).to be_between(3, 4)
    end
  end

  context "multiple postcodes validation" do

    before(:all) do
      @postcodesio = Postcodesio.new('w93pt', ['w93pt','nw88sy'])
    end

    it "should respond with a status message of 200" do
      expect(@postcodesio.get_multiple_postcodes_status).to eq 200
    end

    it "should return the first query as the first postcode in the postcodesio.single_post" do
      expect(@postcodesio.get_multiple_postcodes_query_first).to eq "w93pt"
    end

    it "should return the second query as the first postcode in the postcodesio.single_post" do
        expect(@postcodesio.get_multiple_postcodes_query_second).to eq "nw88sy"
    end

    it "should have a results hash" do
      expect(@postcodesio.get_multiple_postcodes).to be_kind_of(Hash)
    end

    it "should return a postcode between 5-7 in length"  do
      expect(@postcodesio.remove_space(@postcodesio.get_multi_post_attributes_1("result", "postcode")).length).to be_between(5, 7)
      expect(@postcodesio.remove_space(@postcodesio.get_multi_post_attributes_2("result", "postcode")).length).to be_between(5, 7)
    end

    it "should return an quality key integer between 1-9" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "quality")).to be_between(1, 9)
      expect(@postcodesio.get_multi_post_attributes_2("result", "quality")).to be_between(1, 9)
    end

    it "should return an ordnance survey eastings value as integer" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "eastings")).to be_kind_of(Integer)
      expect(@postcodesio.get_multi_post_attributes_2("result", "eastings")).to be_kind_of(Integer)
    end

    it "should return an ordnance survey northings value as integer" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "northings")).to be_kind_of(Integer)
      expect(@postcodesio.get_multi_post_attributes_2("result", "northings")).to be_kind_of(Integer)
    end

    it "should return a country which is one of the four constituent countries of the UK" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "country")).to eq "England"
      expect(@postcodesio.get_multi_post_attributes_2("result", "country")).to eq "England"
    end

    it "should return a string value for NHS authority " do
      expect(@postcodesio.get_multi_post_attributes_1("result", "nhs_ha")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "nhs_ha")).to be_kind_of(String)
    end

    it "should return a longitude float value" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "longitude")).to be_kind_of(Float)
      expect(@postcodesio.get_multi_post_attributes_2("result", "longitude")).to be_kind_of(Float)
    end

    it "should return a latitude float value" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "latitude")).to be_kind_of(Float)
      expect(@postcodesio.get_multi_post_attributes_2("result", "latitude")).to be_kind_of(Float)
    end

    it "should return a parliamentary constituency string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "parliamentary_constituency")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "parliamentary_constituency")).to be_kind_of(String)
    end

    it "should return a european_electoral_region string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "european_electoral_region")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "european_electoral_region")).to be_kind_of(String)
    end

    it "should return a primary_care_trust string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "primary_care_trust")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "primary_care_trust")).to be_kind_of(String)
    end

    it "should return a region string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "region")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "region")).to be_kind_of(String)
    end

    it "should return a parish string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "parish")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "parish")).to be_kind_of(String)
    end

    it "should return a lsoa string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "lsoa")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "lsoa")).to be_kind_of(String)
    end

    it "should return a msoa string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "msoa")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "msoa")).to be_kind_of(String)
    end
#     # admin ward and county are not documented however tested below

    it "should return a admin_district string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "admin_district")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "admin_district")).to be_kind_of(String)
    end

    it "should return a incode string of three characters" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "incode")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "incode")).to be_kind_of(String)
    end

    it "should return a msoa string" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "msoa")).to be_kind_of(String)
      expect(@postcodesio.get_multi_post_attributes_2("result", "msoa")).to be_kind_of(String)
    end

    it "should return a incode string of 3-4 characters" do
      expect(@postcodesio.get_multi_post_attributes_1("result", "incode").length).to be_between(3, 4)
      expect(@postcodesio.get_multi_post_attributes_2("result", "incode").length).to be_between(3, 4)
    end
  end
end

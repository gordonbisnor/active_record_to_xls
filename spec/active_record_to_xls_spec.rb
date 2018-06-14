require 'spec_helper'
require 'ostruct'


describe ActiveRecordToXls do

  let(:foo) {
    OpenStruct.new({
      title: "foo", description: "bar",
      attributes: {
        title: "foo", description: "bar"
      }
    })
  }

  let(:baz) {
    OpenStruct.new({
      title: "baz", description: "qux",
      attributes: {
        title: "baz", description: "qux"
      }
    })
  }
  
  let(:items) { [foo, baz] }
 
  
  describe 'being called' do
   
    let(:subject) { ActiveRecordToXls.call(items) }
   
    it 'returns a string' do
      expect(subject).to be_kind_of(String)
    end
  
    it 'contains expected string data' do
      expect(subject).to match(/foo/)
      expect(subject).to match(/bar/)
      expect(subject).to match(/baz/)
      expect(subject).to match(/qux/)
    end

  end

  context 'with header columns' do
  
    let(:subject) { ActiveRecordToXls.call( items, header_columns: ["GreatTitle","GreatDescription"] ) }
    
    it 'returns a string' do
      expect(subject).to be_kind_of(String)
    end
  end

  context 'with omitted header' do
  
    let(:subject) { ActiveRecordToXls.call( items, header: false ) }
    
    it 'returns a string' do
      expect(subject).to be_kind_of(String)
    end
  end

  context 'with prepend' do
    let(:subject) { ActiveRecordToXls.call( items, prepend: [["my title","my desc"]] ) }
    
    it 'contains expected string data' do
      expect(subject).to match(/my title/)
      expect(subject).to match(/my desc/)
    end

  end

  context 'with append' do
    let(:subject) { ActiveRecordToXls.call( items, append: [["my footer title","my footer desc"]] ) }
    
    it 'contains expected string data' do
      expect(subject).to match(/my footer title/)
      expect(subject).to match(/my footer desc/)
    end

  end

  context 'with only' do
    
    let(:subject) { ActiveRecordToXls.call( items, only: [:title] ) }
    
      it 'contains expected string data' do
      expect(subject).to match(/foo/)
      expect(subject).not_to match(/bar/)
      expect(subject).to match(/baz/)
      expect(subject).not_to match(/qux/)
    end

  end


  context 'with except' do
    
    let(:subject) { ActiveRecordToXls.call( items, except: [:title] ) }
    
      it 'contains expected string data' do
      expect(subject).not_to match(/foo/)
      expect(subject).to match(/bar/)
      expect(subject).not_to match(/baz/)
      expect(subject).to match(/qux/)
    end

  end

end
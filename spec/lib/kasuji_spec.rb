require 'rails_helper'
require 'kansuji'

RSpec.describe 'Kansuji test' do
  context "Number to Kansuji" do
    it '1 number' do
      expect(0.to_kansuji).to eq '零'
      expect(1.to_kansuji).to eq '一'
      expect(01.to_kansuji).to eq '一'
      expect(2.to_kansuji).to eq '二'
      expect(3.to_kansuji).to eq '三'
      expect(4.to_kansuji).to eq '四'
      expect(5.to_kansuji).to eq '五'
      expect(6.to_kansuji).to eq '六'
      expect(7.to_kansuji).to eq '七'
      expect(8.to_kansuji).to eq '八'
      expect(9.to_kansuji).to eq '九'
    end    

    it '2 number' do
      expect(10.to_kansuji).to eq '十'
      expect(13.to_kansuji).to eq '十三'
      expect(20.to_kansuji).to eq '二十'
      expect(30.to_kansuji).to eq '三十'
      expect(31.to_kansuji).to eq '三十一'
      expect(99.to_kansuji).to eq '九十九'
    end
    it '3 number' do
      expect(100.to_kansuji).to eq '百'
      expect(101.to_kansuji).to eq '百一'
      expect(224.to_kansuji).to eq '二百二十四'
      expect(333.to_kansuji).to eq '三百三十三'
      expect(409.to_kansuji).to eq '四百九'
    end
    it 'n number' do
      expect(100.to_kansuji).to eq '百'
      expect(1000.to_kansuji).to eq '千'
      expect(10000.to_kansuji).to eq '万'
      expect((10 ** 8).to_kansuji).to eq '億'
      expect((10 ** 12).to_kansuji).to eq '兆'
      expect((10 ** 16).to_kansuji).to eq '京'
      expect((10 ** 20).to_kansuji).to eq '垓'
      expect((10 ** 24).to_kansuji).to eq '𥝱'
      expect((10 ** 28).to_kansuji).to eq '穣'
      expect((10 ** 32).to_kansuji).to eq '溝'
      expect((10 ** 36).to_kansuji).to eq '澗'
      expect((10 ** 40).to_kansuji).to eq '正'
      expect((10 ** 44).to_kansuji).to eq '載'
      expect((10 ** 48).to_kansuji).to eq '極'
      expect((10 ** 52).to_kansuji).to eq '恒河沙'
      expect((10 ** 56).to_kansuji).to eq '恒河沙'
      expect((10 ** 60).to_kansuji).to eq '那由他'
      expect((10 ** 64).to_kansuji).to eq '不可思議'
      expect((10 ** 68).to_kansuji).to eq '無量大数'
    end
    it 'mixin number' do
      expect(75454652352.to_kansuji).to eq '七百五十四億五千四百六十五万二千三百五十二'
      expect(7545465235289756812.to_kansuji).to eq '七百五十四京五千四百六十五兆二千三百五十二億八千九百七十五万六千八百十二'
      expect((10 ** 20 + 4*10**16).to_kansuji).to eq '垓四京'
      expect((10 ** 24).to_kansuji).to eq '𥝱'
      expect((10 ** 28 + 3 * 10 ** 24).to_kansuji).to eq '穣三𥝱'
      expect('四千四百十三溝五千四百五十四穣八千九百四十四𥝱六千五百四十六垓七千六百七十九京四千四百六十五兆四千五百七十四億六千二百十五万六千三百二十四'.to_number).to eq 441_354_548_944_654_676_794_465_457_462_156_324
    end
  end
  
  context "Kansuji to number" do
    it '1 number' do
      expect('零'.to_number).to eq 0
      expect('一'.to_number).to eq 1
      expect('二'.to_number).to eq 2
      expect('三'.to_number).to eq 3
      expect('四'.to_number).to eq 4
      expect('五'.to_number).to eq 5
      expect('六'.to_number).to eq 6
      expect('七'.to_number).to eq 7
      expect('八'.to_number).to eq 8
      expect('九'.to_number).to eq 9
    end    

    it '2 number' do
      expect('十'.to_number).to eq 10
      expect('十三'.to_number).to eq 13
      expect('一十三'.to_number).to eq 13
      expect('二十'.to_number).to eq 20
      expect('三十'.to_number).to eq 30
      expect('三十一'.to_number).to eq 31
      expect('九十九'.to_number).to eq 99
    end
    it '3 number' do
      expect('百'.to_number).to eq 100
      expect('百一'.to_number).to eq 101
      expect('二百二十四'.to_number).to eq 224
      expect('三百三十三'.to_number).to eq 333
      expect('四百九'.to_number).to eq 409
    end
    it 'n number' do
      expect('百'.to_number).to eq 100
      expect('千'.to_number).to eq 1000
      expect('万'.to_number).to eq 10000
      expect('億'.to_number).to eq (10 ** 8)
      expect('兆'.to_number).to eq (10 ** 12)
      expect('京'.to_number).to eq (10 ** 16)
      expect('垓'.to_number).to eq (10 ** 20)
      expect('𥝱'.to_number).to eq (10 ** 24)
      expect('穣'.to_number).to eq (10 ** 28)
      expect('溝'.to_number).to eq (10 ** 32)
      expect('澗'.to_number).to eq (10 ** 36)
      expect('正'.to_number).to eq (10 ** 40)
      expect('載'.to_number).to eq (10 ** 44)
      expect('極'.to_number).to eq (10 ** 48)
      expect('恒河沙'.to_number).to eq (10 ** 52)
      # expect('恒河沙'.to_number).to eq (10 ** 56)
      expect('那由他'.to_number).to eq (10 ** 60)
      expect('不可思議'.to_number).to eq (10 ** 64)
      expect('無量大数'.to_number).to eq (10 ** 68)
    end
    it 'mixin number' do
      expect('七百五十四億五千四百六十五万二千三百五十二'.to_number).to eq 75454652352
      expect('七百五十四京五千四百六十五兆二千三百五十二億八千九百七十五万六千八百十二'.to_number).to eq 7545465235289756812
      expect('垓四京'.to_number).to eq (10 ** 20 + 4*10**16)
      expect('穣三𥝱'.to_number).to eq (10 ** 28 + 3 * 10 ** 24)
      expect('四千四百十三溝五千四百五十四穣八千九百四十四𥝱六千五百四十六垓七千六百七十九京四千四百六十五兆四千五百七十四億六千二百十五万六千三百二十四'.to_number).to eq 441_354_548_944_654_676_794_465_457_462_156_324
    end
  end
 
end
require 'fast_blank'

class ::String
  def blank2?
    /\A[[:space:]]*\z/ === self
  end
end

describe String do
  it 'works' do
    expect(''.blank?).to eq(true)
    expect(' '.blank?).to eq(true)
    expect("\r\n".blank?).to eq(true)
    "\r\n\v\f\r\s\u0085".blank? == true
  end

  it 'provides a parity with active support function' do
    (16**4).times do |i|
      c = i.chr('UTF-8') rescue nil
      next if c.nil?
      expect("#{i.to_s(16)} #{c.blank?}").to eq "#{i.to_s(16)} #{c.blank2?}"
    end

    256.times do |i|
      c = i.chr('ASCII') rescue nil
      next if c.nil?
      expect("#{i.to_s(16)} #{c.blank?}").to eq("#{i.to_s(16)} #{c.blank2?}")
    end
  end

  it 'treats \u0000 correctly' do
    expect("\u0000".strip.length).to eq(0)
    expect("\u0000".blank?).to be_falsey
  end
end

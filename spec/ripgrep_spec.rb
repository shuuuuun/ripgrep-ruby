RSpec.describe Ripgrep do
  let(:rg) do
    Ripgrep::Client.new
  end

  it 'has a version number' do
    expect(Ripgrep::VERSION).not_to be nil
  end

  it 'display version.' do
    expect(rg.version).to eq(`rg --version`)
  end

  it 'display help' do
    expect(rg.help).to eq(`rg --help`)
  end

  it 'exec' do
    expect(rg.exec('ripgrep').lines.sort).to eq(`rg ripgrep .`.split("\n").sort)
  end

  it 'exec specifying path' do
    expect(rg.exec('ripgrep', path: 'bin').lines.sort).to eq(`rg ripgrep bin`.split("\n").sort)
  end

  it 'exec when nomatch' do
    text = rand.to_s
    expect(rg.exec(text).to_s).to eq(`rg #{text} .`)
  end

  it 'exec with bad argument' do
    expect { rg.exec('--foobar') }.to raise_error(Ripgrep::ResultError)
  end

  it 'exec with cli options' do
    expect(rg.exec('ripgrep', options: { ignore_case: true }).lines.sort).to eq(`rg --ignore-case ripgrep .`.split("\n").sort)
    expect(rg.exec('The MIT License (MIT)', options: { fixed_strings: true }).lines.sort).to eq(`rg --fixed-strings 'The MIT License (MIT)' .`.split("\n").sort)
  end

  it 'run with block' do
    result = rg.run do
      rg '--ignore-case', 'ripgrep'
    end
    expect(result.lines.sort).to eq(`rg --ignore-case ripgrep .`.split("\n").sort)
    expect(rg.run { rg '--version' }.to_s).to eq(`rg --version`)
    expect(rg.run { rg.version }).to eq(`rg --version`)
  end
end

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
    expect(rg.exec('ripgrep').to_s.split("\n").sort).to eq(`rg ripgrep .`.split("\n").sort)
  end

  it 'exec specifying dir' do
    expect(rg.exec('ripgrep', dir: 'bin').to_s.split("\n").sort).to eq(`rg ripgrep bin`.split("\n").sort)
  end

  it 'exec when nomatch' do
    text = rand.to_s
    expect(rg.exec(text).to_s).to eq(`rg #{text} .`)
  end

  it 'exec with bad argument' do
    expect { rg.exec('--foobar') }.to raise_error(Ripgrep::ResultError)
  end

  it 'run with block' do
    result = rg.run do
      rg 'ripgrep', '--ignore-case'
    end
    expect(result.to_s.split("\n").sort).to eq(`rg ripgrep --ignore-case .`.split("\n").sort)
    expect(rg.run { rg '--version' }.to_s).to eq(`rg --version`)
    expect(rg.run { rg.version }.to_s).to eq(`rg --version`)
  end
end

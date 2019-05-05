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
    expect(rg.exec('ripgrep').split("\n").sort).to eq(`rg ripgrep .`.split("\n").sort)
  end

  it 'exec specifying dir' do
    expect(rg.exec('ripgrep', dir: 'bin').split("\n").sort).to eq(`rg ripgrep bin`.split("\n").sort)
  end

  it 'exec when nomatch' do
    expect { rg.exec(rand.to_s) }.to raise_error(Ripgrep::NoMatchError)
  end

  it 'exec with bad argument' do
    expect { rg.exec('--foobar') }.to raise_error(Ripgrep::CommandExecutionError)
  end
end

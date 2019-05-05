RSpec.describe Ripgrep do
  let(:rg) do
    Ripgrep::Core
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
end

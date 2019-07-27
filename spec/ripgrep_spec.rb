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
    expected = `rg --ignore-case ripgrep .`.split("\n").sort
    expect(rg.exec('ripgrep', options: { ignore_case: true }).lines.sort).to eq(expected)
    expect(rg.exec('ripgrep', options: { ignore_case: false }).lines.sort).not_to eq(expected)
    expected = `rg --fixed-strings 'The MIT License (MIT)' .`.split("\n").sort
    expect(rg.exec('The MIT License (MIT)', options: { fixed_strings: true }).lines.sort).to eq(expected)
    expect(rg.exec('The MIT License (MIT)', options: { fixed_strings: false }).lines.sort).not_to eq(expected)
  end

  it 'exec with verbose option' do
    client = Ripgrep::Client.new
    expect { client.exec('ripgrep') }.not_to output.to_stdout
    expect { client.exec('ripgrep', verbose: true) }.to output.to_stdout
    expect { client.exec('ripgrep', verbose: false) }.not_to output.to_stdout

    client = Ripgrep::Client.new(verbose: true)
    expect { client.exec('ripgrep') }.to output.to_stdout
    expect { client.exec('ripgrep', verbose: true) }.to output.to_stdout
    expect { client.exec('ripgrep', verbose: false) }.not_to output.to_stdout

    client = Ripgrep::Client.new(verbose: false)
    expect { client.exec('ripgrep') }.not_to output.to_stdout
    expect { client.exec('ripgrep', verbose: true) }.to output.to_stdout
    expect { client.exec('ripgrep', verbose: false) }.not_to output.to_stdout
  end

  it 'result.matches interface' do
    result = rg.exec 'require', path: 'lib'
    expected = `rg require lib`.split("\n").sort
    expect(result.matches.size).to eq(expected.size)
    expect(result.matches.map(&:to_s).sort).to eq(expected)
  end

  it 'run with block' do
    result = rg.run do
      rg '--ignore-case', 'ripgrep'
    end
    expect(result.lines.sort).to eq(`rg --ignore-case ripgrep .`.split("\n").sort)
    expect(rg.run { rg '--version' }.to_s).to eq(`rg --version`)
    expect(rg.run { rg.version }).to eq(`rg --version`)
  end

  it 'Ripgrep.run' do
    rspec = self
    Ripgrep.run do
      # include RSpec::Matchers
  
      result = rg '--ignore-case', 'ripgrep'
      rspec.expect(result.lines.sort).to rspec.eq(`rg --ignore-case ripgrep .`.split("\n").sort)
  
      result = rg '--version'
      rspec.expect(result.to_s).to rspec.eq(`rg --version`)
      rspec.expect(rg.version).to rspec.eq(`rg --version`)
  
      result = rg '--help'
      rspec.expect(result.to_s).to rspec.eq(`rg --help`)
      rspec.expect(rg.help).to rspec.eq(`rg --help`)
    end
  end
end

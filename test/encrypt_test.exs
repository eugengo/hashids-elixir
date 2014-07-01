defmodule SaltieTest.Encrypt do
  use ExUnit.Case

  import SaltieTest.Helpers

  test "default key" do
    s = Saltie.new()
    for {num, cipher} <- tests_from_fixture("default_key") do
      assert cipher == Saltie.encrypt(s, num)
      assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "default key large" do
    s = Saltie.new()
    for {num, cipher} <- tests_from_fixture("default_key_large") do
      assert cipher == Saltie.encrypt(s, num)
      #assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "short alphabet" do
    s = Saltie.new(alphabet: 'abc1029384756XYZ')
    for {num, cipher} <- tests_from_fixture("short_alphabet") do
      assert cipher == Saltie.encrypt(s, num)
      assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "short alphabet large" do
    s = Saltie.new(alphabet: 'abc1029384756XYZ')
    for {num, cipher} <- tests_from_fixture("short_alphabet_large") do
      assert cipher == Saltie.encrypt(s, num)
      #assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "min length 3" do
    s = Saltie.new(min_len: 3)
    for {num, cipher} <- tests_from_fixture("min_length_3") do
      assert cipher == Saltie.encrypt(s, num)
      assert length(cipher) >= 3
      assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "min length 20" do
    s = Saltie.new(min_len: 20)
    for {num, cipher} <- tests_from_fixture("min_length_20") do
      assert cipher == Saltie.encrypt(s, num)
      assert length(cipher) == 20
      assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "min length 20 large" do
    s = Saltie.new(min_len: 20, alphabet: 'abcdefghijklmnop0')
    for {num, cipher} <- tests_from_fixture("min_length_20_large") do
      assert cipher == Saltie.encrypt(s, num)
      assert length(cipher) > 20
      #assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "custom key 1" do
    s = Saltie.new(key: 'hello world')
    for {num, cipher} <- tests_from_fixture("key_hello_world") do
      assert cipher == Saltie.encrypt(s, num)
      assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "custom key 2" do
    s = Saltie.new(key: '123_-+EBNFarigatou')
    for {num, cipher} <- tests_from_fixture("key_gibberish") do
      assert cipher == Saltie.encrypt(s, num)
      assert [num] == Saltie.decrypt(s, cipher)
    end
  end

  test "custom key large" do
    s = Saltie.new(key: '-->secret key, no salt<--')
    for {num, cipher} <- tests_from_fixture("custom_key_large") do
      assert cipher == Saltie.encrypt(s, num)
      #assert [num] == Saltie.decrypt(s, cipher)
    end
  end
end

# frozen_string_literal: true

# メソッド１：number_of_rowが行数になるような二次元配列を作り、最終行の要素が足りなかったら要素数を揃える
def build_table(number_of_row)
  files = Dir.glob('*').sort # カレントデェレクトリの中身を取得して昇順にsort
  number_of_elements_per_row = (files.length.to_f / number_of_row).ceil # 要素数÷number_of_rowの結果を繰り上げて、1行あたりの要素数を算出
  @files_table = files.each_slice(number_of_elements_per_row).to_a # number_of_rowが行数となる二次元配列を作る
  remainder = files.length % number_of_row # 配列の要素数をnumber_of_rowで割った時の余り
  unless remainder.zero? # 余りがゼロじゃない、つまり割り切れない、ということは最終行で要素が少ないので
    number_of_empty_elements = number_of_row - remainder # 空要素を入れる数を算出
    number_of_empty_elements.times { @files_table[number_of_row - 1] << '' } # 最後の配列（＝要素数が足りていない配列）に、空要素を追加する
  end
  @files_table
end

# メソッド２：メソッド1で作った二次元配列を使って、最終的なリストの列ごとの文字数を配列として作る
def build_space(spaces_in_the_gap)
  @files_table.map do |n| # mapで中のn配列を取り出している
    maximum_number_of_characters = n.max_by(&:length) # max_byメソッドで一番文字数の多い要素を取り出す
    maximum_number_of_characters.length + spaces_in_the_gap # 一番文字数の多い要素に、さらに特定の文字数を足す
  end
end

# メソッド３：メソッド１とメソッド２を使って、最終的な出力
def display_ls(row, space)
  table = build_table(row) # 最終的に出力する列の数
  column_space = build_space(space) # 列ごとのスペースの数
  files_table_transpose = table.transpose # 二次元配列の行列を入れ替える
  files_table_transpose.each do |column|
    column.each_with_index do |n, number|
      print n.ljust(column_space[number]) # ljustメソッドでcolumn_spaceの文字数を呼び出してレイアウトを揃える
    end
    print "\n"
  end
end

display_ls(3, 4)

<?php
# lê o arquivo e atribui para variável file
$file = file_get_contents("teste.csv");
# substituir " por nada
$file = str_replace("\"","", $file);
# substituir ; por ,
$file = str_replace(";",",", $file);
# substituir , por \n
$file = str_replace(",","\n", $file);
# remover as linhas em branco e vazias
$file = preg_replace("/(^[\r\n]*|[\r\n]+)[\s\t]*[\r\n]+/", "\n", $file);
# transforma em array e remove espaço em branco e palavras repetidas
$file_in_array = explode("\n", $file);
array_pop($file_in_array);
foreach($file_in_array as &$value) {
    $value = trim($value);
}
$file = array_unique($file_in_array);
# transforma array em string
$file = implode(",", $file);
# substituir , por \n
$file = str_replace(",","\n", $file);
# escreve uma string para um arquivo
file_put_contents("tags_corrigidas.csv", $file);

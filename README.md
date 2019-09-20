#Compilador
Repositório para desenvolvimento do compilador da cadeira de Compiladores - S7

#Documentação
Escopo:
    comecou = Onde comeca o código;
    acabou = Fim do código

    Exemplo:
        comecou
            código
        acabou

Comentário:
    ** = representa o comentário de uma linha, ou seja, ignora a linha na compilação.
    Exemplo: 
        comecou
            **Comando comentado
            **comando
            código
        acabou
        
Tipos de variáveis:
    inteiro = Tipo inteiro;
    quebrado = Tipo de ponto flutuante;
    letras = Tipo com conjunto de caracteres;

    Exemplo:
        comecou
            inteiro $var1 = 10
            quebrado $var2 = 12.5
            lettras $var3 = "string"
        acabou

Declaração de variável:
    $var = Toda variável começa com o caracter "$".

    Exemplo:
        comecou
            quebrado $var1 = 15.25
        acabou

Entrada e saída de dados:
    imputi($var) = Leitura de dados($var: variável);
    altiputi($var) = saída de dados($var: variável);

    Exemplo: 
        comecou
            quebrado $var = 0
            imputi($var)
            altiputi($var)
        acabou

Operações e atribuição:
    +, -, *, / = Operadores aritméticos;
    () = precedência
    ^ = exponenciação;
    # = raiz quadrada;
    '=' = atribuição.

    Exemplo: 
        comecou
            quebrado $var = 0
            $var = (5+5)*3/3
            quebrado $pot = 2^2
            quebrado $raiz = #16
            altiputi($var)
            altiputi($pot)
            altiputi($raiz)
        acabou

Testes condicionais:
    ifi = Executa se a condição for verdade
    euzi = Executa caso a condição do ifi for falsa

    Exemplo:
        comecou
            quebrado $x = 0
            quebrado $y = 0
            imputi($x)
            imputi($y)

            ifi($x > $y) {
                altiputi($x)
            } euzi {
                altiputi($y)
            }

        acabou

        Exemplo2:
        comecou
            **Maior de 3 números
            quebrado $x = 0
            quebrado $y = 0
            quebrado $z = 0
            imputi($x)
            imputi($y)
            imputi($z)
            ifi($x > $y) {
                altiputi($x)
            } euzi {
                ifi($y > $z) {
                    altiputi($y)
                } euzi {
                    altiputi($z)
                }
            }
        acabou
Laço de repetição:
    uaile = Repeti enquanto a condição for verdadeira

    Exemplo: 
        comecou
            **Exibir de 1 a 10
            quebrado $count = 1

            uaile($count < 10) {
                altiputi($count)
                $count = $count +1
            }

        acabou


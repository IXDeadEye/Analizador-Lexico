import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.Reader;

%%
%public
%class Lexer
%unicode
%standalone

%{
    private BufferedWriter writer;

    public Lexer(Reader in, BufferedWriter writer){
        this.zzReader = in;
        this.writer = writer;
    }

    public boolean isEOF() {
        return zzAtEOF;
    }

    private void escribeToken(String lexema, String token) {
        try {
            writer.write(token + ": " + lexema + "\n");
            writer.flush();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
%}

DIGITO        = [0-9]
LETRA         = [a-zA-Z_]
IDENTIFICADOR = {LETRA}({LETRA}|{DIGITO})*
LITERAL       = "\".*?\"|'[^']*'"
OPERADOR      = \+|\-|\*|\/|=|==
DELIMITADOR   = ;|\{|\}
ESPACIO       = [ \t\n\r]+

%%

"if"|"else"|"while"|"for"|"function"|"return" { escribeToken(yytext(), "PALABRA_CLAVE"); }
{IDENTIFICADOR}                               { escribeToken(yytext(), "IDENTIFICADOR"); }
{DIGITO}+                                     { escribeToken(yytext(), "NÚMERO"); }
{LITERAL}                                     { escribeToken(yytext(), "LITERAL"); }
{OPERADOR}                                    { escribeToken(yytext(), "OPERADOR"); }
{DELIMITADOR}                                 { escribeToken(yytext(), "DELIMITADOR"); }
{ESPACIO}                                     { /* Ignorar espacios */ }
.                                             { escribeToken(yytext(), "TEXTO NO RECONOCIDO"); }
import java.io.*;

public class Main {
    public static void main(String[] args) throws Exception {
        if (args.length < 2) {
            System.out.println("Uso: java Main <archivo_entrada> <archivo_salida>");
            return;
        }

        String archivoEntrada = args[0];
        String archivoSalida = args[1];

        try (
            BufferedReader reader = new BufferedReader(new FileReader(archivoEntrada));
            BufferedWriter writer = new BufferedWriter(new FileWriter(archivoSalida))
        ) {
            Lexer lexer = new Lexer(reader, writer);
            while (true) {
                lexer.yylex();
                if (lexer.isEOF()) break;
            }
            System.out.println("Análisis completado. Tokens guardados en " + archivoSalida);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
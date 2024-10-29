#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use utf8;

# Crear una instancia de CGI
my $q = CGI->new;

# Procesar el formulario
procesar_formulario();

sub procesar_formulario {
    # Obtener la expresión ingresada
    my $expresion = $q->param('expresion') // '';
    
    # Validar la expresión
    my $resultado = validar_expresion($expresion);
    
    # Generar la salida HTML
    generar_html($expresion, $resultado);
}

sub validar_expresion {
    my ($expresion) = @_;

    # Validar que la expresión contenga solo caracteres permitidos
    if ($expresion =~ m/^[\d\+\-\*\/\(\) ]+$/) {
        return evaluar_expresion($expresion);
    } else {
        return "Expresión no válida. Solo se permiten números y los operadores +, -, *, /.";
    }
}

sub evaluar_expresion {
    my ($expresion) = @_;
    my $resultado;

    # Intentar evaluar la expresión
    eval {
        $resultado = eval $expresion;
    };

    if ($@) {
        return "Error en la expresión: $@";
    }
    return $resultado;
}

sub generar_html {
    my ($expresion, $resultado) = @_;

    print $q->header('text/html; charset=UTF-8');
    print "<!DOCTYPE html>";
    print "<html lang=\"es\">";
    print "<head>";
    print "<title>Lab 05: Expresiones Regulares en Perl</title>";
    print "<meta charset=\"UTF-8\">";
    print "<link rel=\"stylesheet\" href=\"../css/mystyle.css\">";
    print "</head>";
    print "<body>";

    print "<h2>Lab 05: Expresiones regulares en Perl</h2>";
    print "<form action=\"/cgi-bin/evalExpresion.pl\" method=\"post\">";
    print "<input type=\"text\" name=\"expresion\" placeholder=\"Ingrese expresión\" value=\"" . $expresion . "\" required>";
    print "<button type=\"submit\">Calcular</button>";
    print "</form>";

    if (defined $resultado) {
        print "<h2>Resultado: $resultado</h2>";
    }

    print "<footer class=\"footer\">";
	print "Rivas Revilla Diego, Cornejo Hurtado Dario &copy; 2024/10/24 - Programacion Web Lab. Grupo F.";
	print "</footer>";

    print "</body>";
    print "</html>";

}

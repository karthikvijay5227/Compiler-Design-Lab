%{
    int in_comment = 0;
%}

identifier [a-zA-Z_][a-zA-Z0-9_]*

%%

#.* { if(!in_comment) printf("\n%s is a preprocessor directive", yytext); }

int | float | char | printf | scanf | goto | while | do | for | if | else | return | struct { if(!in_comment) printf("\n%s is a keyword", yytext); }

"/*" {printf("\n%sComment code\n",yytext); in_comment = 1;}
"*/" {in_comment = 0;}

"//" {printf("\nComment code\n"); in_comment = 1;}
\n { in_comment = 0;}

{identifier}([0-9]*)? { if(!in_comment) printf("\n%s is an identifier", yytext); }

\".*\" { if(!in_comment) printf("\n%s is a string", yytext); }

[0-9]+ { if(!in_comment) printf("\n%s is a digit", yytext); }

[+\-*/%=\<>!&|] { if(!in_comment) printf("\n%s is an operator", yytext); }

\'[a-zA-Z0-9]\' { if(!in_comment) printf("\n%s is a character literal", yytext); }

[,{}\[\]();:"'] { if(!in_comment) printf("\n%s is special symbol", yytext); }

[\t ]+ ;

. { if(!in_comment) printf("\n%s is unrecognized token",yytext);}

%%

int main(int argc, char **argv)
{
    FILE *file;
    file = fopen("file.c", "r");
    if (!file)
    {
        printf("Could not open the file");
        exit(0);
    }
    yyin = file;
    yylex();
    printf("\n");
    return (0);
}

int yywrap() {
    return (1);
}

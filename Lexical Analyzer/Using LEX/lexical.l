%{
    int comment = 0;
%}

identifier [a-zA-Z_][a-zA-Z0-9_]*

%%

#.* {printf("\n%s is a preprocessor directive",yytext);}

int | float | char | printf | scanf | goto | while | do | for | if | else | return | struct {if(!comment) printf("\n%s is a keyword",yytext);}

"/*." {comment=1;printf("\n%s is a comment start",yytext);}

{identifier}([0-9]*)? {if(!comment) printf("\n%s is an identifier",yytext);}

\".*\" {if(!comment) printf("\n%s is a string",yytext);}

[0-9]+ {if(!comment) printf("\n%s is a digit",yytext);}

[+\-*/%=\<>!&|] {if(!comment) printf("\n%s is an operator",yytext);}

\'[a-zA-Z0-9]\' {if(!comment) printf("\n%s is a character literal",yytext);}

[,{}\[\]();:"'] {if(!comment) printf("\n%s is special symbol",yytext);}

[\t \n]+ ;

. {if (!comment) printf("\n%s is an unrecognized token", yytext);}

%%

int main(int argc,char **argv)
{
    FILE *file;
    file = fopen("file.c","r");
    if(!file)
    {
        printf("Could not open the file");
        exit(0);
    }
    yyin = file;
    yylex();
    printf("\n");
    return (0);
}

int yywrap()
{
    return (1);
}
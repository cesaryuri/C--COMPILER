/*
 * Compiladores - etapa1 - tokens.h
 *
 * Lista dos tokens, com valores constantes associados.
 * Este arquivo serah posterioremente alterado, nao acrescente nada.
 * Os valores das constantes sao arbitrarios, mas nao podem ser alterados.
 * Cada valor deve ser distinto e fora da escala ascii.
 * Assim, nao conflitam entre si e com os tokens representados pelo proprio valor ascii de caracteres isolados.
 */

 #define KW_CHAR = 258,
 #define KW_INT = 259,
 #define KW_IF = 260,
 #define KW_THEN = 261,
 #define KW_ELSE = 262,
 #define KW_WHILE = 263,
 #define KW_READ = 264,
 #define KW_PRINT = 265,
 #define KW_RETURN = 266,
 #define KW_MAIN = 293,
 #define TK_IDENTIFIER = 267,
 #define LIT_INT = 268,
 #define LIT_CHAR = 269,
 #define LIT_STRING = 270,
 #define TK_ERROR = 271,
 #define TK_SCOMENT = 291,
 #define TK_MCOMENT = 292
/* END OF FILE */
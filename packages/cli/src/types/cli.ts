/**
 * Tipos e interfaces do CLI
 *
 * Este arquivo deve definir:
 * - Interface Command (para todos os comandos)
 * - Tipos para argumentos e opções
 * - Tipos para configurações
 * - Tipos para templates
 * - Tipos para retorno de comandos
 *
 * Exemplo:
 * interface Command {
 *   name: string;
 *   description: string;
 *   execute(args: string[], options: Record<string, any>): Promise<void>;
 * }
 *
 * interface CLIConfig {
 *   // configurações do projeto
 * }
 */

interface Command {
    name: string;
    description: string;
    execute(args: string[], options: Record<string, any>): Promise<void>;
    getHelp?(): string;
}

interface ParsedArgs {
    command: string;
    subcommand?: string;
    options: Record<string, any>;
    args: string[];
}

interface CLIConfig {
    projectName: string;
    version: string;
    commands: Command[];
    defaultCommand?: string;
    templatesPath?: string;
    outputPath?: string;
}

interface TemplateVariable {
    name: string;
    description?: string;
    defaultValue?: string;
}

interface ReturnCommand { 
    success: boolean;
    message: string;
    data?: any; // Dados adicionais retornados pelo comando
    error?: string; // Mensagem de erro, se houver
    help?: string; // Ajuda adicional para o comando
    command?: string; // Nome do comando executado
    subcommand?: string; // Subcomando executado, se houver
    options?: Record<string, any>; // Opções usadas no comando
    args?: string[]; // Argumentos passados para o comando
    templateVariables?: TemplateVariable[]; // Variáveis de template, se aplicável
    config?: CLIConfig; // Configuração do CLI, se aplicável
    date?: Date; // Data de execução do comando
    duration?: number; // Duração da execução do comando em milissegundos
}
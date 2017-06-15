import { ContainerModule, injectable, inject } from "inversify";
import { BaseLanguageClientContribution, LanguageClientContribution, LanguageClientFactory, Languages, Workspace } from 'theia-core/lib/languages/browser';

export default new ContainerModule(bind => {
    bind<LanguageClientContribution>(LanguageClientContribution).to(DslClientContribution)

    // initialize monaco
    monaco.languages.register({
        id: 'calc',
        aliases: ['CALC', 'calc'],
        extensions: ['.calc'],
        mimetypes: ['text/calc']
    })

    monaco.languages.setLanguageConfiguration('calc', {
        comments: {
            lineComment: "//",
            blockComment: ['/*', '*/']
        },
        brackets: [['{', '}'], ['(', ')']],
        autoClosingPairs: [
            {
                open: '{',
                close: '}'
            },
            {
                open: '(',
                close: ')'
            }]
    })

    monaco.languages.setMonarchTokensProvider('calc', <any>{
        // Set defaultToken to invalid to see what you do not tokenize yet
        // defaultToken: 'invalid',

        keywords: [
            'let', 'native'
        ],

        operators: [
            '+', '-', '*', '/'
        ],

        autoClosingPairs: [
            { open: '(', close: ')', notIn: ['string', 'comment'] },
            { open: '/**', close: '*/' },
        ],

        // The main tokenizer for our languages
        tokenizer: {
            root: [
                // keywords
                [/let|native/, { cases: { '@keywords': 'keyword' } }],
                [':', 'string'],

                // whitespace
                { include: '@whitespace' },

                // delimiters and operators
                [/[{}()\[\]]/, '@brackets'],

                // numbers
                [/\d*\.\d+([eE][\-+]?\d+)?/, 'number.float'],
                [/0[xX][0-9a-fA-F]+/, 'number.hex'],
                [/\d+/, 'number'],

                // delimiter: after number because of .\d floats
                [/[;,.]/, 'delimiter']
            ],

            comment: [
                [/[^\/*]+/, 'comment'],
                [/\/\*/, 'comment', '@push'],    // nested comment
                ["\\*/", 'comment', '@pop'],
                [/[\/*]/, 'comment']
            ],

            whitespace: [
                [/[ \t\r\n]+/, 'white'],
                [/\/\*/, 'comment', '@comment'],
                [/\/\/.*$/, 'comment'],
            ],
        }

    })
})

@injectable()
export class DslClientContribution extends BaseLanguageClientContribution {

    readonly id = "calc";
    readonly name = "CALC";

    constructor(
        @inject(Workspace) protected readonly workspace: Workspace,
        @inject(Languages) protected readonly languages: Languages,
        @inject(LanguageClientFactory) protected readonly languageClientFactory: LanguageClientFactory
    ) {
        super(workspace, languages, languageClientFactory);
    }

    protected get globPatterns() {
        return [
            '**/*.calc'
        ];
    }

}
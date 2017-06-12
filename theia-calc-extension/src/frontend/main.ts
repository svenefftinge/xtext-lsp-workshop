import "xterm/dist/xterm.css";
import "theia-core/src/application/browser/style/index.css";
import "theia-core/src/monaco/browser/style/index.css";
import "theia-core/src/navigator/browser/style/index.css";
import "theia-core/src/terminal/browser/terminal.css";
import { Container } from "inversify";
import { FrontendApplication, browserApplicationModule } from "theia-core/lib/application/browser";
import { messagingModule } from "theia-core/lib/messaging/browser";
import { navigatorModule } from "theia-core/lib/navigator/browser";
import { fileSystemClientModule } from "theia-core/lib/filesystem/browser";
import { editorModule } from "theia-core/lib/editor/browser";
import { frontendLanguagesModule } from 'theia-core/lib/languages/browser/frontend-languages-module';
import { monacoModule } from 'theia-core/lib/monaco/browser';
import { browserClipboardModule } from 'theia-core/lib/application/browser/clipboard/clipboard-module';
import { browserMenuModule } from "theia-core/lib/application/browser/menu/menu-module";
import terminalFrontendModule from 'theia-core/lib/terminal/browser/terminal-frontend-module';
import calcModule from './calc-contribution'

(() => {
    const container = new Container();
    container.load(calcModule);
    container.load(browserApplicationModule);
    container.load(messagingModule);
    container.load(navigatorModule);
    container.load(fileSystemClientModule);
    container.load(editorModule);
    container.load(frontendLanguagesModule);
    container.load(monacoModule);
    container.load(browserMenuModule);
    container.load(browserClipboardModule);
    container.load(terminalFrontendModule);
    const application = container.get(FrontendApplication);
    application.start();
})();
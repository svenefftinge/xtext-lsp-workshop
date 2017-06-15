import 'reflect-metadata';
import * as path from 'path';
import * as express from 'express';
import { Container, injectable } from "inversify";
import { messagingModule } from "theia-core/lib/messaging/node";
import { backendLanguagesModule } from 'theia-core/lib/languages/node';
import { fileSystemServerModule } from "theia-core/lib/filesystem/node";
import terminalBackendModule from 'theia-core/lib/terminal/node/terminal-backend-module'
import { BackendApplication, BackendApplicationContribution, applicationModule } from "theia-core/lib/application/node";
import calcServerModule from './calc-contribution';

process.on('uncaughtException', function (err: any) {
    console.error('Uncaught Exception: ', err.toString());
    if (err.stack) {
        console.error(err.stack);
    }
});

@injectable()
class StaticServer implements BackendApplicationContribution {
    configure(app: express.Application): void {
        app.use(express.static(path.join(__dirname, '..'), {
            index: path.join('frontend', 'index.html')
        }));
    }
}

(() => {
    const container = new Container();
    container.load(calcServerModule);
    container.load(applicationModule);
    container.load(messagingModule);
    container.load(fileSystemServerModule);
    container.load(backendLanguagesModule);
    container.load(terminalBackendModule);
    container.bind(BackendApplicationContribution).to(StaticServer);
    const application = container.get(BackendApplication);
    application.start();
})();
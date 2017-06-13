import * as path from 'path';
import { injectable, ContainerModule } from "inversify";
import { BaseLanguageServerContribution, LanguageServerContribution, IConnection } from "theia-core/lib/languages/node";

const LS_SERVER_JAR_PATH = path.resolve(__dirname, path.join('..', '..', '..', 'org.xtext.calc.parent', 'org.xtext.calc.ide', 'build', 'libs', 'calculator-language-server.jar'));

export default new ContainerModule(bind => {
    bind<LanguageServerContribution>(LanguageServerContribution).to(CalcServerContribution);
});

@injectable()
export class CalcServerContribution extends BaseLanguageServerContribution {

    public id: string = 'calc';
    public name: string = 'CALC';

    start(clientConnection: IConnection): void {
        const serverConnection = this.createProcessStreamConnection('java', 
            [   '-Xdebug', 
                '-Xrunjdwp:server=y,transport=dt_socket,address=4000,suspend=n,quiet=y',
                '-jar', LS_SERVER_JAR_PATH]);
        this.forward(clientConnection, serverConnection);
    }

}
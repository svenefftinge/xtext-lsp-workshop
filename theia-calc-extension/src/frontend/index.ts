window.onload = () => {
    const w = <any>window;
    w.require(["vs/editor/editor.main"], () => {
        w.require([
            'vs/platform/commands/common/commands',
            'vs/platform/actions/common/actions',
            'vs/platform/keybinding/common/keybindingsRegistry',
            'vs/platform/keybinding/common/keybindingResolver',
            'vs/base/common/keyCodes',
            'vs/editor/browser/standalone/simpleServices'
        ], (commands: any, actions: any, registry: any, resolver: any,
            keyCodes: any, simpleServices: any) => {

                const global: any = self;
                global.monaco.commands = commands;
                global.monaco.actions = actions;
                global.monaco.keybindings = Object.assign(registry, resolver, keyCodes);
                global.monaco.services = simpleServices;
                require('./main');
            });
    });
};
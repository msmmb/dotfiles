from sys import argv
import os

home_directory = '/home/michael'

def escribir(archivo, nuevo, patron, lines):

        fich = open(archivo,'r')
        lineas = fich.readlines()

        for i,line in enumerate(lineas):
            if patron in line:
                break

        for k,j in enumerate(lines):
            lineas[i+j] = nuevo[k]

        fich = open(archivo,'w')
        fich.writelines(lineas)
        fich.close()

def fondo(bg):
    if bg in [f'0{i}' if i < 10 else str(i) for i in range(1,len(os.listdir(f'{home_directory}/Imágenes/Fondos de Pantalla'))+1)]:
        nuevo = f'feh --bg-fill {home_directory}/Imágenes/Fondos\\ de\\ Pantalla/{bg}.jpg\n'
        os.system(nuevo)
        escribir(f'{home_directory}/.config/bspwm/bspwmrc', [nuevo], 'feh', [0])

    else:
        print('El fondo escrito no existe')

def opacidad(op):
        if 0 <= float(op) and float(op) <= 1:
            escribir(f'{home_directory}/.config/alacritty/alacritty.yml', ['  opacity: {}\n'.format(op)], '  opacity:',[0])

        else:
            print('Esa opacidad no es posible')

def tamaño_fuente(tm):
    if float(tm) > 6:
        escribir(f'{home_directory}/.config/alacritty/alacritty.yml', ['  size: {}\n'.format(tm)], 'size', [0])
    else:
        print('Fuente demasiado pequeña')

def padding(pd):
    escribir(f'{home_directory}/.config/alacritty/alacritty.yml', ['    x: {}\n'.format(pd), '    y: {}\n'.format(pd)], 'padding', [1,2])

def fuente(ft):
    fuentes = {'mononoki': 'mononoki Nerd Font', 'agave': 'agave Nerd Font', 'hurmit': 'Hurmit Nerd Font', 'ubuntu': 'Ubuntu Nerd Font', 'ubuntumono': 'Ubuntu Mono Nerd Font',
               'caskaydia': 'CaskaydiaCove Nerd Font', 'terminess': 'TerminessTTF Nerd Font', 'spacemono': 'SpaceMono NF', 'jetbrains': 'JetBrains Mono ExtraBold Nerd Font'}
    if ft in fuentes:
        escribir(f'{home_directory}/.config/alacritty/alacritty.yml', [f'    family: {fuentes.get(ft)}\n' for i in range(3)], 'family', [0,3,6])
    else:
        print([f for f in fuentes])

def sep(sp):
    separadores = {1:'', 2:'', 3:' ', 4:' '}
    if int(sp) in range(1,5):
        escribir(f'{home_directory}/.config/polybar/modules.ini', [f'content = \"{separadores.get(int(sp))}\"\n'], 'content', [0])
    else:
        print('Separador no existente')


def tema(tm):
    temas = ['basic', 'dark-grey', 'dracula', 'material-darker', 'material-ocean',
             'monokai-pro', 'nord', 'onedark', 'rosepine', 'xmonad', 'grey']
    if tm in temas:
        escribir(f'{home_directory}/.config/polybar/config.ini', [f'include-file = $HOME/.config/polybar/themes/{tm}.ini'], 'polybar/themes', [0])
        if tm == 'basic' or tm == 'xmonad':
            escribir(f'{home_directory}/.config/polybar/modules.ini', [f'content = \'\'\n'], 'content', [0])

    else:
        print(temas)



if __name__ == '__main__':

    fdic = {'-b': fondo, '-o': opacidad, '-s': tamaño_fuente, '-f': fuente, '-p': padding, '-t': tema, '-sp': sep}
    for i in range(len(argv)):
        for f in fdic:
            if argv[i] == f:
                fdic[f](argv[i+1])



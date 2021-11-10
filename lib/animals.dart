/*FORMAT
'name': String name,
'id': String id,
'breed': String breed,
'birthDate': DateTime date -- yyyy-MM-dd,
'entryDate': DateTime date -- yyyy-MM-dd,
'photo': String photoRoute -- located in /assets 
'description': String description.
*/

const ANIMAL_LIST = [
  {
    'name': 'Pupo',
    'id': '1234',
    'breed': 'Galgo',
    'birthDate': '2019-12-12',
    'entryDate': '2020-05-09',
    'photo': 'galgo.png',
    'description':
        'Muy cariñoso pero a veces intenta abrir puertas. Le gusta mucho el pan y dormir en el sofá.'
  },
  {
    'name': 'Max',
    'id': '752378',
    'breed': 'Galgo',
    'birthDate': '2020-05-05',
    'entryDate': '2021-10-30',
    'photo': 'galgo.png',
    'description':
        'Le encantan los mimos y a veces se pone celoso cuando hay otro perro cerca. ' +
            'Nunca mordería a un humano pero sí puede que se meta en peleas con otros perros.'
  },
  {
    'name': 'Kros',
    'id': '752234378',
    'breed': 'Galgo',
    'birthDate': null,
    'entryDate': '2021-10-24',
    'photo': 'galgo.png',
    'description':
        'Nunca empieza una pelea ni con perros ni con personas, excepto si ' +
            'intentas quitarle la comida. En ese caso puede ser peligroso, aunque hay que hacerle ver' +
            'que él no manda y si se hace bien se echará atrás.'
  },
  {
    'name': 'Linares',
    'id': '755232378',
    'breed': 'Bodeguero',
    'birthDate': null,
    'entryDate': '2021-06-24',
    'photo': 'galgo.png',
    'description':
        'Ha sido maltratado y tiene mucho miedo cuando alguien se acerca.' +
            'Le gusta mucho que le den cariño pero tiene que ser con mucho cuidado para no asustarle.' +
            'No muerde pero puede que haga el amago cuando se siente atacado.'
  },
  {
    'name': 'Narco',
    'id': '75237478',
    'breed': 'Galgo',
    'birthDate': null,
    'entryDate': '2020-01-05',
    'photo': 'galgo.png',
    'description':
        'Es el más cabrón de todos. Se escapa corriendo al sofá cuando está fuera jugando.' +
            'Cuando está ahí corre de lado a lado y se tumba para que no le saques de él. A la hora de irse a dormir ' +
            'se esconde para que no lo veas. Es muy cariñoso y lo que más le gusta es estar en el sofá y jugar.'
  },
  {
    'name': 'Thor',
    'id': '75237845',
    'breed': 'Galgo',
    'birthDate': null,
    'entryDate': '2019-10-24',
    'photo': 'galgo.png'
  },
  {
    'name': 'Trueno',
    'id': '75237809',
    'breed': 'Galgo',
    'birthDate': null,
    'entryDate': '2021-02-13',
    'photo': 'galgo.png',
    'description': 'Es absolutamente estúpido.'
  },
  {
    'name': 'Pupo',
    'id': '72412348',
    'breed': 'Galgo',
    'birthDate': '2019-12-12',
    'entryDate': '2020-05-09',
    'photo': 'galgo.png'
  },
  {
    'name': 'Max',
    'id': '752378',
    'breed': 'Galgo',
    'birthDate': '2020-05-05',
    'entryDate': '2021-10-30',
    'photo': 'galgo.png'
  },
  {
    'name': 'Kros',
    'id': '752234378',
    'breed': 'Galgo',
    'birthDate': null,
    'entryDate': '2021-10-24',
    'photo': 'galgo.png'
  },
  {
    'name': 'Linares',
    'id': '755232378',
    'breed': 'Bodeguero',
    'birthDate': null,
    'entryDate': '2021-06-24',
    'photo': 'galgo.png'
  },
  {
    'name': 'Narco',
    'id': '75237478',
    'breed': 'Galgo',
    'birthDate': null,
    'entryDate': '2020-01-05',
    'photo': 'galgo.png'
  },
  {
    'name': 'Thor',
    'id': '75237845',
    'breed': 'Galgo',
    'birthDate': null,
    'entryDate': '2019-10-24',
    'photo': 'galgo.png'
  },
  {
    'name': 'Trueno',
    'id': '75237809',
    'breed': 'Galgo',
    'birthDate': null,
    'entryDate': '2021-02-13',
    'photo': 'galgo.png'
  }
];

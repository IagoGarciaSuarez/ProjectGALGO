/*FORMAT
'id': String id,
'name': String name,
'breed': String breed,
'photo': String photoRoute -- located in /assets 
'chip': String chipNumber
'birthDate': DateTime date -- yyyy-MM-dd,
'entryDate': DateTime date -- yyyy-MM-dd,
'description': String description,
'diseases': String diseases,
'entryReasons': String reasons,
'notes': String notes
*/

const ANIMAL_LIST = [
  {
    'id': '1234',
    'name': 'Pupo',
    'breed': 'Galgo',
    'photo': 'galgo.png',
    'chip': '127819471827492',
    'birthDate': '2019-12-12',
    'entryDate': '2020-05-19',
    'description':
        'Muy cariñoso pero a veces intenta abrir puertas. Le gusta mucho el pan y dormir en el sofá.',
    'diseases': '-',
    'entryReasons':
        'Realmente no hay razones porque este es probablemente el mejor perro del planeta. ' +
            'Es listo, guapo, cariñoso y le gusta jugar, ya me dirás porqué iba a dejarlo en una protectora.',
    'notes': '-'
  },
  {
    'id': '752378',
    'name': 'Max',
    'breed': 'Galgo',
    'photo': 'galgo.png',
    'chip': '127819471827493',
    'birthDate': '2020-05-05',
    'entryDate': '2021-10-30',
    'description':
        'Le encantan los mimos y a veces se pone celoso cuando hay otro perro cerca. ' +
            'Nunca mordería a un humano pero sí puede que se meta en peleas con otros perros.',
    'diseases': '-',
    'entryReasons': '-',
    'notes': '-'
  },
  {
    'id': '752234378',
    'name': 'Kros',
    'chip': '59284029402849',
    'breed': 'Galgo',
    'photo': 'galgo.png',
    'birthDate': 'null',
    'entryDate': '2021-10-24',
    'description':
        'Nunca empieza una pelea ni con perros ni con personas, excepto si ' +
            'intentas quitarle la comida. En ese caso puede ser peligroso, aunque hay que hacerle ver' +
            'que él no manda y si se hace bien se echará atrás.',
    'diseases': '-',
    'entryReasons': '-',
    'notes': '-'
  },
  {
    'id': '755232378',
    'name': 'Linares',
    'breed': 'Bodeguero',
    'photo': 'galgo.png',
    'chip': '59284029402849',
    'birthDate': 'null',
    'entryDate': '2021-06-24',
    'description':
        'Ha sido maltratado y tiene mucho miedo cuando alguien se acerca.' +
            'Le gusta mucho que le den cariño pero tiene que ser con mucho cuidado para no asustarle.' +
            'No muerde pero puede que haga el amago cuando se siente atacado.',
    'diseases': '-',
    'entryReasons': '-',
    'notes': '-'
  },
  {
    'id': '75237478',
    'name': 'Narco',
    'breed': 'Galgo',
    'photo': 'galgo.png',
    'chip': '59284029402849',
    'birthDate': 'null',
    'entryDate': '2020-01-05',
    'description':
        'Es el más cabrón de todos. Se escapa corriendo al sofá cuando está fuera jugando.' +
            'Cuando está ahí corre de lado a lado y se tumba para que no le saques de él. A la hora de irse a dormir ' +
            'se esconde para que no lo veas. Es muy cariñoso y lo que más le gusta es estar en el sofá y jugar.',
    'diseases': '-',
    'entryReasons': '-',
    'notes':
        'Cuando se vayan todos a dormir, tener cuidado con Narco porque se esconde para no entrar.'
  },
  /*{
    'name': 'Thor',
    'id': '75237845',
    'breed': 'Galgo',
    'birthDate': 'null',
    'entryDate': '2019-10-24',
    'photo': 'galgo.png'
  },
  {
    'name': 'Trueno',
    'id': '75237809',
    'breed': 'Galgo',
    'birthDate': 'null',
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
    'birthDate': 'null',
    'entryDate': '2021-10-24',
    'photo': 'galgo.png'
  },
  {
    'name': 'Linares',
    'id': '755232378',
    'breed': 'Bodeguero',
    'birthDate': 'null',
    'entryDate': '2021-06-24',
    'photo': 'galgo.png'
  },
  {
    'name': 'Narco',
    'id': '75237478',
    'breed': 'Galgo',
    'birthDate': 'null',
    'entryDate': '2020-01-05',
    'photo': 'galgo.png'
  },
  {
    'name': 'Thor',
    'id': '75237845',
    'breed': 'Galgo',
    'birthDate': 'null',
    'entryDate': '2019-10-24',
    'photo': 'galgo.png'
  },
  {
    'name': 'Trueno',
    'id': '75237809',
    'breed': 'Galgo',
    'birthDate': 'null',
    'entryDate': '2021-02-13',
    'photo': 'galgo.png'
  }*/
];

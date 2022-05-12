// Container(
//                       padding: const EdgeInsets.fromLTRB(20, 150, 20, 10),
//                       child: GridView.builder(
//                           itemCount: blocPoubelle.length,
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   mainAxisSpacing: 20,
//                                   crossAxisSpacing: 20),
//                           itemBuilder: (context, indexBloc) {
//                             List poubelle =
//                                 blocPoubelle[indexBloc]['poubelles'];
//                             return Column(children: [
//                               Text(
//                                 "${blocPoubelle[indexBloc]['bloc_etablissement']}",
//                                 style: const TextStyle(fontSize: 24),
//                               ),
//                               Flexible(
//                                   child: SingleChildScrollView(
//                                       scrollDirection: Axis.vertical,
//                                       child: Column(
//                                         children: List.generate(poubelle.length,
//                                             (index) {
//                                           return ListTile(
//                                             title: Text(
//                                               "${poubelle[index]['type']} : ${poubelle[index]['Etat']} % ",
//                                               style: const TextStyle(fontSize: 16),
//                                             ),
//                                           );
//                                         }),
//                                       )))
//                             ]);
//                           }
//                           )
//                           ),


///new
//  Container(
//                         alignment: Alignment.bottomCenter,
//                         child: Column(
//                           children: [
//                             Text(
//                               poubelle[i]['type'],
//                               style: const TextStyle(
//                                 fontFamily: "hindi",
//                                 fontSize: 28,
//                               ),
//                             ),
//                             const Padding(padding: EdgeInsets.all(5)),
//                             Stack(alignment: Alignment.center, children: [
//                               Image(
//                                 image:
//                                     AssetImage("images/${poubelle[i]['type']}.png"),
//                                 width: 220.0,
//                                 height: 230.0,
//                                 fit: BoxFit.contain,
//                               ),
//                               Container(
//                                 width: 80,
//                                 decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(40),
//                                     )),
//                                 height: 80,
//                                 child: CircularPercentIndicator(
//                                   animation: true,
//                                   radius: 40,
//                                   lineWidth: 12,
//                                   percent: (poubelle[i]['Etat']) / 100,
//                                   progressColor:
//                                       check.check((poubelle[i]['Etat']) / 100),
//                                   backgroundColor: Colors.grey,
//                                   circularStrokeCap: CircularStrokeCap.round,
//                                   center: Text(
//                                     '${poubelle[i]['Etat']} %',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ),
//                               )
//                             ]),
//                             ElevatedButton(
//                               style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all(
//                                     const Color(0xFFc60001)),
//                                 fixedSize:
//                                     MaterialStateProperty.all(const Size(150, 40)),
//                               ),
//                               onPressed: () {
//                                 viderPoubelle(2, poubelle[i]['id']);
//                                 if (mounted) {
//                                   setState(() {
//                                     remplirEtablissement();
//                                   });
//                                 }
//                               },
//                               child: const Text('Vider la poubelle'),
//                             ),
//                           ],
//                         )),
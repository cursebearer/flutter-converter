import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Conversor de Moedas'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        children: [
          _buildConversorView(bandeiraUrl: 'https://s1.static.brasilescola.uol.com.br/be/conteudo/images/2-bandeira-do-brasil.jpg', 
          nomePais: 'BRA', 
          moeda: 'BRL', 
          simbolo: '\$'),
          const SizedBox(height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3)
                    )
                  ]
                ),
                child: const Center(
                  child:  Text('=', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),),
                ),
              ),
                Container(
                height: 50,
                //width: 50,
                decoration: BoxDecoration(
                  color: Colors.indigo[50],
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.indigo)
                  ),
                  child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Image.asset('assets/images/switch.png',
                        height: 30,
                        ),
                        const Text('Trocar as moedas', style: TextStyle(color: Colors.indigo, fontSize: 17, fontWeight: FontWeight.w500),)
                      ],
                    ),
                ),
          ),
        ],
          ),
          const SizedBox(
            height: 30,
          ),
          _buildConversorView(
            bandeiraUrl: 'https://s1.static.brasilescola.uol.com.br/be/conteudo/images/2-bandeira-do-brasil.jpg', 
            nomePais: 'BRA', 
            moeda: 'BRL', 
            simbolo: '\$'
          )
        ],
        
        )
      ),
    );
  }

  Container _buildConversorView(
    {String? bandeiraUrl, String? nomePais, String? moeda ,String? simbolo}) {
    return Container(
          height: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(
              color: Colors.indigo.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 4,
              offset: const Offset(0, 3)
            )]
            ),
            child: Padding(padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: 
                      Image.network(
                    bandeiraUrl!,
                      width: 50,
                      height: 30,
                  )
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(  nomePais! , style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600)),
                          Text( moeda! , style: const TextStyle(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400))
                    ],
                   ),
                    ),
                    const Icon(Icons.chevron_right, 
                      color: Colors.grey,
                   )
                  ],
                ),
                TextField(
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: '0.0',
                    suffixIcon: Text(
                      simbolo!,
                       style: const TextStyle(fontSize: 20, color: Colors.grey),),
                    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0)
                  ),
                )
              ],
            ),
        )
        );
  }
}
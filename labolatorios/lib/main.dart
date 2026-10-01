import 'package:flutter/material.dart';

void main() {
  runApp(const MiPedidoApp());
}

class MiPedidoApp extends StatelessWidget {
  const MiPedidoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mis productos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
        ),
        useMaterial3: true, 
      ),
      home: const MiPedido(),
    );
  }
}

class ProductoPedido extends StatelessWidget {
  final String nombre;
  final double precio;
  final int cantidad;
  final VoidCallback onRestar;
  final VoidCallback onSumar;

  const ProductoPedido({
    super.key,
    required this.nombre,
    required this.precio,
    required this.cantidad,
    required this.onRestar,
    required this.onSumar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ), 
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.brown.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              nombre == 'Café'
                  ? Icons.coffee
                  : nombre == 'Sándwich'
                      ? Icons.lunch_dining
                      : Icons.local_drink,
              color: Colors.brown,
              size: 28,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nombre,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Q${precio.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: cantidad > 0 ? onRestar : null,
            icon: const Icon(Icons.remove),
            style: IconButton.styleFrom(
              backgroundColor: Colors.grey.shade200,
            ),
          ),
          SizedBox(
            width: 42,
            child: Center(
              child: Text(
                '$cantidad',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: onSumar,
            icon: const Icon(Icons.add),
            style: IconButton.styleFrom(
              backgroundColor: Colors.brown.shade100,
            ),
          ),
        ],
      ),
    );
  }
}

class MiPedido extends StatefulWidget {
  const MiPedido({super.key});

  @override
  State<MiPedido> createState() => _MiPedidoState();
}

class _MiPedidoState extends State<MiPedido> {
  int cantidadCafe = 0;
  int cantidadSandwich = 0;
  int cantidadJugo = 0;

  final double precioCafe = 10.00;
  final double precioSandwich = 25.00;
  final double precioJugo = 12.00;

  double calcularTotal() {
    return (cantidadCafe * precioCafe) +
        (cantidadSandwich * precioSandwich) +
        (cantidadJugo * precioJugo);
  }

  void vaciarPedido() {
    setState(() {
      cantidadCafe = 0;
      cantidadSandwich = 0;
      cantidadJugo = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double total = calcularTotal();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Mis pedidos :D',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 700,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Productos',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Seleccione la cantidad que desea agregar',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                ProductoPedido(
                  nombre: 'Café',
                  precio: precioCafe,
                  cantidad: cantidadCafe,
                  onRestar: () {
                    if (cantidadCafe > 0) {
                      setState(() {
                        cantidadCafe--;
                      });
                    }
                  },
                  onSumar: () {
                    setState(() {
                      cantidadCafe++;
                    });
                  },
                ),
                ProductoPedido(
                  nombre: 'Sándwich',
                  precio: precioSandwich,
                  cantidad: cantidadSandwich,
                  onRestar: () {
                    if (cantidadSandwich > 0) {
                      setState(() {
                        cantidadSandwich--;
                      });
                    }
                  },
                  onSumar: () {
                    setState(() {
                      cantidadSandwich++;
                    });
                  },
                ),
                ProductoPedido(
                  nombre: 'Jugo',
                  precio: precioJugo,
                  cantidad: cantidadJugo,
                  onRestar: () {
                    if (cantidadJugo > 0) {
                      setState(() {
                        cantidadJugo--;
                      });
                    }
                  },
                  onSumar: () {
                    setState(() {
                      cantidadJugo++;
                    });
                  },
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Q${total.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: vaciarPedido,
                    icon: const Icon(Icons.delete_outline),
                    label: const Text(
                      'Vaciar pedido',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
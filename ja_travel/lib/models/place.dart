class Place {
  final double longitud;
  final double latitud;
  final String id;
  final String nombre;
  final String descripcion;
  final String imagen;
  final String provincia;
  final String comunidad;
  final String pais;

  Place(
      {required this.nombre,
      required this.id,
      required this.latitud,
      required this.longitud,
      required this.descripcion,
      required this.imagen,
      required this.comunidad,
      required this.pais,
      required this.provincia});

  Map<String, dynamic> toMap() => {
        'nombre': nombre,
        'id': id,
        'longitud': longitud,
        'latitud': latitud,
        'descripcion': descripcion,
        'imagen': imagen,
      };

  Place.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        nombre = data['nombre'],
        longitud = data['longitud'],
        latitud = data['latitud'],
        descripcion = data['descripcion'],
        imagen = data['imagen'],
        provincia = data['provincia'],
        pais = data['pais'],
        comunidad = data['comunidad'];
}

import UIKit

class TableViewController: UITableViewController {

    // MARK: - Datos
    var peliculas = [Pelicula]()

    override func viewDidLoad() {
        super.viewDidLoad()
        crearPeliculas()
    }

    func crearPeliculas() {
        let sentidoDeLaVida = Pelicula(
            titulo: "El sentido de la vida",
            caratula: "sentido",   // nombre del asset SIN .png/.jpg
            fecha: "1983",
            descripcion: """
            Conjunto de episodios que muestran de forma disparatada los momentos más importantes del ciclo de la vida. Desde el nacimiento a la muerte, pasando por asuntos como la filosofía, la historia o la medicina, todo tratado con el inconfundible humor de los populares cómicos ingleses. El prólogo es un cortometraje independiente rodado por Terry Gilliam: Seguros permanentes Crimson.
            """
        )
        
        let endgame = Pelicula(
                    titulo: "Vengadores: Endgame",
                    caratula: "endgame",
                    fecha: "2019",
                    descripcion:
        """
        Tras los devastadores eventos de Infinity War, los Vengadores restantes se reúnen una vez más para deshacer el daño causado por Thanos y restaurar el equilibrio del universo.
        """
                )

                let ironMan3 = Pelicula(
                    titulo: "Iron Man 3",
                    caratula: "ironman3",
                    fecha: "2013",
                    descripcion:
        """
        Tony Stark se enfrenta a las consecuencias de la batalla de Nueva York mientras un nuevo enemigo, el Mandarín, amenaza su mundo personal y pone a prueba el verdadero poder de Iron Man.
        """
                )

                peliculas = [sentidoDeLaVida, endgame, ironMan3]

        
    }
    

    // MARK: - Tabla

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return peliculas.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        cell.textLabel?.text = peliculas[indexPath.row].titulo
        return cell
    }

    // MARK: - Selección de fila

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {

        let pelicula = peliculas[indexPath.row]
        print("Fila tocada: \(pelicula.titulo)")

        // 1) Intentar usar el Detail ya existente en el Split (iPad / ancho regular)
        if let splitVC = splitViewController,
           let detailVC = obtenerDetailController(desde: splitVC) {

            detailVC.didChangePelicula(with: pelicula)
            return
        }

        // 2) Modo compact (iPhone): crear uno nuevo desde el storyboard y hacer push
        guard let detailVC = storyboard?.instantiateViewController(
            identifier: "DetailViewController"
        ) as? DetailViewController else {
            return
        }

        detailVC.didChangePelicula(with: pelicula)
        show(detailVC, sender: self)
    }

    // MARK: - Helpers

    private func obtenerDetailController(desde splitVC: UISplitViewController)
        -> DetailViewController? {

        // Puede ser directamente el Detail...
        if let detail = splitVC.viewController(for: .secondary) as? DetailViewController {
            return detail
        }

        // ...o un NavigationController cuyo root es el Detail
        if let nav = splitVC.viewController(for: .secondary) as? UINavigationController,
           let detail = nav.topViewController as? DetailViewController {
            return detail
        }

        return nil
    }
}


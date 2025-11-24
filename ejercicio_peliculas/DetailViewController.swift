import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var imagenView: UIImageView!
    @IBOutlet weak var descripcionTextView: UITextView!
    @IBOutlet weak var stackView: UIStackView!

    // Película actualmente mostrada
    private var peliculaActual: Pelicula?

    // MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()

        // Por si acaso: aseguramos solo lectura
        descripcionTextView.isEditable = false
        descripcionTextView.isSelectable = false

        // Estado inicial o película ya asignada
        if let peli = peliculaActual {
            aplicarPelicula(peli)
        } else {
            mostrarEstadoInicial()
        }
    }

    // MARK: - Actualizar detalle desde la tabla

    /// Llamado por TableViewController cuando cambia la película seleccionada
    func didChangePelicula(with pelicula: Pelicula) {
        peliculaActual = pelicula

        // Si la vista ya está cargada, actualizamos directamente
        if isViewLoaded {
            aplicarPelicula(pelicula)
        }
    }

    // Aplica los datos de la película a la interfaz
    private func aplicarPelicula(_ pelicula: Pelicula) {
        tituloLabel.text = pelicula.titulo
        fechaLabel.text = pelicula.fecha
        descripcionTextView.text = pelicula.descripcion
        imagenView.image = UIImage(named: pelicula.caratula)

        // Título de la barra: "Título (Año)"
        title = "\(pelicula.titulo) (\(pelicula.fecha))"
    }

    // Estado cuando aún no se ha seleccionado ninguna película
    private func mostrarEstadoInicial() {
        title = "Película"
        tituloLabel.text = ""
        fechaLabel.text = ""
        descripcionTextView.text = "Selecciona una película"
        imagenView.image = nil
    }

    // MARK: - Stack / adaptación a giros
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        if view.bounds.width >= view.bounds.height {
            // Más ancho que alto → imagen y texto en horizontal
            stackView.axis = .horizontal
        } else {
            // Más alto que ancho → imagen arriba, texto debajo
            stackView.axis = .vertical
        }
    }
}


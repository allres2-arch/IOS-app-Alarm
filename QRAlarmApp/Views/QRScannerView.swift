import SwiftUI
import AVFoundation
import Vision

struct QRScannerView: UIViewControllerRepresentable {
    @EnvironmentObject var alarmManager: AlarmManager
    var onQRDetected: (String) -> Void

    func makeUIViewController(context: Context) -> QRScannerViewController {
        let controller = QRScannerViewController()
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onQRDetected: onQRDetected)
    }

    class Coordinator: NSObject, QRScannerDelegate {
        let onQRDetected: (String) -> Void

        init(onQRDetected: @escaping (String) -> Void) {
            self.onQRDetected = onQRDetected
        }

        func didDetectQRCode(_ code: String) {
            onQRDetected(code)
        }
    }
}

protocol QRScannerDelegate: AnyObject {
    func didDetectQRCode(_ code: String)
}

class QRScannerViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    weak var delegate: QRScannerDelegate?

    private let captureSession = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var lastDetectedCode: String = ""
    private var detectionQueue = DispatchQueue(label: "qr.detection.queue")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }

    private func setupCamera() {
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("No camera available")
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: camera)
            captureSession.addInput(input)

            videoOutput.setSampleBufferDelegate(self, queue: detectionQueue)
            captureSession.addOutput(videoOutput)

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            if let previewLayer = previewLayer {
                previewLayer.videoGravity = .resizeAspectFill
                view.layer.addSublayer(previewLayer)
            }

            captureSession.startRunning()
        } catch {
            print("Error setting up camera: \(error.localizedDescription)")
        }
    }

    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        let request = VNDetectBarcodesRequest { [weak self] request, error in
            guard let observations = request.results as? [VNBarcodeObservation] else { return }

            for observation in observations {
                if observation.symbology == .qr, let payload = observation.payloadStringValue {
                    if self?.lastDetectedCode != payload {
                        self?.lastDetectedCode = payload
                        DispatchQueue.main.async {
                            self?.delegate?.didDetectQRCode(payload)
                        }
                    }
                }
            }
        }

        let imageRequestHandler = VNImageRequestHandler(
            cvPixelBuffer: pixelBuffer,
            orientation: .right,
            options: [:]
        )

        try? imageRequestHandler.perform([request])
    }

    deinit {
        captureSession.stopRunning()
    }
}
